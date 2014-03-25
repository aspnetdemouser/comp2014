jQuery.fn.extend({
	bbcode_wysiwyg: function( options ){
		$(this).each(function(i,obj){
			if(!options)
				options = {};
			var settings = {
					nocol1: 		"&#78;&#79;&#32;&#67;&#79;&#76;&#79;&#82;",
					clos1: 			"X",
					ifm: 			null,
					content: 		"",
					isIE: /msie/.test(navigator.userAgent.toLowerCase()),
					isChrome: /chrome/.test(navigator.userAgent.toLowerCase()),
					isSafari: /safari/.test(navigator.userAgent.toLowerCase()) && !/chrome/.test(navigator.userAgent.toLowerCase()),
					browser: /msie/.test(navigator.userAgent.toLowerCase()) || window.opera,
					textRange: 		"",
					enter: 			0,
					editorVisible: 	false,
					enableWysiwyg: 	false
				};
			$(obj).data('bbcode_settings', $.extend({}, settings, options));
			var parent = $(obj).parents("*").get(0);
			var bbcode_editor_content = '' + 
				'<div class="editbar" rel="' + $(obj).attr("id") + '">' + 
					'<button title="Bold" func="doClick" args="bold" type="button"><b>B</b></button>' + 
					'<button title="Italic" func="doClick" args="italic" type="button"><i>I</i></button>' + 
					'<button title="Underline" func="doClick" args="underline" type="button"><u>U</u></button>' + 
					'<button title="Hyperlink" func="doLink" args="" type="button" style="background-image:url(\'images/bbcode/url.gif\');"></button>' + 
					'<button title="Image reference" func="doImage" args="" type="button" style="background-image:url(\'images/bbcode/img.gif\');"></button>' + 
					'<!--<button title="list" func="doClick" args="InsertUnorderedList" type="button" style="background-image:url(\'images/bbcode/icon_list.gif\');"></button>-->' + 
					'<button title="Color" func="showColorGrid2" args="none" type="button" style="background-image:url(\'images/bbcode/colors.gif\');"></button><span id="colorpicker201" class="colorpicker201"></span>' + 
					'<button title="Quote" func="doQuote" args="" type="button" style="background-image:url(\'images/bbcode/icon_quote.png\');"></button>' + 
					'<!--<button title="youtube" func="InsertYoutube" args="" type="button" style="background-image:url(\'images/bbcode/icon_youtube.gif\');"></button>-->' + 
					'<button title="Toggle source and preview modes" type="button" func="SwitchEditor" args="" style="background-image:url(\'images/bbcode/icon_html.gif\');"></button>' + 
				'</div>' + 
				'<div class="container">' + 
				'</div>';
			$("<div />")
				.addClass("richeditor")
				.html(bbcode_editor_content)
				.insertBefore("#" + $(obj).attr("id"));
			$(parent).find(".richeditor div.container").append($("#" + $(obj).attr("id")));
			$(obj).bbcode_initEditor(true);
			var parent_form = $(obj).parents("form").get(0);
			$(parent_form).submit(function(){
				$(parent_form).find(".bbcode_wysiwyg").bbcode_doCheck();
			});
		});
		$('.editbar button').click(function(e){
			var p = $(this).parents(".editbar").get(0);
			eval('$("#' + $(p).attr("rel") + '").bbcode_' + $(this).attr("func") + '(\'' + $(this).attr("args") + '\', e);');
		});
	},
	bbcode_rep: function(re, str) { $(this).data('bbcode_settings').content = $(this).data('bbcode_settings').content.replace(re, str); },
	bbcode_initEditor: function(wysiwyg) {
		if(wysiwyg!=undefined)
			$(this).data('bbcode_settings').enableWysiwyg = wysiwyg;
		else
			$(this).data('bbcode_settings').enableWysiwyg = true;

		//$(this).data('bbcode_settings').textboxelement = $("#" + $(this).attr("id"));
		$(this).addClass('editorBBCODE');
	    if ($(this).data('bbcode_settings').enableWysiwyg) {
	    	$("<iframe />")
	        	.attr("id", "rte_" + $(this).attr("id"))
	        	.attr("frameborder", "0")
	        	.addClass("frm_editorBBCODE")
	        	.css({width: $(this).css("width"), height: $(this).css("height"), display: 'none'})
	        	.append('<html><head></head><body></body></html>')
	        	.insertBefore("#" + $(this).attr("id"));
	    	$(this).data('bbcode_settings').ifm = $("#rte_" + $(this).attr("id"));
		    $(this).data('bbcode_settings').myeditor = $(this).data('bbcode_settings').ifm.contents().find("body");
		    $(this).data('bbcode_settings').myeditor_doc = $(this).data('bbcode_settings').ifm[0].contentWindow.document;
	    	eval("setTimeout(function(){ $('#" + $(this).attr("id") + "').bbcode_initIframe(); },100);");
		    if ($(this).data('bbcode_settings').ifm[0].contentWindow.document.attachEvent) {
		        if(parent.ProcessKeyPress)
		        	$(this).data('bbcode_settings').ifm[0].contentWindow.document.attachEvent("onkeydown", parent.ProcessKeyPress);
		        $(this).data('bbcode_settings').ifm[0].contentWindow.document.attachEvent("onkeypress", function(){ $.bbcode_kp(); });
		    }
		    else if ($(this).data('bbcode_settings').ifm[0].contentWindow.document.addEventListener) {
		        if (parent.ProcessKeyPress)
		        	$(this).data('bbcode_settings').ifm[0].contentWindow.document.addEventListener("keydown", parent.ProcessKeyPress, true);
		        $(this).data('bbcode_settings').ifm[0].contentWindow.document.addEventListener("keypress",$.bbcode_kp,true);
		    }
	    	eval("setTimeout(function(){ $('#" + $(this).attr("id") + "').bbcode_SwitchEditor(); },100);");
	    }
	},
	bbcode_initIframe: function(id){
		$('#' + $(this).attr("id")).data('bbcode_settings').ifm[0].contentWindow.document.designMode = 'on';
		if(!$(this).data('bbcode_settings').isIE)
			$('#' + $(this).attr("id")).data('bbcode_settings').ifm[0].contentDocument.designMode = 'on';
		if(!$("#rte_" + $(this).attr('id')).contents().find("body").hasClass('editorWYSIWYG')) {
			$("#rte_" + $(this).attr('id')).contents().find("head").append('<LINK REL="STYLESHEET" TYPE="text/css" HREF="css/main_index.css">');
	    	$("#rte_" + $(this).attr('id')).contents().find("body")
		    	.css({'margin':'0px 0px 0px 0px','background':'#ffffff'})
		    	.addClass('editorWYSIWYG');
		}
	},
	bbcode_getStyle: function(el,styleProp) { return $("#" + el).css(styleProp); },
	bbcode_ShowEditor: function() {
	    if (!$(this).data('bbcode_settings').enableWysiwyg) return;
	    $(this).data('bbcode_settings').editorVisible = true;
	    $(this).data('bbcode_settings').content = $(this).val();
	    $(this).bbcode2html();
	    $("#rte_" + $(this).attr('id')).contents().find("body").html($(this).data('bbcode_settings').content);
		$(this).bbcode_initIframe();
	},
	bbcode_SwitchEditor: function() {
	    if ($(this).data('bbcode_settings').editorVisible) {
	    	$(this).bbcode_doCheck();
	    	$(this).data('bbcode_settings').ifm.css('display', 'none');
	    	$(this).css('display', '');
	    	$(this).data('bbcode_settings').editorVisible = false;
	    }
	    else {
	        if ($(this).data('bbcode_settings').enableWysiwyg && $(this).data('bbcode_settings').ifm.length > 0) {
	        	$(this).data('bbcode_settings').ifm.css('display', '');
	        	$(this).css('display', 'none');
	        	$(this).bbcode_ShowEditor();
	        	$(this).data('bbcode_settings').editorVisible = true;
	        }
	    }
	},
	html2bbcode: function() {
		$(this).bbcode_rep(/<img\s[^<>]*?src=\"?([^<>]*?)\"?(\s[^<>]*)?\/?>/gi,"[img]$1[/img]");
		$(this).bbcode_rep(/<\/(strong|b)>/gi, "[/b]");
		$(this).bbcode_rep(/<(strong|b)(\s[^<>]*)?>/gi,"[b]");
		$(this).bbcode_rep(/<\/(em|i)>/gi,"[/i]");
		$(this).bbcode_rep(/<(em|i)(\s[^<>]*)?>/gi,"[i]");
		$(this).bbcode_rep(/<\/u>/gi, "[/u]");
		$(this).bbcode_rep(/\n/gi, " ");
		$(this).bbcode_rep(/\r/gi, " ");
		$(this).bbcode_rep(/<u(\s[^<>]*)?>/gi, "[u]");
		$(this).bbcode_rep(/<div><br(\s[^<>]*)?>/gi, "<div>");//chrome-safari fix to prevent double linefeeds
		$(this).bbcode_rep(/<br(\s[^<>]*)?>/gi,"\n");
		$(this).bbcode_rep(/<p(\s[^<>]*)?>/gi,"");
		$(this).bbcode_rep(/<\/p>/gi, "\n");
		$(this).bbcode_rep(/<ul>/gi, "[ul]");
		$(this).bbcode_rep(/<\/ul>/gi, "[/ul]");
		$(this).bbcode_rep(/<ol>/gi, "[ol]");
		$(this).bbcode_rep(/<\/ol>/gi, "[/ol]");
		$(this).bbcode_rep(/<li>/gi, "[li]");
		$(this).bbcode_rep(/<\/li>/gi, "[/li]");
		$(this).bbcode_rep(/<\/div>\s*<div([^<>]*)>/gi, "</span>\n<span$1>");//chrome-safari fix to prevent double linefeeds
		$(this).bbcode_rep(/<div([^<>]*)>/gi,"\n<span$1>");
		$(this).bbcode_rep(/<\/div>/gi,"</span>\n");
		$(this).bbcode_rep(/&nbsp;/gi," ");
		$(this).bbcode_rep(/&quot;/gi,"\"");
		$(this).bbcode_rep(/&amp;/gi,"&");
		var sc, sc2;
		do {
			sc = $(this).data('bbcode_settings').content;
			$(this).bbcode_rep(/<font\s[^<>]*?color=\"?([^<>]*?)\"?(\s[^<>]*)?>([^<>]*?)<\/font>/gi,"[color=$1]$3[/color]");
			if(sc==$(this).data('bbcode_settings').content)
				$(this).bbcode_rep(/<font[^<>]*>([^<>]*?)<\/font>/gi,"$1");
			$(this).bbcode_rep(/<a\s[^<>]*?href=\"?([^<>]*?)\"?(\s[^<>]*)?>([^<>]*?)<\/a>/gi,"[url=$1]$3[/url]");
			sc2 = $(this).data('bbcode_settings').content;
			$(this).bbcode_rep(/<(span|blockquote|pre)\s[^<>]*?style=\"?font-weight: ?bold;?\"?\s*([^<]*?)<\/\1>/gi,"[b]<$1 style=$2</$1>[/b]");
			$(this).bbcode_rep(/<(span|blockquote|pre)\s[^<>]*?style=\"?font-weight: ?normal;?\"?\s*([^<]*?)<\/\1>/gi,"<$1 style=$2</$1>");
			$(this).bbcode_rep(/<(span|blockquote|pre)\s[^<>]*?style=\"?font-style: ?italic;?\"?\s*([^<]*?)<\/\1>/gi,"[i]<$1 style=$2</$1>[/i]");
			$(this).bbcode_rep(/<(span|blockquote|pre)\s[^<>]*?style=\"?font-style: ?normal;?\"?\s*([^<]*?)<\/\1>/gi,"<$1 style=$2</$1>");
			$(this).bbcode_rep(/<(span|blockquote|pre)\s[^<>]*?style=\"?text-decoration: ?underline;?\"?\s*([^<]*?)<\/\1>/gi,"[u]<$1 style=$2</$1>[/u]");
			$(this).bbcode_rep(/<(span|blockquote|pre)\s[^<>]*?style=\"?text-decoration: ?none;?\"?\s*([^<]*?)<\/\1>/gi,"<$1 style=$2</$1>");
			$(this).bbcode_rep(/<(span|blockquote|pre)\s[^<>]*?style=\"?color: ?([^<>]*?);\"?\s*([^<]*?)<\/\1>/gi, "[color=$2]<$1 style=$3</$1>[/color]");
			$(this).bbcode_rep(/<(span|blockquote|pre)\s[^<>]*?style=\"?font-family: ?([^<>]*?);\"?\s*([^<]*?)<\/\1>/gi, "[font=$2]<$1 style=$3</$1>[/font]");
			$(this).bbcode_rep(/<(blockquote|pre)\s[^<>]*?style=\"?\"? (class=|id=)([^<>]*)>([^<>]*?)<\/\1>/gi, "<$1 $2$3>$4</$1>");
			$(this).bbcode_rep(/<pre>([^<>]*?)<\/pre>/gi, "[code]$1[/code]");
			$(this).bbcode_rep(/<span\s[^<>]*?style=\"?\"?>([^<>]*?)<\/span>/gi, "$1");
			if(sc2==$(this).data('bbcode_settings').content) {
				$(this).bbcode_rep(/<span[^<>]*>([^<>]*?)<\/span>/gi, "$1");
				sc2 = $(this).data('bbcode_settings').content;
			}
		} while(sc!=$(this).data('bbcode_settings').content);
			$(this).bbcode_rep(/<[^<>]*>/gi,"");
		$(this).bbcode_rep(/&lt;/gi,"<");
		$(this).bbcode_rep(/&gt;/gi,">");
		
		do {
			sc = $(this).data('bbcode_settings').content;
			$(this).bbcode_rep(/\[(b|i|u)\]\[quote([^\]]*)\]([\s\S]*?)\[\/quote\]\[\/\1\]/gi, "[quote$2][$1]$3[/$1][/quote]");
			$(this).bbcode_rep(/\[color=([^\]]*)\]\[quote([^\]]*)\]([\s\S]*?)\[\/quote\]\[\/color\]/gi, "[quote$2][color=$1]$3[/color][/quote]");
			$(this).bbcode_rep(/\[(b|i|u)\]\[code\]([\s\S]*?)\[\/code\]\[\/\1\]/gi, "[code][$1]$2[/$1][/code]");
			$(this).bbcode_rep(/\[color=([^\]]*)\]\[code\]([\s\S]*?)\[\/code\]\[\/color\]/gi, "[code][color=$1]$2[/color][/code]");
		} while(sc!=$(this).data('bbcode_settings').content);

		//clean up empty tags
		do {
			sc = $(this).data('bbcode_settings').content;
			$(this).bbcode_rep(/\[b\]\[\/b\]/gi, "");
			$(this).bbcode_rep(/\[i\]\[\/i\]/gi, "");
			$(this).bbcode_rep(/\[u\]\[\/u\]/gi, "");
			$(this).bbcode_rep(/\[url=([^\]]+)\]\[\/url\]/gi, "");
			$(this).bbcode_rep(/\[img\]\[\/img\]/gi, "");
			$(this).bbcode_rep(/\[color=([^\]]*)\]\[\/color\]/gi, "");
		} while(sc!=$(this).data('bbcode_settings').content);
	},
	bbcode2html: function() {
		// example: [b] to <strong>
		$(this).bbcode_rep(/\</gi,"&lt;"); //removing html tags
		$(this).bbcode_rep(/\>/gi,"&gt;");
		
		$(this).bbcode_rep(/\n/gi, "<br />");
		$(this).bbcode_rep(/\[ul\]/gi, "<ul>");
		$(this).bbcode_rep(/\[\/ul\]/gi, "</ul>");
		$(this).bbcode_rep(/\[ol\]/gi, "<ol>");
		$(this).bbcode_rep(/\[\/ol\]/gi, "</ol>");
		$(this).bbcode_rep(/\[li\]/gi, "<li>");
		$(this).bbcode_rep(/\[\/li\]/gi, "</li>");
		if($(this).data('bbcode_settings').browser) {
			$(this).bbcode_rep(/\[b\]/gi,"<strong>");
			$(this).bbcode_rep(/\[\/b\]/gi,"</strong>");
			$(this).bbcode_rep(/\[i\]/gi,"<em>");
			$(this).bbcode_rep(/\[\/i\]/gi,"</em>");
			$(this).bbcode_rep(/\[u\]/gi,"<u>");
			$(this).bbcode_rep(/\[\/u\]/gi,"</u>");
		}else {
			$(this).bbcode_rep(/\[b\]/gi,"<span style=\"font-weight: bold;\">");
			$(this).bbcode_rep(/\[i\]/gi,"<span style=\"font-style: italic;\">");
			$(this).bbcode_rep(/\[u\]/gi,"<span style=\"text-decoration: underline;\">");
			$(this).bbcode_rep(/\[\/(b|i|u)\]/gi,"</span>");
		}
		$(this).bbcode_rep(/\[img\]([^\"]*?)\[\/img\]/gi,"<img src=\"$1\" />");
		var sc;
		do {
			sc = $(this).data('bbcode_settings').content;
			$(this).bbcode_rep(/\[url=([^\]]+)\]([\s\S]*?)\[\/url\]/gi,"<a href=\"$1\">$2</a>");
			$(this).bbcode_rep(/\[url\]([\s\S]*?)\[\/url\]/gi,"<a href=\"$1\">$1</a>");
			if($(this).data('bbcode_settings').browser) {
				$(this).bbcode_rep(/\[color=([^\]]*?)\]([\s\S]*?)\[\/color\]/gi, "<font color=\"$1\">$2</font>");
				$(this).bbcode_rep(/\[font=([^\]]*?)\]([\s\S]*?)\[\/font\]/gi, "<font face=\"$1\">$2</font>");
			} else {
				$(this).bbcode_rep(/\[color=([^\]]*?)\]([\s\S]*?)\[\/color\]/gi, "<span style=\"color: $1;\">$2</span>");
				$(this).bbcode_rep(/\[font=([^\]]*?)\]([\s\S]*?)\[\/font\]/gi, "<span style=\"font-family: $1;\">$2</span>");
			}
			$(this).bbcode_rep(/\[code\]([\s\S]*?)\[\/code\]/gi,"<pre>$1</pre>&nbsp;");
		}while(sc!=$(this).data('bbcode_settings').content);
	},
	bbcode_doCheck: function() {
		if (!$(this).data('bbcode_settings').editorVisible) {
			$(this).bbcode_ShowEditor();
	    }
		$(this).data('bbcode_settings').content = $("#rte_" + $(this).attr('id')).contents().find("body").html();
		$(this).html2bbcode();
		$(this).val($(this).data('bbcode_settings').content);
	},
	bbcode_stopEvent: function(evt){
		evt || window.event;
		if (evt.stopPropagation){
			evt.stopPropagation();
			evt.preventDefault();
		}else if(typeof evt.cancelBubble != "undefined"){
			evt.cancelBubble = true;
			evt.returnValue = false;
		}
		return false;
	},
	bbcode_doQuote: function() {
	    if ($(this).data('bbcode_settings').editorVisible) {
	    	$(this).data('bbcode_settings').ifm[0].contentWindow.focus();
	        if ($(this).data('bbcode_settings').isIE) {
	        	$(this).data('bbcode_settings').textRange = $(this).data('bbcode_settings').ifm[0].contentWindow.document.selection.createRange();
	            var newTxt = "[quote=]" + $(this).data('bbcode_settings').textRange.text + "[/quote]";
	            $(this).data('bbcode_settings').textRange.text = newTxt;
	        }
	        else {
	            var edittext = $(this).data('bbcode_settings').ifm[0].contentWindow.getSelection().getRangeAt(0);
	            var original = edittext.toString();
	            edittext.deleteContents();
	            edittext.insertNode(document.createTextNode("[quote=]" + original + "[/quote]"));
	        }
	    }
	    else {
	    	$(this).bbcode_AddTag('[quote=]', '[/quote]');
	    }
	},
	bbcode_kp: function(e){
		if(/msie/.test(navigator.userAgent.toLowerCase()))
			var k = e.keyCode;
		else
			var k = e.which;
		if(k==13) {
			if(/msie/.test(navigator.userAgent.toLowerCase())) {
			    var r = this.selection.createRange();
			    if (r.parentElement().tagName.toLowerCase() != "li") {
			        r.pasteHTML('<br/>');
			        if (r.move('character'))
			            r.move('character', -1);
			        r.select();
			        $.bbcode_stopEvent(e);
			        return false;
			    }
			}
		}else
			$(this).data('bbcode_settings').enter = 0;
	},
	bbcode_InsertSmile: function(txt) {
		$(this).bbcode_InsertText(txt);
	    $('#divSmilies').css('display', 'none');
	},
	bbcode_InsertYoutube: function() {
		$(this).bbcode_InsertText("http://www.youtube.com/watch?v=XXXXXXXXXXX");
	},
	bbcode_InsertText: function(txt) {
	    if ($(this).data('bbcode_settings').editorVisible)
	    	$(this).bbcode_insertHtml(txt);
	    else
	    	$(this).val($(this).val() + txt);
	},
	bbcode_doClick: function (command) {
	    if ($(this).data('bbcode_settings').editorVisible) {
	    	$(this).data('bbcode_settings').ifm[0].contentWindow.focus();
	    	$(this).data('bbcode_settings').ifm[0].contentWindow.document.execCommand(command, false, null);
	    }
	    else {
	        switch (command) {
	            case 'bold':
	            	$(this).bbcode_AddTag('[b]', '[/b]'); break;
	            case 'italic':
	            	$(this).bbcode_AddTag('[i]', '[/i]'); break;
	            case 'underline':
	            	$(this).bbcode_AddTag('[u]', '[/u]'); break;
	            case 'InsertUnorderedList':
	            	$(this).bbcode_AddTag('[ul][li]', '[/li][/ul]'); break;
	        }
	    }
	},
	bbcode_doColor: function(color) {
		$(this).data('bbcode_settings').ifm[0].contentWindow.focus();
	  if ($(this).data('bbcode_settings').isIE) {
		  $(this).data('bbcode_settings').textRange = $(this).data('bbcode_settings').ifm[0].contentWindow.document.selection.createRange();
		  $(this).data('bbcode_settings').textRange.select();
	  }
	  $(this).data('bbcode_settings').ifm[0].contentWindow.document.execCommand('forecolor', false, color);
	},
	bbcode_doLink: function() {
	    if ($(this).data('bbcode_settings').editorVisible) {
	    	$(this).data('bbcode_settings').ifm[0].contentWindow.focus();
	        var mylink = prompt("Enter a URL:", "http://");
	        if ((mylink != null) && (mylink != "")) {
	            if ($(this).data('bbcode_settings').isIE) { //IE
	                var range = $(this).data('bbcode_settings').ifm[0].contentWindow.document.selection.createRange();
	                if (range.text == '') {
	                    range.pasteHTML("<a href='" + mylink + "'>" + mylink + "</a>");
	                }
	                else
	                	$(this).data('bbcode_settings').ifm[0].contentWindow.document.execCommand("CreateLink", false, mylink);
	            }
	            else if (window.getSelection) { //FF
	                var userSelection = $(this).data('bbcode_settings').ifm[0].contentWindow.getSelection().getRangeAt(0);
	                if(userSelection.toString().length==0)
	                	$(this).data('bbcode_settings').ifm[0].contentWindow.document.execCommand('inserthtml', false, "<a href='" + mylink + "'>" + mylink + "</a>");
	                else
	                	$(this).data('bbcode_settings').ifm[0].contentWindow.document.execCommand("CreateLink", false, mylink);
	            }
	            else
	            	$(this).data('bbcode_settings').ifm[0].contentWindow.document.execCommand("CreateLink", false, mylink);
	        }
	    }
	    else {
	    	$(this).bbcode_AddTag('[url=',']click here[/url]');
	    }
	},
	bbcode_doImage: function() {
	    if ($(this).data('bbcode_settings').editorVisible) {
	    	$(this).data('bbcode_settings').ifm[0].contentWindow.focus();
	        myimg = prompt('Enter Image URL:', 'http://');
	        if ((myimg != null) && (myimg != "")) {
	        	$(this).data('bbcode_settings').ifm[0].contentWindow.document.execCommand('InsertImage', false, myimg);
	        }
	    }
	    else {
	    	$(this).bbcode_AddTag('[img]', '[/img]');
	    }
	},
	bbcode_insertHtml: function(html) {
		$(this).data('bbcode_settings').ifm[0].contentWindow.focus();
	    if ($(this).data('bbcode_settings').isIE)
	    	$(this).data('bbcode_settings').ifm[0].contentWindow.document.selection.createRange().pasteHTML(html);
	    else
	    	$(this).data('bbcode_settings').ifm[0].contentWindow.document.execCommand('inserthtml', false, html);
	},
	bbcode_MozillaInsertText: function(text, pos) { //textarea-mode functions
		$(this).val($(this).val().slice(0, pos) + text + $(this).val().slice(pos));
	},
	bbcode_AddTag: function(t1, t2) {
	    if ($(this).data('bbcode_settings').isIE) {
	        if (document.selection) {
	        	$(this)[0].focus();

	            var txt = $(this).val();
	            var str = document.selection.createRange();

	            if (str.text == "") {
	                str.text = t1 + t2;
	            }
	            else if (txt.indexOf(str.text) >= 0) {
	                str.text = t1 + str.text + t2;
	            }
	            else {
	            	$(this).val(txt + t1 + t2);
	            }
	            str.select();
	        }
	    }
	    else if (typeof($(this)[0].selectionStart) != 'undefined') {
	        var sel_start = $(this)[0].selectionStart;
	        var sel_end = $(this)[0].selectionEnd;
	        $(this).bbcode_MozillaInsertText(t1, sel_start);
	        $(this).bbcode_MozillaInsertText(t2, sel_end + t1.length);
	        $(this)[0].selectionStart = sel_start;
	        $(this)[0].selectionEnd = sel_end + t1.length + t2.length;
	        $(this)[0].focus();
	    }
	    else {
	    	$(this).val($(this).val() + t1 + t2);
	    }
	},
	bbcode_getScrollY: function() { //=======color picker
		var scrOfX = 0, scrOfY = 0; 
		if (typeof (window.pageYOffset) == 'number') { 
			scrOfY = window.pageYOffset; scrOfX = window.pageXOffset; 
		} else if (document.body && (document.body.scrollLeft || document.body.scrollTop)) { 
			scrOfY = document.body.scrollTop; scrOfX = document.body.scrollLeft; 
		} else if (document.documentElement && (document.documentElement.scrollLeft || document.documentElement.scrollTop)) { 
			scrOfY = document.documentElement.scrollTop; scrOfX = document.documentElement.scrollLeft; 
		} 
		return scrOfY; 
	},
	bbcode_getTop2: function() { 
		csBrHt = 0; 
		if (typeof (window.innerWidth) == 'number') { 
			csBrHt = window.innerHeight; 
		} else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) { 
			csBrHt = document.documentElement.clientHeight; 
		} else if (document.body && (document.body.clientWidth || document.body.clientHeight)) { 
			csBrHt = document.body.clientHeight; 
		} 
		ctop = ((csBrHt / 2) - 115) + $(this).bbcode_getScrollY(); 
		return ctop; 
	},
	bbcode_getLeft2: function() { 
		var csBrWt = 0; 
		if (typeof (window.innerWidth) == 'number') { 
			csBrWt = window.innerWidth; 
		} else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) { 
			csBrWt = document.documentElement.clientWidth; 
		} else if (document.body && (document.body.clientWidth || document.body.clientHeight)) { 
			csBrWt = document.body.clientWidth; 
		} 
		cleft = (csBrWt / 2) - 125; 
		return cleft; 
	},
	bbcode_setCCbldID2: function(val) { //function setCCbldID2(val, textBoxID) { document.getElementById(textBoxID).value = val; }
		if ($(this).data('bbcode_settings').editorVisible) $(this).bbcode_doColor(val); 
		else $(this).bbcode_AddTag('[color=' + val + ']', '[/color]'); 
	},
	bbcode_setCCbldSty2: function(objID, prop, val) {
	    switch (prop) {
	        case "bc": if (objID != 'none') { $("#" + objID).css('backgroundColor', val); }; break;
	        case "vs": $("#" + objID).css('visibility', val); break;
	        case "ds": $("#" + objID).css('display', val); break;
	        case "tp": $("#" + objID).css('top', val); break;
	        case "lf": $("#" + objID).css('left', val); break;
	    }
	},
	bbcode_putOBJxColor2: function(Samp, pigMent, textBoxId) { 
		if (pigMent != 'x') { 
			$(this).bbcode_setCCbldID2(pigMent, textBoxId); 
			$(this).bbcode_setCCbldSty2(Samp, 'bc', pigMent); 
		} 
		$(this).bbcode_setCCbldSty2('colorpicker201', 'vs', 'hidden'); 
		$(this).bbcode_setCCbldSty2('colorpicker201', 'ds', 'none'); 
	},
	bbcode_showColorGrid2: function(Sam, e) {
		var textBoxId = '';
	    var objX = new Array('00', '33', '66', '99', 'CC', 'FF');
	    var c = 0;
	    var xl = "'" + Sam + "','x', '" + textBoxId + "'"; var mid = '';
	    mid += '<table bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #F0F0F0;padding:2px;"><tr>';
	    mid += "<td colspan='9' align='left' style='margin:0;padding:2px;height:12px;' ><input class='o5582n66' type='text' size='12' id='o5582n66' value='#FFFFFF'><input class='o5582n66a' type='text' size='2' style='width:14px;' id='o5582n66a' onclick='javascript:alert(\"click on selected swatch below...\");' value='' style='border:solid 1px #666;'></td><td colspan='9' align='right'><a class='o5582n66' href='' onclick=\"$('#" + $(this).attr("id") + "').bbcode_putOBJxColor2(" + xl + "); return false;\"'><span class='a01p3'>" + $(this).data('bbcode_settings').clos1 + "</span></a></td></tr><tr>";
	    var br = 1;
	    for (o = 0; o < 6; o++) {
	        mid += '</tr><tr>';
	        for (y = 0; y < 6; y++) {
	            if (y == 3) { mid += '</tr><tr>'; }
	            for (x = 0; x < 6; x++) {
	                var grid = '';
	                grid = objX[o] + objX[y] + objX[x];
	                var b = "'" + Sam + "','" + grid + "', '" + textBoxId + "'";
	                mid += '<td class="o5582brd" style="background-color:#' + grid + '"><a class="o5582n66"  href="" onclick="$(\'#' + $(this).attr("id") + '\').bbcode_putOBJxColor2(' + b + '); return false;" onmouseover="$(\'#o5582n66\').val(\'#' + grid + '\'); $(\'#o5582n66a\').css(\'background-color\',\'#' + grid + '\');"  title="#' + grid + '"><div style="width:12px;height:14px;"></div></a></td>';
	                c++;
	            }
	        }
	    }
	    mid += "</tr></table>";
	    //var ttop=getTop2();
	    $(this).bbcode_setCCbldSty2('colorpicker201','tp', e.pageY + 'px');
	    $(this).bbcode_setCCbldSty2('colorpicker201','lf', e.pageX + 'px');
	    //document.getElementById('colorpicker201').style.left=getLeft2();
	    $('#colorpicker201').html(mid);
	    $(this).bbcode_setCCbldSty2('colorpicker201', 'vs', 'visible');
	    $(this).bbcode_setCCbldSty2('colorpicker201', 'ds', 'inline');
	}
});