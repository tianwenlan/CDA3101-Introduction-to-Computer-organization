# First SPIM Assignment
	# Program 2
	# Name:Wenlan Tian 
	# Class: CDA3101 11DG
	# Date:02/10/2015 


# Start with data declarations
	.data 
str1: .asciiz "Enter first integer n1: "
str2: .asciiz "Enter second integer n2: "
str3: .asciiz "The greatest common divisor of n1 and n2 is "
str4: .asciiz "The least common multiple of n1 and n2 is "
newline: .asciiz "\n"  #This will cause the screen cursor to move to a newline

.text # Put program here

.globl main  # globally define 'main'

main:
	#int n1, n2
	#s0->n1, s1->n2
	
	addi $s0, $zero, 0	# n1=0
	addi $s1, $zero, 0	# n2=0

	#printf("Enter first integer n1: ");
	la $a0, str1	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console

	#scanf("%d",n1);
	li $v0, 5       # an I/O sequence to read an integer from the console window
	syscall 
	move $s0, $v0	# place the value read into register $s0 (n1)

	#printf("Enter second integer n2: ");
	la $a0, str2	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console

	#scanf("%d",n2);
	li $v0, 5       # an I/O sequence to read an integer from the console window
	syscall 
	move $s1, $v0	# place the value read into register $s1 (n2)

	#printf("The greatest common divisor of n1 and n2 is ");
	la $a0, str3	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console

	# gcd(n1, n2)
	addi $a0,$s0,0	# a0->s0->n1
	addi $a1,$s1,0	# a1->s1->n2

	addi $sp, $sp, -12	# reserve stack for 3 items
	sw $ra, 0($sp)	# save ra
	sw $a0, 4($sp)	# save arg number 1
	sw $a1, 8($sp)	# save arg number 2
	jal gcd
	lw $a1, 8($sp)	# restore arg number2
	lw $a0, 4($sp)	# restore arg number1
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 12	# restore sp
    move $a0, $v0

	# print the result to console
	li $v0, 1
	syscall  		# execute the syscall to perform input/output via the console
	#jr $ra	# return

	# print new line
	la $a0, newline	# print the new line character to force a carriage return on the console
	li $v0, 4			
	syscall 

	#printf("The least common multiple of n1 and n2 is %d\n");
	la $a0, str4	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console

	# call lcm(n1, n2)
	addi $a0,$s0,0	# a0->s0->n1
	addi $a1,$s1,0	# a1->s1->n2
	addi $sp, $sp, -12	# reserve stack for 3 items
	sw $ra, 0($sp)	# save ra
	sw $a0, 4($sp)	# save arg number 1
	sw $a1, 8($sp)	# save arg number 2
	jal lcm
	lw $a1, 8($sp)	# restore arg number2
	lw $a0, 4($sp)	# restore arg number1
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 12	# restore sp
	move $a0, $v0

	# jr $ra	# return

	li $v0, 1		      
	syscall  		# execute the syscall to perform input/output via the console

	la $a0, newline	# print the new line character to force a carriage return on the console
	li $v0, 4			
	syscall 

	li $v0, 10		# syscall code 10 for terminating the program
	syscall

# End of main routine
	
# Calculates the greatest common divisor
gcd:
	div $a0, $a1	# number1 % number2, restore the remainder in high
	mfhi $s2	# remove from high to to(remainder)

	# if (remainder == 0) 
	bne $s2, $zero, ELSE	# branch if remainer !=0

	add $v0, $a1, $zero	# put number2 (a1) to v0
	jr $ra	# return

	ELSE:
	add $a0, $a1, $zero	# number1 = number 2
	add $a1, $s2, $zero
	addi $sp, $sp, -12	# reserve stack for 3 items
	sw $ra, 8($sp)	# save ra
	sw $a0, 4($sp)	# save arg number 1
	sw $a1, 0($sp)	# save arg number 2
	jal gcd	# recursive call
	lw $ra, 8($sp)	# restore return address
	lw $a0, 4($sp)	# restore arg number1
	lw $a1, 0($sp)	# restore arg number2
	addi $sp, $sp, 12	# pop 3 items from stack
	jr $ra	# return

# Calculates the least common multiple
lcm:
	addi $sp, $sp, -12	# reserve stack for 3 items
	sw $ra, 8($sp)	# save ra
	sw $a0, 4($sp)	# save arg number 1
	sw $a1, 0($sp)	# save arg number 2
	jal gcd	# invoke gcd 
	add $t0, $v0, $zero	# t0 = gcd(number1, number2)
	lw $ra, 8($sp)	# restore return address
	lw $a0, 4($sp)	# restore arg number1
	lw $a1, 0($sp)	# restore arg number2
	addi $sp, $sp, 12	# restore sp
	mult $a0, $a1	# number1 * nubmer2
	mflo $t1	# t1 = number1 * nubmer2
	div $t1, $t0	# number1*number2/gcd(number1, number2), return the value in low
	mflo $v0 # move from low of the return value to v0
	jr $ra # return


