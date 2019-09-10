/** HashTable.c
 * ===========================================================
 * Name:  Mark Demore II, Spring 2017
 * Section: T3A
 * Project: PEX3
 * Purpose: Implement an abstract data type Hash Table
 * ===========================================================
 * Documentation: Assisted in debugging hashTableGetNext by C3C Payne
 */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "HashTable.h"


// Local helper functions:
void hashTableDeleteLinkedList(LinkedListNode *node, Boolean deleteElements);

/** -------------------------------------------------------------------
 * Creates a new, empty hash table.
 * @param tableSize - the size of the hash table. It should
 *                    typically be at least twice as large as
 *                    the number of values you expect to store
 *                    in the hash table.
 * @param hashFunc - a pointer to a function that can calculate an
 *               array index from specific data in a HashTableElement.
 * @param compareFunc - a pointer to a function that can compare two
 *               HashTableElements for equality.
 * @return a pointer to a new hash table
 */
HashTable *hashTableCreate(unsigned int tableSize,
                           hashFunction hashFunc,
                           compareFunction compareFunc) {

    // Make the table size always be a power of 2.
    double exponent = ceil(log2(tableSize));
    tableSize = (unsigned int) pow(2.0, exponent);

    HashTable *newTable = (HashTable *) malloc(sizeof(HashTable));

    newTable->keyToIndex = hashFunc;
    newTable->compareElements = compareFunc;
    newTable->numberSlotsUsed = 0;
    newTable->numberElements = 0;
    newTable->arraySize = tableSize;
    newTable->array = (LinkedListNode **) calloc(tableSize, sizeof(struct linkedListNode *));
    newTable->currentIndex = 0;
    newTable->currentNode = NULL;

    return newTable;
}


/** -------------------------------------------------------------------
 * Delete a hash table.
 * @param table - the table to be deleted
 * @param deleteElements - If TRUE, the elements that the hash table contains
 *                         are deleted. If FALSE, the elements in the hash
 *                         table are not deleted, but the hash table pointers
 *                         are all deleted.
 */
void hashTableDelete(HashTable* table, Boolean deleteElements) {
    // WRITE CODE
    int size = table->arraySize;
    for(int j = 0; j < size; j++)
    {
        hashTableDeleteLinkedList(table->array[j], deleteElements);
    }
    free(table);
}

/** -------------------------------------------------------------------
 * Deletes a single linked lists. Used by hashTableDelete().
 * @param node - a pointer to the head node of the linked list.
 * @param deleteElements - If TRUE, reclaim the memory of the data
 *                         the node references.
 */
void hashTableDeleteLinkedList(LinkedListNode *node, Boolean deleteElements) {
    LinkedListNode * toDelete;
    while (node != NULL) {
        if (deleteElements && node->element != NULL) {
            free(node->element);
        }
        toDelete = node;
        node = node->next;
        free(toDelete);

    }
}

/** -------------------------------------------------------------------
 * Insert a new element into a hash table.
 * @param table - the hash table to be changed.
 * @param newElement - the element to be inserted
 */
void hashTableInsertElement(HashTable* table, void * newElement) {
    //code below copied from delete element function, and then modified
    // Calculate the location where the element should be.
    int index = table->keyToIndex(table, newElement);
    //check 0 < index < maxSize

    // Search the linked list for the element
    LinkedListNode * parent = NULL;
    LinkedListNode * node = table->array[index];

    while (node != NULL && ! table->compareElements(node->element, newElement))
    {
        parent = node;
        node = node->next;
    }
    //create node and add element
    LinkedListNode* newNode = (LinkedListNode *) malloc(sizeof(node));
    if (parent != NULL)
    {
        parent->next = newNode;
    }
    else
    {
        table->array[index] = newNode;
        table->numberSlotsUsed++;
    }

    newNode->element = newElement;
    newNode->next = NULL;

    return;
}

/** -------------------------------------------------------------------
 * Delete an element from a hash table.
 * @param table - the hash table.
 * @param element - the element to be deleted.
 * @return TRUE if the element was deleted, FALSE otherwise.
 */
Boolean hashTableDeleteElement(HashTable* table, void * element) {
    // Calculate the location where the element should be.
    int index = table->keyToIndex(table, element);

    // Search the linked list for the element
    LinkedListNode * parent = NULL;
    LinkedListNode * node = table->array[index];

    while (node != NULL && ! table->compareElements(node->element, element))
    {
        parent = node;
        node = node->next;
    }

    // Did we find the right node?
    if (node == NULL)
    {
        return FALSE;
    } else {
        // Is the node the first node in the linked list?
        if (parent == NULL)
        {
            table->array[index] = node->next;
            if(node->next == NULL)
            {
                table->numberSlotsUsed--;
            }
        } else
        {
            parent->next = node->next;
        }
        free(node);
        table->numberElements--;
    }
    return TRUE;
}

/** -------------------------------------------------------------------
 * Find an element in a hash table.
 * @param table - the hash table.
 * @param toFind - the element to search for.
 * @return - if the element is found, return a pointer to element,
 *           otherwise return NULL to indicate that the element was
 *           not found.
 */
void * hashTableFind(HashTable* table, void * toFind) {
    int index = table->keyToIndex(table, toFind);

    // Search the linked list for the element

    LinkedListNode * node = table->array[index];

    while (node != NULL && ! table->compareElements(node->element, toFind))
    {
        node = node->next;
    }
    if(node == NULL)
    {
        return NULL;
    }
    else
    {
        return node->element;
    }
}

/** -------------------------------------------------------------------
 * Given an array index into a hash table, return the first element
 * that is in that position of the array (i.e, the element of the
 * first node in the linked list for this array position).
 * @param table - the hash table
 * @param index - the array index of the hash table array.
 * @return - If an element exists at this array position, return the
 *           first element in the first node of the linked-list
 *           this location points to. If there is no linked-list
 *           associated with this array position, then return NULL.
 */
void * hashTableGetFirst(HashTable* table, unsigned int index) {
    // WRITE CODE
    void * data;
    if(table->array[index] != NULL)
    {
        data = table->array[index]->element;
        table->currentNode = table->array[index];

    }
    else
    {
        data = NULL;
        table->currentNode = NULL;
    }
    table->currentIndex = index;
    return data;
}

/** -------------------------------------------------------------------
 * Given an array index into a hash table, return the next element
 * that is in that position of the array (i.e., the element of the
 * node after the "currentNode"). The "currentNode" is updated
 * to point to this "next node."
 * @param table - the hash table
 * @param index - the array index of the hash table array.
 * @return If there is a node after the "currentNode," return the
 *         element in the next node. Otherwise, return NULL.
 */
void * hashTableGetNext(HashTable* table, unsigned int index) {
    // WRITE CODE

    if(table->currentNode == NULL)
    {
        return NULL;
    }
    else
    {
        if(table->currentNode->next == NULL)
        {
            table->currentNode=NULL;
            return NULL;
        }
        else
        {
            table->currentNode = table->currentNode->next;
            return table->currentNode->element;
        }
    }

}




