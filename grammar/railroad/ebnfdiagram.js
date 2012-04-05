;var G_vmlCanvasManager = undefined;
(function($){

    //introduce ebnfdia() on $
    $.fn.extend({
        "ebnfcanvas": function(styles) {
            return this.map( function(){            
                return new EbnfDiagram($(this), styles);
            });
        },
        "ebnfdiagram": function(styles) {
            return this.each( function(){            
                makeDiagram($(this), styles);
            });
        }
    });
    
    function makeCanvas(w, h, fn, hidden) {
        fn = fn || function() {};
        h = h ? Math.floor(h) : 100; 
        w = w ? Math.floor(w) : 300;
        
        var $cnv;
        
        // check up on ie support via explorercanvas to initialize properly
        if (G_vmlCanvasManager != undefined) {
            // explorercanvas kinda expects elms to be built this way, not the jquery way.
            var cnv = document.createElement('canvas');
            cnv.setAttribute('height', h);
            cnv.setAttribute('width', w);
            cnv = G_vmlCanvasManager.initElement(cnv);
            $cnv = $(cnv);
        } else {
            $cnv = $('<canvas height="'+h+'" width="'+w+'"></canvas>');
        }
        
        fn($cnv);
        
        if (hidden) $cnv.hide();
        
        return $cnv;
    }
    
    function makeDiagram($elm, styles) {
        var ebnf = $elm.text();
        
        //TODO perform hight/width calculations
        var h = $elm.height();
        var w = $elm.width();

        var $cnv = makeCanvas( $elm.width(), $elm.height(), function($cnv) {$cnv.insertAfter($elm)}, true);
        
        var dia = $cnv.ebnfcanvas(styles)[0];
        
        var showDiagram = function(dia) {
            $elm.hide("normal");
            dia.$cnv.show("normal");
        }
        
        $.ebnfParse( ebnf, 
            function(syn){
                dia.setSyntax(syn);
                showDiagram(dia);
            }, 
            function(err) {
                dia.showErrors(err);
                showDiagram(dia);
            }
        );
    }
    
    $.extend({
        "mergedClone": function(base, spec) {
            return $.extend(true, $.extend({}, base), spec);
        }
    });
    
    function EbnfDiagram($elm, styles) {
        this.$cnv = $elm;

        this.styles = $.mergedClone(STYLES, styles);
        this.style  = this.styles["DIAGRAM"];
        this.init();    
    }

    EbnfDiagram.prototype.getGC = function() {
        if (! this.gc) {
            this.gc = this.$cnv.get(0).getContext('2d');            
        }
        return this.gc;
    }

    //default style
    STYLES = {
        "SYNTAX":          {
            "margin"            : 10,
            "round"             : 10,
            "background-fill"   : "rgba(200,200,100, 0.3)",
            "background-stroke" : "rgba(255,255,255, 0)",
            "background-weight" :   0,
            "separator-stroke"  : "rgba(  0,  0,  0, 0.7)",
            "separator-weight"  :   2,
            "title-font"        : "30px Arial",
            "title-color"       : "rgba(  0,  0,  0, 0.7)", 
            "title-align"       : "left",
            "comment-font"      : "20px Optimer",
            "comment-color"     : "rgba(0, 0, 0, 0.5)",
            "comment-align"     : "left"
        },
        "PRODUCTION_SET":  {
        },
        "PRODUCTION":      {
            "margin"            : 10,
            "round"             : 10,
            "background-fill"   : "rgba(255,255,255, 0.75)",
            "background-stroke" : "rgba(255,255,255, 0)",
            "background-weight" :   0,
            "font"              : "10px Arial",
            "color"             : "rgba(  0,  0,  0, 0.7)", 
            "align"             : "left",
            "baseline"          : "bottom", 
            "trail"             : 75
        },
        "TERM_SET":        {
        },
        "FACTOR_SET":      {
        },
        "LITERAL":         {
            "round"             :  10,
            "background-fill"   : "rgba( 20, 20,200, 0.5)",
            "background-stroke" : "rgba( 10, 10, 10, 0.8)",
            "background-weight" :  3
        },
        "IDENTIFIER":      {
            "round"             :  0,
            "background-fill"   : "rgba(200, 20, 20, 0.5)",
            "background-stroke" : "rgba( 10, 10, 10, 0.8)",
            "background-weight" :  3
        },
        "GROUP":           {
        }, 
        "REPEATING":       {
        }, 
        "OPTIONAL":        {
        },
        "DIAGRAM":         {
            "line-stroke"      : "rgba( 10, 10, 10, 1)",
            "line-weight"      : 2,
            "grid"             : 12,
            "font-width"       : 10,
            "font-height"      : 24,
            "font"             : "12px Arial",
            "color"            : "rgba(  0,  0,  0, 0.7)"
        }
    }
    
    NODEHANDLERS = {
        "SYNTAX":          {
            "prepare": function(node, dia, gc) {
                var s = node.style;
                var m = s.margin;
                
                var c = node.set;
                dia.prepare(c);
                
                node.height = c.height + 2*m + 2*30 + 2*20;   // TODO calculated room for title and comment
                node.width  = c.width  + 2*m;  
            },
            "draw"   : function(node, dia, gc) {
                var s = node.style;
                var m = s.margin;
                
                var ox = node.width  / 2;
                var oy = node.height / 2;
                var ty = 30; //TODO calc
                var cy = 20; //TODO calc
                
                GCLIB.setDrawStyle(gc, s, "background");
                GCLIB.roundedRect(gc, (node.width - m), (node.height - m), s.round, ox, oy);
                
                GCLIB.setTextStyle(gc, s, "title");
                GCLIB.centeredText(gc, node.title, 2*m, ty);                
                
                GCLIB.setDrawStyle(gc, node.style, "separator");
                GCLIB.line(gc, 2*m, 2*ty, node.width - 2*m, 2*ty);

                dia.draw(node.set, m, 2*ty + m); 

                GCLIB.line(gc, 2*m, node.height - 2*cy, node.width - 2*m, node.height - 2*cy);

                GCLIB.setTextStyle(gc, s, "comment");
                GCLIB.centeredText(gc, node.comment, 2*m, node.height - cy);                
            }
        },
        "PRODUCTION_SET":  {
            "prepare": function(node, dia, gc) {
                var sumH = 0;
                var maxW = 0;
                
                var c = node.children;
                for (var i = 0; i< c.length; i++){
                    var ci = c[i];
                    dia.prepare(ci);
                    sumH += ci.height;                
                    maxW = Math.max(maxW, ci.width); 
                }
                
                // align all widths
                for (var i = 0; i < c.length; i++){
                    c[i].width = maxW;
                }
                
                node.width  = maxW; 
                node.height = sumH; 
            },
            "draw"   : function(node, dia, gc) {
                var s = node.style;
                
                var offH = 0; 

                var c = node.children;

                for (var i = 0; i < c.length; i++){
                    var ci = c[i];
                    dia.draw(ci, 0, offH);
                    offH += ci.height;                
                }
            }
        },
        "PRODUCTION":      {
            "prepare": function(node, dia, gc) {
                var s  = node.style;
                var ds = dia.style;
                var g  = ds.grid;
                var m  = s.margin;

                var c = node.expr;
                dia.prepare(c);
                
                node.width  = c.width + 2*m + s.trail;
                node.height = c.height+ 2*m;
            },
            "draw"   : function(node, dia, gc) {
                var s  = node.style;
                var ds = dia.style;
                var g  = ds.grid;
                var m  = s.margin;
                var tx = 10;
                var ty = 10;
                
                var ox = node.width  / 2;
                var oy = node.height / 2;

                GCLIB.setDrawStyle(gc, s, "background");
                GCLIB.roundedRect(gc, (node.width - m), (node.height - m), s.round, ox, oy);

                GCLIB.setTextStyle(gc, s);
                GCLIB.centeredText(gc, node.id, m + tx, m + ty);     
                
                GCLIB.setDrawStyle(gc, ds, "line");
                GCLIB.line(gc, m , m+ 2*g, m + s.trail, m+ 2*g);
                
                // delegate to expression
                var c = node.expr;
                dia.draw(c, m + s.trail, m);                
                
                GCLIB.line(gc, m + s.trail + node.expr.width , m+ 2*g, node.width -m, m + 2*g);
                GCLIB.line(gc, node.width - m, m+ 1.5 * g, node.width - m, m+ 2.5*g);
            }
        },
        "TERM_SET":        {
            "prepare": function(node, dia, gc) {
                var ds = dia.style;
                var g  = ds.grid;

                var sumH = 0;
                var maxW = 0;
                
                var c = node.children;
                for (var i = 0; i< c.length; i++){
                    var ci = c[i];
                    dia.prepare(ci);
                    sumH += ci.height;                
                    maxW = Math.max(maxW, ci.width);
                }
                
                node.width  = maxW +              6 * g; // make room for parallelization lines
                node.height = sumH + (c.length - 1) * g; // make room for space between terms
            },
            "draw"   : function(node, dia, gc) {
                var s  = node.style;
                var ds = dia.style;
                var g  = ds.grid;

                var offH = 0; 

                var c = node.children;
                
                GCLIB.setDrawStyle(gc, ds, "line");
                for (var i = 0; i < c.length; i++){
                    var ci = c[i];
                    GCLIB.slideIn (gc, g, 0 , 2*g, 3*g, offH);

                    dia.draw(ci, 3*g, offH);
                    
                    GCLIB.line(gc, ci.width + 3*g , offH + 2*g, node.width - 3*g, offH + 2*g);
                    GCLIB.slideOut(gc, g, node.width, 2*g, 3*g, offH);

                    offH += ci.height + g;    //add space between terms
                }
            }
        },
        "FACTOR_SET":      {
            "prepare": function(node, dia, gc) {
                var ds = dia.style;
                var g  = ds.grid;

                var sumW = 0;
                var maxH = 0;
                
                var c = node.children;
                for (var i = 0; i< c.length; i++){
                    var ci = c[i];
                    dia.prepare(ci);
                    sumW += ci.width;                
                    maxH = Math.max(maxH, ci.height); 
                }
                
                // no need to align the heights

                node.width  = sumW;
                node.height = maxH;          
            },
            "draw"   : function(node, dia, gc) {
                var s = node.style;
                var ds = dia.style;
                var g  = ds.grid;
                
                var offW = 0; 

                var c = node.children;
                for (var i = 0; i < c.length; i++){
                    var ci = c[i];
                    dia.draw(ci, offW, 0);
                    offW += ci.width;
                }    
            }
        },
        "LITERAL":         {
            "prepare": function(node, dia, gc) {
            
                var l  = Math.max(3, node.txt.length);
                var ds = dia.style;
                var g  = ds.grid;
                
                node.width  = l * ds["font-width"] + 2 * g;
                node.height = 4 * g ;
            },
            "draw"   : function(node, dia, gc) {
                var s  = node.style;
                var ds = dia.style;
                var g  = ds.grid;
                var ox = node.width / 2;
                var oy = node.height /2;
                
                GCLIB.setDrawStyle(gc, ds, "line");
                GCLIB.line(gc, 0, 2*g, g, 2*g);
                GCLIB.line(gc, node.width - g, 2*g, node.width, 2*g);
                
                
                GCLIB.setDrawStyle(gc,s, "background");
                GCLIB.roundedRect(gc, node.width - 2 * g, ds["font-height"], s.round, ox, oy);

                GCLIB.setTextStyle(gc, ds);
                GCLIB.centeredText(gc, node.txt, ox, oy);     
            }
        },
        "IDENTIFIER":      {
            "prepare": function(node, dia, gc) {
            
                var l  = Math.max(3, node.id.length);
                var ds = dia.style;
                var g  = ds.grid;
                
                node.width  = l * dia.style["font-width"] + 2*g;
                node.height = 4*g ;
            },
            "draw"   : function(node, dia, gc) {
                var s  = node.style;
                var ds = dia.style;
                var g  = ds.grid;
                var ox = node.width / 2;
                var oy = node.height /2;
                
                GCLIB.setDrawStyle(gc, ds, "line");
                GCLIB.line(gc, 0, 2*g, g, 2*g);
                GCLIB.line(gc, node.width - g, 2*g, node.width, 2*g);
                
                
                GCLIB.setDrawStyle(gc,s, "background");
                GCLIB.roundedRect(gc, node.width - 2 * g, ds["font-height"], s.round, ox, oy);

                GCLIB.setTextStyle(gc, ds);
                GCLIB.centeredText(gc, node.id , ox, oy);     
            }
        },
        "GROUP":           {
            "prepare": function(node, dia, gc) {
            
                var ds = dia.style;
                var g  = ds.grid;
                
                var c = node.expr;
                dia.prepare(c);
                
                node.width  = c.width + 2 * g;
                node.height = c.height;
            },
            "draw"   : function(node, dia, gc) {
                var s  = node.style;
                var ds = dia.style;
                var g  = ds.grid;

                GCLIB.setDrawStyle(gc, ds, "line");
                GCLIB.line(gc, 0, 2*g, g, 2*g);

                dia.draw(node.expr, g, 0);

                GCLIB.line(gc, node.width - g, 2*g, node.width, 2*g);
            }
        }, 
        "REPEATING":       {
            "prepare": function(node, dia, gc) {
                var ds = dia.style;
                var g  = ds.grid;
            
                var c = node.expr;
                dia.prepare(c);
                
                node.width  = c.width + 6*g;
                node.height = c.height;
            },
            "draw"   : function(node, dia, gc) {
                var s  = node.style;
                var ds = dia.style;
                var g  = ds.grid;
                
                var c = node.expr;

                GCLIB.setDrawStyle(gc, ds, "line");
                GCLIB.slideOut(gc, g, 2*g, 0, 2*g, 2*g);
                GCLIB.line(gc, 2*g , 0, node.width - 2*g, 0);
                GCLIB.slideIn (gc, g, node.width - 2*g, 0, 2*g, 2*g);

                GCLIB.line(gc, 0, 2*g, 3*g, 2*g);
                dia.draw(c, 3*g, 0);
                GCLIB.line(gc, node.width - 3*g, 2*g, node.width, 2*g);
                
                GCLIB.loopDown(gc, g, 3*g + c.width, 2*g, - 2*g + c.height);
                GCLIB.line(gc, 3*g , c.height, node.width - 3*g, c.height);
                GCLIB.loopUp(gc, g, 3*g, 2*g, - 2*g + c.height);
            }
        }, 
        "OPTIONAL":        {
            "prepare": function(node, dia, gc) {
                var ds = dia.style;
                var g  = ds.grid;
            
                var c = node.expr;
                dia.prepare(c);
                
                node.width  = c.width  + 6*g;
                node.height = c.height + 2*g;
            },
            "draw"   : function(node, dia, gc) {
                var s  = node.style;
                var ds = dia.style;
                var g  = ds.grid;

                GCLIB.setDrawStyle(gc, ds, "line");
                GCLIB.line(gc, 0 , 2*g, node.width, 2*g);

                GCLIB.slideIn (gc, g, 0 , 2*g, 3*g, 2*g);

                dia.draw(node.expr, 3*g, 2*g);
                
                GCLIB.slideOut(gc, g, node.width, 2*g, 3*g, 2*g);
            }
        }
    }

    //actual diagram code
    EbnfDiagram.prototype.init = function() {

        this.height = this.$cnv.attr('height');
        this.width = this.$cnv.attr('width');
        
        // clear the canvas
        this.getGC().clearRect( 0, 0, this.width, this.height);
    }
    
    EbnfDiagram.prototype.showErrors = function(err) {
        var l = err.length;
        for (var i = 0; i++; i<l) {
            alert((i+1) + "/" + l + ":\n" + err[i]);
        }
    }
    
    EbnfDiagram.prototype.setSyntax = function(syn) {
        this.prepare(syn, this.styles);
        
        this.resize({"width": syn.width, "height": syn.height}, this.styles.CANVAS);
        this.init();

        var gc = this.getGC();
        var scale = Math.min(this.width/syn.width, this.height/syn.height);
        
        gc.save();
        try {
            gc.scale(scale,scale);
            this.draw(syn);
        } finally {
            gc.restore();
        }            
    }
    
    // Preparation visitor, prepares the complete tree, 
    // assisted by call-backs from the parent-nodes down to their subnodes
    EbnfDiagram.prototype.prepare = function(node) {
        var type = node.nodetype;
        if (node.handler)
            throw "node is already prepared!" + node;
            
        node.handler = NODEHANDLERS[type];
        if (!node.handler) throw "cannot handle node of type " + type;
        
        node.style   = this.styles[type];
        
        node.handler.prepare(node, this, this.getGC());
    }
    
    // Draw visitor, draws the specified node at the specified position
    // Requires nodes to be prepared.
    EbnfDiagram.prototype.draw = function(node, x, y) {
        if (!node.handler) 
            throw "Request to draw a node that is not prepared yet! nodetype=" + node.nodetype;
            
        var gc = this.getGC();
        x = x || 0;
        y = y || 0;
        
        gc.save();
        try {
            gc.translate(x,y);
            node.handler.draw(node, this, gc);
        } catch(e) {
            debugger;
            alert(e);
        } finally {
            gc.restore();
        }            
    }
    

    // Resizes the canvas to fit the needed space according to the rules
    // rules for width and height can be fixed values, or '*' 
    // * indicates that dimension can freely grow/adjust to needs.
    EbnfDiagram.prototype.resize = function(need, rules) {
	    if (!rules || (!rules.height && !rules.width))
		    return; // no rules, no work
	    var dim={"height": this.height, "width": this.width};

	    rules.height = rules.height || this.height; // nothing set means keep current
	    rules.width  = rules.width  || this.width; // nothing set means keep current
	
	    if (rules.width == "*" && rules.height == "*")	{ //set both
	        dim.width  = need.width; 
	        dim.height = need.height;
	    } else if (rules.height = "*" && dim.height < need.height) { // only grow taller
	        dim.height = need.height * rules.width / need.width;
	    } else if (rules.width == "*" && dim.width < need.width) { // only grow wider
	        dim.width = need.width * rules.height / need.height;
	    } else { // take fixes
	        dim.width = rules.width;
	        dim.height = rules.height;
	    }
	    
	    // now apply the new dimension by creating a new canvas and dumoping the previous + context
	    this.gc = null;

        // explorercanvas kinda expects elms to be built this way, not the jquery way.
        var cnv = document.createElement('canvas');
        var $elm = this.$cnv;
        var $cnv = makeCanvas( dim.width, dim.height, 
            function($cnv){
                $cnv.insertAfter($elm);
            }, true);
        
	    this.$cnv.remove();
	    this.$cnv = $cnv;
    }
    
    
    // Internal GCLIB with standard operations/drawing assistance..
    var GCLIB = {};
    
    /** Draws a centered (ie at 0,0) rounded rectangle with the specified width, height and percentage of round-ness on the corners */
    GCLIB.roundedRect = function(gc, width, height, r, atx, aty) {
        if (! (width && height))
            return;

        r = r || 0;
        atx = atx || 0;
        aty = aty || 0;

        var w = width/2;
        var h = height/2;

        gc.beginPath();
            if (r) {
                gc.arc( atx -w + r, aty -h + r, r, -Math.PI  , -Math.PI/2, false);
                gc.arc( atx +w - r, aty -h + r, r, -Math.PI/2, 0         , false);
                gc.arc( atx +w - r, aty +h - r, r, 0         , Math.PI/2 , false);
                gc.arc( atx -w + r, aty +h - r, r, Math.PI/2 , Math.PI   , false);
            } else {
                gc.moveTo( atx -w, aty -h);
                gc.lineTo( atx +w, aty -h);
                gc.lineTo( atx +w, aty +h);
                gc.lineTo( atx -w, aty +h);
            }
        gc.closePath();
        gc.fill();
        gc.stroke();
    }
    
    /** Draws text centered at 0,0 */
    GCLIB.centeredText = function(gc, text, x, y) {
        x = x || 0;
        y = y || 0;
        gc.fillText(text, x, y);
    }
    
    /** Draws line from a to b */
    GCLIB.line = function(gc, ax, ay, bx, by) {
        gc.beginPath();
        gc.moveTo( ax, ay);
        gc.lineTo( bx, by);
        gc.closePath();
        gc.stroke();
    }


    /** Draws slide-in from a to b */
    GCLIB.slideIn = function(gc, g, atx , aty, w, h){
        w = Math.max(w , 2*g); // minimal width
        h = h || 0;
        if (h==0) {
            GCLIB.line(gc, atx, aty, atx+w, aty);
            return;
        }
        gc.beginPath();
        gc.arc( atx , aty + g, g, -Math.PI/2, 0,false);
        gc.lineTo( atx + g, aty + h - g);
        gc.arc( atx +2*g, aty + h - g, g, Math.PI, Math.PI/2,true);
        gc.lineTo(atx + w, aty + h); 
        gc.stroke();
    }
    
    GCLIB.slideOut = function(gc, g, tox, toy, w, h){
        w = Math.max(w , 2*g); // minimal width
        h = h || 0;
        if (h==0) {
            gc.beginPath();
            gc.moveTo(tox -w, toy);
            gc.lineTo( tox , toy);
            gc.stroke();
            return;
        }
        gc.beginPath();
        gc.moveTo(tox -w, toy + h);
        gc.lineTo(tox - 2*g, toy + h); 
        gc.arc( tox - 2 * g , toy + h - g, g, Math.PI/2, 0, true);
        gc.lineTo( tox -g , toy + g);
        gc.arc( tox, toy + g, g, -Math.PI, -Math.PI/2, false);
        gc.stroke();
    }

    GCLIB.loopDown = function(gc, g, atx, aty, h){
        h = h || 0;
        if (h==0) 
            return;
        gc.beginPath();
        gc.arc( atx , aty + g, g, -Math.PI/2, 0,false);
        gc.lineTo( atx + g, aty + h - g);
        gc.arc( atx , aty + h - g, g, 0, Math.PI/2,false);
        gc.stroke();
    }

    GCLIB.loopUp = function(gc, g, tox, toy, h){
        h = h || 0;
        if (h==0) 
            return;
        gc.beginPath();
        gc.arc( tox , toy + h - g, g, Math.PI/2, Math.PI, false);
        gc.lineTo( tox - g, toy + g);
        gc.arc( tox , toy + g, g, -Math.PI, -Math.PI/2,false);
        gc.stroke();
    }

    var DEFAULT_FILL      = "rgb(255,255,255)";
    var DEFAULT_STROKE    = "rgb(  0,  0,  0)";
    var DEFAULT_WEIGHT    = 0;
    var DEFAULT_FONT      = "8px Arial";
    var DEFAULT_COLOR     = "rgb(  0,  0,  0)";
    var DEFAULT_ALIGN     = "center";
    var DEFAULT_BASELINE  = "middle";
    
    /** Sets drawstyles */
    GCLIB.setDrawStyle = function(gc, style, pfx) {
        pfx = pfx ? pfx + "-" : "";
        gc.fillStyle   = style[pfx + "fill"]   || DEFAULT_FILL;
        gc.strokeStyle = style[pfx + "stroke"] || DEFAULT_STROKE;
        gc.lineWidth   = style[pfx + "weight"] || DEFAULT_WEIGHT;
    }

    /** Sets font-styles */
    GCLIB.setTextStyle = function(gc, style, pfx) {
        pfx = pfx ? pfx + "-" : "";
        gc.font         = style[pfx + "font"]     || DEFAULT_FONT;
        gc.fillStyle    = style[pfx + "color"]    || DEFAULT_COLOR;
        gc.textAlign    = style[pfx + "align"]    || DEFAULT_ALIGN;
        gc.textBaseline = style[pfx + "baseline"] || DEFAULT_BASELINE;
    }
})(jQuery);
