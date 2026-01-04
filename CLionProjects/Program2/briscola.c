#include "briscola.h"
#include <limits.h> //used for INT_MAX
#define PLAYERS 5
#define CARDS_PER_PLAYER 8
#define NUM_SUITS 4
/* cards owned by the players
 * E.g. The suit and rank of the third card of the second players are stored in:
 *      suit[1][2] and rank[1][2]
 * NOTE: to indicate that a card has been played (and is unavailable) assign value '\0' to the corresponding suit.
 */
char suit[PLAYERS][CARDS_PER_PLAYER];
char rank[PLAYERS][CARDS_PER_PLAYER];

int lead;    // lead player
int partner; // partner (i.e., teammate of lead player)

/**********************************************************/
/*         HELPER FUNCTIONS DECLARATION                   */
/**********************************************************/

/* returns true if players p1 and p2 are teammates,
 * and false otherwise */
bool teammates(int p1, int p2);

/* returns the highest-ranked card of a given player, where:
 * - suit = target_suit if equal = true
 * - suit <> target_suit if equal = false
 * The value returned is the index of the card within suit[player]/rank[player]
 * If such a card is unavailable, it returns -1.
 * If target_suit == 0, it returns the highest-ranked card of player (independent of the suit).
 * In this case, the value of equal is irrelevant.
 */
int find_max(int player, char target_suit, bool equal);

/* returns the lowest-ranked card of a given player, where:
 * - suit = target_suit if equal = true
 * - suit <> target_suit if equal = false
 * The value returned is the index of the card within suit[player]/rank[player]
 * If such a card is unavailable, it returns -1.
 * If target_suit == 0, it returns the lowest-ranked card of player (independent of the suit).
 * In this case, the value of equal is irrelevant.
 */
int find_min(int player, char target_suit, bool equal);

/*  returns a card of a given player with suit=target_suit,
 *  and rank equal to the lowest rank available greater than target_rank.
 *  The value returned is the index of the card within suit[player]/rank[player]
 *  If such card is not available, returns -1
 */
int find_relative_min(int player, char target_suit, char target_rank);

/**********************************************************/
/*         HELPER FUNCTIONS DEFINITION                    */
/**********************************************************/

char get_value(char rank) {
    if (rank == 'J')
        return 8;
    if (rank == 'Q')
        return 9;
    if (rank == 'K')
        return 10;
    if (rank == 'A')
        return 11;
    return (rank - '0');
}

bool teammates(int p1, int p2) {
    if ((p1 == lead && p2 == partner) || (p1 == partner && p2 == lead)) return true;

    if ((p1 != lead && p1 != partner) && (p2 != lead && p2 != partner)) return true;

    return false;
}

int find_max(int player, char target_suit, bool equal) {
    int index = -1;
    for (int i = 0; i < CARDS_PER_PLAYER; i++) {
        if (suit[player][i]!='\0' && (target_suit == 0 || (equal && suit[player][i] == target_suit) || (!equal && suit[player][i]!=target_suit))) {
            if (index == -1 || get_value(rank[player][i]) > get_value(rank[player][index]))
            {
                index = i;
            }
        }
    }
    return index;
}

int find_min(int player, char target_suit, bool equal) {
    int index = -1;
    for (int i = 0; i < CARDS_PER_PLAYER; i++) {
        if (suit[player][i]!='\0' && (target_suit == 0 || (equal && suit[player][i]==target_suit) || (!equal && suit[player][i] != target_suit))) {
            if (index == -1 || get_value(rank[player][i]) < get_value(rank[player][index]))
            {
                index = i;
            }
        }
    }
    return index;
}

int find_relative_min(int player, char target_suit, char target_rank) {
    int index = -1;
    for (int i = 0; i < CARDS_PER_PLAYER; i++) {
        if (suit[player][i]!=0 && (suit[player][i]==target_suit) && (get_value(rank[player][i]) > get_value(target_rank))) {
            if (index == -1 || get_value(rank[player][i]) < get_value(rank[player][index]))
                index = i;
        }
    }
    return index;
}
int rank_to_index(char rank)
{
    switch (rank)
    {
    case '2': return 0;
    case '3': return 1;
    case '4': return 2;
    case '5': return 3;
    case '6': return 4;
    case '7': return 5;
    case 'J': return 6;
    case 'Q': return 7;
    case 'K': return 8;
    case 'A': return 9;
    default : return -1;

    }
}
int compare_cards(char suit1, char rank1, char suit2, char rank2, char briscola)
{
    if (suit1 == suit2)
    {
        return get_value(rank1) > get_value(rank2);
    }
    //if card is briscola and other is not
    if ((suit1 == briscola) && (suit2 != briscola))
    {
        return 1;
    }
    if ((suit2 == briscola) && (suit1 != briscola))
    {
        return 0;
    }
    return 0;
}
//Update Winner
int update_winner(int player, int winner, char trick_suit[], char trick_rank[], char briscola )
{
    if (compare_cards(trick_suit[player], trick_rank[player], trick_suit[winner], trick_rank[winner], briscola))
    {
        return player;
    }
    return winner;
}

/**********************************************************/
/*         CORE   FUNCTIONS                               */
/**********************************************************/

/* COMPLETE THESE FUNCTIONS */

void deal_cards(const char suits[],const char value[], int numCards) {
    int i, player;
    //Deal the cards, alternating players
    for (i = 0; i < numCards; i++)
    {
        player = i % PLAYERS;
        int cardIndex = i / PLAYERS; // determines the position in Hand(player)

        suit[player][cardIndex] = suits[i];
        rank[player][cardIndex] = value[i];
    }


}

char find_briscola() {
    int suit_Scores[NUM_SUITS] = {0}; //scores for C,D,H,S
    int player_Scores[PLAYERS][NUM_SUITS] = {0}; //individual player scores
    //Map suits to the indexes, in alphabetical order
    char suit_Orders[NUM_SUITS] = {'C', 'D', 'H', 'S'};     // Keeps the suits in alphabetical order
    //Calculate scores per suit per suit
    for (int p = 0; p < PLAYERS; p++)       //scans each players hand and adds value of each suit
    {
        for (int c = 0; c < CARDS_PER_PLAYER; c++)
        {
            char s = suit[p][c];        //suit score
            char r = rank[p][c];        //rank score
            //to find each index of a suit
            int suit_index = (s == 'C') ? 0 : (s == 'D') ? 1 : (s == 'H') ? 2 : 3;
            //Add card value
            int card_val = get_value(r);        //establishes card value
            player_Scores[p][suit_index] += card_val;       //players score
            suit_Scores[suit_index] += card_val;        // keeps the highest suit score for each player
        }
    }
    //Finds Lead player
    lead = 0;
    int max_player_score = 0;
    char lead_suit = 'C';
    for (int p = 0; p < PLAYERS; p++)       //scans wfor which player has the highest suit score
    {
        for (int s = 0; s < NUM_SUITS; s++)
        {
            if (player_Scores[p][s] > max_player_score || (player_Scores[p][s] == max_player_score && suit_Orders[s] < lead_suit))
            {
                max_player_score = player_Scores[p][s];     //highest ocerall score
                lead = p;                                   // assigns lead player
                lead_suit = suit_Orders[s];
            }
        }
    }
    char briscola = lead_suit;
    //Find Partner
    int lowest_brisc_r = INT_MAX;

    for (int p = 0; p < PLAYERS; p++)       //scans players hands to get partner
    {
        if (p == lead) continue;
        int lowest_brisc_index = find_min(p, briscola, true);
        if (lowest_brisc_index != -1)
        {
            int card_rank_val = get_value(rank[p][lowest_brisc_index]);
            if (card_rank_val < lowest_brisc_r)
            {
                lowest_brisc_r = card_rank_val;
                partner = p;
            }
        }
    }
    return briscola;
}

int first_player_strategy(int player, char briscola) {          //parameter are the player which starts as lead and the brisc
    int min_non_briscola_index = find_min(player, briscola, false);     //searches hand for lowest non briscola card
    //Check if card has been played
    while (min_non_briscola_index != -1 && (suit[player][min_non_briscola_index] == '\0' || rank[player][min_non_briscola_index] == '\0'))
    {
        min_non_briscola_index = find_min(player, briscola, false);
    }

    if (min_non_briscola_index == -1)
    {//If no non-brisc cards available
        return find_min(player, briscola, true);
    }
    return min_non_briscola_index;
}
int middle_player_strategy(int player, int winner, char win_suit, char win_rank, char briscola) {
    //printf("\n[DEBUG] Player %d is playing. Current winner: %d, Winning card: %c%c, Briscola: %c\n", player, winner, win_suit, win_rank, briscola);

    bool is_teamte_winning = teammates(player, winner);
    //printf("[DEBUG] is teamate winning?: %d\n", is_teamte_winning);
    int winning_rank_value = rank_to_index(win_rank);
    //Rule #1: current winning ard is briscola
    if (win_suit == briscola)
    {
        if (is_teamte_winning)
        {
            int highest_non_brisc = find_max(player, briscola, false);
            //printf("[DEBUG] Teammate is winning. Trying highest non-briscola: %d\n", highest_non_brisc);
            //check if card has been played
            while (highest_non_brisc != -1 && (suit[player][highest_non_brisc] == '\0'))
            {
                //printf("[DEBUG] Selected card: %c%c\n", suit[player][highest_non_brisc], rank[player][highest_non_brisc]);
                highest_non_brisc = find_max(player, briscola, false);
                //printf("[DEBUG] Player %d, Highest non-briscola available: %d\n", player, highest_non_brisc);

            }
            if (highest_non_brisc != -1) return highest_non_brisc;
            //printf("[DEBUG] Selected card: %c%c\n", suit[player][highest_non_brisc], rank[player][highest_non_brisc]);

        } else {//rule #2 :oponent is winning
            //Find the lowest briscola that outranks the current winning card
            int lowest_outranking_brisc = -1;
            for (int i = 0; i < CARDS_PER_PLAYER; i++)
            {
                if (suit[player][i] == briscola && rank_to_index(rank[player][i]) > winning_rank_value)
                {
                    if (lowest_outranking_brisc == -1 || rank_to_index(rank[player][i]) < rank_to_index(rank[player][lowest_outranking_brisc]))
                    {
                        lowest_outranking_brisc = i;        //
                    }
                }
            }
            //printf("[DEBUG] Opponent is winning. Trying lowest outranking briscola: %d\n", lowest_outranking_brisc);
            if (lowest_outranking_brisc != -1) //return lowest_outranking_brisc;
            {
                //printf("[DEBUG] Selected card: %c%c\n", suit[player][lowest_outranking_brisc], rank[player][lowest_outranking_brisc]);
                return lowest_outranking_brisc;
            }
        }
    } else
    {
        int highest_same_suit = -1;
        for (int i = 0; i < CARDS_PER_PLAYER; i++)
        {
            if (suit[player][i] == win_suit && rank_to_index(rank[player][i]) > winning_rank_value)
            {
                if (highest_same_suit == -1 || rank_to_index(rank[player][i]) < rank_to_index(rank[player][highest_same_suit]))
                {
                    highest_same_suit = i;
                }
            }
        } if (highest_same_suit != -1) return highest_same_suit;
    }
    //if current winning card is Not a briscola
        int lowest_brisc = find_min(player, briscola, true);
        //printf("[DEBUG] Winning card is not briscola. Trying lowest briscola: %d\n", lowest_brisc);
        while (lowest_brisc != -1 && (suit[player][lowest_brisc] == '\0' ))
        {
            //printf("[DEBUG] Card %c%c already played. Finding next lowest briscola.\n", suit[player][lowest_brisc], rank[player][lowest_brisc]);
            lowest_brisc = find_min(player, briscola, true);
        }
        if (lowest_brisc != -1) //return lowest_brisc;
        {
            //printf("[DEBUG] Selected card: %c%c\n", suit[player][lowest_brisc], rank[player][lowest_brisc]);
            return lowest_brisc;
        }

    //if no brisc card matches
    int lowest_non_brisc = find_min(player, briscola, false);
    while (lowest_non_brisc != -1 && (suit[player][lowest_non_brisc] == '\0'))
    {
        lowest_non_brisc = find_min(player, briscola, false);
    }
    if (lowest_non_brisc != -1)
    {
        //printf("[DEBUG] Selected card: %c%c\n", suit[player][lowest_non_brisc], rank[player][lowest_non_brisc]);
        return lowest_non_brisc;
    }
    //if no other option
    int lowest_card = find_min(player, '\0', false);
    //printf("[DEBUG] No valid non-briscola. Playing lowest overall: %c%c\n", suit[player][lowest_card], rank[player][lowest_card]);
    return lowest_card;
}
int last_player_strategy(int player, int winner, char win_suit, char win_rank, char briscola) {
    //checks if teamate is winning
    bool is_teamte_winning = teammates(player, winner);
    int winning_rank_value = rank_to_index(win_rank);       // gets the winning card rank

    if (is_teamte_winning)      // options for if teamate plays a winning card
    {
        int highest_non_brisc = find_max(player, briscola, false);
        while (highest_non_brisc != -1 && (suit[player][highest_non_brisc] == 'X'|| rank[player][highest_non_brisc] == 'X'))
        {
            highest_non_brisc = find_max(player, briscola, false);
        }
        if (highest_non_brisc != -1)
        {
            return highest_non_brisc;       // plays highest no brisc card
        }
        return find_min(player, 0, false);      //return loest value card
    }

    if (win_suit != briscola)       //
    {
        int highest_same_suit = find_max(player, win_suit, true);
        while (highest_same_suit != -1 && (suit[player][highest_same_suit] == 'X' || rank[player][highest_same_suit] == 'X'))
        {
            highest_same_suit = find_max(player, win_suit, true);
        }
        if (highest_same_suit != -1 && (rank_to_index(rank[player][highest_same_suit]) > winning_rank_value))
        {
            return highest_same_suit;       //plays highest card of same suit
        }
        int lowest_brisc = find_min(player, briscola, true);        //gets lowest briscola card
        while (lowest_brisc != -1 && (suit[player][lowest_brisc] == '\0' || rank[player][lowest_brisc] == '\0'))
        {
            lowest_brisc = find_min(player, briscola, true);
        }
        if (lowest_brisc != -1)
        {
            return lowest_brisc;
        }
    } else // if winning card is briscola
    {
        int lowest_outranking_brisc = -1;

        for (int i = 0; i < CARDS_PER_PLAYER; i++)
        {
            if (suit[player][i] == briscola && rank_to_index(rank[player][i]) > winning_rank_value)
            {
                if (lowest_outranking_brisc == -1 || rank_to_index(rank[player][i]) < rank_to_index(rank[player][lowest_outranking_brisc]))
                {
                    lowest_outranking_brisc = i;
                }
            }
        }
        //check if card has been played
        while (lowest_outranking_brisc != -1 && (suit[player][lowest_outranking_brisc] == '\0' || rank[player][lowest_outranking_brisc] == '\0'))
        {
            lowest_outranking_brisc = -1;
            for (int i = 0; i < CARDS_PER_PLAYER; i++)
            {
                if (suit[player][i] == briscola && rank_to_index(rank[player][i]) > winning_rank_value)
                {
                    if (lowest_outranking_brisc == -1 || rank_to_index(rank[player][i]) < rank_to_index(rank[player][lowest_outranking_brisc]))
                    {
                        lowest_outranking_brisc = i;
                    }
                }
            }
        }
        if (lowest_outranking_brisc != -1)
        {
            return lowest_outranking_brisc;
        }
    }
    return find_min(player, 0, false);
}