#include <stdio.h>
#include <stdlib.h>

typedef struct Node
{
    int data;
    struct Node* next;
}Node;

Node* insertFront(Node* head, int newData)
{
    Node* newNode = malloc(sizeof(Node));
    newNode->data = newData;
    newNode->next = head;
    return newNode;
}

int main()
{
    Node* head = malloc(sizeof(Node));
    Node* second = malloc(sizeof(Node));
    Node* third = malloc(sizeof(Node));

    //assign data to each node
    head->data = 10;
    head->next = second;

    second->data = 20;
    second->next = third;

    third->data = 30;
    third->next = NULL;

    //print list
    head = insertFront(head, 5);

    Node* current = head;
    while (current != NULL)
    {
        printf("%d->", current->data);
        current = current->next;
    }
    printf("NULL\n");




    //free mem
    free(head);
    free(second);
    free(third);


    return 0;
}