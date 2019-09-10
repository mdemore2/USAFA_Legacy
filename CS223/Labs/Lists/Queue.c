#include "Queue.h"
#include <stdlib.h>
#include <stdio.h>

Queue * queueCreate()
{
    return malloc(sizeof(Queue));
}
void queueDelete(Queue * the_queue)
{
    free(the_queue);
}
void queueEnqueue(Queue * the_queue, ElementType e)
{
    Node* new = malloc(sizeof(Node));
    new->data = e;
    new->next = NULL;
    if(the_queue->size > 0)
    {
        the_queue->last->next=new;
        the_queue->last=new;
    }
    else
    {
        the_queue->first=new;
        the_queue->last=new;
    }

    the_queue->size++;
}
ElementType queueDequeue(Queue * the_queue)
{
    Node * temp;
    ElementType val;
    temp = the_queue->first;
    the_queue->first=the_queue->first->next;
    val = temp->data;
    free(temp);
    the_queue->size--;
    return val;
}
int queueIsEmpty(Queue * the_queue)
{
    if(the_queue->first==NULL)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}
ElementType queuePeek(Queue * the_queue, int pos)
{
    Node * temp = the_queue->first;
    for(int i = 0; i < pos; i++)
    {
        temp = temp->next;
    }
    return temp->data;
}
ElementType queueFront(Queue * the_queue)
{
    return the_queue->first->data;
}
ElementType queueBack(Queue * the_queue)
{
    return the_queue->last->data;
}
int queueSize(Queue * the_queue)
{
    return the_queue->size;
}
void queueClear(Queue * the_queue)
{
    for (int i = 0; i < the_queue->size; ++i)
    {
        queueDequeue(the_queue);
    }
}

