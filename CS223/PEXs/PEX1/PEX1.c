/** PEX1.c
 * ===========================================================
 * Name:    C3C Mark Demore II, Spring 2017
 * Section: T3A
 * Project: PEX1
 * Purpose: Time the functionality of an ArrayList and a LinkedList.
 * Documentation: None
 * ===========================================================
 */

#include "Array_List.h"
#include "LinkedList.h"
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int main() {
    // Declare the functions that are called.
    void timeArrayListCreation();
    void timeArrayListAppend();
    void timeArrayListResize();
    void timeArrayListSort();
    void timeLinkedListAppend();
    void timeLinkedListInsert();
    void timeLinkedListSort();

    // Perform the timing code
    timeArrayListCreation();
    timeArrayListAppend();
    timeArrayListResize();
    timeArrayListSort();
    timeLinkedListAppend();
    timeLinkedListInsert();
    timeLinkedListSort();

    return 0;
}

void timeArrayListCreation()
{
/** ----------------------------------------------------------
* <time arraylist create function>
* @param <void>
* @return <void>
*/
    ArrayList *my_list;
    clock_t    startTime;
    clock_t    elapsedTime;
    FILE      *fp;

    fp = fopen("PEXs/PEX1/timesForArrayListCreate.csv", "w");

    for (int size = 0; size < 100000; size += 10000) {
        startTime = clock();

        my_list = arrayListCreate(size);

        elapsedTime = clock() - startTime;

        printf("%d, %lu\n", size, elapsedTime);
        fprintf(fp, "%d, %lu\n", size, elapsedTime);

        // Delete the array list so that we will not run out of memory
        arrayListDelete(my_list);
    }
    fclose(fp);
    free(fp);
}
void timeArrayListAppend()
{
/** ----------------------------------------------------------
* <time arraylist append function>
* @param <void>
* @return <void>
*/
    ArrayList *my_list;
    clock_t    startTime;
    clock_t    elapsedTime;
    FILE      *fp;
    int num;

    fp = fopen("PEXs/PEX1/timesForArrayListAppend.csv", "w");
    my_list = arrayListCreate(100000);
    startTime = clock();
    for (int size = 0; size < 100000; size += 1) {
        num =  (int) ((float) rand() / (float) RAND_MAX * size);
        arrayListAppend(my_list,num);

        elapsedTime = clock() - startTime;

        if(size % 10000 == 0)
        {
            printf("%d, %lu\n", size, elapsedTime);
            fprintf(fp, "%d, %lu\n", size, elapsedTime);

        }

    }
    arrayListDelete(my_list);
    fclose(fp);
    free(fp);
}
void timeArrayListResize()
{
/** ----------------------------------------------------------
* <time arraylist append and resize function>
* @param <void>
* @return <void>
*/
    ArrayList *my_list;
    clock_t    startTime;
    clock_t    elapsedTime;
    FILE      *fp;
    int num;

    fp = fopen("PEXs/PEX1/timesForArrayListResize.csv", "w");
    my_list = arrayListCreate(10);
    startTime = clock();
    for (int size = 0; size < 100000; size += 1)
    {

        num =  (int) ((float) rand() / (float) RAND_MAX * size);
        arrayListAppend(my_list,num);

        elapsedTime = clock() - startTime;
        if(size % 10000 == 0)
        {
            printf("%d, %lu\n", size, elapsedTime);
            fprintf(fp, "%d, %lu\n", size, elapsedTime);

        }

    }
    arrayListDelete(my_list);

    fclose(fp);
    free(fp);
}
void timeArrayListSort()
{
/** ----------------------------------------------------------
* <time arraylist sorting function>
* @param <void>
* @return <void>
*/
    ArrayList *my_list;
    clock_t    startTime;
    clock_t    elapsedTime;
    FILE      *fp;
    int num;
    fp = fopen("PEXs/PEX1/timesForArrayListSort.csv", "w");
    my_list=arrayListCreate(100000);
    for(int size = 0; size < 100000; size+= 1)
    {
        num =  (int) ((float) rand() / (float) RAND_MAX * size);
        arrayListAppend(my_list, num);

        if(size % 10000 == 0)
        {
            startTime = clock();
            arrayListInsertSort(my_list);
            elapsedTime = clock() - startTime;

            printf("%d, %lu\n", size, elapsedTime);
            fprintf(fp, "%d, %lu\n", size, elapsedTime);

        }


    }
    arrayListDelete(my_list);
    fclose(fp);
    free(fp);
}
void timeLinkedListAppend()
{
/** ----------------------------------------------------------
* <time linkedlist append function>
* @param <void>
* @return <void>
*/
    LinkedList *my_list;
    clock_t    startTime;
    clock_t    elapsedTime;
    FILE      *fp;
    int num;

    fp = fopen("PEXs/PEX1/timesForLinkedListAppend.csv", "w");
    my_list = linkedListCreate();
    startTime = clock();
    for (int size = 0; size < 100000; size += 1) {
        num =  (int) ((float) rand() / (float) RAND_MAX * size);
        linkedListAppend(my_list,num);

        elapsedTime = clock() - startTime;

        if(size % 10000 == 0)
        {
            printf("%d, %lu\n", size, elapsedTime);
            fprintf(fp, "%d, %lu\n", size, elapsedTime);

        }

    }
    linkedListDelete(my_list);
    fclose(fp);
    free(fp);
}
void timeLinkedListInsert()
{
/** ----------------------------------------------------------
* <time linkedlist insert function>
* @param <void>
* @return <void>
*/
    LinkedList *my_list;
    clock_t    startTime;
    clock_t    elapsedTime;
    FILE      *fp;
    int num;

    fp = fopen("PEXs/PEX1/timesForLinkedListInsert.csv", "w");
    my_list = linkedListCreate();
    startTime = clock();
    for (int size = 0; size < 100000; size += 1) {
        num =  (int) ((float) rand() / (float) RAND_MAX * size);
        linkedListInsertElement(my_list,(size/2),num);

        elapsedTime = clock() - startTime;

        if(size % 10000 == 0)
        {
            printf("%d, %lu\n", size, elapsedTime);
            fprintf(fp, "%d, %lu\n", size, elapsedTime);

        }


    }
    linkedListDelete(my_list);
    fclose(fp);
    free(fp);
}
void timeLinkedListSort()
{
/** ----------------------------------------------------------
* <time linkedlist sorting function>
* @param <void>
* @return <void>
*/
    LinkedList *my_list;
    clock_t    startTime;
    clock_t    elapsedTime;
    FILE      *fp;
    int num;
    fp = fopen("PEXs/PEX1/timesForLinkedListSort.csv", "w");
    my_list=linkedListCreate();

    for (int size = 0; size < 100000; size += 1) {
        num =  (int) ((float) rand() / (float) RAND_MAX * size);
        linkedListAppend(my_list, num);



        if(size % 10000 == 0)
        {
            startTime = clock();
            linkedListSelectSort(my_list);
            elapsedTime = clock() - startTime;

            printf("%d, %lu\n", size, elapsedTime);
            fprintf(fp, "%d, %lu\n", size, elapsedTime);

        }

    }
    linkedListDelete(my_list);
    fclose(fp);
    free(fp);
}





