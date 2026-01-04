#include <stdio.h>
// Function to get the card value
int getCardValue(char value) {
    if (value >= '2' && value <= '7') return value - '0'; // Between 2 and 7
    if (value == 'J') return 8;  // Jack
    if (value == 'Q') return 9;  // Queen
    if (value == 'K') return 10; // King
    if (value == 'A') return 11; // Ace
    return 0;
}
// Function to manually copy a card
void copyCard(char dest[3], const char src[3]) { // copy from source card to destination
    dest[0] = src[0];
    dest[1] = src[1];
    dest[2] = '\0';
}
// Function to determine the trick winner
int evaluateTrick(char playedCard[3], char drawnCard[3], char briscolaSuit) {
    char playedSuit = playedCard[0];  // Suit of the played card
    char drawnSuit = drawnCard[0];    // Suit of the drawn card
    int playedValue = getCardValue(playedCard[1]);  // Value of the played card
    int drawnValue = getCardValue(drawnCard[1]);    // Value of the drawn card

    if (playedSuit == briscolaSuit && drawnSuit != briscolaSuit) { // If played is trump and drawn isn't
        return 1;  // Player wins
    }
    if (playedSuit == drawnSuit) { // If suits match, highest value wins
        if (playedValue > drawnValue) {
            return 1;  // Player wins
        } else {
            return 0;  // Dealer wins
        }
    }

    if (drawnSuit == briscolaSuit && playedSuit != briscolaSuit) { // If drawn is trump and played isn't
        return 0;  // Dealer wins
    }

    return 0;  // If no suit matches and no trump involved, dealer wins
}
// Function to select the best card to play
// Function to select the best card to play
int selectCard(char hand[][3], int handSize, char drawnCard[3], char briscolaSuit) {
    int bestWinningIndex = -1, bestWinningValue = -1;
    int lowestTrumpIndex = -1, lowestTrumpValue = 12;
    int lowestNonTrumpIndex = -1, lowestNonTrumpValue = 12;
    int lowestOverallIndex = -1, lowestOverallValue = 12;

    for (int i = 0; i < handSize; i++) {
        int cardValue = getCardValue(hand[i][1]);

        // (1) Choose the highest possible winning card
        if (hand[i][0] == drawnCard[0] && cardValue > getCardValue(drawnCard[1])) {
            if (bestWinningIndex == -1 || cardValue > bestWinningValue) {
                bestWinningIndex = i;
                bestWinningValue = cardValue;
            }
        }

        // (2) Track the lowest trump card
        if (hand[i][0] == briscolaSuit && drawnCard[0] != briscolaSuit) {
            if (lowestTrumpIndex == -1 || cardValue < lowestTrumpValue) {
                lowestTrumpIndex = i;
                lowestTrumpValue = cardValue;
            }
        }

        // (3) Track the lowest non-trump card for discarding
        if (hand[i][0] != briscolaSuit) {
            if (lowestNonTrumpIndex == -1 || cardValue < lowestNonTrumpValue) {
                lowestNonTrumpIndex = i;
                lowestNonTrumpValue = cardValue;
            }
        }

        // (4) Track the absolute lowest card for last resort
        if (lowestOverallIndex == -1 || cardValue < lowestOverallValue) {
            lowestOverallValue = cardValue;
            lowestOverallIndex = i;
        }
    }

    //
    if (bestWinningIndex != -1) return bestWinningIndex;  // Play the highest winning card
    if (lowestTrumpIndex != -1) return lowestTrumpIndex;  // Use a trump card
    if (lowestNonTrumpIndex != -1) return lowestNonTrumpIndex;  // Discard the lowest non-trump card
    return lowestOverallIndex;  // Otherwise, play the absolute lowest card
}


int main() {
    const int HAND_SIZE = 3; //Hand size is 3 cards
    const int MAX_CARDS = 40;

    char cards[MAX_CARDS][3];
    int count = 0; // count for number of cards
    char briscolaSuit = '\0';
    int deckIndex = 4; // Starts at the 4th card

    printf("Enter a sequence of cards (terminated by 'E'):\n");fflush(stdout);
    while (count < MAX_CARDS) { // Loop to get input for deck
        scanf("%2s", cards[count]);

        if (cards[count][0] == 'E') {  //temrinates input at E
            break;
        }

        char suit = cards[count][0];
        char value = cards[count][1];

        if (count == 0) {
            briscolaSuit = suit;
        }
        //Gets only valid input
        if ((suit == 'H' || suit == 'S' || suit == 'C' || suit == 'D') &&
            ((value >= '2' && value <= '7') || value == 'J' || value == 'Q' || value == 'K' || value == 'A')) {
            count++; //adds to count if its a valid card
        }
    }

    // Initialize the player's hand with the first 3 cards
    char hand[HAND_SIZE][3]; // array for cards in hand
    for (int i = 0; i < HAND_SIZE; i++) {
        copyCard(hand[i], cards[i + 1]);
    }

    int score = 0; // starts score at 0
    char wonCards[MAX_CARDS][3]; //array for holding won cards
    int wonCount = 0;

    while (deckIndex < count) { // loop for
        char drawnCard[3];
        copyCard(drawnCard, cards[deckIndex]);

        int selectedIndex = selectCard(hand, HAND_SIZE, drawnCard, briscolaSuit);
        char playedCard[3];
        copyCard(playedCard, hand[selectedIndex]);

        int winner = evaluateTrick(playedCard, drawnCard, briscolaSuit);
            // If the player wins the trick
            if (winner == 1)
            {
                // If the player wins the trick
                copyCard(wonCards[wonCount], drawnCard);  // Store played card
                wonCount++;
                copyCard(wonCards[wonCount], playedCard);   // Store drawn card
                wonCount++;
                score += getCardValue(playedCard[1]) + getCardValue(drawnCard[1]);  // Add both cards' values to score
            }


        for (int i = selectedIndex; i < HAND_SIZE - 1; i++) {
            copyCard(hand[i], hand[i + 1]);
        }
        if (deckIndex - 1 < count) {
            copyCard(hand[selectedIndex], cards[deckIndex - 1]);
        }

        // Draw a new card from the deck if available
        deckIndex += 2; // Move two steps forward to skip the drawn card

        if (deckIndex - 1 < count) {  // Ensure the new replacement card exists
            copyCard(hand[selectedIndex], cards[deckIndex - 1]);  // Replace played card with the next available card
        }

    }

    printf("cards in deck: %d, ", count);
    printf("briscola: %c, ", briscolaSuit);
    printf("score: %d, ", score);
    printf("cards won: [ ");
    for (int i = 0; i < wonCount; i++) {
        printf("%c%c ", wonCards[i][0], wonCards[i][1]);
    }
    printf("]\n");

    return 0;
}
