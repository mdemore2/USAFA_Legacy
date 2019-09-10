//
// Created by C19Mark.Demore on 2/3/2017.
//


#include "Stack.h"
#include <stdlib.h>
#include <stdio.h>

//int main()
//{
//    return 0;
//}
void stackPush(Stack * the_stack, ElementType newValue)
{
    the_stack->size++;
    Node* new = malloc(sizeof(Node));

    new->data = newValue;
    new->next = the_stack->top;

    if(the_stack->last == NULL)
    {
        the_stack->last = new;
        the_stack->top = new;
    }
    else
    {
        the_stack->top=new;
    }

}
void stackClear(Stack *the_stack)
{
    Node* current = the_stack->top;
    Node* nexty;
    while(current!=NULL)
    {
        nexty=current->next;
        free(current);
        current = nexty;
    }
    the_stack->top = NULL;
    the_stack->last = NULL;
    the_stack->size=0;
}
void stackDelete(Stack *the_stack)
{
    free(the_stack);
}
ElementType stackTop(Stack *the_stack)
{
    int test;
    test = stackIsEmpty(the_stack);
    if(test==1)
    {
        return the_stack->top->data;
    }
    else
    {
        return 0;
    }
}
ElementType stackPeek(Stack *the_stack, int pos)
{
    Node* temp = the_stack->top;
    ElementType val;
    for(int i =0; i < pos; i++)
    {
        temp=temp->next;
    }
    val = temp->data;
    return val;
}

ElementType stackPop(Stack *the_stack)
{
    ElementType val = the_stack->top->data;
    the_stack->top=the_stack->top->next;
    return val;
}
int stackIsEmpty(Stack *the_stack)
{
    Node* iterator = the_stack->top;
    if( iterator==NULL)
    {
        printf("The list is empty.");
        return 1;
    }
    else
    {
        printf("The list is NOT empty.");
        return 0;
    }

}
Stack * stackCreate()
{
    Stack * my_stack = malloc(sizeof(Stack));
    return my_stack;
}
