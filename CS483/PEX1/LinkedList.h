/** LinkedList.h
 * ===========================================================
 * Name: C3C Luke McFadden, Spring 2017
 * Section: M3A
 * Project: Implement a list using a linkedlist.
 * Purpose: General purpose list implementation.
 * ===========================================================
 */

#ifndef LINKEDLIST_H
#define LINKEDLIST_H

typedef char * ElementType;

typedef struct Node {
    ElementType data;
    struct Node * next;
} Node;

typedef Node * NodePtr;

typedef struct LinkedList {
    NodePtr first;
    NodePtr last;
    int    numberElements;
} LinkedList;

LinkedList * linkedListCreate();
void linkedListDelete(LinkedList* my_list);
void linkedListAppend(LinkedList* my_list, ElementType data);
void linkedListPrint(LinkedList* my_list);

void linkedListDeleteElement(LinkedList* my_list,int index);
ElementType linkedListGetElement(LinkedList* my_list, int index);
void linkedListInsertElement(LinkedList *my_list, int index, ElementType value);
void linkedListChangeElement(LinkedList *my_list, int position, ElementType newValue);
int linkedListFindElement (LinkedList *my_list, ElementType value);

void linkedListSelectionSort(LinkedList *my_list);

#endif //LINKEDLIST_H