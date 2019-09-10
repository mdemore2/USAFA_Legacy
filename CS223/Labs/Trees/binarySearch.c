//
// Created by C19Mark.Demore on 3/6/2017.
//

#include <stdlib.h>
#include <stdio.h>
#include "binarySearch.h"

int height = 0;
int temp = 0;

int treeHeight(TreeNode * root)
{
    if (root == NULL)
    {
        return 0;
    }
    else
    {
        int leftHeight = treeHeight(root->leftChild);
        int rightHeight = treeHeight(root->rightChild);
        if(leftHeight > rightHeight)
        {
            return leftHeight + 1;
        }
        else
        {
            return rightHeight + 1;
        }
    }

}

TreeNode * createTree()
{
    TreeNode * root;
    root = malloc(sizeof(struct treeNode));
    return root;
}


int main()
{
    TreeNode * root;
    root = createTree();
    printf("Tree Height: %d",treeHeight(root));

    return 0;
}


