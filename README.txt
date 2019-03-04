
1. CONTENTS OF THE PACKAGE
-------------------------------------------------
calc.l		- Flex code for performing lexical analysis and tokenizing input
calc.y		- Bison code for parsing the input
makefile		- Commands to compile and run the program
README		- Details about the package
-------------------------------------------------

2. SYSTEM REQUIREMENTS
-------------------------------------------------
Following softwares should be installed on system:
flex - lexical analyzer generator
bison - parser generator
gcc - C compiler
-------------------------------------------------

3. COMPILATION AND EXECUTION
-------------------------------------------------
flex calc.l
bison -dv calc.y
gcc -o calc lex.yy.c calc.tab.c -lfl

./calc < input	// input is the name of the input file
-------------------------------------------------

4. DESCRIPTION
-------------------------------------------------
* Lexical analysis is the first phase of a compiler. This phase breaks input into a series of chunks called tokens, by removing any 
whitespace or comments in the input.
* FLEX (Fast Lexical analyzer generator) is a software used for generating tokens. When the analyzer executes, it analyzes input, 
looking for strings that match any of its patterns. 
* Syntax analysis also called as parsing is the second phase of a compiler. This phase uses context-free grammar (CFG) to match 
elements in the input data based to the rules specified in grammar.
* Bison (Bottom up Parser generator) is a software used to read specifications of a context-free grammar, read sequences of tokens 
and decide whether the sequence conforms to the syntax specified by the grammar.
* This assignment generates a parser for a basic C program that performs calculation operations for integer or float values.
* The generated parser supports grammars for simple main function, subtraction and multiplication operation for integer and float values.
-------------------------------------------------

5. SAMPLE OUTPUT
-------------------------------------------------
Input :
main() { int x; x=20; printID x; }

Output : 
20
-------------------------------------------------