/*
	Default driver template for JS/CC generated parsers for Mozilla/Rhino
	
	WARNING: Do not use for parsers that should run as browser-based JavaScript!
			 Use driver_web.js_ instead!
	
	Features:
	- Parser trace messages
	- Step-by-step parsing
	- Integrated panic-mode error recovery
	- Pseudo-graphical parse tree generation
	
	Written 2007 by Jan Max Meyer, J.M.K S.F. Software Technologies
        Modified 2007 from driver.js_ to support Mozilla/Rhino
           by Louis P.Santillan <lpsantil@gmail.com>
	
	This is in the public domain.
*/


;
(function($){

// node structs
function Syntax(set, title, comment) {
        this.set = set;
        this.title = title || "";
        this.comment = comment || "";
}
Syntax.prototype.toString = function() {
        var l = "\n---------------------------------------------------------\n";
        return l + "-- " + this.title + l + this.set + l +"comment:\n" + this.comment + l;
}
Syntax.prototype.nodetype="SYNTAX";


var PRODUCTION_SET = { 
        "label"   : "@@", 
        "join"    : function(i) { return  "\n" + i + "| "; },
        "nodetype": "PRODUCTION_SET"
};
var TERM_SET       = { 
        "label"   : "", 
        "join"    : function(i) { return (i==0) ? "" : "|";},
        "nodetype": "TERM_SET"
};
var FACTOR_SET       = { 
        "label"   : "", 
        "join"    : function(i) { return "";               },
        "nodetype": "FACTOR_SET"
};
function Set(t) {
        this.label    = t.label;
        this.join     = t.join;
        this.nodetype = t.nodetype;
        this.children = new Array();
}
Set.prototype.addChild = function(node) {
        this.children.push(node);
};;
Set.prototype.toString = function() {
        var cnt = this.children.length;
        var o = this.label;
        for (var i = 0; i < cnt; i++)
                o += this.join(i) + this.children[i].toString();
        return o;
}


function Production(id, expr) {
        this.id = id;
        this.expr = expr;
}
Production.prototype.toString = function(ind) {
        ind = ind || "";
        return ind + this.id + "=" + this.expr + " ." ;
}
Production.prototype.nodetype="PRODUCTION";


function Identifier(id) {
        this.id = id;
}
Identifier.prototype.toString = function() {
        return this.id;
};
Identifier.prototype.nodetype="IDENTIFIER";


function Literal(txt) {
        this.txt = txt;
}
Literal.prototype.toString = function() {
        return "\"" + this.txt + "\"";
};
Literal.prototype.nodetype="LITERAL";


function Optional(expr) {
        this.expr = expr;
}
Optional.prototype.toString = function() {
        return "[" + this.expr + "]";
};
Optional.prototype.nodetype="OPTIONAL";


function Repeating(expr) {
        this.expr = expr;
}
Repeating.prototype.toString = function() {
        return "{" + this.expr + "}";
};
Repeating.prototype.nodetype="REPEATING";


function Group(expr) {
        this.expr = expr;
}
Group.prototype.toString = function() {
        return "(" + this.expr + ")";
};
Group.prototype.nodetype="GROUP";


// node factories
function createNode(type, childs)  {
        var children = new Array();
        
        for( var i = 2; i < arguments.length; i++ )
                children.push( arguments[i] );

        return new Node(type, children);
};

function createSyntax(set, title, comment) {
        return new Syntax(set, title, comment);
};

function createSet() {
        return new Set(PRODUCTION_SET);
}

function createProduction(id, expr) {
        return new Production(id, expr);
}

function createExpression() {
        return new Set(TERM_SET);
}

function createTerm() {
        return new Set(FACTOR_SET);
}

function createIdentifier(id) {
        return new Identifier(id);
}

function createLiteral(txt) {
        return new Literal(txt);
}

function createOptional(termset) {
        return new Optional(termset);
}

function createRepeating(termset) {
        return new Repeating(termset);
}

function createGroup(termset) {
        return new Group(termset);
}

var parseComplete = function(syn){};



var _dbg_withparsetree	= false;
var _dbg_withtrace		= false;
var _dbg_withstepbystep	= false;

function __dbg_print( text )
{
	print( text );
}

function __dbg_wait()
{
   var kbd = new java.io.BufferedReader(
                new java.io.InputStreamReader( java.lang.System[ "in" ] ) );

   kbd.readLine();
}

function __lex( info )
{
	var state		= 0;
	var match		= -1;
	var match_pos	= 0;
	var start		= 0;
	var pos			= info.offset + 1;

	do
	{
		pos--;
		state = 0;
		match = -2;
		start = pos;

		if( info.src.length <= start )
			return 21;

		do
		{

switch( state )
{
	case 0:
		if( ( info.src.charCodeAt( pos ) >= 9 && info.src.charCodeAt( pos ) <= 10 ) || info.src.charCodeAt( pos ) == 13 || info.src.charCodeAt( pos ) == 32 ) state = 1;
		else if( info.src.charCodeAt( pos ) == 40 ) state = 2;
		else if( info.src.charCodeAt( pos ) == 41 ) state = 3;
		else if( info.src.charCodeAt( pos ) == 44 ) state = 4;
		else if( info.src.charCodeAt( pos ) == 46 || info.src.charCodeAt( pos ) == 59 ) state = 5;
		else if( info.src.charCodeAt( pos ) == 61 ) state = 6;
		else if( ( info.src.charCodeAt( pos ) >= 65 && info.src.charCodeAt( pos ) <= 90 ) || info.src.charCodeAt( pos ) == 95 || ( info.src.charCodeAt( pos ) >= 97 && info.src.charCodeAt( pos ) <= 122 ) ) state = 7;
		else if( info.src.charCodeAt( pos ) == 91 ) state = 8;
		else if( info.src.charCodeAt( pos ) == 93 ) state = 9;
		else if( info.src.charCodeAt( pos ) == 123 ) state = 10;
		else if( info.src.charCodeAt( pos ) == 124 ) state = 11;
		else if( info.src.charCodeAt( pos ) == 125 ) state = 12;
		else if( info.src.charCodeAt( pos ) == 34 ) state = 14;
		else if( info.src.charCodeAt( pos ) == 39 ) state = 16;
		else state = -1;
		break;

	case 1:
		state = -1;
		match = 1;
		match_pos = pos;
		break;

	case 2:
		state = -1;
		match = 9;
		match_pos = pos;
		break;

	case 3:
		state = -1;
		match = 10;
		match_pos = pos;
		break;

	case 4:
		state = -1;
		match = 3;
		match_pos = pos;
		break;

	case 5:
		state = -1;
		match = 11;
		match_pos = pos;
		break;

	case 6:
		state = -1;
		match = 2;
		match_pos = pos;
		break;

	case 7:
		if( ( info.src.charCodeAt( pos ) >= 48 && info.src.charCodeAt( pos ) <= 57 ) || ( info.src.charCodeAt( pos ) >= 65 && info.src.charCodeAt( pos ) <= 90 ) || info.src.charCodeAt( pos ) == 95 || ( info.src.charCodeAt( pos ) >= 97 && info.src.charCodeAt( pos ) <= 122 ) ) state = 7;
		else state = -1;
		match = 12;
		match_pos = pos;
		break;

	case 8:
		state = -1;
		match = 7;
		match_pos = pos;
		break;

	case 9:
		state = -1;
		match = 8;
		match_pos = pos;
		break;

	case 10:
		state = -1;
		match = 5;
		match_pos = pos;
		break;

	case 11:
		state = -1;
		match = 4;
		match_pos = pos;
		break;

	case 12:
		state = -1;
		match = 6;
		match_pos = pos;
		break;

	case 13:
		state = -1;
		match = 13;
		match_pos = pos;
		break;

	case 14:
		if( info.src.charCodeAt( pos ) == 34 ) state = 13;
		else if( ( info.src.charCodeAt( pos ) >= 0 && info.src.charCodeAt( pos ) <= 33 ) || ( info.src.charCodeAt( pos ) >= 35 && info.src.charCodeAt( pos ) <= 91 ) || ( info.src.charCodeAt( pos ) >= 93 && info.src.charCodeAt( pos ) <= 254 ) ) state = 14;
		else if( info.src.charCodeAt( pos ) == 92 ) state = 17;
		else state = -1;
		break;

	case 15:
		if( info.src.charCodeAt( pos ) == 34 ) state = 13;
		else if( ( info.src.charCodeAt( pos ) >= 0 && info.src.charCodeAt( pos ) <= 33 ) || ( info.src.charCodeAt( pos ) >= 35 && info.src.charCodeAt( pos ) <= 91 ) || ( info.src.charCodeAt( pos ) >= 93 && info.src.charCodeAt( pos ) <= 254 ) ) state = 14;
		else if( info.src.charCodeAt( pos ) == 92 ) state = 17;
		else state = -1;
		match = 13;
		match_pos = pos;
		break;

	case 16:
		if( info.src.charCodeAt( pos ) == 39 ) state = 13;
		else if( ( info.src.charCodeAt( pos ) >= 0 && info.src.charCodeAt( pos ) <= 38 ) || ( info.src.charCodeAt( pos ) >= 40 && info.src.charCodeAt( pos ) <= 91 ) || ( info.src.charCodeAt( pos ) >= 93 && info.src.charCodeAt( pos ) <= 254 ) ) state = 16;
		else if( info.src.charCodeAt( pos ) == 92 ) state = 18;
		else state = -1;
		break;

	case 17:
		if( ( info.src.charCodeAt( pos ) >= 0 && info.src.charCodeAt( pos ) <= 33 ) || ( info.src.charCodeAt( pos ) >= 35 && info.src.charCodeAt( pos ) <= 91 ) || ( info.src.charCodeAt( pos ) >= 93 && info.src.charCodeAt( pos ) <= 254 ) ) state = 14;
		else if( info.src.charCodeAt( pos ) == 34 ) state = 15;
		else if( info.src.charCodeAt( pos ) == 92 ) state = 17;
		else state = -1;
		break;

	case 18:
		if( ( info.src.charCodeAt( pos ) >= 0 && info.src.charCodeAt( pos ) <= 254 ) ) state = 16;
		else state = -1;
		break;

}


			pos++;

		}
		while( state > -1 );

	}
	while( 1 > -1 && match == 1 );

	if( match > -1 )
	{
		info.att = info.src.substr( start, match_pos - start );
		info.offset = match_pos;
		
switch( match )
{
	case 13:
		{
		 ;
                                info.att = info.att.substr( 1, info.att.length - 2 );
                                info.att = info.att.replace(/\\\'/g,"\'").replace(/\\\"/g,"\"").replace(/\\\\/g,"\\");            
		}
		break;

}


	}
	else
	{
		info.att = new String();
		match = -1;
	}

	return match;
}


function __parse( src, err_off, err_la )
{
	var		sstack			= new Array();
	var		vstack			= new Array();
	var 	err_cnt			= 0;
	var		act;
	var		go;
	var		la;
	var		rval;
	var 	parseinfo		= new Function( "", "var offset; var src; var att;" );
	var		info			= new parseinfo();
	
	//Visual parse tree generation
	var 	treenode		= new Function( "", "var sym; var att; var child;" );
	var		treenodes		= new Array();
	var		tree			= new Array();
	var		tmptree			= null;

/* Pop-Table */
var pop_tab = new Array(
	new Array( 0/* root' */, 1 ),
	new Array( 15/* root */, 1 ),
	new Array( 15/* root */, 0 ),
	new Array( 14/* syntax */, 5 ),
	new Array( 14/* syntax */, 4 ),
	new Array( 14/* syntax */, 4 ),
	new Array( 14/* syntax */, 3 ),
	new Array( 16/* productionset */, 1 ),
	new Array( 16/* productionset */, 2 ),
	new Array( 17/* production */, 4 ),
	new Array( 18/* expression */, 1 ),
	new Array( 18/* expression */, 3 ),
	new Array( 19/* term */, 1 ),
	new Array( 19/* term */, 2 ),
	new Array( 20/* factor */, 1 ),
	new Array( 20/* factor */, 1 ),
	new Array( 20/* factor */, 3 ),
	new Array( 20/* factor */, 3 ),
	new Array( 20/* factor */, 3 )
);

/* Action-Table */
var act_tab = new Array(
	/* State 0 */ new Array( 13/* "Literal" */,3 , 5/* "{" */,4 , 21/* "$" */,-2 ),
	/* State 1 */ new Array( 21/* "$" */,0 ),
	/* State 2 */ new Array( 21/* "$" */,-1 ),
	/* State 3 */ new Array( 5/* "{" */,5 ),
	/* State 4 */ new Array( 12/* "Identifier" */,8 ),
	/* State 5 */ new Array( 12/* "Identifier" */,8 ),
	/* State 6 */ new Array( 6/* "}" */,11 , 12/* "Identifier" */,8 ),
	/* State 7 */ new Array( 6/* "}" */,-7 , 12/* "Identifier" */,-7 ),
	/* State 8 */ new Array( 2/* "=" */,12 ),
	/* State 9 */ new Array( 6/* "}" */,13 , 12/* "Identifier" */,8 ),
	/* State 10 */ new Array( 6/* "}" */,-8 , 12/* "Identifier" */,-8 ),
	/* State 11 */ new Array( 13/* "Literal" */,14 , 21/* "$" */,-6 ),
	/* State 12 */ new Array( 12/* "Identifier" */,18 , 13/* "Literal" */,19 , 7/* "[" */,20 , 5/* "{" */,21 , 9/* "(" */,22 ),
	/* State 13 */ new Array( 13/* "Literal" */,23 , 21/* "$" */,-4 ),
	/* State 14 */ new Array( 21/* "$" */,-5 ),
	/* State 15 */ new Array( 4/* "|" */,24 , 11/* "Terminator" */,25 ),
	/* State 16 */ new Array( 12/* "Identifier" */,18 , 13/* "Literal" */,19 , 7/* "[" */,20 , 5/* "{" */,21 , 9/* "(" */,22 , 11/* "Terminator" */,-10 , 4/* "|" */,-10 , 8/* "]" */,-10 , 6/* "}" */,-10 , 10/* ")" */,-10 ),
	/* State 17 */ new Array( 11/* "Terminator" */,-12 , 12/* "Identifier" */,-12 , 13/* "Literal" */,-12 , 7/* "[" */,-12 , 5/* "{" */,-12 , 9/* "(" */,-12 , 4/* "|" */,-12 , 8/* "]" */,-12 , 6/* "}" */,-12 , 10/* ")" */,-12 ),
	/* State 18 */ new Array( 11/* "Terminator" */,-14 , 12/* "Identifier" */,-14 , 13/* "Literal" */,-14 , 7/* "[" */,-14 , 5/* "{" */,-14 , 9/* "(" */,-14 , 4/* "|" */,-14 , 8/* "]" */,-14 , 6/* "}" */,-14 , 10/* ")" */,-14 ),
	/* State 19 */ new Array( 11/* "Terminator" */,-15 , 12/* "Identifier" */,-15 , 13/* "Literal" */,-15 , 7/* "[" */,-15 , 5/* "{" */,-15 , 9/* "(" */,-15 , 4/* "|" */,-15 , 8/* "]" */,-15 , 6/* "}" */,-15 , 10/* ")" */,-15 ),
	/* State 20 */ new Array( 12/* "Identifier" */,18 , 13/* "Literal" */,19 , 7/* "[" */,20 , 5/* "{" */,21 , 9/* "(" */,22 ),
	/* State 21 */ new Array( 12/* "Identifier" */,18 , 13/* "Literal" */,19 , 7/* "[" */,20 , 5/* "{" */,21 , 9/* "(" */,22 ),
	/* State 22 */ new Array( 12/* "Identifier" */,18 , 13/* "Literal" */,19 , 7/* "[" */,20 , 5/* "{" */,21 , 9/* "(" */,22 ),
	/* State 23 */ new Array( 21/* "$" */,-3 ),
	/* State 24 */ new Array( 12/* "Identifier" */,18 , 13/* "Literal" */,19 , 7/* "[" */,20 , 5/* "{" */,21 , 9/* "(" */,22 ),
	/* State 25 */ new Array( 6/* "}" */,-9 , 12/* "Identifier" */,-9 ),
	/* State 26 */ new Array( 11/* "Terminator" */,-13 , 12/* "Identifier" */,-13 , 13/* "Literal" */,-13 , 7/* "[" */,-13 , 5/* "{" */,-13 , 9/* "(" */,-13 , 4/* "|" */,-13 , 8/* "]" */,-13 , 6/* "}" */,-13 , 10/* ")" */,-13 ),
	/* State 27 */ new Array( 4/* "|" */,24 , 8/* "]" */,31 ),
	/* State 28 */ new Array( 4/* "|" */,24 , 6/* "}" */,32 ),
	/* State 29 */ new Array( 4/* "|" */,24 , 10/* ")" */,33 ),
	/* State 30 */ new Array( 12/* "Identifier" */,18 , 13/* "Literal" */,19 , 7/* "[" */,20 , 5/* "{" */,21 , 9/* "(" */,22 , 11/* "Terminator" */,-11 , 4/* "|" */,-11 , 8/* "]" */,-11 , 6/* "}" */,-11 , 10/* ")" */,-11 ),
	/* State 31 */ new Array( 11/* "Terminator" */,-16 , 12/* "Identifier" */,-16 , 13/* "Literal" */,-16 , 7/* "[" */,-16 , 5/* "{" */,-16 , 9/* "(" */,-16 , 4/* "|" */,-16 , 8/* "]" */,-16 , 6/* "}" */,-16 , 10/* ")" */,-16 ),
	/* State 32 */ new Array( 11/* "Terminator" */,-17 , 12/* "Identifier" */,-17 , 13/* "Literal" */,-17 , 7/* "[" */,-17 , 5/* "{" */,-17 , 9/* "(" */,-17 , 4/* "|" */,-17 , 8/* "]" */,-17 , 6/* "}" */,-17 , 10/* ")" */,-17 ),
	/* State 33 */ new Array( 11/* "Terminator" */,-18 , 12/* "Identifier" */,-18 , 13/* "Literal" */,-18 , 7/* "[" */,-18 , 5/* "{" */,-18 , 9/* "(" */,-18 , 4/* "|" */,-18 , 8/* "]" */,-18 , 6/* "}" */,-18 , 10/* ")" */,-18 )
);

/* Goto-Table */
var goto_tab = new Array(
	/* State 0 */ new Array( 15/* root */,1 , 14/* syntax */,2 ),
	/* State 1 */ new Array(  ),
	/* State 2 */ new Array(  ),
	/* State 3 */ new Array(  ),
	/* State 4 */ new Array( 16/* productionset */,6 , 17/* production */,7 ),
	/* State 5 */ new Array( 16/* productionset */,9 , 17/* production */,7 ),
	/* State 6 */ new Array( 17/* production */,10 ),
	/* State 7 */ new Array(  ),
	/* State 8 */ new Array(  ),
	/* State 9 */ new Array( 17/* production */,10 ),
	/* State 10 */ new Array(  ),
	/* State 11 */ new Array(  ),
	/* State 12 */ new Array( 18/* expression */,15 , 19/* term */,16 , 20/* factor */,17 ),
	/* State 13 */ new Array(  ),
	/* State 14 */ new Array(  ),
	/* State 15 */ new Array(  ),
	/* State 16 */ new Array( 20/* factor */,26 ),
	/* State 17 */ new Array(  ),
	/* State 18 */ new Array(  ),
	/* State 19 */ new Array(  ),
	/* State 20 */ new Array( 18/* expression */,27 , 19/* term */,16 , 20/* factor */,17 ),
	/* State 21 */ new Array( 18/* expression */,28 , 19/* term */,16 , 20/* factor */,17 ),
	/* State 22 */ new Array( 18/* expression */,29 , 19/* term */,16 , 20/* factor */,17 ),
	/* State 23 */ new Array(  ),
	/* State 24 */ new Array( 19/* term */,30 , 20/* factor */,17 ),
	/* State 25 */ new Array(  ),
	/* State 26 */ new Array(  ),
	/* State 27 */ new Array(  ),
	/* State 28 */ new Array(  ),
	/* State 29 */ new Array(  ),
	/* State 30 */ new Array( 20/* factor */,26 ),
	/* State 31 */ new Array(  ),
	/* State 32 */ new Array(  ),
	/* State 33 */ new Array(  )
);



/* Symbol labels */
var labels = new Array(
	"root'" /* Non-terminal symbol */,
	"WHITESPACE" /* Terminal symbol */,
	"=" /* Terminal symbol */,
	"," /* Terminal symbol */,
	"|" /* Terminal symbol */,
	"{" /* Terminal symbol */,
	"}" /* Terminal symbol */,
	"[" /* Terminal symbol */,
	"]" /* Terminal symbol */,
	"(" /* Terminal symbol */,
	")" /* Terminal symbol */,
	"Terminator" /* Terminal symbol */,
	"Identifier" /* Terminal symbol */,
	"Literal" /* Terminal symbol */,
	"syntax" /* Non-terminal symbol */,
	"root" /* Non-terminal symbol */,
	"productionset" /* Non-terminal symbol */,
	"production" /* Non-terminal symbol */,
	"expression" /* Non-terminal symbol */,
	"term" /* Non-terminal symbol */,
	"factor" /* Non-terminal symbol */,
	"$" /* Terminal symbol */
);


	
	info.offset = 0;
	info.src = src;
	info.att = new String();
	
	if( !err_off )
		err_off	= new Array();
	if( !err_la )
	err_la = new Array();
	
	sstack.push( 0 );
	vstack.push( 0 );
	
	la = __lex( info );
			
	while( true )
	{
		act = 35;
		for( var i = 0; i < act_tab[sstack[sstack.length-1]].length; i+=2 )
		{
			if( act_tab[sstack[sstack.length-1]][i] == la )
			{
				act = act_tab[sstack[sstack.length-1]][i+1];
				break;
			}
		}

		/*
		_print( "state " + sstack[sstack.length-1] + " la = " + la + " info.att = >" +
				info.att + "< act = " + act + " src = >" + info.src.substr( info.offset, 30 ) + "..." + "<" +
					" sstack = " + sstack.join() );
		*/
		
		if( _dbg_withtrace && sstack.length > 0 )
		{
			__dbg_print( "\nState " + sstack[sstack.length-1] + "\n" +
							"\tLookahead: " + labels[la] + " (\"" + info.att + "\")\n" +
							"\tAction: " + act + "\n" + 
							"\tSource: \"" + info.src.substr( info.offset, 30 ) + ( ( info.offset + 30 < info.src.length ) ?
									"..." : "" ) + "\"\n" +
							"\tStack: " + sstack.join() + "\n" +
							"\tValue stack: " + vstack.join() + "\n" );
			
			if( _dbg_withstepbystep )
				__dbg_wait();
		}
		
			
		//Panic-mode: Try recovery when parse-error occurs!
		if( act == 35 )
		{
			if( _dbg_withtrace )
				__dbg_print( "Error detected: There is no reduce or shift on the symbol " + labels[la] );
			
			err_cnt++;
			err_off.push( info.offset - info.att.length );			
			err_la.push( new Array() );
			for( var i = 0; i < act_tab[sstack[sstack.length-1]].length; i+=2 )
				err_la[err_la.length-1].push( labels[act_tab[sstack[sstack.length-1]][i]] );
			
			//Remember the original stack!
			var rsstack = new Array();
			var rvstack = new Array();
			for( var i = 0; i < sstack.length; i++ )
			{
				rsstack[i] = sstack[i];
				rvstack[i] = vstack[i];
			}
			
			while( act == 35 && la != 21 )
			{
				if( _dbg_withtrace )
					__dbg_print( "\tError recovery\n" +
									"Current lookahead: " + labels[la] + " (" + info.att + ")\n" +
									"Action: " + act + "\n\n" );
				if( la == -1 )
					info.offset++;
					
				while( act == 35 && sstack.length > 0 )
				{
					sstack.pop();
					vstack.pop();
					
					if( sstack.length == 0 )
						break;
						
					act = 35;
					for( var i = 0; i < act_tab[sstack[sstack.length-1]].length; i+=2 )
					{
						if( act_tab[sstack[sstack.length-1]][i] == la )
						{
							act = act_tab[sstack[sstack.length-1]][i+1];
							break;
						}
					}
				}
				
				if( act != 35 )
					break;
				
				for( var i = 0; i < rsstack.length; i++ )
				{
					sstack.push( rsstack[i] );
					vstack.push( rvstack[i] );
				}
				
				la = __lex( info );
			}
			
			if( act == 35 )
			{
				if( _dbg_withtrace )
					__dbg_print( "\tError recovery failed, terminating parse process..." );
				break;
			}


			if( _dbg_withtrace )
				__dbg_print( "\tError recovery succeeded, continuing" );
		}
		
		/*
		if( act == 35 )
			break;
		*/
		
		
		//Shift
		if( act > 0 )
		{
			//Parse tree generation
			if( _dbg_withparsetree )
			{
				var node = new treenode();
				node.sym = labels[ la ];
				node.att = info.att;
				node.child = new Array();
				tree.push( treenodes.length );
				treenodes.push( node );
			}
			
			if( _dbg_withtrace )
				__dbg_print( "Shifting symbol: " + labels[la] + " (" + info.att + ")" );
		
			sstack.push( act );
			vstack.push( info.att );
			
			la = __lex( info );
			
			if( _dbg_withtrace )
				__dbg_print( "\tNew lookahead symbol: " + labels[la] + " (" + info.att + ")" );
		}
		//Reduce
		else
		{		
			act *= -1;
			
			if( _dbg_withtrace )
				__dbg_print( "Reducing by producution: " + act );
			
			rval = void(0);
			
			if( _dbg_withtrace )
				__dbg_print( "\tPerforming semantic action..." );
			
switch( act )
{
	case 0:
	{
		rval = vstack[ vstack.length - 1 ];
	}
	break;
	case 1:
	{
		 parseComplete(vstack[ vstack.length - 1 ]);                                              
	}
	break;
	case 2:
	{
		rval = vstack[ vstack.length - 0 ];
	}
	break;
	case 3:
	{
		 rval = createSyntax( vstack[ vstack.length - 3 ], vstack[ vstack.length - 5 ], vstack[ vstack.length - 1 ]);                                 
	}
	break;
	case 4:
	{
		 rval = createSyntax( vstack[ vstack.length - 2 ], vstack[ vstack.length - 4 ]);                                     
	}
	break;
	case 5:
	{
		 rval = createSyntax( vstack[ vstack.length - 3 ], undefined, vstack[ vstack.length - 1 ]);                          
	}
	break;
	case 6:
	{
		 rval = createSyntax( vstack[ vstack.length - 2 ]);                                         
	}
	break;
	case 7:
	{
		 rval = createSet(); rval.addChild(vstack[ vstack.length - 1 ]);                               
	}
	break;
	case 8:
	{
		 rval = vstack[ vstack.length - 2 ]; rval.addChild(vstack[ vstack.length - 1 ]);                                        
	}
	break;
	case 9:
	{
		 rval = createProduction(vstack[ vstack.length - 4 ], vstack[ vstack.length - 2 ]);                                   
	}
	break;
	case 10:
	{
		 rval = createExpression(); rval.addChild(vstack[ vstack.length - 1 ]);                        
	}
	break;
	case 11:
	{
		 rval = vstack[ vstack.length - 3 ]; rval.addChild(vstack[ vstack.length - 1 ]);                                        
	}
	break;
	case 12:
	{
		 rval = createTerm(); rval.addChild(vstack[ vstack.length - 1 ]);                              
	}
	break;
	case 13:
	{
		 rval = vstack[ vstack.length - 2 ]; vstack[ vstack.length - 2 ].addChild(vstack[ vstack.length - 1 ]);                                        
	}
	break;
	case 14:
	{
		 rval = createIdentifier(vstack[ vstack.length - 1 ]);                                       
	}
	break;
	case 15:
	{
		 rval = createLiteral(vstack[ vstack.length - 1 ]);                                          
	}
	break;
	case 16:
	{
		 rval = createOptional(vstack[ vstack.length - 2 ]);                                         
	}
	break;
	case 17:
	{
		 rval = createRepeating(vstack[ vstack.length - 2 ]);                                        
	}
	break;
	case 18:
	{
		 rval = createGroup(vstack[ vstack.length - 2 ]);                                            
	}
	break;
}


			
			if( _dbg_withparsetree )
				tmptree = new Array();

			if( _dbg_withtrace )
				__dbg_print( "\tPopping " + pop_tab[act][1] + " off the stack..." );
				
			for( var i = 0; i < pop_tab[act][1]; i++ )
			{
				if( _dbg_withparsetree )
					tmptree.push( tree.pop() );
					
				sstack.pop();
				vstack.pop();
			}
									
			go = -1;
			for( var i = 0; i < goto_tab[sstack[sstack.length-1]].length; i+=2 )
			{
				if( goto_tab[sstack[sstack.length-1]][i] == pop_tab[act][0] )
				{
					go = goto_tab[sstack[sstack.length-1]][i+1];
					break;
				}
			}
			
			if( _dbg_withparsetree )
			{
				var node = new treenode();
				node.sym = labels[ pop_tab[act][0] ];
				node.att = new String();
				node.child = tmptree.reverse();
				tree.push( treenodes.length );
				treenodes.push( node );
			}
			
			if( act == 0 )
				break;
				
			if( _dbg_withtrace )
				__dbg_print( "\tPushing non-terminal " + labels[ pop_tab[act][0] ] );
				
			sstack.push( go );
			vstack.push( rval );			
		}
	}

	if( _dbg_withtrace )
		__dbg_print( "\nParse complete." );

	if( _dbg_withparsetree )
	{
		if( err_cnt == 0 )
		{
			__dbg_print( "\n\n--- Parse tree ---" );
			__dbg_parsetree( 0, treenodes, tree );
		}
		else
		{
			__dbg_print( "\n\nParse tree cannot be viewed. There where parse errors." );
		}
	}
	
	return err_cnt;
}


function __dbg_parsetree( indent, nodes, tree )
{
	var str = new String();
	for( var i = 0; i < tree.length; i++ )
	{
		str = "";
		for( var j = indent; j > 0; j-- )
			str += "\t";
		
		str += nodes[ tree[i] ].sym;
		if( nodes[ tree[i] ].att != "" )
			str += " >" + nodes[ tree[i] ].att + "<" ;
			
		__dbg_print( str );
		if( nodes[ tree[i] ].child.length > 0 )
			__dbg_parsetree( indent + 1, nodes, nodes[ tree[i] ].child );
	}
}



$.extend({
	"ebnfParse": function(str, fn, errfn) {

		parseComplete = fn || function(syn) { 
		    alert(syn.toString()); 
		};
		
	    var parseErrors = errfn || function(err) { 
	        alert("errors#" + err.length);
        };

	    
		var error_cnt 	= 0;
		var error_off	= new Array();
		var error_la	= new Array();

		var errors;
		if( ( error_cnt = __parse( str, error_off, error_la ) ) > 0 )
		{
			errors=new Array();
			for( var i = 0; i < error_cnt; i++ ) {
				var msg = "Parse error near >" + str.substr( error_off[i], 30 ) + 
					"<, expecting \"" + error_la[i].join() + "\"" ;
				errors.push(msg);
		    }
			parseErrors(errors);
		}
	}
});

})(jQuery);

