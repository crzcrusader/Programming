// ECE 209 - Fall 2021 - PS5
// Reads a file of appointments for a veterinary clinic
// Prints booked appointments in order of time

#include <stdio.h>
#include "Appointment.h"

int test1();
int test2();

int main() {

    // table of appointment slots, from 8am to 6pm
    Appointment mon[21], fri[21];

    int num = 0;           // number of appointments

    // Task 1 -- translate between time and appointment slot
    printf("Test 1: convert from time to appointment slot\n");
    if (!test1()) {
        printf("FAILED\n");
        return 0;
    }
    printf("PASSED\n");

    printf("Test 2: convert from appointment slot to time\n");
    if (!test2()) {
        printf("FAILED\n");
        return 0;
    }
    printf("PASSED\n");

    // TASK 2: reading appointments from file
    printf("Test 3: open non-existent file\n");
    if (readFile("tuesday.txt", mon) != -1) {
        printf("FAILED\n");
        return 0;
    }
    printf("PASSED\n");
    printf("Test 4: monday.txt\n");
    if ((num = readFile("monday.txt", mon)) != 12) {
        printf("Read %d appointments, should have read 12\n", num);
        return 0;
    }
    printf("Correct # returned -- use debugger to check whether array is correct\nPASSED\n");
    printf("Test 5: friday.txt\n");
    if ((num = readFile("friday.txt", fri)) != 7) {
        printf("Read %d appointments, should have read 7\n", num);
        return 0;
    }
    printf("Correct # returned -- use debugger to check whether array is correct\nPASSED\n");

    // TASK 3 -- Print a single appointment
    Appointment a = { true, "Spot", "dog", "Jane", {10, 30}};
    printf("Test 6: Printing a single appointment.\n");
    printf("Should print: 10:30 Jane / Spot (dog)\n");
    printAppointment(stdout, &a);
    printf("\n");

    // TASK 4 -- Print all booked appointments in an array
    printf("Test 7: Print Monday's appointments\n");
    printAll(stdout, mon);
    printf("\nTest 8: Print Friday's appointments\n");
    printAll(stdout, fri);

    return 0;
}

// TEST FUNCTIONS

// convert time to appointment slot
int test1() {
    int testSlots[5] = {0, 20, 4, 7, 15};
    int testHrs[5] = {8, 18, 10, 11, 15};
    int testMins[5] = {0, 0, 0, 30, 30};
    int errors = 0;
    int s;
    for (int i = 0; i < 5; i++) {
        struct time t = {testHrs[i], testMins[i]};
        s = timeSlot(&t);
        if (s != testSlots[i]) {
            printf("Time %02d:%02d should be slot %d, returned %d\n",
                   testHrs[i], testMins[i], testSlots[i], s);
            errors++;
        }
    }
    return (errors == 0);
}

// convert appointment slot to time
int test2() {
    int testSlots[5] = {0, 20, 4, 7, 15};
    int testHrs[5] = {8, 18, 10, 11, 15};
    int testMins[5] = {0, 0, 0, 30, 30};
    int errors = 0;
    for (int i = 0; i < 5; i++) {
        struct time t = {0, 0};
        slotTime(testSlots[i], &t);
        if ((t.hrs != testHrs[i]) || (t.mins != testMins[i])) {
            printf("Slot %d should be %02d:%02d, returned %02d:%02d\n",
                   testSlots[i], testHrs[i], testMins[i], t.hrs, t.mins);
            errors++;
        }
    }
    return (errors == 0);
}

