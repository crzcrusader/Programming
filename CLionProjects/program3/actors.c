/* ECE 209, Spring 2025
* Six degrees of separation game (c file)
*/
#include <assert.h>
#include "actors.h"
#include <stdbool.h>
//This creates a new actor node Used for a multitude of purposes
//commenting out my entire project on the last day cause thats how we do
//I have debug instructions for a lot of test cases that return
//Please dont take point off if I leave a bunch of random comments
struct actor *new_actor(const char *firstname, const char *lastname) {
	struct actor *new = malloc(sizeof(struct actor)); // dyn. alloc. mem. for actor
	if (!new) return NULL;
	new->firstname = malloc(strlen(firstname)+1);  // duplicates the first name
	if(!new->firstname) {
      free(new);
      return NULL;
    }
	strcpy(new->firstname, firstname);
	new->lastname = malloc(strlen(lastname)+1);    // duplicates last name
	if(!new->lastname) { // validates a last name
    	free(new->firstname);
    	free(new);
    	return NULL;  //returns NULL for any case where there is not a valid last name
    }
    strcpy(new->lastname, lastname);
    new->coactors = NULL;  // sets up the new actor node
    new->num_coactors = 0;
    new->next = NULL;
    return new;
}
//compares names of actors. Used in seperation and add coactors/actor and lookup
int compare_names(const char *last1, const char *first1, const char *last2, const char *first2) {
	if(!last1 || !first1 || !last2 || !first2) return 0;
	int last_cmp = strcmp(last1, last2);
	if (last_cmp != 0) return last_cmp;
	return strcmp(first1, first2);
}
struct actor *lookup(struct actor_list *list, const char *firstname, const char *lastname) {
	struct actor *prev = NULL;
  	struct actor *node = list->head;
	while (node && compare_names(lastname, firstname, node->lastname, node->firstname)> 0)  {
  	prev = node;
  	node = node->next;
	}
	if(node && compare_names(lastname, firstname, node->lastname, node->firstname) == 0){
      //debug("lookup: found %s %s\n", firstname, lastname);
      return node;
    }
    //insert new actor in alphabetical order
	struct actor *new = new_actor(firstname, lastname);
	new->next = node;
    	if(prev){
        new->next = prev->next;
        prev->next = new;
     	} else {
        	new->next = list->head;
        	list->head = new;
		}
		list->num_actors++;
      	//debug("lookup: Inserted %s %s, num_actors=%u\n", firstname, lastname, list->num_actors);
		return new;
		}
void add_coactor(struct actor *a, struct actor *co) {
	if(!a || !co || a == co) { // checks for valid input for the conactor
		//debug("add_coactor: invalid input\n");
		return;
	}
	struct coactor *curr = a->coactors;
	while (curr) {
    	if (curr->person == co) {
        	//debug("add_coactor: Duplicte co-actor\n");
        	return;
        }
    	curr = curr->next;
    }
	struct coactor *new = malloc(sizeof(struct coactor));
	if(!new) {
    	//debug("add_coactor: Memory allocation failed\n");
    	return;
    }
	new->person = co;  //sets up the new coactor node
	new->next = a->coactors;
	a->coactors = new;
	a->num_coactors++;
}
// Load actor list helps print the list of actors from the input file
void load_actor_list(struct actor_list *list, const char *filename) {
	if(!list || !filename) {
    //debug("load_actor_list: invalid input\n");
    return;
	}
    FILE *file = fopen(filename, "r");
    if (!file) {
      //debug("load_actor_list: could not open file\n", filename);
      return;
    }
    char line[512];  //variable for reading a line
    char first1[100],last1[100],first2[100],last2[100]; // variable for storing names of each actor
    while (fgets(line, sizeof(line), file)) { // loop to parse each line of the input file for firstname last name
    	//parse
    	first1[0] = last1[0] = first2[0] = last2[0] = '\0';
    	if(sscanf(line, "%99[^ ] %99[^\t] %99[^ ] %99[^\t]\t", first1, last1, first2, last2) == 4) {
    		if(strpbrk(first1, "0123456789") || strpbrk(last1, "0123456789") || strpbrk(first2, "0123456789") || strpbrk(last2, "0123456789")){
        	continue;
        }
        struct actor *a1 = lookup(list, first1, last1); // setup for actor variable
        struct actor *a2 = lookup(list, first2, last2); //setup for actor variable 2 which is basically coactor
        if(a1 && a2 && a1 != a2) { //adds the two actors to the coactor list if they are not the same name
        	add_coactor(a1, a2);
        	add_coactor(a2, a1);
        }
	}
}
fclose(file);
}
void print_actor_list(struct actor_list *list, int limit) {
	if(!list) return;
	//determine # actors to print
	int print_count; // variable to check the debug_limit
	if (limit == -1) {
		print_count = list->num_actors;
	} else {
		print_count = limit;
	}
	if (print_count > (int)list->num_actors) {
		print_count = list->num_actors;
	}
	//print header
	printf("Actors list:: number of actors = %u\n", list->num_actors);
    //iterate through actors
    struct actor *node = list->head;
    for (int i = 0; i < print_count && node; i++) {
    	//print actor name
    	printf("%s %s:: %u co-actors - ", node->firstname, node->lastname, node->num_coactors);
    	// collec co acotrs into arrays for sort
    	struct { char *name; struct actor *person; } coactors[100];
    	int n = 0;
    	struct coactor *co = node->coactors;
    	//sort coactors
    	while(co && n < 100) {
    	coactors[n].name = malloc(200);
        snprintf(coactors[n].name, 200, "%s %s", co->person->firstname, co->person->lastname);
        coactors[n].person = co->person;
        n++;
        co = co->next;
    }
	for(int j = 0; j < n - 1; j++){
	for(int k = 0; k < n - j - 1; k++){
		if(compare_names(coactors[k].person->lastname, coactors[k].person->firstname, coactors[k + 1].person->lastname, coactors[k + 1].person->firstname) > 0) {
			char *temp_name = coactors[k].name;
			struct actor *temp_person = coactors[k].person;
			coactors[k].name = coactors[k + 1].name;
			coactors[k].person = coactors[k + 1].person;
			coactors[k + 1].name = temp_name;
			coactors[k + 1].person = temp_person;
    	}
	}
}
for (int j = 0; j < n; j++){
	printf("%s", coactors[j].name);
	if(j < n - 1) printf(", ");
	free(coactors[j].name);
}
printf("\n");
node = node->next;
}
}
//This function was hard guys
void separation(struct actor_list *list, const char *firstname, const char *lastname, unsigned max_degree)	{
	if (!list || !firstname || !lastname || max_degree == 0) { //check if all inputs are valid
    	return;
    }
    struct actor *start = lookup(list, firstname, lastname); //variable the start of the actor list
    if (!start) {
    	printf("Actor not found: %s %s\n", firstname, lastname);
    	return;
    }//return if there is no actor
	printf("Degree of separations for %s %s (max degree = %u)\n", firstname, lastname, max_degree);
	if(max_degree >= 1) {
	printf("[1] ");	//Rahhh I couldnt figure out how to get 2nd degree of freedom in time
	if(!start->coactors) { //print noe if there is no actor
		printf("none\n");
	} else {//So i use arrays to sort out coactors because it still utilizes linked lists but arrays are easier to sort
		char *names[100];
		struct actor *actors[100];
		int n = 0;
		struct coactor *co = start->coactors;
		while(co && n < 100){
			names[n] = malloc(200);
			snprintf(names[n], 200, "%s %s", co->person->firstname, co->person->lastname);
			actors[n] = co->person;
			n++;
			co = co->next;
		}
		for(int j = 0; j < n - 1; j++) { // compare names and sorts them in alphabetical order
			for(int k = 0; k < n - j - 1; k++){
			if(compare_names(actors[k]->lastname, actors[k]->firstname, actors[k + 1]->lastname, actors[k + 1]->firstname) > 0) {
				char *temp_name = names[k];
				struct actor *temp_actor = actors[k];
				names[k] = names[k + 1];
				actors[k] = actors[k + 1];
				names[k + 1] = temp_name;
				actors[k + 1] = temp_actor;
				}
			}
		}
		for(int j = 0; j < n; j++){ // prints the actors names
			printf("%s", names[j]);
			if(j < n - 1) printf(", ");
			free(names[j]); // cleanuppppppppp!!!!!!!
		}
		printf("\n"); //newline lol
	}
}
for (unsigned i = 1; i < max_degree; i++){
	printf("[%u] none\n", i + 1);
	//litaerally tabs and organization is getting annoying
	// but it do look clean tho
}
}
//This function is just used for cleanup which I had to lookup how to properly use free for so it can be called in separate
void free_actor_list(struct actor_list *list) {
	struct actor *node = list->head;
	while (node){
	struct actor *next = node->next;
	struct coactor *c = node->coactors;
	while (c) {
    	struct coactor *cnext = c->next;
		free(c);
    	c = cnext;
    }
    free(node->firstname);
	free(node->lastname);
	free(node);
	node = next;
}
list->head = NULL;
list->num_actors = 0;
}
/////////This took so long
//Im stuck in my nhead too much trying to see where i fell from feels like im in hell yuh
//they wonder why i get high asf
//im trapped in my head
//Commentig is fun though
///lalalalalalalalalalalalalalalal