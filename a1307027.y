/* C Declarations */

%{
	#include<stdio.h>
	#include<math.h>
	#define PI 3.141593
	int sym[26];
	int temp;
%}

/* bison declarations */

%token NUM VAR IF ELSE MAIN INT FLOAT CHAR START END SWITCH CASE DEFAULT BREAK
%token SIN COS TAN LN THREEDOT FOR
%nonassoc IFX
%nonassoc ELSE
%nonassoc SWITCH
%nonassoc CASE
%nonassoc DEFAULT
%left UMINUS
%left '<' '>'
%left '+' '-'
%left '*' '/'
%right '^'

/* Grammar rules and actions follow.  */

%%

program: MAIN '(' ')' START cstatement END
	 ;

cstatement: /* NULL */

	| cstatement statement
	;

statement: ';'			
	| declaration ';'		{ printf("Declaration\n"); }

	| expression ';' 			{   printf("value of expression: %d\n", $1); }

        | VAR '=' expression ';' 		{ 
							sym[$1] = $3; 
							printf("Value of the variable: %d\t\n",$3);
						}
	| SWITCH '(' VAR ')' START Bases  END
	
	| FOR '(' NUM THREEDOT NUM ')' START statement END {
									int a = $3;
									int b = $5;
									int i;
									for(i=a; i<=b; i++) {
										printf("\nvalue of For Loop for %d time = %d\n",i, $8);
									}
									
								}

	| IF '(' expression ')' START statement END %prec IFX {
								if($3)
								{
									printf("\nvalue of expression in IF: %d\n",$6);
								}
								else
								{
								printf("condition value zero in IF block\n");
								}
							}

	| IF '(' expression ')' START statement END ELSE START statement END {
								 	if($3)
									{
										printf("value of expression in IF: %d\n",$6);
									}
									else
									{
										printf("value of expression in ELSE: %d\n",$10);
									}
								   }
	
	;
	
Bases: Base 
	| Base Defaults
	;
Base : /*NULL*/
	| Base Cases 
    ;
	
Cases   : CASE NUM ':' expression ';' BREAK ';' { printf("Value of the case expression: %d\t\n",$4); }
	;

Defaults   : DEFAULT ':' expression ';' BREAK ';' { printf("Value of the default expression: %d\t\n",$3); }
	;
	
declaration : TYPE ID1   
             ;


TYPE : INT   
     | FLOAT  
     | CHAR   
     ;



ID1 : ID1 ',' VAR  
    |VAR  
    ;

expression: NUM				{ $$ = $1; 	}

	| VAR				{ $$ = sym[$1]; }
	
	| expression '+' expression	{ $$ = $1 + $3; }

	| expression '-' expression	{ $$ = $1 - $3; }

	| expression '*' expression	{ $$ = $1 * $3; }

	| expression '/' expression	{ 	if($3) 
				  		{
				     			$$ = $1 / $3;
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by zero\t");
				  		} 	
				    	}
	| '-' expression %prec UMINUS { $2 = - $2; }
						
	| expression '^' expression { $$ = pow($1, $3); }					
						
	| expression '<' expression	{ $$ = $1 < $3; }

	| expression '>' expression	{ $$ = $1 > $3; }

	| '(' expression ')'		{ $$ = $2;	}
	
	| SIN '(' expression ')' 	{ double val = sin($3 * PI / 180); printf("sin %d = %lf\n",$3, val); $$ = val;}

    | COS '(' expression ')' { double val = cos($3 * PI / 180); printf("cos %d = %lf\n",$3, val); $$ = val; }

    | TAN '(' expression ')' { double val = tan($3 * PI / 180); printf("tan %d = %lf\n",$3, val); $$ = val; }

    | LN '(' expression ')' { double val = log($3 * PI / 180); printf("ln %lf\n",$3, val); $$ = val; }
	;
%%

int yywrap()
{
return 1;
}

yyerror(char *s){
	printf( "%s\n", s);
}

