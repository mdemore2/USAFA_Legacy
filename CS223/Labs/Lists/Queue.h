/** Queue.h
 * ===========================================================
 * Name: Mark Demore II, Spring 2017
 * Section: T3A
 * Project: Lab 13
 * Purpose: Define an interface to a Queue data structure.
 * ===========================================================
 */

#ifndef QUEUE_H
#define QUEUE_H

#include "linkedlist.h"  // FIX THIS to include the correct path to your LinkedList.h file

typedef struct linkedList Queue;

// Standard Queue functionality
Queue *     queueCreate ();
void        queueDelete (Queue *q);
void        queueEnqueue(Queue *q, ElementType element);
ElementType queueDequeue(Queue *q);
int         queueIsEmpty(Queue *q);

// Optional Queue functionality
ElementType queuePeek   (Queue *q, int index);
ElementType queueFront  (Queue *q);
ElementType queueBack   (Queue *q);
int         queueSize   (Queue *q);
void        queueClear  (Queue *q);

#endif // QUEUE_H