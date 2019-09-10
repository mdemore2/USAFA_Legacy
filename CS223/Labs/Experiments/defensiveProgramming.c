//
// Created by C19Mark.Demore on 4/5/2017.
//

//
// Created by Wayne.Brown on 2/14/2017.
//

#include <stdlib.h>
#include <stdio.h>

int extractWords(char buffer[], char wordList[][10]);
void printWords(char wordList[][10], int numberWords);

int main() {
    char wordList[20][10];
    char string[] = "This, is, a, test, abcdefghijklmnop";

    int n = extractWords(string, wordList);
    printWords(wordList, n);
}

/**
 * Given a string which contains "words" separated by commas,
 * fill the 2D array, wordList, with the individual words.
 * @param buffer - the input string.
 * @param wordList - the array of words
 */
int extractWords(char buffer[], char wordList[][10]) {
    int row = 0;
    int column = 0;
    int j = 0;
    while (buffer[j] != '\0') {
        if (buffer[j] == ' ') {
            ; // skip any spaces
        } else if (buffer[j] == ',') {
            // end the current word and start a new word
            wordList[row][column] = '\0';
            row++;
            if(row > 20)
            {
                printf("Too many words.\n");
                return (row-1);
            }
            column = 0;
        } else {
            if(column >= 10)
            {
                wordList[row][10] = '\0';
                printf("String out of bounds.\n");
            }
            else
            {
                wordList[row][column] = buffer[j];
                column++;
            }
        }
        j++;
    }
    // Finish off the last word
    wordList[row][column] = '\0';
    row++;

    return row;
}

/**
 * Given an array of strings and the number of words in the array,
 * print the individual words to the console, one word per line.
 * @param wordList - an array of strings
 * @param numberWords - the number of words in the array
 */
void printWords(char wordList[][10], int numberWords) {
    for (int j=0; j<numberWords; j++) {
            printf("%s\n", wordList[j]);
    }
}
