/* ECE 209, Spring 2025
* Six Degrees of Separations game.
* Cruz Sanchez 04/09/2025
 * (1) The user enters the expression: <filename> <debug_limit> <num_actors> [<first_name> <last_name> <max_degree> ]{num_actors}, where:
 *     - <filename> is the name of the file containing links between actors (i.e., pairs of actors playing in the same movie);
 *     - <debug_limit> is the maximum number of actors whose information must be printed out;
 *     - <num_actors> is the number of actors to process. For each of these actors, the user specifies the first name (<first_name>), the last name (<last_name>),
 *       and the maximum number of degrees of separations that need to be analyzed (<max_degree>).
 * (2) The program prints:
 *     - The total number of actors in the file;
 *     - For up to <debug_limit> actors, their list of co-actors;
 *     - For each specified actor, the list of actors at each degree of separation, up to <max_degree>.
 */

#include <stdio.h>
#include <stdlib.h>
#include "actors.h"
//should i comment my main.c file? ... sure
int main(void) {
  char filename[256]; //filename variable
  int debug_limit, num_actors; // debug limit varibale read from input

  //read the input
  if (scanf("%255s %d %d", &filename, &debug_limit, &num_actors) != 3) { //check for 3 arguments in the input.
    printf("Invalid input\n");
    return 1; /// hmmmmmmm
  }
  //validate num_acotrs
  if(num_actors < 0) {
    printf("Invalid input\n");
    return 1; //????
  }
  FILE *file = fopen(filename, "r");
  if (!file) { // Checks for filename validity
    printf("File not found\n");
    return 1; // I was wondering if I should have returned 1 or a NULL but it works
  }
  //allocate actor list
  struct actor_list *list = malloc(sizeof(struct actor_list));
  if(!list) {
    printf("Memory allocation error\n");
    return 1;// honestly idk
  }
  list->head = NULL; // assigns the start node
  list->num_actors = 0; // resets num actors
  //load actors from file
  load_actor_list(list, filename); // call the actor list function to get the entire list of actors to sort
  if (debug_limit == -1) { //for the case of debug limit of -1 prints the whole list
     debug_limit = list->num_actors;
  }
   //print debug output
  load_actor_list(list, filename); // actually pretty simple but the load_actor_list function was hard


  if (debug_limit == -1) {
     debug_limit = list->num_actors;
  }
  print_actor_list(list, debug_limit);

  //process degrees of seperation
  for(int i = 0; i < num_actors; i++) {
    char first[100], last[100];
    unsigned max_degree;
    if(scanf("%99s %99s %u", first, last, &max_degree) != 3) {//checks for input validity
      printf("Invalid input\n");
      free(list);
      return 1;
    }
    separation(list, first, last, max_degree);// calls separation function which sadly doesnt do it for all degrees yet
  }
  free_actor_list(list);//CLEANUPPPPPPP!!!!!!!!!!!
  free(list); // i know it was said this part wasnt necessary but I kept having small issues with test so I figure I'd all the cleanup which helped
  return 0;
}