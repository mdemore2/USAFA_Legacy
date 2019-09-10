//
// Created by Wayne.Brown on 5/1/2017.
//

#include <stdio.h>
#include "Set.h"

int main() {
    UniversalSet * x = universalSetCreate(20, 30);

    Set * a = setCreate(x);
    setAddElement(a, 21);
    setAddElement(a, 24);
    setAddElement(a, 27);

    Set * b = setCreate(x);
    setAddElement(b, 21);
    setAddElement(b, 24);
    setAddElement(b, 28);

    Set * c = setUnion(a, b);
    printf("\n");
    setPrint(a, "a");
    setPrint(b, "b");
    setPrint(c, "a union b");
    setDelete(c);

    setAddElement(a, 30);
    c = setUnion(a, b);
    printf("\n");
    setPrint(a, "a");
    setPrint(b, "b");
    setPrint(c, "a union b");
    setDelete(c);

    setDeleteElement(a, 21);
    c = setUnion(a, b);
    printf("\n");
    setPrint(a, "a");
    setPrint(b, "b");
    setPrint(c, "a union b");
    setDelete(c);

    c = setIntersection(a, b);
    printf("\n");
    setPrint(c, "a intersect b");
    setDelete(c);

    c = setDifference(a, b);
    printf("\n");
    setPrint(a, "a");
    setPrint(b, "b");
    setPrint(c, "a minus b");
    setDelete(c);

    c = setDifference(b, a);
    printf("\n");
    setPrint(a, "a");
    setPrint(b, "b");
    setPrint(c, "b minus a");
    setDelete(c);

    c = setComplement(a);
    printf("\n");
    setPrint(a, "a");
    setPrint(c, "~a");
    setDelete(c);

    c = setComplement(b);
    printf("\n");
    setPrint(b, "b");
    setPrint(c, "~b");
    setDelete(c);

    printf("\n");
    printf("a equals b %s\n", (setEquals(a,b) ? "TRUE" : "FALSE"));
    printf("a not equals b %s\n", (setNotEquals(a,b) ? "TRUE" : "FALSE"));
    printf("a subset b %s\n", (setSubset(a,b) ? "TRUE" : "FALSE"));
    printf("a superset b %s\n", (setSuperset(a,b) ? "TRUE" : "FALSE"));

    Set * d = setCreate(x);
    setAddElement(d, 21);
    setAddElement(d, 24);

    Set * e = setCreate(x);
    setAddElement(e, 21);
    setAddElement(e, 24);

    printf("\n");
    printf("d equals e %s\n", (setEquals(d,e) ? "TRUE" : "FALSE"));
    printf("d not equals e %s\n", (setNotEquals(d,e) ? "TRUE" : "FALSE"));
    printf("d subset e %s\n", (setSubset(d,e) ? "TRUE" : "FALSE"));
    printf("d superset e %s\n", (setSuperset(d,e) ? "TRUE" : "FALSE"));

}