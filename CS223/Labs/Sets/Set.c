/** Set.h
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Section:
 * Project: Lesson 39
 * Purpose: Implement a Set data structure
 * ===========================================================
 */

#include <stdio.h>
#include "Set.h"

//---------------------------------------------------------------------
UniversalSet * universalSetCreate(int first, int last) {
    UniversalSet * u = (UniversalSet *) malloc(sizeof(UniversalSet));
    if (u == NULL) {
        printf("ERROR: Out of memory in universalSetCreate(). Exiting...");
        exit(1);
    }

    if (first < last) {
        u->firstInt = first;
        u->lastInt = last;
    } else {
        u->firstInt = last;
        u->lastInt = first;
    }

    return u;
}

//---------------------------------------------------------------------
void universalSetDelete(UniversalSet *u) {
    free(u);
}

//---------------------------------------------------------------------
int universalSetElementIndex(UniversalSet * u, int element) {
    if (element < u->firstInt || element > u->lastInt) {
        printf("Element %d is not valid for this set.\n", element);
        return ILLEGAL_ELEMENT;
    } else {
        return element - u->firstInt;  // offset from the first element
    }
}

//---------------------------------------------------------------------
Set * setCreate(UniversalSet * u) {
    Set * set = (Set *) malloc(sizeof(Set));
    if (set == NULL) {
        printf("ERROR: Out of memory in setCreate(). Exiting...");
        exit(1);
    }

    int maxPossibleElements = u->lastInt - u->firstInt + 1;

    // How many integers do we need to store the bit flags?
    size_t n = maxPossibleElements / sizeof(int);
    if (maxPossibleElements % sizeof(int) != 0) {
        n++; // round the number of integers up
    }

    set->u = u;
    set->bitsSize = n;
    set->bits = (int *) calloc(n, sizeof(int) );

    if (set->bits == NULL) {
        printf("ERROR: Out of memory in setCreate(). Exiting...");
        exit(1);
    }

    return set;
}

//---------------------------------------------------------------------
void  setDelete(Set *set) {
    if (set != NULL) {
        free(set->bits);
        free(set);
    }
}

//---------------------------------------------------------------------
void  setAddElement(Set * set, int element) {
    int offset = universalSetElementIndex(set->u, element);
    if (offset != ILLEGAL_ELEMENT) {
        int whichInt = offset / sizeof(int);
        int whichBit = offset % sizeof(int);
        set->bits[whichInt] = set->bits[whichInt] | (1 << whichBit);
    }
}

//---------------------------------------------------------------------
void  setDeleteElement(Set * set, int element) {
    // FIX ME!
    set->bits[element] = 0;
}

//---------------------------------------------------------------------
Boolean setIsIn(Set * set, int element) {
    int max = set->bitsSize;
    Boolean val = FALSE;
    for(int i = 0; i < max; i++)
    {
        if(set->bits[i] == element)
        {
            val = TRUE;
        }
    }
    return val;  // WRONG - FIX ME!
}

//---------------------------------------------------------------------
static void verifySetsHaveSameUniverse(Set *s1, Set *s2) {
    if (s1->u != s2->u) {
        printf("Error: sets do not have common elements. Exiting... \n");
        exit(1);
    }
}

//---------------------------------------------------------------------
Set * setUnion(Set * s1, Set * s2) {
    verifySetsHaveSameUniverse(s1, s2);

    // Create a new set that will hold the union of s1 and s2
    Set * newSet = setCreate(s1->u);

    // Combine all of the bits from both sets.
    for (int j=0; j<s1->bitsSize; j++) {
        newSet->bits[j] = s1->bits[j] | s2->bits[j];
    }

    return newSet;
}

//---------------------------------------------------------------------
Set * setIntersection(Set * s1, Set * s2) {

    verifySetsHaveSameUniverse(s1,s2);

    Set * s3 = setCreate(s1->u);
    int max;
    if(s1->bitsSize> s2->bitsSize)
    {
        max = s1->bitsSize;
    }
    else
    {
        max = s2->bitsSize;
    }
    for(int i = 0; i < max; i++)
    {
        s3->bits[i] = s1->bits[i] & s2->bits[i];
    }
    return s3; // WRONG - FIX ME!
}

//---------------------------------------------------------------------
Set * setDifference(Set * s1, Set * s2) {
    Set * s3 = malloc(sizeof(Set));
    int max;
    if(s1->bitsSize> s2->bitsSize)
    {
        max = s1->bitsSize;
    }
    else
    {
        max = s2->bitsSize;
    }
    for(int i = 0; i < max; i++)
    {
        s3->bits[i] = s1->bits[i] & !s2->bits[i];
    }
    return s3; // WRONG - FIX ME!
}

//---------------------------------------------------------------------
Set * setComplement(Set * s1) {

    // Create a new set that holds the complement
    Set * newSet = setCreate(s1->u);

    // Complement each integer of the bits array
    for (int j=0; j<s1->bitsSize; j++) {
        newSet->bits[j] = ~(s1->bits[j]);
    }

    return newSet;
}

//---------------------------------------------------------------------
Boolean setEquals(Set * s1, Set * s2) {

    // To be equal, every integer in the bits array must be equal.
    for (int j=0; j<s1->bitsSize; j++) {
        if (s1->bits[j] != s2->bits[j]) {
            return FALSE;
        };
    }

    return TRUE;
}

//---------------------------------------------------------------------
Boolean setNotEquals(Set * s1, Set * s2) {

    int max;
    if(s1->bitsSize > s2->bitsSize)
    {
        return FALSE;
    }
    else
    {
        max = s2->bitsSize;
    }
    for(int i = 0; i < max; i++)
    {
        if(s1->bits[i] != s2->bits[i])
        {
            return FALSE;
        }
    }
    return TRUE; // WRONG - FIX ME!
}

//---------------------------------------------------------------------
Boolean setSubset(Set * s1, Set * s2) {
    // To be a subset, remove every element of s2 from s1 and test that s1 is empty
    for (int j=0; j<s1->bitsSize; j++) {
        if (s1->bits[j] & ~(s2->bits[j])) {
            return FALSE;
        }
    }

    return TRUE;
}

//---------------------------------------------------------------------
Boolean setProperSubset(Set * s1, Set * s2) {
    // To be a proper subset, remove every element of s2 from s1 and test that s1 is empty
    for (int j=0; j<s1->bitsSize; j++) {
        if (s1->bits[j] & ~(s2->bits[j])) {
            return FALSE;
        }
    }

    return setNotEquals(s1, s2);
}

//---------------------------------------------------------------------
Boolean setSuperset(Set * s1, Set * s2) {

    //!(s2&!s1)>0
    int max;
    if(s2->bitsSize > s1->bitsSize)
    {
        return FALSE;
    }
    else
    {
        max = s1->bitsSize;
    }
    for(int i = 0; i < max; i++)
    {
        if((!(s2->bits[i] & !s1->bits[i])) <= 0)
        {
            return FALSE;
        }
    }
    return TRUE; // WRONG - FIX ME!
}

//---------------------------------------------------------------------
Boolean setProperSuperset(Set * s1, Set * s2) {

    int max;
    if(s2->bitsSize >= s1->bitsSize)
    {
        return FALSE;
    }
    else
    {
        max = s1->bitsSize;
    }
    for(int i = 0; i < max; i++)
    {
        if((!(s2->bits[i] & !s1->bits[i])) <= 0)
        {
            return FALSE;
        }
    }
    return TRUE; // WRONG - FIX ME!
}

//---------------------------------------------------------------------
void setPrint(Set *s, char *description) {
    printf("Set %s: ", description);
    if (s == NULL) {
        printf("NULL");
    } else {
        for (int j = s->u->firstInt; j <= s->u->lastInt; j++) {
            if (setIsIn(s, j)) {
                printf("%d ", j);
            }
        }
    }
    printf("\n");
}

//---------------------------------------------------------------------
int  setCardinality(Set *s) {
    int cardinality = 0;
    for (int j = s->u->firstInt; j <= s->u->lastInt; j++) {
        if (setIsIn(s, j)) {
            cardinality++;
        }
    }
   return cardinality;
}

