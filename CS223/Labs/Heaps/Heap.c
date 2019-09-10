/** heapSort.c
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Section:
 * Project: Lab 30
 * Purpose: Implement a heapSort
 * ===========================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Heap.h"

#define MAX_BYTES_PER_ELEMENT 1000

// Local functions that work on a max-heap
static void convertToMaxHeap(Heap * heap);
static void heapSort(int[], int);
static void shiftDown(Heap * heap, int last, int root);
static void shiftUp(Heap *heap, int last, int child );

/** -------------------------------------------------------------------
 * Create a max-heap from an existing array
 * @param array - the array to be made into a max-heap
 * @param arrayCapacity - the total number of elements that could be put into the array.
 * @param numberElements - the actual number of elements in the array.
 * @param bytesPerElement - the number of bytes in each element.
 * @param func - a function that can compare two elements for greater-than
 * @return - the max-heap that was created
 */
Heap * maxHeapCreate(void * array, int arrayCapacity,
                     int numberElements, int bytesPerElement,
                     greaterThanFunction func) {
    Heap * heap;

    heap = (Heap *) malloc(sizeof(Heap));

    // The heap points to the application's array
    heap->array = array;
    heap->compare = func;
    heap->arrayCapacity = arrayCapacity;
    heap->numberElements = numberElements;
    heap->bytesPerElement = bytesPerElement;
    heap->array = array;

    if (bytesPerElement > MAX_BYTES_PER_ELEMENT) {
        printf("Error in maxHeapCreate, the swap buffer is too small.\n");
        exit(1);
    }

    convertToMaxHeap(heap);

    return heap;
}

/** -------------------------------------------------------------------
 * Delete a max-heap
 * @param heap - the heap to delete
 */
void   maxHeapDelete(Heap *heap) {
    free(heap);
}

/** -------------------------------------------------------------------
 * Remove the maximum element from the heap (the value at the root)
 * and update the heap to keep it a max-heap.
 * @param heap - the heap
 * @return - the maximum value from the heap.
 */
void * maxHeapRemoveMaximumElement(Heap *heap) {
    unsigned char temp[MAX_BYTES_PER_ELEMENT];
    // swap the root value with the last value
    void * root = heap->array + heap->bytesPerElement; // [1]
    void * last = heap->array + heap->numberElements * heap->bytesPerElement;

    memcpy(&temp, last, heap->bytesPerElement);
    memcpy(last,  root, heap->bytesPerElement);
    memcpy(root, &temp, heap->bytesPerElement);

    // Make the heap size one less
    heap->numberElements--;

    // Shift the root value to its proper place in the array
    shiftDown(heap, heap->numberElements, 1);

    // return the address of the last value
    return last;
}

/** -------------------------------------------------------------------
 * Add a new element to the heap
 * @param heap - the heap
 * @param element - the new element
 */
void maxHeapInsertNewElement(Heap *heap, void *element) {
    unsigned char temp[MAX_BYTES_PER_ELEMENT];

    // Make sure the array has room for the new element
    if (heap->numberElements >= heap->arrayCapacity ) {
        printf("Error in maxHeapInsertNewElement, the array is too small.\n");
        exit(1);
    }

    // Add the element to the end of the array
    void * last = heap->array + (heap->numberElements+1) * heap->bytesPerElement;
    memcpy(last,  element, heap->bytesPerElement);

    // Shift the root value to its proper place in the array
    shiftUp(heap, heap->numberElements, heap->numberElements+1);

    // Make the heap size one more
    heap->numberElements++;
}

/** -------------------------------------------------------------------
 * Convert an array of values to a max-heap
 * @param heap - the heap to convert
 */
void convertToMaxHeap(Heap * heap) {

    int n = heap->numberElements;

    // Note that the leaf nodes don't need to be shifted down,
    // so we start at the parent of the last node.
    for (int root = n / 2; root >= 1; root--) {
        shiftDown(heap, n, root);
    }
}

/** -------------------------------------------------------------------
 * Given a array that is a heap, except the root node does not
 * have the correct heap relationship to its children, shift
 * the value in the root node down until the heap is valid.
 * @param array - the array that holds the max-heap
 * @param last - the index of the last value in the max-heap;
 *               the heap is in indexes [1] to [last].
 * @param root - the index of the node that needs updating
 */
static void shiftDown(Heap * heap, int last, int root ) {
    unsigned char key[MAX_BYTES_PER_ELEMENT];
    void * rootAddress = heap->array + root * heap->bytesPerElement;

    // Copy the root value into the "key"
    memcpy(&key, rootAddress, heap->bytesPerElement);

    int child = 2 * root;
    void * childAddress = heap->array + child * heap->bytesPerElement;

    while (child <= last) { // While there is at least one child.

        if (child < last) { // There is a right child.
            // Find the bigger child.
            if (heap->compare(childAddress + heap->bytesPerElement, childAddress)) {
                child++;
                childAddress += heap->bytesPerElement;
            }
        }

        // 'child' holds the index of the bigger child node
        if (heap->compare(&key, childAddress)) {
            // The root node's value is bigger than both its children
            break;
        }

        // The key is smaller; promote num[child] to it's parent
        memcpy(rootAddress, childAddress, heap->bytesPerElement);

        // Move down the tree
        root = child;
        child = 2 * root;

        rootAddress  = heap->array + root * heap->bytesPerElement;
        childAddress = heap->array + child * heap->bytesPerElement;
    }
    memcpy(rootAddress, &key, heap->bytesPerElement);
} // end siftDown

/**
 * Given a new element at the end of the heap, shift it up
 * until it is in a correct location.
 * @param heap - the heap
 * @param last - the index of the last element in the heap
 * @param child - the index of the new element to be shifted
 */
static void shiftUp(Heap *heap, int last, int child ) {
    unsigned char key[MAX_BYTES_PER_ELEMENT];
    void * childAddress = heap->array + child * heap->bytesPerElement;
    memcpy(&key, childAddress, heap->bytesPerElement);

    int parent = child / 2;
    void * parentAddress = heap->array + parent * heap->bytesPerElement;
    while (parent > 0) { // While the top root of the tree has not been reached

        // If the key is smaller than its parent, we are done
        if (heap->compare(parentAddress, &key)) {
            break;
        }

        // The key is bigger than its parent; promote up the tree
        memcpy(childAddress, parentAddress, heap->bytesPerElement);

        // Move up the tree
        child = parent;
        parent = child / 2;

        childAddress = heap->array + child * heap->bytesPerElement;
        parentAddress = heap->array + parent * heap->bytesPerElement;
    }
    memcpy(childAddress, &key, heap->bytesPerElement);
} // end siftUp



