// 20180490 Jaehun Lee - Assignment3 - customer_manager2.c

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "customer_manager.h"


enum {HASH_MULTIPLIER = 65599};
enum {BUCKET_COUNT = 1024};

static int hash_function(const char *pcKey, int iBucketCount)

/* Return a hash code for pcKey that is between 0 and iBucketCount-1,
   inclusive. Adapted from the EE209 lecture notes. */
{
   int i;
   unsigned int uiHash = 0U;
   for (i = 0; pcKey[i] != '\0'; i++)
      uiHash = uiHash * (unsigned int)HASH_MULTIPLIER
               + (unsigned int)pcKey[i];
   return (int)(uiHash % (unsigned int)iBucketCount);
}


struct UserInfo {
  char *name;                // customer name
  char *id;                  // customer id
  int purchase;              // purchase amount (> 0)
  struct UserInfo *next;
};

struct DB {
  struct UserInfo *id_array[BUCKET_COUNT];   // id hash table
  struct UserInfo *name_array[BUCKET_COUNT]; // name hash table
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
  d->curArrSize = BUCKET_COUNT; // start with 1024 elements
  int i;
  for (i = 0; i < (d->curArrSize); i++){  // initialize hash tables
    d->id_array[i] = NULL;
    d->name_array[i] = NULL;
  }
 
  return d;

}
/*--------------------------------------------------------------------*/
void
DestroyCustomerDB(DB_T d)
{
  /* fill out this function */
  assert(d);
  
  struct UserInfo *p;
  struct UserInfo *nextp;
  
  int b;
 /* destroy id hash table */  
  for (b = 0; b < (d->curArrSize); b++){
    for (p = d->id_array[b]; p != NULL; p = nextp){
      nextp = p->next;
      free(p->id);
      free(p->name);
      free(p);
    }
  }
 /* destroy name hash table */
  for (b = 0; b < (d->curArrSize); b++){
    for (p = d->name_array[b]; p != NULL; p = nextp){
      nextp = p->next;
      free(p->id);
      free(p->name);
      free(p);
    }
  }

  free(d);
 
}
/*-------------------------------------------------------------------*/
int
RegisterCustomer(DB_T d, const char *id,
		 const char *name, const int purchase)
{
  /* fill out this function */
  assert(d&&id&&name);
  if (d==NULL||id==NULL||name==NULL||purchase <= 0) return (-1);
  
  int id_hash = hash_function(id, d->curArrSize);
  int name_hash = hash_function(name, d->curArrSize);
  struct UserInfo *p, *q;
  /*if the name or id is already in DB, it fails */
  for (p = d->id_array[id_hash]; p != NULL; p = p->next){
    if (strcmp(p->id, id) == 0) {
      return (-1);
    }
  }
  for (p = d->name_array[name_hash]; p != NULL; p = p->next){
    if (strcmp(p->name, name) == 0) {
      return (-1);
    }   
  }
  
  /* resister in id hash table */
  p = (struct UserInfo*)malloc(sizeof(struct UserInfo));
  p->id = strdup(id);
  p->name = strdup(name);
  p->purchase = purchase;
  p->next = d->id_array[id_hash];
  d->id_array[id_hash] = p;
  
  /* resister in name hash table */
  q = (struct UserInfo*)malloc(sizeof(struct UserInfo));
  q->id = strdup(id);
  q->name = strdup(name);
  q->purchase = purchase;
  q->next = d->name_array[name_hash];
  d->name_array[name_hash] = q;
  
  d->numItems ++;
  
  return 0;
}
/*--------------------------------------------------------------------*/
int
UnregisterCustomerByID(DB_T d, const char *id)
{
  /* fill out this function */
  assert(d&&id);
  if (d==NULL||id==NULL) return (-1);
  
  char *name;
  int id_hash = hash_function(id, d->curArrSize);
  struct UserInfo *p, *q, *prev = NULL;
  
  /* find User with ID */
  for(p = d->id_array[id_hash]; p != NULL; prev = p, p= p->next){
    if(strcmp(p->id, id) == 0){
    
    /* unresister from name hash table first */
      name = p->name;    
      int name_hash = hash_function(name, d->curArrSize);
      for(q = d->name_array[name_hash]; q != NULL; prev = q, q= q->next){
        if(strcmp(q->name, name) == 0){
          if (prev == NULL) d->name_array[name_hash] = q->next;
          else prev->next = q->next;
          free(q->id);
          free(q->name);
          free(q);
          break;
        }
      }
      /* unresister from id hash table */
      if (prev == NULL) d->id_array[id_hash] = p->next;
      else prev->next = p->next;
      free(p->id);
      free(p->name);
      free(p);
      
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
  
  
  char *id;
  int name_hash = hash_function(name, d->curArrSize);
  struct UserInfo *p, *q, *prev = NULL;
  
  /* find User with name */
  for(p = d->name_array[name_hash]; p != NULL; prev = p, p= p->next){
    if(strcmp(p->name, name) == 0){
    
      id = p->id;    
      int id_hash = hash_function(id, d->curArrSize);
      /* unresister from id hash table first */
      for(q = d->id_array[id_hash]; q != NULL; prev = q, q= q->next){
        if(strcmp(q->id, id) == 0){
          if (prev == NULL) d->id_array[id_hash] = q->next;
          else prev->next = q->next;
          free(q->id);
          free(q->name);
          free(q);
          break;
        }
      }
      /* unresister from name hash table */
      if (prev == NULL) d->name_array[name_hash] = p->next;
      else prev->next = p->next;
      free(p->id);
      free(p->name);
      free(p);
      
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
  
  struct UserInfo *p;
  int h = hash_function(id, d->curArrSize);
  /* find User with ID */
  for (p = d->id_array[h]; p != NULL; p = p->next){
    if (strcmp(p->id, id) == 0) {
      return p->purchase;
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
  
  struct UserInfo *p;
  int h = hash_function(name, d->curArrSize);
  /* find User with name */
  for (p = d->name_array[h]; p != NULL; p = p->next){
    if (strcmp(p->name, name) == 0) {
      return p->purchase;
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
  
  int value=0;
  struct UserInfo *p;
  int  h;
  /* visit all array element and linked UserInfo */
  for (h = 0; h < (d->curArrSize); h++){
    for (p = d->id_array[h]; p != NULL; p = p->next){
      value += (*fp)(p->id, p->name, p->purchase);
    }
  }
    return value;
}
