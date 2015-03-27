#include <stdio.h>
#include <string.h>
#include "memory.h"
#include "heap.h"

/* A program to sort the command line arguments using the heap. */

int main(int argc, char *argv[]) {
 
 int i;
/*  struct heap * heap = initialize_heap(argc, (void *)strcmp);

 for (i = 1; i < argc; i++) {
   add_to_heap(heap, argv[i]);
 }

 printf("The command line arguments in order:\n");
 while (!heap_empty(heap))
   printf("%s ", (char *)heap_remove_min(heap));
 printf("\n");
 free_heap(heap);
 return 0; */


 //Here is an alternative way:x
     heapSort(argv + 1, argc - 1, strcmp);
     for (i = 1; i < argc; i++)
         printf("%s ", argv[i]);
     printf("\n");
 
 //printf("My compare returns: %d", myCompare(6, 9));
}