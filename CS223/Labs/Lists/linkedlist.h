//
// Created by C19Mark.Demore on 1/18/2017.
//

#ifndef CS223_REPOSITORY_SPRING_2017_LINKEDLIST_H

typedef float ElementType;

typedef struct node
{
    ElementType data;
    struct node* next;

} Node;

typedef struct linkedList
{
    int size;
    Node* first;
    Node* last;
} LinkedList;
LinkedList *linkedListCreate(int initSize);
void linkedListAppend(ElementType newValue, LinkedList* the_list);
void linkedListDelete(LinkedList* the_list);
void linkedListDeleteElement(LinkedList* the_list, int offset);
void linkedListPrint(LinkedList* the_list);
ElementType linkedListGetElement (LinkedList* list, int position);
void linkedListInsertElement(LinkedList* list, int position, ElementType value);
void linkedListChangeElement(LinkedList* list, int position, ElementType newValue);
int linkedListFindElement (LinkedList* list, ElementType value);
void linkedListSelectSort(LinkedList* the_list);

#define CS223_REPOSITORY_SPRING_2017_LINKEDLIST_H

#endif //CS223_REPOSITORY_SPRING_2017_LINKEDLIST_H
