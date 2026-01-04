#include <stdio.h>
#include <string.h>
#include <ctype.h>   // ispunct

int wordInfo(const char* fileName, char shortest[], char longest[], char lowest[], char highest[]);

int main() {
    char filename[25];
    char shortWord[16] = "";
    char longWord[16] = "";
    char firstWord[16] = "";
    char lastWord[16] = "";
    printf("Filename: ");
    fflush(stdout);
    scanf("%24s", filename);

    int w = wordInfo(filename, shortWord, longWord, firstWord, lastWord);
    if (w < 0) {
        printf("Unable to open file: %s\n", filename);
        return -1;
    }
    printf("File has %d words.\n", w);
    printf("Shortest word: %s\n", shortWord);
    printf("Longest word: %s\n", longWord);
    printf("Alphabetically first: %s\n", firstWord);
    printf("Alphabetically last: %s\n", lastWord);

    return 0;
}

int wordInfo(const char *fileName, char *shortest, char *longest, char *lowest, char *highest) {
    FILE *file = fopen(fileName, "r");
    if (!file) return -1;

    char word[16];
    int wordCount = 0;

    while (fscanf(file, "%15s", word) == 1) {

        int len = strlen(word);
        while (len > 0 && ispunct((unsigned char)word[len - 1])) {
            word[--len] = '\0';
        }

        if (wordCount == 0 || strlen(word) < strlen(shortest)) {
            strcpy(shortest, word);
        }
        if (wordCount == 0 || strlen(word) > strlen(longest)) {
            strcpy(longest, word);
        }
        if (wordCount == 0 || strcasecmp(word, lowest) < 0) {
            strcpy(lowest, word);
        }
        if (wordCount == 0 || strcasecmp(word, highest) > 0) {
            strcpy(highest, word);
        }

        wordCount++;
    }

    fclose(file);
    return wordCount;
}