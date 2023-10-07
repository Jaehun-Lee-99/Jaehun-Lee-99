// 20180490 Jaehun Lee - assignment_1 - file :  decomment.c

#include <stdio.h>
#include <stdlib.h>

int main(void){      // this main function elminates comments contained in a given file
  int c;
  int insq = 0; // =1 when in single quote
  int indq = 0; // =1 when in double quote
  int incomment = 0; // =1 when in comment
  int was_slash = 0;
  int was_star = 0;
  int lines = 1;
  int error_line = 1;
 
  while((c=getchar()) != EOF){

   if (c=='\n')
     lines += 1;
    
   if ((incomment==0)&&((insq|indq)==0)){ // neither in comment nor in string constant

     if ((was_slash)&&(c!='*'))
       printf("/");
      
      switch(c){
	
      case '\'':
	printf("%c", c);
	insq = 1;
	was_slash = 0;
	break;
	
      case '\"':
	printf("%c", c);
	indq = 1;
	was_slash = 0;
	break;
	
      case '/':
	was_slash = 1;
	break;
	
      case '*':
	if (was_slash){   // comment begins
	  incomment = 1;
	  printf(" ");
	  was_slash = 0;
	  error_line = lines;
	  }
	else {
	  printf("%c", c);
	  was_slash = 0;
	}
	break;
	
      default :
	printf("%c", c);
	was_slash = 0;
      }
   }

   else if ((incomment==0)&&(insq==1)){ //not in comment but in single quote

     if (c=='\''){
       insq = 0;
     }
     printf("%c", c);
   }

   else if ((incomment==0)&&(indq==1)){ //not in comment but in double quote
     if (c=='\"'){
       indq = 0;
       }
       
     printf("%c", c);
   }

   else if (incomment) {  // in comment
       if (c=='\n')
	 printf("%c", c);

       switch(c){

       case '*':
	 was_star = 1;
	 break;

       case '/':
	 if (was_star){  // comment ends
	   incomment = 0;
	   was_star = 0;
	   }
	 break;
	
       default :
	 was_star = 0;
       }
     }

  }

  if (incomment==1){
    fprintf(stderr, "Error: line %d: unterminated comment\n", error_line);
    return EXIT_FAILURE;
  }
  else
    return EXIT_SUCCESS;
  
}
