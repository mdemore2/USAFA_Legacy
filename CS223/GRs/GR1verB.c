/** GR1verB.c
 * ===========================================================
 * Name:   Mark Demore II,  Spring 2017
 * Section: T3A
 * Project: GR 1, version B
 * Purpose: Assessment on lists
 * ===========================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct exam{
    int number;
    float decimal;                  //define necessary data struct
    char string[20];
}Exam;

// Function definitions
Exam* makeMetaData();
int* createArray(int size);
void selectionSort(int *array, int arraySize);





//---------------------------------------------------------------------
// Main function, start of execution
int main()
{
    makeMetaData();
    int* anArray;
    anArray=createArray(10);
    selectionSort(anArray, 10);
}

//---------------------------------------------------------------------
// Problem 15:                                        ________ / 14 pts
Exam* makeMetaData() {
    Exam* test;
    test = malloc(sizeof(Exam));    //allocate memory to store data struct
    test->number = -1;                //dereference struct to set values
    test->decimal = 10.5;
    strcpy(test->string, "Lucy");
    return test;                    //return pointer
}

//---------------------------------------------------------------------
// Problem 16:                                        ________ / 20 pts
int* createArray(int size)
{
    int* the_list;
    the_list=(int *) malloc(sizeof(int)*size);  //allocate memory to store list of given size

    for(int i = 0; i < size; i++)
    {
        if(i==0)
        {
            the_list[i]=12;                 //take care of exception for mod division
        }
        else if(i % 5 == 0)
        {
            the_list[i] = 12;               //if every fifth element, set equal to 12
        }
        else
        {
            the_list[i] = 4;                //else, set equal to 4
        }
    }
    return the_list;                        //return pointer to array
}

//---------------------------------------------------------------------
// Problem 17:                                        ________ / 20 pts

int findSmallest(int *array, int firstIndex, int lastIndex)
{
    int smallestIndex = firstIndex;
    for (int j=firstIndex+1; j<=lastIndex; j++)         //iterate from beginning of list
    {
        if (array[j] < array[smallestIndex])
        {
            smallestIndex = j;                          //if value is less than current min, set index to new val
        }
    }
    return smallestIndex;
}

void swap(int *array, int j, int k)
{
    int temp = array[j];
    array[j] = array[k];                            //swap two elements, not necessary to change
    array[k] = temp;
}

void selectionSort(int *array, int arraySize)
{
    int indexOfSmallestValue;
    int startIndex = 0;                                                     //use iterator to only sort list once
    for (int firstIndex = 0; firstIndex <= arraySize-1; firstIndex++)           //iterate from beginning of list
    {
        indexOfSmallestValue = findSmallest(array, startIndex, arraySize-1);         //get the smallest value
        swap(array, indexOfSmallestValue, firstIndex);                      //swap with first value
        startIndex++;
    }
}

