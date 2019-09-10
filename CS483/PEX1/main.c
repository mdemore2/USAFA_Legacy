//Name: C2C Mark Demore & Luke McFadden
//Date: 7 Mar 2018
//Project: PEX 1
//Course/Section: CS483 - M3A
//Documentation: Referenced sample lesson 5 code, minor assistance on segfault troubleshooting from C2C Adam Payne

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include "LinkedList.h"
//#include "LinkedList.c"

char * getParent(char * path);

int main()
{
    char buffer[128];
    char workDirect[1024];
    char * user = malloc(sizeof(buffer));
    char * newDirect = malloc(sizeof(buffer));
    LinkedList * history = linkedListCreate();
    char* cmdCopy = malloc(sizeof(buffer));

    char *cmd = malloc(sizeof(buffer));
    int exitNow = 1;
    char * token[sizeof(buffer)];
    char * newPath = malloc(sizeof(buffer));
    int last = 0;
    int n = 0;
    int i = 0;
    int j = 0;

    while(exitNow != 0){
        getcwd(workDirect, sizeof(workDirect));     //get working directory
        user = getenv("USER");
        printf("%s@%s$", user, workDirect);                  //prompt user


        fgets(buffer,sizeof(buffer),stdin);                        //read command
        strcpy(cmd, buffer);
        //strcpy(buffer,"\0");

        cmd = strtok(cmd,"\n");
        //strcat(cmd, " ");
        //cmd[strlen(cmd)] = '\0';
        cmdCopy = strdup(cmd);

        token[0] = strtok(cmd, " ");   // parse command into tokens and put in an array
        i = 0;
        while (token[i] != NULL) {
            i++;
            token[i] = strtok(NULL," ");
        }

        if (strcmp(token[0],"recall") == 0) {
            n = history->numberElements - atoi(token[1]);
            cmd = linkedListGetElement(history, n);
            cmdCopy = strdup(cmd);

            token[0] = strtok(cmd, " ");   // parse command into tokens and put in an array
            i = 0;
            while (token[i] != NULL) {
                i++;
                token[i] = strtok(NULL," ");
            }
        }
            last = linkedListFindElement(history, cmdCopy);     //check if command used and append to history
            if(last == -1)
            {
                linkedListAppend(history, cmdCopy);
            }
            else
            {
                linkedListDeleteElement(history, last);
                linkedListAppend(history, cmdCopy);
            }


        j = 0;          // for accessing token array

        if(strcmp(token[j],"exit") == 0)             //check exit
        {
            exitNow = 0;
        }
        else if(strcmp(token[j], "history") == 0)   { //check history
            linkedListPrint(history);
        }
        else if(strcmp(token[j], "recall") == 0)    //check recall
        {
            j++;
            n = history->numberElements - atoi(token[j]);
            cmd = linkedListGetElement(history, n);
        }
        else if((strcmp(token[j],"cd") == 0)) {
            j++;
            if(strcmp(token[j],"~") == 0) {
                newPath = getenv("HOME");
                chdir(newPath);
                getcwd(workDirect, sizeof(workDirect));     //get working directory
            }
            else if (strcmp(token[j], "..") == 0) {
                //newPath = getParent(workDirect);
                //newDirect = getenv(newPath);
                chdir("..");
                getcwd(workDirect, sizeof(workDirect));     //get working directory
            }
            newPath = strcat(workDirect, token[j]);
            chdir(newPath);
        }
        else //if ( 1 == 0)
        { // external commands
            int i = 0;
            char * cmd_ptr_array[20];       //parse command
            while(cmd != NULL)
            {
                cmd_ptr_array[i] = strdup(cmd);
                printf("token[%d] = \"%s\"\n", i, cmd_ptr_array[i]);
                cmd = strtok(NULL, "\t");
                i++;
            }
            cmd_ptr_array[i] = NULL;

            pid_t ret_val;
            int status;
            ret_val = fork();       //create process and pass command
            if(ret_val != 0)
            {
                wait(&status);
            }
            else
            {
                execvp(cmd_ptr_array[0],cmd_ptr_array);
                exit(1);
            }
        }
    }
    return 0;
}



