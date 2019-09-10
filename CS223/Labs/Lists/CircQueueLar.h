//
// Created by C19Mark.Demore on 2/10/2017.
//

#ifndef CS223_REPOSITORY_SPRING_2017_CIRCQUEUELAR_H
#define CS223_REPOSITORY_SPRING_2017_CIRCQUEUELAR_H

typedef float ElementType;

typedef struct queue{
    int size;
    int front;
    int back;
    ElementType* arrayQueue;
}Queue;

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


#endif //CS223_REPOSITORY_SPRING_2017_CIRCQUEUELAR_H
