%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	
	// extern declarations
	extern int yyparse();
	extern	FILE* yyin;
	extern int yylex();
	extern int yylineno;
	
	// function declarations
	int yyerror(const char *s);
	void Insert(char identifier[], char dataType[], char value[]);
	int SearchElement(char identifier[]);
	void Update(char identifier[], char value[]);
	void AssignValue(char identifier[],char numberType[],int intValue,float floatValue);
	void PrintValue(char numberType[],int intValue,float floatValue);
	struct number GetIdValue(char identifier[]);
	
	// symbol table structure declaration
	struct data 
	{
		int key;
		char identifier[100];
		char dataType[100];
		char value[100]; 
	
	};
	struct data array[100];
	
	// global variable declarations
	int size = 0;
	int error=0;

%}

/* number constants structure */ 
%code requires 
{
	struct number
	{
		char *numberType;
		int intValue;
		float floatValue;
	};
}

/* declaration of supported types */
%union 
{
	char idName[100];
	char mainFunc[100];	 
	struct number numberConst;
};

/* tokens */
%token TOK_SEMICOLON TOK_SUB TOK_MUL TOK_NUM TOK_PRINTID TOK_PRINTEXP TOK_INT TOK_FLOAT TOK_IDENTIFIER TOK_EQUAL TOK_ACCESS_SPECIFIER TOK_TYPE_QUALIFIER TOK_FUNC_STRING TOK_OPEN_BRAC TOK_CLOSE_BRAC TOK_CUR_OPEN TOK_CUR_CLOSE 
%token <numberConst> TOK_FLOAT_CONST 
%token <numberConst> TOK_INT_CONST

/* grammar return types */
%type <numberConst> Exp NumberConstant
%type <idName> TOK_IDENTIFIER
%type <mainFunc> FunctionName TOK_FUNC_STRING

/* precedence for operators */
%left TOK_SUB
%left TOK_MUL

%%
FunctionDefinition	: FunctionName TOK_CUR_OPEN VariableDefs Statements TOK_CUR_CLOSE
					
					;

FunctionName		: TOK_FUNC_STRING TOK_OPEN_BRAC TOK_CLOSE_BRAC
					;

VariableDefs		:
					| VariableDef VariableDefs
					;
					
VariableDef			:TOK_INT TOK_IDENTIFIER TOK_SEMICOLON
					{
						int idIndex=SearchElement($2);
						if(idIndex<=-1)
						{
							Insert($2,"int","0");
						}
						else
						{
							yyerror("Identifier already present");
							exit(1);
						}
						
					}
	   				| TOK_FLOAT TOK_IDENTIFIER TOK_SEMICOLON
					{
						int idIndex=SearchElement($2);
						if(idIndex<=-1)
						{
							
							Insert($2,"float","0.0");
						}
						else
						{
							yyerror("Identifier already present");
							exit(1);
						}
					}
					;

Statements			:
					| Statement Statements
					;

Statement			: TOK_IDENTIFIER TOK_EQUAL Exp TOK_SEMICOLON
					{
						AssignValue($1,$3.numberType,$3.intValue,$3.floatValue);
					}
					| TOK_PRINTID Exp TOK_SEMICOLON
					{
						PrintValue($2.numberType,$2.intValue,$2.floatValue);
					}
					| TOK_PRINTEXP Exp TOK_SEMICOLON
					{
						PrintValue($2.numberType,$2.intValue,$2.floatValue);
					}
					;

Exp				:   Exp TOK_MUL Exp
					{
						if(strcmp($1.numberType,$3.numberType)==0)
						{
							struct number calcValue;
							if(strcmp($1.numberType,"int")==0)
							{
								calcValue.numberType="int";
								calcValue.intValue=$1.intValue * $3.intValue;
							}
							else
							{
								calcValue.numberType="float";
								calcValue.floatValue=$1.floatValue * $3.floatValue;
							}
							$$=calcValue;
						}
						else
						{
							yyerror("Type error");
							exit(1);
						}
						
					}
					| Exp TOK_SUB Exp
					{
						if(strcmp($1.numberType,$3.numberType)==0)
						{
							struct number calcValue;
							if(strcmp($1.numberType,"int")==0)
							{
								calcValue.numberType="int";
								calcValue.intValue=$1.intValue - $3.intValue;
							}
							else
							{
								calcValue.numberType="float";
								calcValue.floatValue=$1.floatValue - $3.floatValue;
							}
							$$=calcValue;
						}
						else
						{
							yyerror("Type error");
							exit(1);
						}
					}
					| NumberConstant
					{
							$$=$1;
				    }
					| TOK_IDENTIFIER
					{
						
						$$=GetIdValue($1);
					}
					;

NumberConstant		:TOK_INT_CONST
					{
						$$=$1;
					}
					| TOK_FLOAT_CONST
					{
						$$=$1;
					}
					;


%%

/* main function */
int main()
{
    yyparse();
    return 0;
}

/* function prints parsing error that is reported from the grammar definition */ 
int yyerror(const char *msg)
{
	printf("Parsing Error at line :%d %s\n",yylineno,msg);
	return 0;
}

/* function gives a unique hash code to the given key */
int Hashcode(int key)
{
	return (key % 100);
}

/* function to insert indentifier in the hash table(symbol table) */
void Insert(char identifier[], char dataType[], char value[])
{
    int index = Hashcode(size);
    
	//key not present, insert it
    array[index].key=size;
	strcpy(array[index].identifier,identifier);
	strcpy(array[index].dataType,dataType);
    strcpy(array[index].value, value);
    size++;
}

/* fucntion to update value of identifier in symbol table */
void Update(char identifier[], char value[])
{
	int foundIndex=SearchElement(identifier);
	if(foundIndex>-1)	
		strcpy(array[foundIndex].value,value);
	
}

/* function to search the index of identifier in symbol table */
int SearchElement(char identifier[])
{
	int i;
	int index=-1;
	for (i = 0; i < 100; i++)
    {
    	if (strcmp(array[i].identifier,identifier)==0)
        {
			index=i;
			break;
		}
	}
	return index;
}

/* fucntion to assign value to identifier in symbol table */
void AssignValue(char identifier[],char numberType[],int intValue,float floatValue)
{
	int idFoundIndex=SearchElement(identifier);
	if(idFoundIndex>-1)
	{
		if(strcmp(array[idFoundIndex].dataType,numberType)==0)
		{
			char *valueInString;
			if(strcmp(numberType,"int")==0)
			{
				valueInString=(char *)malloc(50*sizeof(int));
				snprintf(valueInString,50*sizeof(int),"%d",intValue);
			}
			else
			{
				valueInString=(char *)malloc(50*sizeof(float));
				snprintf(valueInString,50*sizeof(float),"%.2f",floatValue);	
			}
			Update(identifier,valueInString);
		}
		else
		{
			yyerror("Type error");
			exit(1);
		}
	}
	else
	{
		yyerror(strcat(identifier," is used but is not declared"));
		exit(1);
	}
}

/* function to print the expression value (int and float) */
void PrintValue(char numberType[],int intValue,float floatValue)
{
	if(strcmp(numberType,"int")==0)
		printf("%d\n",intValue);
	else
		printf("%.2f\n",floatValue);
}

/* function to get the value of identifier from symbol table */
struct number GetIdValue(char identifier[])
{
	int indexFound=SearchElement(identifier);
	struct number numValue;
	if(strcmp(array[indexFound].dataType,"int")==0)
	{
		numValue.intValue=atoi(array[indexFound].value);
		numValue.numberType="int";
	}
	else
	{
		numValue.floatValue=atof(array[indexFound].value);
		numValue.numberType="float";
	}
	return numValue;
}