# func1.s
.data
before: .asciiz "Before function\n"
promptNumber: .asciiz "Enter a number: "
result: .asciiz "The result is: "
newline: .asciiz "\n"

.text
main:
	li $v0, 4		  # system call code for print_string
	la $a0, promptNumber	  # address of string to print
	syscall			  # print the string

	li $v0, 5		# system call code for read_int
	syscall 		# Read the int
	
	move $t0, $v0		# Load number into $t0
	
	li $v0, 4
	la $a0, result
	syscall
	
	addi $sp, $sp, -4 # move the stack pointer to increase stack size
	sw $t0, 0($sp) # put the value of $t0 on the allocated space
	
	jal mystery	
	# what exactly does jal do? Lookup the reference sheet
	# sets $ra (return address) to program counter and then jump to the label. Saving the return address means
	# saving the address of the next instruction. Now inside the function call, we can do jr $ra to jump to the 
	# instruction inside $ra. ra = PC + 8
	
	lw $t1, 0($sp) # load the word at the top of the stack
	addi $sp, $sp, 4 # decrease the size of the stack

	li $v0, 1 # code for print int
	la $a0, ($t1) # set a0 to t1 which is the value to print
	syscall

	li $v0, 4 	# system call code for print_string
	la $a0, newline # address of string to print
	syscall 	# print the string	
									
	# End of main, make a syscall to "exit"
	li $v0, 10 	# system call code for exit
	syscall 	# terminate program	
	
mystery:
	lw $t2, 0($sp) # load the word at the top of the stack
	addi $sp, $sp, 4 # decrease the size of the stack
	
	addi $sp, $sp, -8 # increase size of stack for 2 words
        sw   $t2, 0($sp)  # save n to top of stack
        sw   $ra, 4($sp) # Save return address on stack (position before n so n is still top of stack)
        
        bne  $t2, $zero, RECURSION # if t2 = n != 0 then recurse
        addi $sp, $sp, 8  # if n == 0 then we dont need the return address or value of n in stack, so we can decrease size
        
        addi $sp, $sp, -4 # move the stack pointer to increase stack size
	sw $zero, 0($sp) # put the value of $zero on the allocated space (this is return value for base case)
	
	jr $ra
	
RECURSION:
	addi $t3, $t2, -1 # set the value of t3 to be n-1
	addi $sp, $sp, -4 # move the stack pointer to increase stack size
	sw $t3, 0($sp) # put the value of $t3 on the allocated space
	
	jal mystery # call mystery with new value of n-1
	
	lw $t4, 0($sp) # load the word at the top of the stack (return value)
	lw $t5, 4($sp) # restore the value n from the stack
	lw $ra, 8($sp) # restore the return address from the stack
	addi $sp, $sp, 12 # decrease size of stack after reading necessary values   
	li $t6, 2
	#mult $t5, $t6
	#mflo $t5
	add $t5, $t5, $t5 # instead of multiplying by 2, just add itself to itself
	add $t5, $t5, $t4 # arithmetic overflow if n>46340 
	# register holds 32 bits. max 32 bit val: 2147483647. 46341^2=2147488281 and 46340^2=2147395600. hence 46340 max val
	addi $t5, $t5, -1
	
	addi $sp, $sp, -4 # increase size of stack to add return value $t5
	sw $t5, 0($sp) # put the value of $t0 on the allocated space
	
	jr $ra
	
	
	
