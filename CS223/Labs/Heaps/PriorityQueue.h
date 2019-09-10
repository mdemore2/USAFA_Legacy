/** PriorityQueue.h
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Section:
 * Project: Lab 31
 * Purpose: Implement a priority queue using a max-heap.
 * ===========================================================
 */

#ifndef PRIORITY_QUEUE_H
#define PRIORITY_QUEUE_H

#include "../../Trees/Heap.h"

typedef Heap * PriorityQueue;

PriorityQueue pqCreate(int queueCapacity, int bytesPerElement,
                       greaterThanFunction func);
void   pqDelete(PriorityQueue pq);
void   pqEnqueue(PriorityQueue pq, void *newElement);
void * pqDequeue(PriorityQueue pq);

#endif // PRIORITY_QUEUE_H
