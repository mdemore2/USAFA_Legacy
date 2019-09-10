//
// Created by C19Mark.Demore on 1/11/2017.
//

#ifndef CS223_REPOSITORY_SPRING_2017_ARRAY_LIST_H
#define CS223_REPOSITORY_SPRING_2017_ARRAY_LIST_H

typedef int ElementType;

typedef struct ArrayList {
    int currentSize;
    int maxSize;
    ElementType *list;
}ArrayList;


ArrayList *arrayListCreate(int initial_size);
void arrayListDelete (ArrayList* list);
void arrayListAppend (ArrayList* list, ElementType element);
void arrayListPrint (ArrayList* list);
ElementType arrayListGetElement (ArrayList* list, int position);
void arrayListDeleteElement(ArrayList* list, int position);
void arrayListInsertElement(ArrayList* list, int position, ElementType value);
void arrayListChangeElement(ArrayList* list, int position, ElementType newValue);
int arrayListFindElement (ArrayList* list, ElementType value);
int arrayListGetSize(ArrayList* list);
void arrayListInsertSort(ArrayList* the_list);

#endif //CS223_REPOSITORY_SPRING_2017_ARRAY_LIST_H