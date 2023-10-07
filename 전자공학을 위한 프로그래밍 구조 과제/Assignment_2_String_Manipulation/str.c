// 20180490 - Jaehun Lee - Assignment2 

#include <assert.h> /* to use assert() */
#include <stdio.h>
#include <stdlib.h> /* for strtol() */
#include <string.h>
#include "str.h"
#include <limits.h>
#include <ctype.h>

/* Your task is: 
   1. Rewrite the body of "Part 1" functions - remove the current
      body that simply calls the corresponding C standard library
      function.
   2. Write appropriate comment per each function
*/

/* Part 1 */
/*-------------------------------------------------------------------*/
size_t StrGetLength(const char* pcSrc)
{
  const char *pcEnd;
  assert(pcSrc); /* NULL address, 0, and FALSE are identical. */
  pcEnd = pcSrc;
	
  while (*pcEnd) /* null character and FALSE are identical. */
    pcEnd++;

  return (size_t)(pcEnd - pcSrc);
}

/*-------------------------------------------------------------------*/
char *StrCopy(char *pcDest, const char* pcSrc)
{
  /* TODO: fill this function */

  assert(pcSrc);
  assert(pcDest);

  char* Dest = pcDest;
 
  while (*pcSrc){
    *pcDest = *pcSrc; // copy the values from the source
    pcSrc++;
    pcDest++;
  }
  *pcDest = '\0'; // put NULL at the end
  
  return Dest;
}

/*-------------------------------------------------------------------*/
int StrCompare(const char* pcS1, const char* pcS2)
{
  /* TODO: fill this function */

  assert(pcS1);
  assert(pcS2);

  int diff = 0;

  while(*pcS1){
    if (*pcS1 != *pcS2){
      diff = *pcS1 - *pcS2; // if different, record the difference
      break;
    }
    pcS1++;
    pcS2++;
  }
  if ((diff==0)&&(*pcS2)) // if S2 is longer
    diff = -*pcS2;
 
  return diff;
}
/*-------------------------------------------------------------------*/
char *StrFindChr(const char* pcHaystack, int c)
{
  /* TODO: fill this function */

  assert(pcHaystack);

  while(*pcHaystack){
    if (*pcHaystack == c) // matched
      break;
    pcHaystack++;
  }
  if (*pcHaystack == c)
    return (char*) pcHaystack; // return address of matched element
  else
    return NULL;
}
/*-------------------------------------------------------------------*/
char *StrFindStr(const char* pcHaystack, const char *pcNeedle)
{
  /* TODO: fill this function */
  
  assert(pcHaystack);
  
  char* ptrN = (char*) pcNeedle;
  char* ptrH = (char*) pcHaystack;

  while(*pcHaystack){
    if (*pcHaystack == *pcNeedle){ // if first element matched
      ptrN = (char*) pcNeedle;
      ptrH = (char*) pcHaystack;
      while ((*pcHaystack == *ptrN)&&(*ptrN)){ 
      // keep searching till different
	pcHaystack++;
	ptrN++;
      }
    }
    if (*ptrN == '\0') // if the string is perfectly matched
      return ptrH;
    pcHaystack++;
  }
  
  return NULL;
}
/*-------------------------------------------------------------------*/
char *StrConcat(char *pcDest, const char* pcSrc)
{
  /* TODO: fill this function */

  assert(pcDest);
  assert(pcSrc);

  char* Dest = pcDest;

  while (*pcDest) // move to the end of Dest
    pcDest++;

  while (*pcSrc){ // concatenate the string from the source
    *pcDest = *pcSrc;
    pcDest++;
    pcSrc++;
  }
  *pcDest = '\0';
  
  return Dest;
}

/*-------------------------------------------------------------------*/
long int StrToLong(const char *nptr, char **endptr, int base)
{
  /* handle only when base is 10 */
  if (base != 10) return 0;

  /* TODO: fill this function */
  assert(nptr);
  
  long int sign = 1;
  long int value = 0;
  long int temp = 0;
  char* ptr = (char*)nptr; // save the initial value of nptr
  
  if (endptr != NULL)
    *endptr = ptr;
  
  while (*nptr && isspace(*nptr)) // skip the spaces
    nptr++;
  if (*nptr == '+')  // check the sign
    nptr++;
  else if (*nptr == '-'){
    sign = -1;
    nptr++;
  }
  
  while(*nptr){
    if ((*nptr >= '0')&&(*nptr <= '9')){  // if the string is in 0~9
      temp = value;
      value = 10*value + (*nptr - '0');  // convert to int

      if ((temp > 0)&&(value < 0)){
	if (sign == -1)
	  return LONG_MIN; // underflow
	else
	  return LONG_MAX; // overflow
      }
      nptr++;
    }
    else
      break;
  }
  
  if (value == 0) // no digits were there
    return value;
  else{
    ptr = (char*)nptr;
    if (endptr != NULL)
      *endptr = ptr; //save the address of the first non-digit element
  }
  return value*sign;
}
