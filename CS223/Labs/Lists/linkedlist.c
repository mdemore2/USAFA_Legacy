//
// Created by C19Mark.Demore on 1/18/2017.
//

#include "linkedlist.h"
#include <stdlib.h>
#include <stdio.h>

int main()
{
    /*LinkedList* my_list = malloc(sizeof(LinkedList));
    my_list->size = 1;
    my_list->first = malloc(sizeof(Node));
    my_list->first->data = 1;
    my_list->last = my_list->first;

    linkedListAppend(7,my_list);
    linkedListAppend(6,my_list);
    linkedListAppend(3,my_list);
    linkedListAppend(5,my_list);
    linkedListAppend(9,my_list);
    linkedListAppend(4,my_list);
    linkedListAppend(8,my_list);

    linkedListDeleteElement(my_list,4); //NOTE: accepts index value
    linkedListPrint(my_list);
    int retVal=linkedListGetElement(my_list,3); //Also uses index value, keep consistent
    printf("%d\n",retVal);

    linkedListDelete(my_list);
    linkedListPrint(my_list);
    printf("\nSplit");
    */

    LinkedList* new_list = linkedListCreate(7);
    linkedListChangeElement(new_list,3,12);
    linkedListInsertElement(new_list,5,11);
    int retVal = linkedListFindElement(new_list,11);
    printf("%d\n",retVal);
    linkedListPrint(new_list);

    printf("\nBreak");
    linkedListSelectSort(new_list); // all working, all functions use index values.
    linkedListPrint(new_list);

    return 0;
}
void linkedListAppend(ElementType newValue, LinkedList* the_list)
{
    the_list->size++;
    Node* new = malloc(sizeof(Node));

    new->data = newValue;
    new->next = NULL;

    if(the_list->last == NULL)
    {
        the_list->last = new;
        the_list->first = new;
    }
    else
    {
        the_list->last->next = new;
        the_list->last = new;
    }

}
void linkedListDelete(LinkedList* the_list)
{
    Node* current = the_list->first;
    Node* nexty;
    while(current!=NULL)
    {
        nexty=current->next;
        free(current);
        current = nexty;
    }
    the_list->first = NULL;
    the_list->last = NULL;
    the_list->size=0;
}
void linkedListDeleteElement(LinkedList* the_list, int offset)
{
    Node* current = the_list->first;
    Node* successor;
    Node* predeccesor;
    the_list->size--;
    for(int i = 0; i < (offset-1); i++)
    {
        current=current->next;
    }
    predeccesor=current;
    current=current->next;
    successor=current->next;
    predeccesor->next=successor;
    free(current);
}
void linkedListPrint(LinkedList* the_list)
{
    Node* iterator = the_list->first;
    if( iterator==NULL)
    {
        printf("The list is empty");
    }
    while(iterator != NULL)
    {
        printf("%d\n", iterator->data);
        iterator = iterator->next;
    }
}
ElementType linkedListGetElement(LinkedList* the_list, int pos)
{
    Node* temp = the_list->first;
    ElementType val;
    for(int i =0; i < pos; i++)
    {
        temp=temp->next;
    }
    val = temp->data;
    return val;
}
void linkedListInsertElement(LinkedList* the_list, int pos, ElementType val)
{
    Node* current = the_list->first;
    Node* successor;
    Node* predeccesor;
    the_list->size++;

    for(int i = 0; i < (pos-1); i++)
    {
        current=current->next;
    }
    predeccesor=current;
    current=current->next;
    successor=current->next;
    predeccesor->next=successor;

    Node* new = malloc(sizeof(Node));
    new->data = val;
    new->next = current;
    predeccesor->next=new;
}
void linkedListChangeElement(LinkedList* the_list, int pos, ElementType newVal)
{
    Node* current = the_list->first;
    for(int i=0; i < pos; i++)
    {
        current=current->next;
    }
    current->data=newVal;
}
int linkedListFindElement(LinkedList* the_list, ElementType val)
{
    int count = 0;
    Node* iterator = the_list->first;
    while(iterator->data != val)
    {
        iterator=iterator->next;
        count++;
    }
    return count;
}
LinkedList* linkedListCreate(int initSize)
{
    LinkedList* my_list = malloc(sizeof(LinkedList));
    for(int i = 0; i < initSize; i++)
    {
        linkedListAppend(initSize,my_list);
    }
    return my_list;
}
void linkedListSelectSort(LinkedList* the_list)
{
    Node* temp = the_list->first;
    Node* iterator = the_list->first;
    Node* place = the_list->first;
    int holder;
    while(place != NULL)
    {
        while(iterator != NULL)
        {
            if (iterator->data < temp->data)
            {
                temp = iterator;
            }
            iterator=iterator->next;

        }
        holder = temp->data;
        temp->data = place->data;
        place->data = holder;
        place=place->next;
        iterator=place;
        temp= place;
    }

}