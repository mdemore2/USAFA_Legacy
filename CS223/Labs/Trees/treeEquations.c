/** treeEquation.c
 * ===========================================================
 * Name: Mark Demore II, Spring 2017
 * Section: T3A
 * Project: Lab19
 * Purpose: Experiments with tree recursion.
 *          Manipulate a tree that represents an equation.
 * Notes: This code reads a "fully parenthesed" equation from a file
 *        and builds a binary tree to represent the equation. If
 *        the equation does not have valid syntax, the code will fail.
 *        The parentheses determine the order of operations for
 *        evaluating the equation. If you did not use the parentheses,
 *        the order of operations would have to be determined using
 *        operator precedence, which requires a more complex parsing
 *        algorithm.
 * ===========================================================
 */
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>  // defines isdigit()
#include <math.h>

//---------------------------------------------------------------------
#define MAXIMUM_EQUATION_LENGTH  100
#define MAXIMUM_DIGITS_IN_OPERAND  10
#define FALSE 0
#define TRUE  1

//---------------------------------------------------------------------
// Tree definition
//---------------------------------------------------------------------
struct treeNode {
    char              data[MAXIMUM_DIGITS_IN_OPERAND + 1];
    struct treeNode * leftChild;
    struct treeNode * rightChild;
};

typedef struct treeNode TreeNode;

typedef TreeNode * Tree;

//---------------------------------------------------------------------
// Tree functions
//---------------------------------------------------------------------
Tree buildTree(char * filename);
Tree parseEquationIntoTree(char * equationString);
Tree parseSubTree(char * equationString);
void printTreeEquation(Tree root);
int evaluateTreeEquation(Tree root);

//---------------------------------------------------------------------
int main() {
    Tree  root;
    root = buildTree("Labs/Trees/equation1.txt");
    printTreeEquation(root);
    int result = evaluateTreeEquation(root);
    printf("\n%d",result);
}

//---------------------------------------------------------------------
void removeSpaces(char *str) {
    int k = 0;
    for (int j = 0; str[j] != '\0'; j++) {
        if (str[j] != ' ') {
            str[k++] = str[j];
        }
    }
    str[k] = '\0'; // null termination
}

//---------------------------------------------------------------------
// Store a global index into the equation string. This is needed because
// the recursive functions return node pointers and we need to track
// the position in the input string as it is parsed. Global variables
// should be minimized, but recursive functions sometimes need them.
// Declaring this variable "static" makes it local to this file.
// Declaring this variable here makes it access only to the remainder
// of the file. It is not accessible in main().
static int equationPosition;

//---------------------------------------------------------------------
Tree buildTree(char * filename) {
    FILE * fp;
    char * buffer;

    buffer = (char *) malloc(sizeof(char) * (MAXIMUM_EQUATION_LENGTH + 1));

    fp = fopen(filename, "r");
    fgets(buffer , MAXIMUM_EQUATION_LENGTH + 1, fp);
    fclose(fp);

    printf("original equation = '%s'\n", buffer);
    removeSpaces(buffer);
    printf("equation without spaces = '%s'\n", buffer);

    equationPosition = 0;
    return parseEquationIntoTree(buffer);
}

//---------------------------------------------------------------------
Tree createNode(char * equationString) {
    TreeNode * node = (TreeNode *) malloc(sizeof(TreeNode));
    node->leftChild = NULL;
    node->rightChild = NULL;

    int j = 0;
    if (isdigit(equationString[equationPosition])) {
        // Transfer the operand digits to the node data
        while (j < MAXIMUM_DIGITS_IN_OPERAND && isdigit(equationString[equationPosition])) {
            node->data[j++] = equationString[equationPosition++];
        }
    } else {
        // Assume it is an operator
        node->data[j++] = equationString[equationPosition++];
    }
    node->data[j] = '\0'; // null terminate the string

    return node;
}

//---------------------------------------------------------------------
Tree parseEquationIntoTree(char * equationString) {

    TreeNode * leftChild;
    TreeNode * rightChild;
    TreeNode * node = NULL;

    leftChild = parseSubTree(equationString);   // Create the left operand
    node = createNode(equationString);          // Create the operator node
    rightChild = parseSubTree(equationString);  // Create the right operand

    node->leftChild = leftChild;
    node->rightChild = rightChild;

    return node;
}

//---------------------------------------------------------------------
Tree parseSubTree(char * equationString) {

    TreeNode * node = NULL;

    if (equationString[equationPosition] == '(') {
        // This operand is a sub-tree
        equationPosition++;  // passes over the '('
        node = parseEquationIntoTree(equationString);
        equationPosition++;  // passed over the ')'
    } else {
        // This operand is a single number
        node = createNode(equationString);
    }

    return node;
}
void printTreeEquation(Tree root)
{
    if(root != NULL)
    {
        if (isdigit(root->data[0]))
        {
            printf("%s ", root->data);

        }
        else
        {
            printf("(");
            printTreeEquation(root->leftChild);
            printf("%s", root->data);
            printTreeEquation(root->rightChild);
            printf(")");
        }
    }
}
int evaluateTreeEquation(Tree root)
{
    int left = 0, right = 0;
    if(root->leftChild == NULL && root->rightChild == NULL)
    {
        return atoi(root->data);
        // at a leaf aka number
    }
    if(root->leftChild != NULL)
    {
        left = evaluateTreeEquation(root->leftChild);
        //recursion to get to left leaf
    }
    if(root->rightChild != NULL)
    {
        right = evaluateTreeEquation(root->rightChild);
        //recursion to get to right leaf
    }
    if (root->data[0] == '+')
    {
        return left + right;
        //at parent operator, do work
    }
    if (root->data[0] == '-')
    {
        return left - right;
    }
    if (root->data[0] == '*')
    {
        return left * right;
    }
    if (root->data[0] == '/')
    {
        return left / right;
    }
    if (root->data[0] == '^')
    {
        return (int) pow(left,right);
    }
    if (root->data[0] == '%')
    {
        return left % right;
    }
    else
    {
        return 0;
    }

}