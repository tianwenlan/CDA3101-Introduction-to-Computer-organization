# First SPIM Assignment
	# Program 1
	# Name:Wenlan Tian 
	# Class: CDA3101 11DG
	# Date:01/30/2015 


# Start with data declarations
	.data 
str1: .asciiz "Programming assignment 1 for CDA3101"
str2: .asciiz "This palindrome checker only deals with positive integer number."
str3: .asciiz "Enter a number to check if it is a palindrome or not."
str4: .asciiz " is a palindrome number."
str5: .asciiz " is not a palindrome number."
newline: .asciiz "\n"  #This will cause the screen cursor to move to a newline

.text # Put program here

.globl main  # globally define 'main'

main:

	#int num, reverse = 0, temp
	#s0->num, s1->reserse, s2->temp
	
	addi $s0, $zero, 0	# num=0
	addi $s1, $zero, 0	# reverse=0

	#printf("Programming assignment 1 for CDA3101\n");
	la $a0, str1	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console

	la $a0, newline	# print the new line character to force a carriage return on the console
	li $v0, 4			
	syscall 

	#printf("This palindrome checker only deals with positive integer number.\n");
	la $a0, str2	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console

	la $a0, newline	# print the new line character to force a carriage return on the console
	li $v0, 4			
	syscall 

	#printf("Enter a number to check if it is a palindrome or not.\n");
	la $a0, str3	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console

	la $a0, newline	# print the new line character to force a carriage return on the console
	li $v0, 4			
	syscall 

	#scanf("%d",&num);
	li $v0, 5       # an I/O sequence to read an integer from the console window
	syscall 
	move $s0, $v0	# place the value read into register $s0 (num)

	#temp = num;
	addi $s2, $s0, 0	#temp = num

	#while( temp != 0 ){
		#reverse = reverse * 10;
		#reverse = reverse + temp%10;
		#temp = temp/10;
	#}

	Loop:
	addi $t1, $zero, 10 	#t1-> 10
	beqz $s2, BOTTOM  # break if temp==0
	mult $s1, $t1 # reverse * 10 and stored in low
	mflo $s1 # move from low to t1 which is reverse * 10
	div $s2, $t1	# temp%10
	mfhi $t2 # move from high to t2 which is temp%10
	add $s1, $s1, $t2 # reverse = reverse + temp % 10
	div $s2, $t1 # temp = temp/10
	mflo $s2 # move from low back to s2

	j Loop
	BOTTOM:

	#if (num == reverse)
		#printf("%d is a palindrome number.\n", num);
	#else
		#printf("%d is not a palindrome number.\n", num);
	
	bne $s0,$s1,ELSE	#branch if !(num == reverse)

	#printf("%d is a palindrome number.\n", num);
	move $a0, $s0	# move integer address into $a0 and I/O code into $v0     
	li $v0, 1		      
	syscall  		# execute the syscall to perform input/output via the console

	la $a0, str4	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console

	la $a0, newline	# print the new line character to force a carriage return on the console
	li $v0, 4			
	syscall

	j Endif # go to Endif

	ELSE:
	#printf("%d is not a palindrome number.\n", num);
	move $a0, $s0	# move integer address into $a0 and I/O code into $v0     
	li $v0, 1		      
	syscall  		# execute the syscall to perform input/output via the console

	la $a0, str5	# load string address into $a0 and I/O code into $v0     
	li $v0, 4		      
	syscall  		# execute the syscall to perform input/output via the console

	la $a0, newline	# print the new line character to force a carriage return on the console
	li $v0, 4			
	syscall 

	Endif:

	li $v0, 10		# syscall code 10 for terminating the program
	syscall

