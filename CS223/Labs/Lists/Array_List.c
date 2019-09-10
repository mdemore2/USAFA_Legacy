//
// Created by C19Mark.Demore on 1/11/2017.
//
#include "Array_List.h"
#include <stdio.h>
#include <stdlib.h>

ElementType arrayListGetElement(ArrayList * the_list, int pos)
{
    if(pos > the_list->currentSize)
    {
        return -1;
    }
    return the_list->list[pos];
}
int arrayListGetSize(ArrayList * the_list)
{
    return the_list->currentSize;
}
ArrayList* arrayListResize(ArrayList * the_list)
{
    ArrayList* new_list = malloc(sizeof(ArrayList));
    new_list->currentSize=the_list->currentSize;
    new_list->maxSize=the_list->maxSize+10;
    new_list->list=(ElementType *) malloc(sizeof(ElementType)*new_list->maxSize);

    for(int i = 0; i < new_list->maxSize; i++)
    {
        new_list->list[i]=0;
    }
    for(int j =0; j < the_list->currentSize;j++)
    {
        new_list->list[j]=the_list->list[j];
    }
    ArrayList * temp = the_list;
    the_list = new_list;
    free(temp);
    return the_list;
}
void arrayListAppend(ArrayList * the_list, ElementType e)
{
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
    free(the_list->list);
}
void arrayListPrint(ArrayList * the_list)
{
    for(int i = 0; i < the_list->currentSize; i++)
    {
        printf("%d \n",the_list->list[i]);
    }
}
void arrayListDeleteElement(ArrayList * the_list, int pos)
{
    for(int j=pos; j < the_list->currentSize;j++)
    {
        the_list->list[j]=the_list->list[j+1];
    }
    the_list->currentSize--;

}
void arrayListInsertElement(ArrayList * the_list,int pos, ElementType val)
{
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
    the_list->list[pos]=val;
}
int arrayListFindElement(ArrayList * the_list, ElementType val)
{
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
    ArrayList* new_list = malloc(sizeof(ArrayList));
    new_list->maxSize=initial_size;
    new_list->currentSize=0;
    //new_list->data=(ElementType *) malloc(sizeof(ElementType)*new_list->maxSize);

    for(int i = 0; i < initial_size; i++)
    {
        new_list->list[i]=0;
    }
    return new_list;
}
void arrayListInsertSort(ArrayList * the_list)
{
    ElementType temp;
    for(int i = 0; i <the_list->currentSize; i++)
    {

        for(int j = 0; j < i;j++)
        {
            if (the_list->list[j] < the_list->list[i])
            {
                temp = the_list->list[j];
                the_list->list[j]=the_list->list[i];
                the_list->list[i]=temp;
                j=0;
            }
        }
    }
}
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
}