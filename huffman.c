/* A program to read in an input file and produce the Huffman codes that are used to compress the file. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "memory.h"
#include "heap.h" 

/* This is the node of the huffman tree */

struct hufftreenode {
  int value;                            // the character being stored
  int weight;                           // the weight is the number of occurrences of the character in the file
  struct hufftreenode * leftchild;
  struct hufftreenode * rightchild;
};

/* A list of Huffman codes for each of the 256 legal C characters */
char * huffmancodes[256];  

  char * concat(char * prefix, char letter) {
    char * result = (char *)eecs345_malloc(strlen(prefix) + 2);
    sprintf(result, "%s%c", prefix, letter);
    return result;
  }

  int nodecompare(struct hufftreenode * node1, struct hufftreenode * node2) {
    int result;
    if(node1->weight > node2->weight){
      result =  1;
    }
    if(node2->weight > node1->weight){
      result = -1;
    }
    if(node1->weight == node2->weight){
      result = 0;
    }
    return result;
  }

void generateCode(struct hufftreenode * root, char * string) {
  char * newstring = (char *)eecs345_calloc(strlen(string), sizeof(char));
  if(root->leftchild == NULL && root->rightchild == NULL) {
    //printf("Im here!! %s \n", "");
    huffmancodes[root->value] = string;
    //eecs345_free(newstring);
  }
    else{
        if(root->leftchild != NULL) {
        //printf("went left %s \n", "");
        newstring = concat(string, '0');
        //printf("first else-if string: %s \n", concat(string, '0'));
        generateCode(root->leftchild, newstring);
        //eecs345_free(newstring);
      }
        if(root->rightchild != NULL) {
        newstring = concat(string, '1');
        //printf("went right %s \n", "");
        generateCode(root->rightchild, newstring);
        //eecs345_free(newstring);
      }
    }
    //eecs345_free(newstring);
}                   


/* Read in a file.  Count the number of occurrences of each character in the file, and produce the Huffman tree and the Huffman codes for each character */
int main(int argc, char *argv[]) {
  FILE *infile;
  int i, c;
  int counts[256];

  if (argc != 2) {
     printf("Usage: %s inputfile\n", argv[0]);
     return 0;
  }

  /* Open a file.  For reading. */
  infile = fopen(argv[1], "r");

  /* Initialize the count of each character to 0 */
  for (i = 0; i < 256; i++)
    counts[i] = 0;

  /* Count the number of occurrences each character */
  while ((c = fgetc(infile)) != EOF)
    counts[c]++;


  /** TODO: 1. Create a heap */

  struct heap * heap = initialize_heap(256, (void *)nodecompare);
  /**       2. For each character c with counts[c] greater than 0, create a hufftreenode with value = c, weight = counts[c], and children = NULL.  Place the hufftreenode in the heap. */
  for(i = 0; i < 256; i++){
    if(counts[i] > 0) {
      struct hufftreenode * newhufftreenode =  (struct hufftreenode *)eecs345_malloc(sizeof(struct hufftreenode));
      newhufftreenode->value = i;
      newhufftreenode->weight = counts[i];
      newhufftreenode->leftchild = NULL;
      newhufftreenode->rightchild = NULL;
      //printf("node value: %c \n", newhufftreenode->value);
      //printf("node weight: %d \n", newhufftreenode->weight);
      add_to_heap(heap, newhufftreenode);
  }
}

  /**       3. Repeat until there is only one thing left in the heap: */
  /**          3.a Remove the two minimum elements from the heap */
  /**          3.b Create a new hufftreenode.  Make its left and right children the two elements you removed in step 3.a and make its weight the sum of the weights of those two elements. */
  /**          3.c Add the new hufftreenode to the heap. */

while(heap->endptr != 1) {
  struct hufftreenode * temphufftreenode =  (struct hufftreenode *)eecs345_malloc(sizeof(struct hufftreenode));
  struct hufftreenode * min1 = heap_remove_min(heap);
  struct hufftreenode * min2 = heap_remove_min(heap);
  temphufftreenode->leftchild = min1;
  temphufftreenode->rightchild = min2;
  temphufftreenode->weight = (min1->weight + min2->weight);
  //printf("Min 1: %c \n", min1->value);
  //printf("Min 2: %c \n", min2->value);

  //printf("leftchild value: %c \n", min1->value);
  //printf("rightchild value: %c \n", min2->value);
  //printf("parent weight: %d \n", temphufftreenode->weight);
  add_to_heap(heap, temphufftreenode);

}

//char * concatTest = (char *)eecs345_calloc(1, sizeof(char));
//concatTest = "JOOO";
//printf("Concat test: %s \n", concat(concatTest, '1'));


  /**       4. When the heap is empty, the last thing you removed will be the root node of the Huffman tree. */
  /**       5. Traverse the Huffman tree starting from the root, creating code strings as you go.  When you go left, append a '0' to the code string, and when you go right, append a '1', */
  /**           to the code string.  When you get to a leaf, store the code string generated in codes[leafnode->value]. */
char * string = (char *)eecs345_calloc(1, sizeof(char));
string = "";
generateCode(heap_remove_min(heap), string);
eecs345_free(heap);
  /**       6. Clean up all memory used.  */

//eecs345_free(temphufftreenode);
//eecs345_free(newhufftreenode);
  /** Ok, you will want to remove the next line.  I only added it so you can see that the "special" allocation works the same as normal allocation */
  //char * initialcode = eecs345_malloc(20);   /* LOOK! I am allocating memory without freeing it.  The test_tor_memoryleaks function will print an error! */


  /* Print the codes for each character used in the file */
  for (i = 0; i < 256; i++) {
    if (counts[i] != 0) {
      printf("%3c  %5d  %s\n", i, counts[i], huffmancodes[i]);
    }
  }
  //eecs345_free(heap);
  /* Hopefully, you correctly handled all your memory allocations and deallocations */
  test_for_memoryleaks();
}