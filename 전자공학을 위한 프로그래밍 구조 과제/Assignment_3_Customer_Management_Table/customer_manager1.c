// 20180490 Jaehun Lee - Assignment3 - customer_manager1.c


#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "customer_manager.h"


#define UNIT_ARRAY_SIZE 1024

struct UserInfo {
  char *name;                // customer name
  char *id;                  // customer id
  int purchase;              // purchase amount (> 0)
};

struct DB {
  struct UserInfo *pArray;   // pointer to the array
  int curArrSize;            // current array size (max # of elements)
  int numItems;              // # of stored items, needed to determine
			     // # whether the array should be expanded
			     // # or not
};


/*--------------------------------------------------------------------*/
DB_T
CreateCustomerDB(void)
{

  DB_T d;
  
  d = (DB_T) calloc(1, sizeof(struct DB));
  if (d == NULL) {
    fprintf(stderr, "Can't allocate a memory for DB_T\n");
    return NULL;
  }
  d->curArrSize = UNIT_ARRAY_SIZE; // start with 1024 elements
  d->pArray = (struct UserInfo *)calloc(d->curArrSize,
               sizeof(struct UserInfo));
  if (d->pArray == NULL) {
    fprintf(stderr, "Can't allocate a memory for array of size %d\n",
	    d->curArrSize);   
    free(d);
    return NULL;
  }
  return d;

}
/*--------------------------------------------------------------------*/
void
DestroyCustomerDB(DB_T d)
{
  /* fill out this function */
  assert(d);
  
  int i;
  for (i=0; i<(d->curArrSize); i++){
    if (d->pArray[i].purchase != 0){ //check if element is empty
      free(d->pArray[i].name);
      free(d->pArray[i].id);
      }
  } 
  free(d->pArray);
  free(d);

}
/*--------------------------------------------------------------------*/
int
RegisterCustomer(DB_T d, const char *id,
		 const char *name, const int purchase)
{
  /* fill out this function */
  assert(d&&id&&name);
  if (d==NULL||id==NULL||name==NULL||purchase <= 0) return (-1);
  
  int i;
  /*if the name or id is already in DB, it fails */
  for (i=0; i<(d->numItems); i++){
    if ( strcmp( ((d->pArray)+i)->name, name )  == 0 )
      return (-1);
    if ( strcmp( ((d->pArray)+i)->id, id )  == 0 )
      return (-1);
  }
  
  for (i=0; i<(d->curArrSize); i++){
    if (d->pArray[i].purchase == 0){ //check if element is empty
      d->pArray[i].id = strdup(id);
      d->pArray[i].name = strdup(name);
      d->pArray[i].purchase = purchase;
      d->numItems ++;
      return 0;
      }
  } 
  
  return (-1);
}
/*--------------------------------------------------------------------*/
int
UnregisterCustomerByID(DB_T d, const char *id)
{
  /* fill out this function */
  assert(d&&id);
  if (d==NULL||id==NULL) return (-1);
  
  int i;
  for (i=0; i<(d->curArrSize); i++){
    if (d->pArray[i].id == NULL) // avoid seg fault for strcmp
      continue;
    //unresister  
    if (strcmp(d->pArray[i].id, id)==0){ // check id
      free(d->pArray[i].name);
      d->pArray[i].name = NULL;
      free(d->pArray[i].id);
      d->pArray[i].id = NULL;
      d->pArray[i].purchase = 0;
      d->numItems --;
      return 0;
      }
  }
  
  return (-1);
}

/*--------------------------------------------------------------------*/
int
UnregisterCustomerByName(DB_T d, const char *name)
{
  /* fill out this function */
  assert(d&&name);
  if (d==NULL||name==NULL) return (-1);
  
  
  int i;
  for (i=0; i<(d->curArrSize); i++){
    if (d->pArray[i].name == NULL) // avoid seg fault for strcmp
      continue;
    //unresister
    if (strcmp(d->pArray[i].name, name)==0){ // check name
      free(d->pArray[i].name);
      d->pArray[i].name = NULL;
      free(d->pArray[i].id);
      d->pArray[i].id = NULL;
      d->pArray[i].purchase = 0;
      d->numItems --;
      return 0;
      }
  }
  
  return (-1);
}
/*--------------------------------------------------------------------*/
int
GetPurchaseByID(DB_T d, const char* id)
{
  /* fill out this function */
  assert(d&&id);
  if (d==NULL||id==NULL) return (-1);
  
  int i;
  for (i=0; i<(d->curArrSize); i++){
    if (d->pArray[i].id == NULL) // avoid seg fault for strcmp
      continue;
    if (strcmp(d->pArray[i].id, id)==0){ // check id
      return d->pArray[i].purchase;
      }
  }
  
  return (-1);
}
/*--------------------------------------------------------------------*/
int
GetPurchaseByName(DB_T d, const char* name)
{
  /* fill out this function */
  assert(d&&name);
  if (d==NULL||name==NULL) return (-1);
  
  int i;
  for (i=0; i<(d->curArrSize); i++){ // avoid seg fault for strcmp
    if (d->pArray[i].name == NULL)
      continue;
    if (strcmp(d->pArray[i].name, name)==0){ // check name
      return d->pArray[i].purchase;
      }
  }
  
  return (-1);
}
/*--------------------------------------------------------------------*/
int
GetSumCustomerPurchase(DB_T d, FUNCPTR_T fp)
{
  /* fill out this function */
  assert(d&&fp);
  if (d==NULL||fp==NULL) return (-1);
  
  int i=0;
  int value=0;
  for (i=0; i<(d->curArrSize); i++){
    // avoid seg fault for strcmp
    if ( (d->pArray[i].id == NULL)||(d->pArray[i].name == NULL) )
      continue;
    value += (*fp)(d->pArray[i].id, d->pArray[i].name, d->pArray[i].purchase);
  }
  
  return value;
}
