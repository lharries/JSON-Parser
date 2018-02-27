package Example;

import java_cup.runtime.SymbolFactory;
%%
%cup
%class Scanner
%{
	public Scanner(java.io.InputStream r, SymbolFactory sf){
		this(r);
		this.sf=sf;
	}
	private SymbolFactory sf;
%}
%eofval{
    return sf.newSymbol("EOF",sym.EOF);
%eofval}


/**
 a number can either be an int, a floating point number, an exponential or a floating point number exponential

*/

digit1_9 = [1-9]
digit = [0-9]
integer = 0 | [+-]?{digit1_9}{digit}*
floating_number = [+-]?{digit}* \. {digit}*{digit1_9}
e_number = [eE][+-]?[0-9]+

number = ({integer} | {floating_number}) {e_number}?

/**
 a boolean is either true or false
*/

boolean = true | false

/**
 a string contains "" or " valid chars "

 char =
 any-Unicode-character-
     except-"-or-\-or-
     control-character
 \"
 \\
 \/
 \b
 \f
 \n
 \r
 \t
 \u four-hex-digits
*/

apostrophe = \"
general_chars = [^\"\\]
special_chars = \\[bfnrt\"\\]
unicode = \\u[a-fA-F0-9]{4}

all_valid_chars = {general_chars} | {special_chars} | {unicode}

string = {apostrophe}{all_valid_chars}*{apostrophe}

%%
"," { return sf.newSymbol("Comma",sym.COMMA); }
"[" { return sf.newSymbol("Left Square Bracket",sym.LSQBRACKET); }
"]" { return sf.newSymbol("Right Square Bracket",sym.RSQBRACKET); }
"{" { return sf.newSymbol("Left Curly Brace",sym.LCUBRACE); }
"}" { return sf.newSymbol("Right Curly Brace",sym.RCUBRACE); }
":" { return sf.newSymbol("Colon",sym.COLON); }
"\"" { return sf.newSymbol("Apostrophe",sym.APOSTROPHE); }

{number} { return sf.newSymbol("Integral Number",sym.NUMBER); }
{string} { return sf.newSymbol("String",sym.STRING); }
{boolean} { return sf.newSymbol("Boolean",sym.BOOLEAN); }
"null" { return sf.newSymbol("Null",sym.NULL); }

[ \t\r\n\f] { /* ignore white space. */ }
. { System.err.println("Illegal character: "+yytext()); }