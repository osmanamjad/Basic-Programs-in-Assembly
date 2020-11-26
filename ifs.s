.data 

promptA: .asciiz "Enter an int A: "
promptOdd: .asciiz "THIS IS ODD"
promptEven: .asciiz "THIS IS EVEN"
newline: .asciiz "\n"

.globl main
.text

main: 
	li $v0, 4 # load service number 4 (print string) in register v0 		      
	la $a0, promptA # set a0 to promptA's address
	syscall # execute the system call specified by the value in v0 (printing promptA)

	li $v0, 5 # load service number 5 (read integer) in register v0
	syscall # execute the system call specified by value in v0 (reading an integer)
	move $t0, $v0 # set t0 to contents of v0
	
	li $v0, 4
	la $a0, newline
	syscall 
	
IF: 
	andi $t1, $t0, 1 #BITWISE AND (&), a number & 1 will return 1 if the number is odd, zero if even
	beqz $t1, ELSE
THEN:
	li $v0, 4 # load service number 4 (print string) in register v0 		      
	la $a0, promptOdd # set a0 to promptOdd's address
	syscall # execute the system call specified by the value in v0 (printing promptOdd)
	j DONE
ELSE:
	li $v0, 4 # load service number 4 (print string) in register v0 		      
	la $a0, promptEven # set a0 to promptEven's address
	syscall # execute the system call specified by the value in v0 (printing promptEven) 

DONE:
	li $v0, 4
	la $a0, newline
	syscall 

	li $v0, 10
	syscall
