//
// Created by C19Mark.Demore on 2/3/2017.
//

#ifndef CS223_REPOSITORY_SPRING_2017_LAB11_H
#define CS223_REPOSITORY_SPRING_2017_LAB11_H

typedef float ElementType;

typedef struct node
{
    ElementType data;
    struct node* next;

} Node;

typedef struct linkedList
{
    int size;
    Node* top;
    Node* last;
} LinkedList;

typedef LinkedList Stack;

// Standard stack functionality
Stack *     stackCreate ();
void        stackDelete (Stack *s);
void        stackPush   (Stack *s, ElementType element);
ElementType stackPop    (Stack *s);
int         stackIsEmpty(Stack *s);

// Optional stack functionality
ElementType stackPeek   (Stack *s, int index);
ElementType stackTop    (Stack *s);
int         stackSize   (Stack *s);
void        stackClear  (Stack *s);

#endif //CS223_REPOSITORY_SPRING_2017_LAB11_H