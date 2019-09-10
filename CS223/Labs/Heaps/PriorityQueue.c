/** PriorityQueue.c
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Section:
 * Project: Lab 31
 * Purpose: Implement a priority queue using a max-heap.
 * ===========================================================
 */

#include "PriorityQueue.h"

PriorityQueue pqCreate(int queueCapacity, int bytesPerElement,
                       greaterThanFunction func) {
    // Create an array to hold the max-heap.
    void * array = malloc(queueCapacity * bytesPerElement);

    // Return the max-heap that will store the priority queue
    return maxHeapCreate(array, queueCapacity, 0,
                         bytesPerElement, func);
}

void   pqDelete(PriorityQueue pq) {
    maxHeapDelete(pq);
}

void   pqEnqueue(PriorityQueue pq, void *newElement) {
    maxHeapInsertNewElement(pq, newElement);
}

void * pqDequeue(PriorityQueue pq) {
    return maxHeapRemoveMaximumElement(pq);
}


