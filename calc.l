%{
	#include <stdio.h>
	#include <string.h>
	#include <math.h>
	#include "calc.tab.h"
%}

%%
"main"				{	sscanf(yytext, "%s", &yylval.mainFunc);
						return(TOK_FUNC_STRING);
					}

"printID"       	{   return(TOK_PRINTID);}
"printExp"       	{   return(TOK_PRINTEXP);}


"int"				{	return(TOK_INT);}
"float"				{	return(TOK_FLOAT);}

";"					{	return(TOK_SEMICOLON);	}

"-"					{	return(TOK_SUB);	}
"*"					{	return(TOK_MUL);	}
"="					{	return(TOK_EQUAL);	}
"("					{	return(TOK_OPEN_BRAC);	}
")"					{	return(TOK_CLOSE_BRAC);	}
"{"					{	return(TOK_CUR_OPEN);	}
"}"					{	return(TOK_CUR_CLOSE);	}


[a-z][0-9a-zA-Z]*	{	
						sscanf(yytext, "%s", &yylval.idName);
						return(TOK_IDENTIFIER);
					}

[0-9]+				{
						sscanf(yytext, "%d", &yylval.numberConst.intValue);
						yylval.numberConst.numberType="int";
						return TOK_INT_CONST;
					}

([0-9]*[.])?[0-9]+	{
						sscanf(yytext, "%f", &yylval.numberConst.floatValue);
						yylval.numberConst.numberType="float";
						return TOK_FLOAT_CONST;
					}

[0-9]+[E][0-9]+		{
						sscanf(yytext, "%f", &yylval.numberConst.floatValue);
						yylval.numberConst.numberType="float";
						return TOK_FLOAT_CONST;
					}

([0-9]*[.])?[0-9]+[E][0-9]+	{
								sscanf(yytext, "%f", &yylval.numberConst.floatValue);
								yylval.numberConst.numberType="float";
								return TOK_FLOAT_CONST;
							}

[\n] 				{yylineno++;}


%%

