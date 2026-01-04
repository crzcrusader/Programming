/* ECE 209, Spring 2025
* Six degrees of separation game (header file)
*/

#ifndef ACTORS_H
#define ACTORS_H

#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>

/* MACRO FOR DEBUGGING PURPOSES */
//#define DEBUG // uncomment to show debugging information
#ifdef DEBUG
    #define debug(...) printf(__VA_ARGS__)
#else
    #define debug(...)
#endif

/* Data structure representing an actor within a linked list */
struct actor {
    char *firstname;            // actor's first name
    char *lastname;             // actor's last name
    struct coactor *coactors;   // list of co-actors
    unsigned num_coactors;      // number of co-actors
    struct actor *next;         //next actor in the list
};

/* Data structure representing a linked list of actors (and their relationships) */
struct actor_list {
    struct actor *head;     // head of the linked list of authors
    unsigned num_actors;    // number of actors in the list
};

/* Data structure representing a co-actor within a linked list */
struct coactor {
   /* FILL HERE */
   struct actor *person;
   struct coactor *next;
};


/* Given the first and last names of an actor, creates, initializes and returns a struct actor */
struct actor *new_actor(const char *firstname, const char *lastname);

/* Checks whether an actor with a specified first and last name exists in the given actor list.
 * If not, the function adds the actor to the linked list in alphabetical order by last name. If the last names are the same, it sorts them in alphabetical order by first name.
 * Returns the corresponding (new or existing) struct actor. */
struct actor *lookup(struct actor_list *list, const char *firstname, const char *lastname);

/* Prints the first name, last name and relationships of up to "limit" actors within an actor list.
*  If limit is equal to -1, it prints the information of all the actors in the list.
*/
void print_actor_list(struct actor_list *list, int limit);

/* Reads a file containing a list of co-actor relationships and populates the given actor list accordingly. */
void load_actor_list(struct actor_list *list, const char *filename);

/* Given a list of actors, a specific actor (identified by first and last name), and a maximum degree of separation (max_degree),
 * the function prints the list of actors at each degree of separation up to the specified maximum. */
void separation(struct actor_list *list, const char *firstname, const char *lastname, unsigned max_degree);
void free_actor_list(struct actor_list *list);

#endif //ACTORS_H
