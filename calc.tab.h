/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_CALC_TAB_H_INCLUDED
# define YY_YY_CALC_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 40 "calc.y" /* yacc.c:1909  */

	struct number
	{
		char *numberType;
		int intValue;
		float floatValue;
	};

#line 53 "calc.tab.h" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TOK_SEMICOLON = 258,
    TOK_SUB = 259,
    TOK_MUL = 260,
    TOK_NUM = 261,
    TOK_PRINTID = 262,
    TOK_PRINTEXP = 263,
    TOK_INT = 264,
    TOK_FLOAT = 265,
    TOK_IDENTIFIER = 266,
    TOK_EQUAL = 267,
    TOK_ACCESS_SPECIFIER = 268,
    TOK_TYPE_QUALIFIER = 269,
    TOK_FUNC_STRING = 270,
    TOK_OPEN_BRAC = 271,
    TOK_CLOSE_BRAC = 272,
    TOK_CUR_OPEN = 273,
    TOK_CUR_CLOSE = 274,
    TOK_FLOAT_CONST = 275,
    TOK_INT_CONST = 276
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 51 "calc.y" /* yacc.c:1909  */

	char idName[100];
	char mainFunc[100];	 
	struct number numberConst;

#line 93 "calc.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_CALC_TAB_H_INCLUDED  */
