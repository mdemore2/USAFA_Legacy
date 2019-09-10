//
// Created by C19Mark.Demore on 2/3/2017.
//

/** lab11.c
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Section: M3A
 * Project: Lab 11
 * Purpose: Demonstrate the use of a stack.
 * ===========================================================
 */

#include "Stack.h"
#include <stdio.h>

int main() {
    Stack *     myStack;
    ElementType value;

    myStack = stackCreate();

    // Fill the stack with values until the user enters 0
    printf("Please enter a floating point value (0 to quit): ");
    scanf("%f", &value);
    while (value != 0.0) {
        stackPush(myStack, value);

        printf("Please enter a floating point value (0 to quit): ");
        scanf("%f", &value);  // change to %d if ElementType is int
    }

    // Print the values on the stack, which prints in reverse order
    while (! stackIsEmpty(myStack)) {
        value = stackPop(myStack);
        printf("%g  ", value); // change to %d if ElementType is int
    }
    printf("\n");

    stackDelete(myStack);
}

