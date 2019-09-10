/** linkedlist.c
 * ===========================================================
 * Name:    C3C Mark Demore II, Spring 2017
 * Section: T3A
 * Project: LinkedList
 * Purpose: Implement LinkedList data structure and appropriate functions.
 * Documentation: None
 * ===========================================================
 */
#include "linkedlist.h"
#include <stdlib.h>
#include <stdio.h>

/*int main()
{
    *//*LinkedList* my_list = malloc(sizeof(LinkedList));
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
    *//*

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
}*/
void linkedListAppend(LinkedList *the_list, ElementType newValue)
{
/** ----------------------------------------------------------
* <append element to linkedlist>
* @param <linkedlist pointer, value to append>
* @return <void>
*/
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
void linkedListDelete(LinkedList *the_list)
{
/** ----------------------------------------------------------
* <delete linkedlist, free memory>
* @param <linkedlist pointer>
* @return <void>
*/
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
void linkedListDeleteElement(LinkedList *the_list, int offset)
{
/** ----------------------------------------------------------
* <delete element from linkedlist>
* @param <linkedlist pointer, location of element to delete>
* @return <void>
*/
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
void linkedListPrint(LinkedList *the_list)
{
/** ----------------------------------------------------------
* <print elements of linkedlist>
* @param <linkedlist pointer>
* @return <void>
*/
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
ElementType linkedListGetElement(LinkedList *the_list, int pos)
{
/** ----------------------------------------------------------
* <retrieve element from linkedlist>
* @param <linkedlist pointer, location of element>
* @return <value of element>
*/
    Node* temp = the_list->first;
    ElementType val;
    for(int i =0; i < pos; i++)
    {
        temp=temp->next;
    }
    val = temp->data;
    return val;
}
void linkedListInsertElement(LinkedList *the_list, int pos, ElementType val)
{
/** ----------------------------------------------------------
* <insert element in linkedlist>
* @param <linkedlist pointer, location to insert, value to insert>
* @return <void>
*/
    Node* current = the_list->first;
    Node* successor;
    Node* predeccesor;
    the_list->size++;
    Node* new = malloc(sizeof(Node));
    new->data = val;
    if(current == NULL)
    {
        new->next = current;
        the_list->first=new;
        the_list->last=new;
    }
    else if (the_list->size == 1)
    {
        if (pos > 0)
        {
            new->next=NULL;
            the_list->last=new;
        }
        else
        {
            new->next = the_list->first;
            the_list->first = new;
        }

    }
    else if(the_list->size == 2)
    {
        if (pos > 1)
        {
            new->next=NULL;
            the_list->last=new;
        }
        if(pos < 1)
        {
            new->next = the_list->first;
            the_list->first = new;
        }
        else
        {
            current = current->next;
            predeccesor=current;
            current=current->next;
            successor=current->next;
            predeccesor->next=successor;
        }

    }
    else
    {
        for(int i = 0; i < (pos-1); i++)
        {
            current=current->next;
        }
        predeccesor=current;
        current=current->next;
        successor=current->next;
        predeccesor->next=successor;

        new->next = current;
        predeccesor->next=new;
    }

}
void linkedListChangeElement(LinkedList *the_list, int pos, ElementType newVal)
{/** ----------------------------------------------------------
* <change value of element in linkedlist>
* @param <linkedlist pointer, location of element to change, new value>
* @return <void>
*/
    Node* current = the_list->first;
    for(int i=0; i < pos; i++)
    {
        current=current->next;
    }
    current->data=newVal;
}
int linkedListFindElement(LinkedList *the_list, ElementType val)
{
/** ----------------------------------------------------------
* <find element in linkedlist>
* @param <linkedlist pointer, value to find>
* @return <location of element>
*/
    int count = 0;
    Node* iterator = the_list->first;
    while(iterator->data != val)
    {
        iterator=iterator->next;
        count++;
    }
    return count;
}
LinkedList * linkedListCreate()
{
/** ----------------------------------------------------------
* <create linkedlist>
* @param <void>
* @return <linkedlist pointer>
*/
    LinkedList *my_list = malloc(sizeof(LinkedList));
    my_list->size = 0;
    my_list->first = NULL;
    my_list->last = NULL;
    return my_list;
}
void linkedListSelectSort(LinkedList *the_list)
{
/** ----------------------------------------------------------
* <sort linkedlist using selection sort>
* @param <linkedlist pointer>
* @return <void>
*/
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