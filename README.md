# CDA3101-Introduction-to-Computer-organization

Description
----------------------
Organization of computing systems. Logical basis of computer structure. Machine representation of instructions and data, flow of control, and basic machine instructions. Assembly language programming.

Programming Assignment
----------------------
Transform the following code into MIPS instructions. The programs should run correctly on the QtSPIM simulator. 

1. Palindrome. 
  - A typical palindrome is a word, phrase, number, or other sequence of characters which reads the same backward or forward. Famous examples include "A man, a plan, a canal, Panama!", "Amor, Roma", "race car", "taco cat”. Following code snippet is a palindrome checker for only positive integer numbers. Examples of palindrome numbers are “123454321”, “464”, “66”.

  - Code Snippet: 
  
    int num, reverse = 0, temp;

    printf("Programming assignment 1 for CDA3101\n");
    
    printf("This palindrome checker only deals with positive integer number.\n");
    
    printf("Enter a number to check if it is a palindrome or not.\n");
    
    scanf("%d",&num);
 
    temp = num;
 
    while( temp != 0 ){
    
	    reverse = reverse * 10;
	    
	    reverse = reverse + temp%10;
	    
	    temp = temp/10;
	    
    }
 
    if ( num == reverse )
    
	    printf("%d is a palindrome number.\n", num);
    else
	    printf("%d is not a palindrome number.\n", num);

2. Greatest Common Divisor(GCD), and Least Common Multiple (LCM)
  - Assume the product of two input values is a 32‐bit integer. However, 10% extra credit will be given if the program can handle any 32‐bit input value of ‘n1’ and ‘n2’ that may produce an LCM bigger than a 32‐bit integer. Also, assume two inputs are positive integers except 0.
  
  - Code Snippet:
 
  // Calculates the greatest common divisor

  int gcd(int number1, int number2) {
  
	    int remainder = number1 % number2;
    
	    if (remainder == 0) {
    
	    	    return number2;
      
	    } else {
    
	    	    return gcd(number2, remainder);
      
	    }
   }

  // Calculates the least common multiple
  
	    int lcm(int number1, int number2) {
  
	    	    return number1*number2/gcd(number1, number2);
    
	    }
  
	    int main(){
  
	    	    int n1, n2;
    
	    	    printf("Enter first integer n1: ");
    
	    	    scanf("%d", &n1);
    
	    	    printf("Enter second integer n2: ");
    
	    	    scanf("%d", &n2);
    
	    	    printf("The greatest common divisor of n1 and n2 is %d\n", gcd(n1, n2));
    
	    	    printf("The least common multiple of n1 and n2 is %d\n", lcm(n1, n2));
    
	    	    return 0;
    
	    }
