//
// Created by Wayne.Brown on 4/9/2017.
//

#ifndef HEAP_H
#define HEAP_H

typedef int Boolean;
#define FALSE    0
#define TRUE     1

// A forward reference
typedef struct heap Heap;

// A pointer to a function.
typedef Boolean (*greaterThanFunction)(void *, void *);

typedef struct heap {
    greaterThanFunction compare;
    int    arrayCapacity;   // Possible number of elements
    int    numberElements;  // Actual number of elements
    size_t bytesPerElement; // Bytes for each element
    void * array;
} Heap;

Heap * maxHeapCreate(void * array, int arrayCapacity,
                     int numberElements, int bytesPerElement,
                     greaterThanFunction func);
void   maxHeapDelete(Heap *heap);
void * maxHeapRemoveMaximumElement(Heap *heap);
void   maxHeapInsertNewElement(Heap *heap, void *element);

#endif // HEAP_H
