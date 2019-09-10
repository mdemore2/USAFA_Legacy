/** Set.h
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Section:
 * Project: Lesson 39
 * Purpose: Implement a Set data structure
 * ===========================================================
 */

#ifndef SET_H
#define SET_H

#include <stdlib.h>

typedef int Boolean;

#define FALSE                   0
#define TRUE                    1
#define ILLEGAL_ELEMENT        -1

// A Universal Set - a range of integers
typedef struct universalSet {
    int  firstInt;
    int  lastInt;
} UniversalSet;

// A set data structure
typedef struct set {
    UniversalSet * u;   // The Universal Set that defines the set's values
    size_t  bitsSize;   // How many integers are used to store the set bits
    int *   bits;       // An array of integers for the bits (one bit per element; 32 bits per int)
} Set;

// The definition of a universal set; a range of integers [first, last]
UniversalSet * universalSetCreate(int first, int last);
void           universalSetDelete(UniversalSet *u);
int            universalSetElementIndex(UniversalSet * u, int element);

Set * setCreate(UniversalSet * u);
void  setDelete(Set * set);

void  setAddElement   (Set * set, int element);
void  setDeleteElement(Set * set, int element);

Set * setUnion       (Set * s1, Set * s2);
Set * setIntersection(Set * s1, Set * s2);
Set * setDifference  (Set * s1, Set * s2);
Set * setComplement  (Set * s1);

Boolean setIsIn          (Set * set, int element);
Boolean setEquals        (Set * s1, Set * s2);
Boolean setNotEquals     (Set * s1, Set * s2);
Boolean setSubset        (Set * s1, Set * s2);
Boolean setProperSubset  (Set * s1, Set * s2);
Boolean setSuperset      (Set * s1, Set * s2);
Boolean setProperSuperset(Set * s1, Set * s2);

void setPrint(Set * s, char * description);
int  setCardinality(Set * s);

#endif // SET_H
