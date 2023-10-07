// 20180490 Jaehun Lee - Assignment2 

#include <stdio.h>
#include <stdlib.h>
#include <string.h> /* for skeleton code */
#include <unistd.h> /* for getopt */
#include "str.h"

#define MAX_STR_LEN 1023

#define FALSE 0
#define TRUE  1

/*
 * Fill out your own functions here (If you need) 
 */


/*-------------------------------------------------------------------*/
/* PrintUsage()
   print out the usage of the Simple Grep Program                    */
/*-------------------------------------------------------------------*/
void 
PrintUsage(const char* argv0) 
{
  const static char *fmt = 
	  "Simple Grep (sgrep) Usage:\n"
	  "%s pattern [stdin]\n";

  printf(fmt, argv0);
}
/*-------------------------------------------------------------------*/
/* SearchPattern()
   Your task:
   1. Do argument validation 
   - String or file argument length is no more than 1023
   - If you encounter a command-line argument that's too long, 
   print out "Error: argument is too long"
   
   2. Read the each line from standard input (stdin)
   - If you encounter a line larger than 1023 bytes, 
   print out "Error: input line is too long" 
   - Error message should be printed out to standard error (stderr)
   
   3. Check & print out the line contains a given string (search-string)
      
   Tips:
   - fgets() is an useful function to read characters from file. Note 
   that the fget() reads until newline or the end-of-file is reached. 
   - fprintf(sderr, ...) should be useful for printing out error
   message to standard error

   NOTE: If there is any problem, return FALSE; if not, return TRUE  */
/*-------------------------------------------------------------------*/
int
SearchPattern(const char *pattern)   
// compare input line and pattern. Method : character by character
{
  char buf[MAX_STR_LEN + 2]; 
  int len;
  char* bptr;                        // added two declaration
  char* pptr = (char*)pattern;
  
  /* 
   *  TODO: check if pattern is too long
   */
  if ((len = StrGetLength(pattern)) > MAX_STR_LEN) {
    fprintf(stderr, "Error: argument is too long\n");
    return FALSE;
  }

  /* Read one line at a time from stdin, and process each line */
  while (fgets(buf, sizeof(buf), stdin)) {
    
    // added two lines : initializing bptr and pptr for new line input
    bptr = buf;                       
    pptr = (char*)pattern;
	  
    /* check the length of an input line */
    if ((len = StrGetLength(buf)) > MAX_STR_LEN) {
      fprintf(stderr, "Error: input line is too long\n");
      return FALSE;
    }
	
    /* TODO: fill out this function */
    while ((*bptr != '\0') && (*pptr != '\0')) {
      
      if (*pptr == '*') {
	
	if (*(pptr+1) == '\0') {   
	// if * and the next is null, pattern is founded.
	  fputs(buf, stdout);
	  break; }
	  
 	else if (*(pptr+1) == '*') //if star comes in a row in pattern
 	  pptr++;                  //skip a star
 
	else {
	  bptr = StrFindChr(bptr, *(pptr+1)); 
// move the buffer to where the next pattern character apprears
	  
	  if (bptr == NULL)  
	    break;
// if failed to find next pattern character, this line doesn't match	    
	  pptr++;
	  
	  while ((*bptr)&(*bptr == *(bptr+1))){   
	      bptr++; }
/* for the case like - input : "Google", pattern : "*og*e"
the letter 'o' comes twice in a row
skip the letter if the next letter is the same */
	}
      }    
      
      else {
        if (*bptr == *pptr)  // if pattern matched
          pptr++;
	else
	  pptr = (char*)pattern; // if not matched
	
	bptr++;
      }
    }
    
    if (*pptr == '\0') // if pattern matched
      fputs(buf, stdout);
  }
  return TRUE;
}

/*-------------------------------------------------------------------*/
int 
main(const int argc, const char *argv[]) 
{
  /* Do argument check and parsing */
  if (argc < 2) {
	  fprintf(stderr, "Error: argument parsing error\n");
	  PrintUsage(argv[0]);
	  return (EXIT_FAILURE);
  }

  return SearchPattern(argv[1]) ? EXIT_SUCCESS:EXIT_FAILURE;
}
