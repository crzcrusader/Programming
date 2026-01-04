/*
---This program simulates a five-player card game inspired by the Italian trick-taking game
“Briscola Chiamata.” The program takes as input the number of tricks to be simulated and a
sequence of 40 cards,representing the deck. It then simulates the play and outputs the set
of cards played in each trick, as well as the outcome of the game (the cards won by each team
and the score achieved).
8 DA DJ D4 S4 C2 C6 CK S6 D6 H6 H5 H4 D5 CA HK C4 H2 C7 H3 HJ SK S7 SJ SA S5
DK C5 D2 CQ HQ C3 S3 CJ DQ H7 D3 S2 SQ HA D7 E

ECE 209
Cruz Sanchez
*/
//////////////
#include <stdio.h>
#include "briscola.h"

const int MAX_CARDS = 40; // total cards in deck
int main(void)
{
    int tricks;     // tricks variable
    int count = 0; // count for number of cards
    char suits[MAX_CARDS], values[MAX_CARDS]; // variable declarations for the suit and value
    char suitInput, valueInput, terminator; //variable declarations

        //Get Input
    printf("Enter the number of tricks and the cards in the deck (terminated by 'E'):\n");
    //
    scanf("%d", &tricks); //Gets integer input for number of tricks
    //
    while (count < MAX_CARDS) { // Loop to get input for deck
        scanf(" %c", &terminator); //reads the suit

        if (terminator == 'E') break; //checks for end

        suitInput = terminator; // pushes the terminator value onto suit
        scanf(" %c", &valueInput); //reads value

        suits[count] = suitInput;       //
        values[count] = valueInput;
        count++;                        //increments counts for # of cards
        } //end of while loop
    /* Call Deal Cards Function*/
    deal_cards(suits,values,count);  //cals deal_cards functions
    /* PRINT PLAYERS HAND*/
    for (int i = 0; i < PLAYERS; i++)  // prints the hand of each player
    {
        printf("player %d:: ", i);
        for (int j = 0; j < count / PLAYERS; j++)
        {
            printf("%c%c ", suit[i][j], rank[i][j]);
        }
        printf("\n");
    }           /////
    char briscola = find_briscola();    // calls the function find briscola
    //output briscola, leader, and partner
    printf("briscola = %c, lead player = %d, partner = %d \n", briscola, lead, partner);
    //Arrays to store won cards
    char Team0_won_S[MAX_CARDS], Team1_won_S[MAX_CARDS];        //variable to store won cards
    char Team0_won_R[MAX_CARDS], Team1_won_R[MAX_CARDS];        //variable to store won cards
    int Team0_score = 0, Team1_score = 0;
    int Team0_count = 0, Team1_count = 0;
    //Begin playing tricks
    int lead_player = lead;         //variable for the lead player
    for (int trick = 0; trick < tricks; trick++)        // loop to play tricks
    {
        int trick_cards[PLAYERS]; // stores the indexes of all the played cards
        char trick_suits[PLAYERS], trick_ranks[PLAYERS];
        int trick_winner = lead_player; // default lead player winner
        char trick_suit, trick_rank;

        //simulate player turns in round robin fashion
        for (int i = 0; i < PLAYERS; i++)       //
        {
            int current_player = (lead_player + i) % PLAYERS;           //variable to know what player is playing
            if (i == 0)
            {
                trick_cards[current_player] = first_player_strategy(current_player, briscola);
                trick_suit = suit[current_player][trick_cards[current_player]];
                trick_rank = rank[current_player][trick_cards[current_player]];
            } else if (i == (lead_player - 1) % PLAYERS)
            {
                trick_cards[current_player] = last_player_strategy(current_player, trick_winner,trick_suit, trick_rank, briscola);
            } else
            {
                trick_cards[current_player] = middle_player_strategy(current_player, trick_winner, trick_suit, trick_rank, briscola);
            }
            //store played card
            trick_suits[i] = suit[current_player][trick_cards[current_player]];     //tracks the suit played by the current player
            trick_ranks[i] = rank[current_player][trick_cards[current_player]];     //tracks the rank played by the current player
            //Mark as used
            suit[current_player][trick_cards[current_player]] = '\0';
            rank[current_player][trick_cards[current_player]] = '\0';
            //Determines if card played card wins trick
            if (i > 0) // if not the lead player
            {//after first card is played, compare cards
                int winner_index = (trick_winner - lead_player + PLAYERS) % PLAYERS;
                for (int j = 0; j < PLAYERS; j++)
                {
                    if (trick_winner == (lead_player+ j) % PLAYERS)
                    {
                        winner_index = j;
                        break;
                    }
                }
                int winner_suit = trick_suits[winner_index];
                int winner_rank_value = get_value(trick_ranks[winner_index]);
                int current_rank_value = get_value(trick_ranks[i]);


                //Winning
                if (trick_suits[i] == winner_suit)
                {//if same suit
                    if (current_rank_value > winner_rank_value)
                    {
                        trick_winner = current_player;
                    }
                }else if (trick_suits[i] == briscola && winner_suit != briscola)
                {
                    trick_winner = current_player;
                }
                else if (trick_suits[i] == briscola && winner_suit == briscola)
                {
                    if (current_rank_value > winner_rank_value)
                    {
                        trick_winner = current_player;
                    }
                }
            }
        }
         //print trick plays
        printf("trick %d:: cards played: [ ", trick);
        for (int i = 0;i < PLAYERS; i++)        //prints for each player
        {
            printf("%c%c ",trick_suits[i], trick_ranks[i]);
        }
        printf("], winner: %d\n", trick_winner);

        //assign won cards to to correct team
        for (int i = 0; i < PLAYERS; i++)
        {
            char won_suit = trick_suits[i];     //variable to store won suit
            char won_rank = trick_ranks[i];     //variable to store won rank
            int card_score = get_value(won_rank);       //variable to store card score

            if ((trick_winner == lead) || (trick_winner == partner))        //if lead or partner wins
            {//Team0 wins trick
                Team0_won_S[Team0_count] = won_suit;
                Team0_won_R[Team0_count] = won_rank;
                Team0_score += card_score;
                Team0_count++;      //Adds to team0 score
            }else
            {//Team1 Wins trick
                Team1_won_S[Team1_count] = won_suit;
                Team1_won_R[Team1_count] = won_rank;
                Team1_score += card_score;
                Team1_count++;      //Adds to team1 score
            }
        }
        lead_player = trick_winner;     //changes the current trick winner for comparison
    }
    //Print final results
    if (tricks != 0)
    {
        printf("team 0:: cards won: [ ");
        for (int i = 0;i < Team0_count;i++)
        {
            printf("%c%c ", Team0_won_S[i], Team0_won_R[i]);
        }
        printf("], score: %d\n", Team0_score);

        printf("team 1:: cards won: [ ");
        for (int i = 0;i < Team1_count;i++)
        {
            printf("%c%c ", Team1_won_S[i], Team1_won_R[i]);
        }
        printf("], score: %d\n", Team1_score);
    }

    return 0; //end main
    }