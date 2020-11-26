.data 

promptN: .asciiz "Enter a positive int N: "
promptInt: .asciiz "Enter a positive int: "
promptProduct: .asciiz "The product is: "
newline: .asciiz "\n"

.globl main
.text

main: 
	li $v0, 4 # load service number 4 (print string) in register v0 		      
	la $a0, promptN # set a0 to promptN's address
	syscall # execute the system call specified by the value in v0 (printing promptN)
	
	li $v0, 5 # load service number 5 (read integer) in register v0
	syscall # execute the system call specified by value in v0 (reading an integer)
	move $t0, $v0 # set t0 to contents of v0
	
	li $v0, 4
	la $a0, newline
	syscall
	
WHILE0:
	bgtz $t0, INIT
	
	li $v0, 4 # load service number 4 (print string) in register v0 		      
	la $a0, promptN # set a0 to promptN's address
	syscall # execute the system call specified by the value in v0 (printing promptA)

	li $v0, 5 # load service number 5 (read integer) in register v0
	syscall # execute the system call specified by value in v0 (reading an integer)
	move $t0, $v0 # set t0 to contents of v0
	
	li $v0, 4
	la $a0, newline
	syscall
	
	j WHILE0

INIT:	
	li $t2, 1
	# t0 is number of times to ask for integer, $t2 will be product
WHILE:
	beqz $t0, DONE
	
	li $v0, 4 # load service number 4 (print string) in register v0 		      
	la $a0, promptInt # set a0 to promptInt's address
	syscall # execute the system call specified by the value in v0 (printing promptInt)

	li $v0, 5 # load service number 5 (read integer) in register v0
	syscall # execute the system call specified by value in v0 (reading an integer)
	move $t1, $v0 # set t1 to contents of v0
	
	li $v0, 4
	la $a0, newline
	syscall
	
	mult $t2, $t1
	mfhi $t3
	mflo $t4
	add $t2, $t3, $t4
	
	subi $t0, $t0, 1

	j WHILE

DONE:
	li $v0, 4 # load service number 4 (print string) in register v0 		      
	la $a0, promptProduct # set a0 to promptEven's address
	syscall # execute the system call specified by the value in v0 (printing promptProduct)  

	li $v0, 1 #load service number 1 (print integer) in register v0
	la $a0, ($t2) #set $a0 to contents of t2
	syscall # execute system call (print integer)

	li $v0, 10
	syscall
