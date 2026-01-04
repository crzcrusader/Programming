//Cruz Sanchez
#include <stdio.h>

int main(void)
{
    printf("Enter a number: ");
    // flush(stdout);
    int number = 0;
    int digit = 0;
    scanf("%d", &number);
    printf("Enter a digit: ");
    scanf("%d", &digit);
    int userinput = number;
    int counter = 0;
    // fflush(stdout);
    if (userinput == 0)
    {
        counter = 1;
    }
    else
    {
        while (userinput != 0)
        {
            if ((userinput % 10) == digit)
            {
                counter++;

            }
            userinput = userinput / 10;
        }
    }
    printf("The digit %d appears %d times in %d.\n", digit,counter,number);

    return 0;
}