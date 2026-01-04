// ECE 209 - Fall 2024
// PS3 -- arrays and functions
// Program simulates a card dealer.

#include <stdio.h>

// functions for random number generation
void seedRandom(unsigned int seed);
unsigned int getRandom(unsigned int limit);
unsigned int lfsrNext();

// functions for card deck

// initialize and then shuffle a deck of cards
void shuffle(unsigned int[], unsigned int);
// print string that describes a single card
void printCard(unsigned int);

// global variable for dealing
unsigned int nextDeal = 0;  // position of next card to be dealt

// card function for dealing (provided by student)
// DECLARATION HERE, NOT DEFINITION
unsigned int deal(unsigned int [], unsigned int , unsigned int);


// functions for general arrays (provided by student)
// DECLARATIONS HERE, NOT DEFINITION
void init(unsigned int [],unsigned int );

void permute(unsigned int [],unsigned int);

int main() {
    unsigned int cardDeck[52];   // allocate space for largest deck
    unsigned int cardNum;        // actual number of cards in the deck
    int dealt = 0;      // number of cards that have been dealt
    printf("Howdy, pardner. How many cards in your deck? ");
    fflush(stdout);
    scanf("%u", &cardNum);
    while ((cardNum < 5) || (cardNum > 52)) {
        printf("Sorry, we only allow decks between 5 and 52. How many? ");
        fflush(stdout);
        scanf("%u", &cardNum);
    }
    // set up the random number generator
    seedRandom(0xcafe);  // arbitrary seed number

    // initialize the deck (Task 1)  -- for debugging
    init(cardDeck, cardNum);
    for (int k = 0; k < cardNum; k++) printf("%d ", cardDeck[k]);
    printf("\n");

    // shuffle the deck (Task 2)
    shuffle(cardDeck, cardNum);

    // print the shuffled cards -- for debugging
    for (int i = 0; i < cardNum; i++) printf("%d ", cardDeck[i]);
    printf("\n");

    // print using card notation -- for debugging
    for (int j = 0; j < cardNum; j++) {
        printCard(cardDeck[j]);
        printf(" ");
    }
    printf("\n");

    // deal... (Task 4)
    unsigned int n = 0;  // number to deal
    unsigned int p = 0;  // current position in deck
    unsigned int d = 0;  // result of deal
    while (1) {
        printf("How many to deal? ");
        fflush(stdout);
        scanf("%u", &n);
        if ((n == 0) || (n > cardNum)) break;   // exit loop if deal number is zero
        while ((d = deal(cardDeck, cardNum, n)) == 0) {
            printf("Not enough cards. Re-shuffling.\n");
            shuffle(cardDeck, cardNum);
            p = 0;
        }
        p += d;
    }
    printf("Thanks for playing!\n");
    return 0;
}


// shuffle -- initialize and rearrange card deck of size n
// initialize to values 0..n-1, and then permute
void shuffle(unsigned int deck[], unsigned int size) {
    init(deck, size);
    permute( deck, size);
    nextDeal = 0;  // start dealing from the top of the deck
}

// printCard -- print a string corresponding to card number
// Suit order = clubs (0-12), diamonds (13-25), hearts (26-38), spades (39-51)
// no spaces before or after, just the value (2-10,J,Q,K,A) and the suit (C,D,H,S)
// if n > 51, don't print anything
void printCard(unsigned int c) {
   unsigned int suit = c / 13;
   unsigned int face = c % 13;
   char f[] = "234567890JQKA";
   char s[] = "CDHS";
   if (face == 8) printf("10");
   else printf("%c", f[face]);
   printf("%c", s[suit]);

}


// DEFINE YOUR FUNCTIONS HERE

// TASK 1
// init -- given array of size n, set values to 0..n-1
void init(unsigned int array[],unsigned int size)
{
    for (int i = 0; i < size; i++)
    {
        array[i] = i;
    }
}

// TASK 2
// permute -- rearrange the elements of an array of size n
// must call getRandom() and must follow exactly the algorithm in the spec
void permute(unsigned int array[],unsigned int size)

{
    for (unsigned int i = size -1; i > 0; i--)
    {
        unsigned int j = getRandom(i + 1);

        unsigned int temp = array[i];
        array[i] = array[j];
        array[j] = temp;


    }
}

// TASK 3
// deal -- start at a given position, call printCard for the next n cards in the array
// each card must be followed by a space, and print a linefeed at the end
// return value = number of cards dealt, zero if not enough cards in the deck to deal


unsigned int deal(unsigned int deck[], unsigned int decksize, unsigned int numberOfCards)
{
    if (nextDeal + numberOfCards > decksize)
    {
        return 0;
    }
    for (unsigned int i = 0; i < numberOfCards; i++)
    {
        printCard(deck[nextDeal+i]);
        printf(" ");
    }
    printf("\n");
    nextDeal += numberOfCards;
    return numberOfCards;
}

// RANDOM NUMBER FUNCTIONS -- DO NOT CHANGE

unsigned int lfsr = 0;  // global variable -- holds current state of LFSR

// set starting value for LFSR-based random number generator
void seedRandom(unsigned int seed) {
    if (seed) lfsr = seed;
}

// return a random integer between 0 and limit-1
unsigned int getRandom(unsigned int limit) {
    return lfsrNext() % limit;  //
}

// lfsrNext -- function to advance an LFSR for pseudorandom number generation
// uses global variable (lfsr)
// code from: https://en.wikipedia.org/wiki/Linear-feedback_shift_register
unsigned int lfsrNext(void) {
    lfsr ^= lfsr >> 7;
    lfsr ^= lfsr << 9;
    lfsr ^= lfsr >> 13;
    return lfsr;
}
