/** Array_List.c
 * ===========================================================
 * Name:    C3C Mark Demore II, Spring 2017
 * Section: T3A
 * Project: ArrayList
 * Purpose: Implement the ArrayList data structure and appropriate functions.
 * Documentation: None
 * ===========================================================
 */
#include "Array_List.h"
#include <stdio.h>
#include <stdlib.h>


ElementType arrayListGetElement(ArrayList * the_list, int pos)
{
/** ----------------------------------------------------------
* <retrieves an element from the arraylist>
* @param <pointer to arraylist, location of desired element>
* @return <value of element>
*/
    if(pos > the_list->currentSize)
    {
        return -1;
    }
    return (ElementType) the_list->list[pos];
}

void arrayListResize(ArrayList * the_list)
{
/** ----------------------------------------------------------
* <increases the size of the arraylist>
* @param <pointer to arraylist>
* @return <void>
*/
    the_list->maxSize=the_list->maxSize*2;
    the_list->list=(ElementType *) realloc(the_list->list, (sizeof(ElementType)*the_list->maxSize));


}
void arrayListAppend(ArrayList * the_list, ElementType e)
{
/** ----------------------------------------------------------
* <appends a value to the arraylist>
* @param <arraylist pointer, value to append>
* @return <void>
*/
    if(the_list->currentSize < the_list->maxSize)
    {
        the_list->list[the_list->currentSize] = e;
        the_list->currentSize += 1;
    }
    else
    {
        arrayListResize(the_list);
        arrayListAppend(the_list,e);
    }
}
void arrayListDelete(ArrayList * the_list)
{
/** ----------------------------------------------------------
* <frees memory occupied by arraylist>
* @param <pointer to arraylist>
* @return <void>
*/
    free(the_list->list);
}
void arrayListPrint(ArrayList * the_list)
{
/** ----------------------------------------------------------
* <prints all elements of arraylist>
* @param <arraylist pointer>
* @return <null>
*/
    for(int i = 0; i < the_list->currentSize; i++)
    {
        printf("%d \n",the_list->list[i]);
    }
}
void arrayListDeleteElement(ArrayList * the_list, int pos)
{
/** ----------------------------------------------------------
* <deletes element from arraylist>
* @param <arraylist pointer, position of element to be deleted>
* @return <void>
*/
    for(int j=pos; j < the_list->currentSize;j++)
    {
        the_list->list[j]=the_list->list[j+1];
    }
    the_list->currentSize--;

}
void arrayListInsertElement(ArrayList * the_list,int pos, ElementType val)
{
/** ----------------------------------------------------------
* <inserts element into arraylist>
* @param <arraylist pointer, position to insert element, element value>
* @return <void>
*/
    if(the_list->currentSize+1 > the_list->maxSize)
    {
        arrayListResize(the_list);
    }
    the_list->currentSize++;
    for(int i = the_list->currentSize; i >= pos; i--)
    {
        the_list->list[i+1]=the_list->list[i];
    }
    the_list->list[pos]=val;
}
void arrayListChangeElement(ArrayList * the_list, int pos, ElementType val)
{
/** ----------------------------------------------------------
* <change value of element in arraylist>
* @param <arraylist pointer, position to be changed, new value>
* @return <void>
*/
    the_list->list[pos]=val;
}
int arrayListFindElement(ArrayList * the_list, ElementType val)
{
/** ----------------------------------------------------------
* <find location of element in arraylist>
* @param <pointer of arraylist, value to be searched>
* @return <location of element>
*/
    int count;
    for(int i = 0; i < the_list->currentSize; i++)
    {
        count = i;
        if(the_list->list[i]==val)
        {
            i = the_list->maxSize;
        }
    }
    return count;
}
ArrayList* arrayListCreate(int initial_size)
{
/** ----------------------------------------------------------
* <create an arraylist>
* @param <initial size>
* @return <arraylist pointer>
*/
    ArrayList* new_list = malloc(sizeof(ArrayList));
    new_list->maxSize=initial_size;
    new_list->currentSize=0;
    new_list->list=(ElementType *) malloc(sizeof(ElementType)*new_list->maxSize);

    return new_list;
}
void arrayListInsertSort(ArrayList * the_list)
{
/** ----------------------------------------------------------
* <sort arraylist with insertion sort>
* @param <arraylist pointer>
* @return <void>
*/
    ElementType temp;
    for(int i = 0; i < the_list->currentSize; i++)
    {

        for(int j = 0; j < i;j++)
        {
            if (the_list->list[j] > the_list->list[i])
            {
                temp = the_list->list[i];
                arrayListDeleteElement(the_list, i);
                arrayListInsertElement(the_list, j, temp);
                j = the_list->currentSize + 1;
            }
        }
    }
}
/*
int main()
{
    ArrayList* my_list = malloc(sizeof(ArrayList));
    my_list->currentSize=0;
    my_list->maxSize=10;
    my_list->list=(ElementType *) malloc(sizeof(ElementType)*my_list->maxSize);

    arrayListAppend(my_list,12);
    arrayListAppend(my_list,4);
    arrayListInsertElement(my_list,1,16);
    arrayListAppend(my_list,8);

    printf("%d\n",arrayListGetElement(my_list,1));
    arrayListPrint(my_list);
    my_list = arrayListResize(my_list);
    printf("%d\n",my_list->maxSize);

    arrayListInsertSort(my_list);
    arrayListPrint(my_list);

    //arrayListDelete(my_list);

    //ArrayList * new_list = arrayListCreate(10);
    //printf("\n");
    //arrayListPrint(new_list);

    return 0;
}*/
