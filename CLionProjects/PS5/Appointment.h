// ECE 209 - Fall 2021 - PS5
// definition of appointment data structure
// declaration of functions to be implemented

#ifndef PS5_APPOINTMENT_H
#define PS5_APPOINTMENT_H

#include <stdbool.h>
#include <stdio.h>

struct time {  // using 24-hour clock
    int hrs;     // 0 - 23
    int mins;    // 0 - 59
};

struct appt {
    bool booked;
    char petName[25];    // one word only, no spaces
    char petType[25];    // e.g., dog, cat, goldfish... -- one word only
    char ownerName[25];  // last name only, no spaces
    struct time arrival;
};
typedef struct appt Appointment;

// function declarations
int timeSlot(const struct time* t);
void slotTime(int slot, struct time* t);

int readFile(const char * fname, Appointment* table);
void printAppointment(FILE*, const Appointment *a);
void printAll(FILE*, const Appointment *table);

#endif //PS5_APPOINTMENT_H
