#ifndef BRISCOLA_H
#define BRISCOLA_H

#include <stdbool.h>
#include <stdio.h>

#define PLAYERS 5
#define DECK_SIZE 40
#define CARDS_PER_PLAYER 8
#define TEAMS 2

extern char suit[PLAYERS][CARDS_PER_PLAYER];
extern char rank[PLAYERS][CARDS_PER_PLAYER];
extern int lead;
extern int partner;


/* MACRO FOR DEBUGGING PURPOSES */
//#define DEBUG // uncomment to show debugging information
#ifdef DEBUG
    #define debug(...) printf(__VA_ARGS__)
#else
    #define debug(...)
#endif


//translate rank of card to its index
int rank_to_index(char rank);
/* translates card's rank into numeric value */
char get_value(char rank);

/* distributes the card in the deck to the 5 players */
void deal_cards(const char suits[], const char values[], int num_cards);


/* identifies the briscola, the lead player and his partner
 * returns the briscola (the lead player and partner are global variables)
 */
char find_briscola();

/* returns the card played using the strategy of the first player of the trick
 * The value returned is the index of the card within suit[player]/rank[player]
 * - player = current player
 */
int first_player_strategy(int player, char briscola);

/* returns the card played using the strategy of the last player of the trick
 * The value returned is the index of the card within suit[player]/rank[player]
 * - player = current player
 * - winner = current winner of the trick
 * - win_suit = suit of the card that is winning the trick
 * - win_rank = rank of the card that is winning the trick
*/
int middle_player_strategy(int player, int winner, char win_suit, char win_rank, char briscola);

/* returns the card played using the strategy of middle players of the trick
 * The value returned is the index of the card within suit[player]/rank[player]
 * - player = current player
 * - winner = current winner of the trick
 * - win_suit = suit of the card that is winning the trick
 * - win_rank = rank of the card that is winning the trick
 */
int last_player_strategy(int player, int winner, char win_suit, char win_rank, char briscola);

int compare_cards(char suit1, char rank1, char suit2, char rank2, char briscola);

int update_winner(int player, int winner, char trick_suit[], char trick_rank[], char briscola );


#endif //BRISCOLA_H
