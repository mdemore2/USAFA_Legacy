//
// Created by C19Mark.Demore on 2/6/2017.
//

/** lab12_palindrome.c
 * ===========================================================
 * Name: C3C Mark Demore II, Spring 2017
 * Section: T3A
 * Project: Lab 12
 * Purpose: Use a stack to solve a problem. #TacocaT
 * ===========================================================
 */

#include <stdio.h>     // defines printf(), scanf
#include <string.h>    // defines strlen()
#include <ctype.h>     // defines isalpha(), isdigit(), & tolower()
#include <stdlib.h>    // defines malloc()

#include "Stack.h"


#define TRUE 1
#define FALSE 0

char * cleanString(char *originalString);

/**
 * Prompt the user for a string and determine if it is palindrome.
 * @return 0 if there were no errors.
 */
int main() {
    int const MAX_STRING_LENGTH = 300;
    char    inputString[MAX_STRING_LENGTH];
    //char    inputString[] = "A man, a plan, a canal, Panama!"; // hardcoded while debugging
    char  * testString;
    int     palindrome;

    // Read a string from a user; commented out while debugging
   printf("Please enter a string: ");
    fgets(inputString, MAX_STRING_LENGTH, stdin);
    inputString[strcspn(inputString, "\n")] = '\0';  // remove the trailing new-line character

    // Remove all characters from the string that are not letters or digits.
    testString = cleanString(inputString);
    printf("Palindrome string: '%s'\n", testString);

    // STEP 1: Create a stack
    Stack * palStack = stackCreate();

    // STEP 2: Push all the characters onto a stack
    for(int i = 0; i < (strlen(testString)/2); i++)
    {
        stackPush(palStack, testString[i]);
    }
    for(int j = (strlen(testString)/2)+1; j < strlen(testString);j++)
    {
        if(stackPop(palStack)==testString[j])
        {
            palindrome=1;
        }
        else
        {
            palindrome=0;
            j=strlen(testString)+1;
        }
    }
    // STEP 3: Get the characters off of the stack and compare them against the original string

    // Display the results
    if (palindrome) {
        printf("'%s' is a palindrome\n", inputString);
    } else {
        printf("'%s' is NOT a palindrome\n", inputString);
    }

    return 0; // Which indicates no errors occurred during exexcution
}

/** -------------------------------------------------------------------
 * Given a string, create a copy of the string that contains only its
 * @param originalString
 * @return
 */
char * cleanString(char *originalString) {
    char * newString = (char *) malloc(strlen(originalString) + 1);
    int    k = 0;
    char   c;

    for (int j=0; j<strlen(originalString); j++) {
        c = tolower(originalString[j]);
        if (isalpha(c) || isdigit(c)) {
            newString[k] = c;
            k++;
        }
    }
    newString[k] = '\0';  // null terminate the new string
    return newString;
}