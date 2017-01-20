/* C Declarations */

%{
	#include<stdio.h>
	#include "a1307027.tab.h"
	#include<stdlib.h>
	extern int yylval;
%}

/* RE and Actions */
SINGLELINECOMMENT		"//".*
MULTLINECOMMENT 		[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]
DIGIT [0-9]
NUMBER [-]?{DIGIT}*[.]?{DIGIT}+
%%

[a-z]	{
		yylval = *yytext - 'a';
		return	VAR;
	}
{NUMBER} {
				yylval = atoi(yytext);
				return NUM;
			}

{SINGLELINECOMMENT} {printf("\nSingle Line Comment\n"); }
{MULTLINECOMMENT}  { printf("\nMulti Line Comment\n");}
"ForLoop"          { return FOR;  }
"..."			   { return THREEDOT; }
"switch" 		   { return SWITCH; }
"case"   		   { return CASE;   }
"break"  		   { return BREAK;  }
"default" 		   { return DEFAULT;}
"start" 		   { return(START); }
"end"  			   { return(END);	}
"integer"  		   { return(INT);	}
"character" 	   { return(CHAR);	}
"float" 		   { return(FLOAT); }
"if"			   { return IF;		}
"else"			   { return ELSE;	}
"main_function"	   { return MAIN;	}
"sin"			   { return SIN;	}
"cos"		       { return COS;	}
"tan"			   { return TAN;	}
"ln"			   { return LN;		}

[-+/*^<>=,{}():;] 	{
			yylval = yytext[0];
			return *yytext;
		}

[ \t\n]*	;

.	{
		yyerror("Unknown Character.\n");
	}
%%

main(){
	yyin = freopen("in1.txt","r",stdin);
	yyout = freopen("out.txt","w",stdout);
	yyparse();
}

