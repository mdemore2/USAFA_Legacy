/** lab13.c
 * ===========================================================
 * Name: Mark Demore II, Spring 2017
 * Section: T3A
 * Project: Lab 13
 * Purpose: Demonstrate the use of a queue.
 * ===========================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include "Queue.h"
#include "Queue.c"

int main() {
    Queue *     myQueue;
    ElementType value;

    myQueue = queueCreate();

    // Fill the stack with values until the user enters 0
    printf("Please enter a floating point value (0 to quit): ");
    scanf("%f", &value);
    while (value != 0.0) {
        queueEnqueue(myQueue, value);

        printf("Please enter a floating point value (0 to quit): ");
        scanf("%f", &value);  // change to %d if ElementType is int
    }

    // Print the value at the front of the queue
    printf("Front of queue: %f\n", queueFront(myQueue));

    // Print the value at the end of the queue
    printf("Back of queue: %f\n", queueBack(myQueue));

    // Print the entire queue without changing the contents of the queue
    for (int j=0; j<queueSize(myQueue); j++) {
        printf("Queue position %d has a value of %f\n", j, queuePeek(myQueue, j));
    }

    // Print the values on the stack, which prints in reverse order
    while (! queueIsEmpty(myQueue)) {
        value = queueDequeue(myQueue);
        printf("%g  ", value); // change to %d if ElementType is int
    }
    printf("\n");

    // Verify that the queue is empty
    printf("The queue has %d elements in it.\n", queueSize(myQueue));


    // Make the queue wrap around in the circular array by adding a few
    // elements and them deleting a few elements. If we add three and
    // then remove two over and over, the queue will grow slowly by one
    // element.
    for (int j=0; j<7; j++) {
        // Add 3 elements to the queue
        for (int add=0; add<3; add++) {
            value = ((float) random() / (float) RAND_MAX) * 20.0f;
            printf("Enqueue %8.2f\n", value);
            queueEnqueue(myQueue, value);
        }
        // Remove 2 elements from the queue
        for (int remove=0; remove<2; remove++) {
            value = queueDequeue(myQueue);
            printf("Dequeued %8.2f\n", value);
        }
        // Display the entire contents of the queue
        printf("\nThe queue's current contents are:\n");
        for (int k=0; k<queueSize(myQueue); k++) {
            printf("Queue position %d has a value of %8.2f\n", k, queuePeek(myQueue, k));
        }
        printf("\n");
    }
    queueDelete(myQueue);
}



