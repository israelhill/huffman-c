/**********************/
/* THE HEAP STRUCTURE */
/**********************/

struct heap {
  /* The array of data to be stored in the heap.  Each element is a pointer to the true data. */
  void **data;

  /* The number of elements the heap can store. */
  int capacity;

  /* Stores the last used entry (i.e. the largest leaf) of the heap */
  int endptr;
  
  /* The function used to order the elements of the heap.
   * Returns < 0 if the first is smaller than the second, > 0 if the first is larger than the second */
  int (* compare)(void *, void *); 
};

/**********************/
/* THE HEAP FUNCTIONS */
/**********************/

/*--------------------------------------------------------------------------------------*
 * Does an in-place heap sort of the array.                                             *
 * INPUT:  The array to be sorted, the size of the array, and a function to order the   *
 *         elements.  The array stores pointers to the elements that must be sorted.    *
 *--------------------------------------------------------------------------------------*/
void heapSort(void **, int, int (*compare)(void *, void *));

/*--------------------------------------------------------------------------------------*
 * Creates an empty heap and returns a pointer to the heap                              *
 * INPUT:  The desired capacity of the heap and a function that orders two elements.    *
 * OUTPUT: A pointer to the heap.                                                       *
 *--------------------------------------------------------------------------------------*/
struct heap * initialize_heap(int, int (* compare)(void *, void *));

/*--------------------------------------------------------------------------------------*
 * Frees the memory used by the heap and the heap pointer                               *
 * INPUT:  A pointer to the heap.                                                       *
 *--------------------------------------------------------------------------------------*/
void free_heap(struct heap *);

/*--------------------------------------------------------------------------------------*
 * Returns the element, but does not remove, the element at the top of the heap.        *
 * INPUT:  A pointer to the heap.                                                       *
 * OUTPUT: The minimum element.                                                         *
 *--------------------------------------------------------------------------------------*/
void * heap_get_min(struct heap *);

/*--------------------------------------------------------------------------------------*
 * Adds another element to the heap.                                                    *
 * INPUT:  A pointer to the heap, and a pointer to the data.                            *
 *--------------------------------------------------------------------------------------*/
void add_to_heap(struct heap *, void * data);

/*--------------------------------------------------------------------------------------*
 * Removes and returns the element at the top of the heap.                              *
 * INPUT:  A pointer to the heap.                                                       *
 * OUTPUT: A pointer to the minimum element.                                            *
 *--------------------------------------------------------------------------------------*/
void * heap_remove_min(struct heap *);

/*--------------------------------------------------------------------------------------*
 * Returns true if the heap is empty.                                                   *
 * INPUT:  A pointer to the heap.                                                       *
 * OUTPUT: 0 if there are no elements in the heap and non-0 otherwise.                  *
 *--------------------------------------------------------------------------------------*/
char heap_empty(struct heap *);
