/*-----------------------------------------------------------------------------------------*
 * Behaves the same as "normal" malloc, but keeps track of the memory allocation so we can *
 *  watch for memory leaks.                                                                *
 * INPUT:  the number of bytes to be allocated                                             *
 * OUTPUT: a pointer to the allocated memory                                               *
 *-----------------------------------------------------------------------------------------*/
void * eecs345_malloc(int size);

/*-----------------------------------------------------------------------------------------*
 * Behaves the same as "normal" calloc, but keeps track of the memory allocation so we can *
 *  watch for memory leaks.                                                                *
 * INPUT:  the number of entries in the desired array and the size in bytes for each entry *
 * OUTPUT: a pointer to the allocated memory                                               *
 *-----------------------------------------------------------------------------------------*/
void * eecs345_calloc(int number, int size);

/*-----------------------------------------------------------------------------------------*
 * Behaves the same as "normal" free, but does not call free unless the memory was         *
 *   allocated by eecs345_malloc or eecs345_calloc.  Keeps track of the number of times    *
 *   eecs345_free is called incorrectly.                                                   *
 * INPUT:  a pointer to the memory to be deallocated                                       *
 *-----------------------------------------------------------------------------------------*/
void eecs345_free(void * p);

/*-----------------------------------------------------------------------------------------*
 * Prints a message if there is still allocated memory not freed or if eecs345_free        *
 *   was ever called incorrectly on an address.                                            *
 *-----------------------------------------------------------------------------------------*/
void test_for_memoryleaks();