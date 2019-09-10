/** HashTable.h
 * ===========================================================
 * Name: Mark Demore II, Spring 2017
 * Section: T3A
 * Project: PEX3
 * Purpose: Implement an abstract data type Hash Table
 * ===========================================================
 */

#ifndef HASH_TABLE_H
#define HASH_TABLE_H

typedef int Boolean;
#define FALSE    0
#define TRUE     1

// A "forward reference," the actual HashTable definition is below.
// This is needed because a hashFunction refers to a HashTable and
// the HashTable refers to a hashFunction. This "circular reference"
// must be resolved by declaring that a HashTable is a structure, but
// leaving the details of the structure until later.
typedef struct hashTable HashTable;

// Define 'hashFunction' as a pointer to a function. The function
// receives two parameters: a hash table and an element of the HashTable.
// The function returns an array index in the range of the hash
// table's array size.
typedef unsigned int (*hashFunction)(HashTable *, void *);

// Define a 'compareFunction' that receives two element pointers
// and returns whether the two elements are equal.
typedef Boolean (*compareFunction)(void *, void *);

// Define one node in a linked list.
typedef struct linkedListNode {
    void *                  element;
    struct linkedListNode * next;
} LinkedListNode;

// Define the meta-data for a hash table.
typedef struct hashTable {
    // A pointer to a function that receives a hash table and
    // an element pointer and calculates an array index.
    hashFunction  keyToIndex;

    // A pointer to a function that receives two elements and
    // returns TRUE if the elements are equal, FALSE otherwise.
    compareFunction compareElements;

    // Keep track of the number of elements in the hash table
    unsigned int numberSlotsUsed;
    unsigned int numberElements;

    // An array of pointers to hash table "buckets", each a linked list
    unsigned int arraySize;
    LinkedListNode ** array;

    // The current state of a traversal through the elements of a hash table
    unsigned int currentIndex;     // index of current element
    LinkedListNode * currentNode;  // pointer to current node in linked list
} HashTable;

HashTable * hashTableCreate(unsigned int tableSize, hashFunction func, compareFunction compareTwoWords);
void        hashTableDelete(HashTable* table, Boolean deleteElements);
void        hashTableInsertElement(HashTable* table, void * newElement);
Boolean     hashTableDeleteElement(HashTable* table, void * element);
void *      hashTableFind(HashTable* table, void * element);
void *      hashTableGetFirst(HashTable* table, unsigned int index);
void *      hashTableGetNext(HashTable* table, unsigned int index);

#endif //HASH_TABLE_H
