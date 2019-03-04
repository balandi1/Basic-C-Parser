all: calc

calc.tab.c calc.tab.h:	calc.y
	bison -dv calc.y

lex.yy.c: calc.l calc.tab.h
	flex calc.l

calc: lex.yy.c calc.tab.c calc.tab.h
	gcc -o calc lex.yy.c calc.tab.c -lfl