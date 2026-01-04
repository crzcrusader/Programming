// this program intakes an unsigned integer number, stores it into a string
// and reprints it with commas seperating every group of three digits
// such as 1,234,567


#include <stdio.h>
int intToStr(unsigned int num, char str[], unsigned int n);
int main(void)
{
    unsigned int num;  // The number to convert
    printf("Enter an integer: ");
    scanf("%d", &num);
    char str[100];                 // Buffer for the resulting string (large enough)
    unsigned int size = sizeof(str);  // The size of the character array

    // Call the function
    if (intToStr(num, str, size)) {
        printf("Formatted number: %s\n", str);
    } else {
        printf("Buffer too small!\n");
    }

    return 0;
}
int intToStr(unsigned int num, char str[], unsigned int n)
{
    int numDigits = 0, temp = num;

    do{
        numDigits++;
        temp /= 10;
    } while (temp > 0);
    //counts digits in integer
    unsigned int numcommas = (numDigits - 1) / 3;
    unsigned int totallength = numDigits + numcommas;

    if (totallength + 1 > n)
    {
        return 0;
    }
    str[totallength] = '\0';

    int index = totallength - 1;
    int count = 0;

    do
    {
        str[index--] = '0' + num % 10;
        num /= 10;
        count++;
        if (count % 3 == 0 && num > 0)
        {
            str[index--] = ',';
        }
    }while (num > 0);
    return 1;
}