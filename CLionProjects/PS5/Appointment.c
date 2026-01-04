// implementation of Appointment functions
// Your Name:

#include "Appointment.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// time functions
int timeSlot(const struct time* t) {
    /* Converts a time to an appointment slot. Will return an integer between 0 and 20.*/

    return 2 * (t->hrs - 8) + (t->mins / 30);
    //return -1;
}

void slotTime(int slot, struct time* t) {
    t->hrs = 8 + (slot / 2);
    t->mins = (slot % 2) * 30;
    return;
}

int readFile(const char * filename, Appointment* appts) {
    for (int i =0; i < 21; i++)
    {
        appts[i].booked = 0;
    }
    FILE *file = fopen(filename, "r");
    if (file == NULL)
    {
        return -1;
    }
    int numAppointments = 0;
    int hrs, mins;
    char owner[25], pet[25], type[25];
    while (fscanf(file, "%d:%d %24s %24s %24s", &hrs,&mins, owner, pet, type) == 5)
    {
        struct time t = {hrs, mins};
        int slot = timeSlot(&t);

        appts[slot].booked = 1;
        strncpy(appts[slot].ownerName, owner, 24);
        strncpy(appts[slot].petName, pet, 24);
        strncpy(appts[slot].petType, type, 24);
        appts[slot].arrival = t;

        numAppointments++;
    }
    fclose(file);
    return numAppointments;
}

void printAppointment(FILE* stream, const Appointment * a) {
    if (a->booked)
        fprintf(stream, "%02d:%02d %s / %s (%s)\n", a->arrival.hrs, a->arrival.mins, a->ownerName, a->petName, a->petType);

}

void printAll(FILE* stream, const Appointment *a) {
    for (int i = 0; i < 21; i++)
    {
        if (a[i].booked)
        {
            printAppointment(stream, &a[i]);
        }
    }
    return;
}
