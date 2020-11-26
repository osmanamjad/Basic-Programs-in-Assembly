.data 
# TODO: What are the following 5 lines doing?
promptA: .asciiz "Enter an int A: "
promptB: .asciiz "Enter an int B: "
resultAdd: .asciiz "A + 42 = "
resultSub: .asciiz "B - A = "
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
	la $a0, promptB # set a0 to promptB's address which is 0x10010011 which is 147
	syscall # execute the system call specified by the value in v0 (printing promptB)

    # TODO: Explain what happens if a non-integer is entered
    # by the user.
	li $v0, 5 
	syscall # "Runtime exception at 0x00400014: invalid integer input (syscall 5" if non integer entered
    # TODO: t stands for "temp" -- why is the value from $v0 
    # being moved to $t1?
	move $t1, $v0 # it is being moved because we will change v0 to another service number, and we wanna have its value saved before we change it

	# TODO: What if I want to get A + 42 and B - A instead
	# t0 refers to the value of A, t1 refers to the value of B.
	add $t2, $t0, 42
	sub $t3, $t1, $t0 

	li $v0, 4
	la $a0, resultAdd
	syscall # print the string specified by the address in a0

    # TODO: What is the difference between "li" and "move"?
	li $v0, 1 # sets v0 to 1
	move $a0, $t2 #	sets a0 to contents of t2
	syscall 

    # TODO: Why is the next block of three lines needed? 
    # Remove them and explain what happens.
	li $v0, 4
	la $a0, newline
	syscall # these lines aren't technically needed because they just print a newline. Looks better, but we can do without one

	li $v0, 4
	la $a0, resultSub # set a0 to resultSub address
	syscall

	move $a0, $t3 # set a0 to contents of t3
	li $v0, 1
	syscall 

	li $v0, 4
	la $a0, newline
	syscall 

	li $v0, 10
	syscall
