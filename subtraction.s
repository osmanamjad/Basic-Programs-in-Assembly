.data 
# TODO: What are the following 5 lines doing?
promptA: .asciiz "Enter an int A: "
promptB: .asciiz "Enter an int B: "
promptC: .asciiz "Enter an int C: "
resultAdd: .asciiz "A + B + C = "
newline: .asciiz "\n"

.globl main
.text

main: 
    # TODO: Set a breakpoint here and step through. 
    # What does this block of 3 lines do?
	li $v0, 4 # load service number 4 (print string) in register v0 		      
	la $a0, promptA # set a0 to promptA's address
	syscall # execute the system call specified by the value in v0 (printing promptA)

    # TODO: Set a breakpoint here and step through. 
    # What does this block of 3 lines do?
	li $v0, 5 # load service number 5 (read integer) in register v0
	syscall # execute the system call specified by value in v0 (reading an integer)
	move $t0, $v0 # set t0 to contents of v0

    # TODO: What is the value of "promptB"? Hint: Check the
    # value of $a0 and see what it corresponds to.
	li $v0, 4 # load service number 4 (print string) in register v0 	
	la $a0, promptB 
	syscall # execute the system call specified by the value in v0 (printing promptB)

    # TODO: Explain what happens if a non-integer is entered
    # by the user.
	li $v0, 5 
	syscall # "Runtime exception at 0x00400014: invalid integer input (syscall 5" if non integer entered
    # TODO: t stands for "temp" -- why is the value from $v0 
    # being moved to $t1?
	move $t1, $v0 # it is being moved because we will change v0 to another service number, and we wanna have its value saved before we change it

	li $v0, 4 # load service number 4 (print string) in register v0 		      
	la $a0, promptC # set a0 to promptC's address
	syscall # execute the system call specified by the value in v0 (printing promptC)

	li $v0, 5 # load service number 5 (read integer) in register v0
	syscall # execute the system call specified by value in v0 (reading an integer)
	move $t2, $v0 # set t2 to contents of v0

	# t0 refers to the value of A, t1 refers to the value of B, t2 refers to the value of C.
	add $t3, $t0, $t1
	add $t4, $t2, $t3,

	li $v0, 4
	la $a0, resultAdd
	syscall # print the string specified by the address in a0

    # TODO: What is the difference between "li" and "move"?
	li $v0, 1 # sets v0 to 1
	move $a0, $t4 #	sets a0 to contents of t4
	syscall 

	li $v0, 4
	la $a0, newline
	syscall 

	li $v0, 10
	syscall