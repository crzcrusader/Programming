#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void)
{
    int min, max;
    printf("Please enter an integer value from 1 to 99(MIN): ");
    scanf("%d", &min);
    printf("Please enter an integer value from 1 to 99(MAX): ");
    scanf("%d", &max);
    //seed the random number gen
    srand(time(NULL));

    int randomNumber = rand() % (max - min + 1) + (min);

    printf("Randome Number between %d and %d = %d\n", min, max, randomNumber);
    printf("Thank you!\n");
    return 0;
}