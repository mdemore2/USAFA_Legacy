/** LinkedList.c
 * ===========================================================
 * Name: C3C Luke McFadden, Spring 2017
 * Section: M3A
 * Project: Implement a list using a linked list.
 * Purpose: General purpose list implementation.
 * ===========================================================
 */

#include <stdio.h>
#include <stdlib.h>  // Defines malloc and free
#include <string.h>

#include "LinkedList.h"

/** ----------------------------------------------------------
* <Creates a LinkedList instance.>
* @param <None>
* @return <None>
*/
LinkedList * linkedListCreate() {
    LinkedList* my_list;

    // Create the structure that holds the list information
    my_list = (LinkedList*) malloc(sizeof(LinkedList));

    // Set the fields of the LinkedList
    my_list->first = NULL;
    my_list->last = NULL;
    my_list->numberElements = 0;

    return my_list;
}

/** ----------------------------------------------------------
* <Deletes a linked list>
* @param <my_list, a LinkedList>
* @return <None>
*/
void linkedListDelete(LinkedList* my_list) {
    // Delete the structure that holds the list information
    free(my_list);
}

/** ----------------------------------------------------------
* <Appends a node onto a linked list>
* @param <my_list, a LinkedList, & the address to an ElementType data.>
* @return <None>
*/
void linkedListAppend(LinkedList* my_list, ElementType data) {
    NodePtr new_node = (Node *) malloc(sizeof(Node));
    new_node->data = data;
    new_node->next = NULL;
    if (my_list->last == NULL) {
        my_list->first = new_node;
    }
    else {
        my_list->last->next = new_node;
    };
    my_list->last = new_node;
    my_list->numberElements++;
};

/** ----------------------------------------------------------
* <Prints a linked list>
* @param <my_list, a LinkedList>
* @return <None>
*/
void linkedListPrint(LinkedList* my_list) {
    NodePtr start = (Node *) malloc(sizeof(Node));
    start = my_list->first;
    if (start == NULL) {
        return;
    }
    else {
        for (int i = 0; i < (my_list->numberElements); i++) {
            printf("%d: %s\n", my_list->numberElements-i,start->data);
            if (start->next != NULL) {
                start = start->next;
            } else {
            }
        };
    }
};

/** ----------------------------------------------------------
* <Returns the value at a specified index in a linked list.>
* @param <my_list, a LinkedList, & index, an int value.>
* @return <return the ElementType value held at start->data>
*/
ElementType linkedListGetElement(LinkedList* my_list, int index) {
    NodePtr start = (Node *) malloc(sizeof(Node));
    start = my_list->first;
    for (int i=0; i <= index;i++) {
        if (i == index){
            return start->data;
        }
        else {
            if (start->next != NULL){
                start = start->next;
            }
            else {
                return NULL;
            }
        }
    };
};

/** ----------------------------------------------------------
* <Deletes a specific node in a linked list.>
* @param <my_list, a LinkedList, & index, an int value.>
* @return <None>
*/
void linkedListDeleteElement(LinkedList* my_list,int index) {
    NodePtr previousNode = (Node *) malloc(sizeof(Node));
    NodePtr currentNode = (Node *) malloc(sizeof(Node));
    NodePtr nextNode = (Node *) malloc(sizeof(Node));

    currentNode = my_list->first;
    if (currentNode == NULL) {
        return;
    }
    else {
        if (currentNode->next == NULL) {
            free(currentNode);
            my_list->numberElements -= 1;
            return;
        }
        else {
            nextNode = currentNode->next;
            for (int i = 0; i <= index; i++) {
                if (index == i) {
                    if (i == 0) {
                        my_list->first = nextNode;
                    } else {
                        if (nextNode == NULL) {
                            previousNode->next = NULL;
                            my_list->last = previousNode;
                        } else {
                            previousNode->next = nextNode;

                        }
                        free(currentNode);
                    }
                } else {
                    previousNode = currentNode;
                    currentNode = nextNode;
                    nextNode = currentNode->next;
                }
            };
            my_list->numberElements -= 1;
        }
    }
};

/** ----------------------------------------------------------
* <Inserst a nod einto a linked list.>
* @param <my_list, a LinkedList, index, an int value, & ElementType value.>
* @return <None>
*/
void linkedListInsertElement(LinkedList *my_list, int index, ElementType value){
    NodePtr previousNode = (Node *) malloc(sizeof(Node));
    NodePtr currentNode = (Node *) malloc(sizeof(Node));
    NodePtr nextNode = (Node *) malloc(sizeof(Node));

    currentNode = my_list->first;
    if (currentNode != NULL) {
        nextNode = currentNode->next;
    }
    for (int i=0; i <= index;i++) {
        if (index == i) {
            NodePtr newNode = (Node *) malloc(sizeof(Node));
            newNode->data = value;
            if (i == 0){
                my_list->first = newNode;
                newNode->next = currentNode;
            }
            else {
                previousNode->next = newNode;
                newNode->next = currentNode;
            }
        }
        else {
            previousNode = currentNode;
            currentNode = nextNode;
            if (currentNode != NULL) {
                nextNode = currentNode->next;
            }
        }
    };
    my_list->numberElements += 1;
};

/** ----------------------------------------------------------
* <Chnages an element in a node of a linked list.>
* @param <my_list, a LinkedList, position, an int value, & ElementType newValue.>
* @return <None>
*/
void linkedListChangeElement(LinkedList *my_list, int position, ElementType newValue){
    NodePtr start = (Node *) malloc(sizeof(Node));
    start = my_list->first;
    for (int i=0; i <= position;i++) {
        if (i == position){
            start->data = newValue;
        }
        else {
            if (start->next != NULL){
                start = start->next;
            }
            else {
                exit(1);
            }
        }
    };
};

/** ----------------------------------------------------------
* <high level description of purpose of the function
* including what the parameters are used for>
* @param <my_list, a LinkedList, & ElementType value.>
* @return <i, the index value where the desired element is in the linked list>
*/
int linkedListFindElement (LinkedList *my_list, ElementType value){
    NodePtr start = (Node *) malloc(sizeof(Node));
    start = my_list->first;
    if (start == NULL) {
        return -1;
    }
    else {
        for (int i=0; i <= my_list->numberElements;i++) {
            if (strcmp(start->data,value) == 0){
                return i;
            }
            else {
                if (start->next != NULL){
                    start = start->next;
                }
                else {
                    return -1;
                }
            }
        };
    }
};

/** ----------------------------------------------------------
* <Finds the smallest element in a linked list>
* @param <my_list, a LinkedList, firstIndex, an int, & lastIndex, an int.>
* @return <returns the smallest value in the LinkedList. (At smallest->data)>
*/
NodePtr findSmallest(NodePtr startNode, NodePtr lastNode) {
    NodePtr smallest;
    NodePtr current;

    smallest = startNode;
    current = smallest->next;
    while (current != NULL && current != lastNode->next) {
        if (current->data < smallest->data) {
            smallest = current;
        }
        current = current->next;
    }
    return smallest;
}

/** ----------------------------------------------------------
* Swaps values in a linked list in a manner which sorts them from smallest to biggest values.
* @param my_list, a LinkedList, beginIndex, an int, smallestIndex, an int, & smallData, an int.
* @return None
*/
void swapSort(NodePtr n1, NodePtr n2) {
    ElementType temp;

    temp = n1->data;
    n1->data = n2->data;
    n2->data = temp;
}

/** ----------------------------------------------------------
* <Sorts a linked list using a selection sort.>
* @param my_list, a LinkedList
* @return None
*/
void linkedListSelectionSort(LinkedList *my_list){

    NodePtr smallest;

    for (NodePtr start = my_list->first; start != NULL ; start = start->next) {
        smallest = findSmallest(start, my_list->last);
        swapSort(start,smallest);
    }

};
