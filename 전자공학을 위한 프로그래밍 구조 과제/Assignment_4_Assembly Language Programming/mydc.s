### --------------------------------------------------------------------
### mydc.s - 20180490 Jaehun Lee Assignment4
###
### Desk Calculator (dc)
### --------------------------------------------------------------------

	.equ   ARRAYSIZE, 20
	.equ   EOF, -1
	
.section ".rodata"

scanfFormat:
	.asciz "%s"

ErrorPrompt:
	.asciz "dc: stack empty\n"

Print_Top:
	.asciz "%d\n"
### --------------------------------------------------------------------

        .section ".data"

### --------------------------------------------------------------------

        .section ".bss"
buffer:
        .skip  ARRAYSIZE

### --------------------------------------------------------------------

	.section ".text"

	## -------------------------------------------------------------
	## int main(void)
	## Runs desk calculator program.  Returns 0.
	## -------------------------------------------------------------

	.globl  main
	.type   main,@function

main:

	pushl   %ebp
	movl    %esp, %ebp
	jmp input

input:
	## input is like the main function
	## check the input and do what needs to be done for the input

	## dc number stack initialized. %esp = %ebp
	
	## scanf("%s", buffer)
	pushl	$buffer
	pushl	$scanfFormat
	call    scanf
	addl    $8, %esp

	## check if user input EOF
	cmpl	$EOF, %eax
	je	quit
	
	## check if buffer[0] is digit
	movl $0, %eax
	movb buffer, %al
	pushl %eax
	call isdigit
	addl $4, %esp
	cmpl $0, %eax
	jg is_pos_num	## if buffer[0] >= 0
	movl $0, %eax

	## check if buffer[0] is '_'
	movb buffer, %al
	cmpb $'_', %al
	je is_neg_num	## if buffer[0] < 0

	movl $0, %eax
	movb buffer, %al
	
	## if 'p'
	cmpb $'p', %al
	je is_p

	## if 'q'
	cmpb $'q', %al
	je quit

	## if '+'
	cmpb $'+', %al
	je is_plus

	## if '-'
	cmpb $'-', %al
	je is_minus

	## if '*'
	cmpb $'*', %al
	je is_multi

	## if '/'
	cmpb $'/', %al
	je is_div

	## if '|'
	cmpb $'|', %al
	je is_abssum

	## if 'f' cdr
	cmpb $'f', %al
	je is_f

	## if 'c'
	cmpb $'c', %al
	je is_c

	## if 'd'
	cmpb $'d', %al
	je is_d

	## if 'r'
	cmpb $'r', %al
	je is_r

	jmp input

##-----------------------------------------------

is_pos_num:
	pushl $buffer
	call atoi
	addl $4, %esp
	pushl %eax	## push input to stack
	jmp input	## back to input
	
is_neg_num:
	movb $'-', buffer
	pushl $buffer
	call atoi
	addl $4, %esp
	pushl %eax	## push intput to stack
	jmp input	## back to input

##-----------------------------------------------

is_p:
	## if stack is empty
	cmpl %ebp, %esp
	je stack_empty
	
	pushl $Print_Top
	call printf
	addl $4, %esp 

	jmp input

##-----------------------------------------------

is_plus:
	cmpl %ebp, %esp
	je stack_empty
	popl %eax	## eax = 1st top
	cmpl %ebp, %esp
	je stack_empty_with_restore
	popl %ebx	## ebx = 2nd top
	
	addl %ebx, %eax
	pushl %eax
	movl $0, %ebx
	jmp input

##-----------------------------------------------

is_minus:
	cmpl %ebp, %esp
	je stack_empty
	popl %eax	## eax = 1st top
	cmpl %ebp, %esp
	je stack_empty_with_restore
	popl %ebx	## ebx = 2nd top
	
	subl %eax, %ebx	## we need ebx - eax
	pushl %ebx
	movl $0, %ebx
	jmp input

##----------------------------------------------
	
is_multi:
	cmpl %ebp, %esp
	je stack_empty
	popl %eax	## eax = 1st top
	cmpl %ebp, %esp
	je stack_empty_with_restore
	popl %ebx	## ebx = 2nd top
	
	imull %ebx
	pushl %eax
	movl $0, %ebx
	jmp input

##----------------------------------------------
	
is_div:
	cmpl %ebp, %esp
	je stack_empty
	popl %eax	## eax = 1st top
	cmpl %ebp, %esp
	je stack_empty_with_restore
	popl %ebx	## ebx = 2nd top
	
	cmpl $0, %eax
	## error handling. set %edx according to %eax
	jl neg_div
	jmp pos_div
	
neg_div:	
	movl $-1, %edx
	idivl %ebx
	pushl %eax
	movl $0, %ebx
	jmp input

pos_div:
	movl $0, %edx
	idivl %ebx
	pushl %eax
	movl $0, %ebx
	jmp input
	
##---------------------------------------------	

is_abssum:
	cmpl %ebp, %esp
	je stack_empty
	popl %eax	## eax = 1st top
	cmpl %ebp, %esp
	je stack_empty_with_restore
	popl %ebx	## ebx = 2nd top

	movl $0, %edx	## int sum ;
	cmpl %ebx, %eax
	je abssum_equal
	jg abssum_swap
	jmp abssum_loop

abssum_equal:
	movl %eax, %edx
	movl %eax, %ecx
	jmp abssum_end

abssum_swap:
	## set eax < ebx
	movl %ebx, %ecx
	movl %eax, %ebx
	movl %ecx, %eax
	jmp abssum_loop

abssum_loop:
	## summing up
	cmpl %eax, %ebx
	jl abssum_end
	cmpl $0, %eax
	jl add_neg	## adding abs value of negative int
	jge add_pos

	
abssum_end:
	pushl %edx
	jmp input

add_neg:
	subl %eax, %edx
	incl %eax
	jmp abssum_loop

add_pos:	
	addl %eax, %edx
	incl %eax
	jmp abssum_loop

##---------------------------------------------

is_f:
	cmpl %ebp, %esp
	je stack_empty
	movl %esp, %ecx
	jmp do_f
	
do_f:
	cmpl %ebp, %ecx
	je input
	movl %ecx, %ebx
	movl (%ecx), %edx
	pushl %edx
	pushl $Print_Top
	call printf
	addl $8, %esp
	movl %ebx, %ecx
	addl $4, %ecx	## to check next element in stack
	jmp do_f

##--------------------------------------------

is_c:
	cmpl %ebp, %esp
	je input
	popl %eax
	jmp is_c
	
##-------------------------------------------
	
is_d:
	cmpl %ebp, %esp
	je stack_empty
	popl %eax
	pushl %eax
	pushl %eax
	jmp input

##-------------------------------------------	

is_r:
	cmpl %ebp, %esp
	je stack_empty
	popl %eax	## eax = 1st top
	cmpl %ebp, %esp
	je stack_empty_with_restore
	popl %ebx	## ebx = 2nd top
	pushl %eax
	pushl %ebx
	jmp input

##------------------------------------------

stack_empty:
	## print "dc: stack empty"
	pushl $ErrorPrompt
	call printf
	addl $4, %esp
	jmp input

stack_empty_with_restore:
	## push the poped value again and print err msg
	pushl %eax
	pushl $ErrorPrompt
	call printf
	addl $4, %esp
	jmp input

	
	## PSEUDO-CODE
	## /*
	##  * In this pseudo-code we assume that you do not use no local variables
	##  * in the _main_ process stack. In case you want to allocate space for local
	##  * variables, please remember to update logic for 'empty dc stack' condition
	##  * (stack.peek() == NULL). 
	##  */
	##
        ##  while (1) {
        ##     /* read the current line into buffer */
        ##     if (scanf("%s", buffer) == EOF)
        ##         return 0;
        ## 
        ##     /* is this line a number? */
        ##     if (isdigit(buffer[0]) || buffer[0] == '_') {
        ##        int num;
        ##        if (buffer[0] == '_') buffer[0] = '-';
        ##        num = atoi(buffer);
        ##        stack.push(num);	/* pushl num */
        ##        continue;
        ##     }
        ## 
        ##     /* p command */
        ##     if (buffer[0] == 'p') {
        ##        if (stack.peek() == NULL) { /* is %esp == %ebp? */
        ##           printf("dc: stack empty\n");
        ##        } else {
        ##           /* value is already pushed in the stack */
        ##           printf("%d\n", (int)stack.top()); 
        ##        }
        ##        continue;
        ##     }
        ## 
        ##     /* q command */
        ##     if (buffer[0] == 'q') {
        ##        goto quit;
        ##     }
        ##  
        ##     /* + operation */
        ##     if (buffer[0] == '+') {
        ##        int a, b;
        ##        if (stack.peek() == NULL) {
        ##           printf("dc: stack empty\n");
        ##           continue;
        ##         }
        ##         a = (int)stack.pop();
        ##         if (stack.peek() == NULL) {
        ##            printf("dc: stack empty\n");
        ##            stack.push(a); /* pushl some register value */
        ##            continue;
        ##         }
        ##         b = (int)stack.pop(); /* popl to some register */
        ##         res = a + b;
        ##         stack.push(res);
        ##         continue;
        ##     }
        ## 
        ##     /* - operation */
        ##     if (buffer[0] == '-') {
        ##        /* ... */
        ##     }
        ## 
        ##     /* | operation */
        ##     if (buffer[0] == '|') {
        ##        /* pop two values & call abssum() */
        ##     }
        ## 
        ##     /* other operations and commands */
        ##     if (/* others */) {
        ##        /* ... and so on ... */
        ##     }
        ##  
        ##   } /* end of while */
        ## 

quit:	
	## return 0
	movl    $0, %eax
	movl    %ebp, %esp
	popl    %ebp
	ret
