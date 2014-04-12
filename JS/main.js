function log(msg)
{
	if(typeof(console) != "undefined") {
		console.log(msg);
	}
}

$(function (e) {
    /**
    * JS Links
    **/
    $('.jsLink, .jslink').live('click', function (e) {
        e.preventDefault();
        $(this).blur();
    });
});

function init_forum() {
	if (!$("#forum").length)
		return;
		
	/**
	* bbCode control by subBlue design [ www.subBlue.com ]
	* Includes unixsafe colour palette selector by SHS`
	*/
	
	// Startup variables
	var imageTag = false;
	var theSelection = false;
	
	// Check for Browser & Platform for PC & IE specific bits
	// More details from: http://www.mozilla.org/docs/web-developer/sniffer/browser_type.html
	var clientPC = navigator.userAgent.toLowerCase(); // Get client info
	var clientVer = parseInt(navigator.appVersion); // Get browser version
	
	var is_ie = ((clientPC.indexOf('msie') != -1) && (clientPC.indexOf('opera') == -1));
	var is_win = ((clientPC.indexOf('win') != -1) || (clientPC.indexOf('16bit') != -1));
	
	var baseHeight;
	//onload_functions.push('initInsertions()');
	
	/**
	* Shows the help messages in the helpline window
	*/
	function helpline(help)
	{
		document.forms[form_name].helpbox.value = help_line[help];
	}
	
	/**
	* Fix a bug involving the TextRange object. From
	* http://www.frostjedi.com/terra/scripts/demo/caretBug.html
	*/ 
	function initInsertions() 
	{
		var doc;
	
		if ($("#forum #" + form_name).length)
		{
			doc = document;
		}
		else if (opener)
		{
			doc = opener.document;
		}
		else
		{
			return;
		}
	
		var textarea = doc.forms[form_name].elements[text_name];
	
	/*	if (is_ie && typeof(baseHeight) != 'number')
		{
			textarea.focus();
			baseHeight = doc.selection.createRange().duplicate().boundingHeight;
	
			if (!document.forms[form_name])
			{
				document.body.focus();
			}
		}
	*/
	}
	
	/**
	* bbstyle
	*/
	function bbstyle(bbnumber)
	{	
		if (bbnumber != -1)
		{
			bbfontstyle(bbtags[Number(bbnumber)], bbtags[Number(bbnumber)+1]);
		} 
		else 
		{
			insert_text('[*]');
			document.forms[form_name].elements[text_name].focus();
		}
	}
	
	/**
	* Apply bbcodes
	*/
	function bbfontstyle(bbopen, bbclose)
	{
		theSelection = false;
		
		var textarea = document.forms[form_name].elements[text_name];
	
		textarea.focus();
	
		if ((clientVer >= 4) && is_ie && is_win)
		{
			// Get text selection
			theSelection = document.selection.createRange().text;
	
			if (theSelection)
			{
				// Add tags around selection
				document.selection.createRange().text = bbopen + theSelection + bbclose;
				document.forms[form_name].elements[text_name].focus();
				theSelection = '';
				return;
			}
		}
		else if (document.forms[form_name].elements[text_name].selectionEnd && (document.forms[form_name].elements[text_name].selectionEnd - document.forms[form_name].elements[text_name].selectionStart > 0))
		{
			mozWrap(document.forms[form_name].elements[text_name], bbopen, bbclose);
			document.forms[form_name].elements[text_name].focus();
			theSelection = '';
			return;
		}
		
		//The new position for the cursor after adding the bbcode
		var caret_pos = getCaretPosition(textarea).start;
		var new_pos = caret_pos + bbopen.length;		
	
		// Open tag
		insert_text(bbopen + bbclose);
	
		// Center the cursor when we don't have a selection
		// Gecko and proper browsers
		if (!isNaN(textarea.selectionStart))
		{
			textarea.selectionStart = new_pos;
			textarea.selectionEnd = new_pos;
		}	
		// IE
		else if (document.selection)
		{
			var range = textarea.createTextRange(); 
			range.move("character", new_pos); 
			range.select();
			storeCaret(textarea);
		}
	
		textarea.focus();
		return;
	}
	
	/**
	* Insert text at position
	*/
	function insert_text(text, spaces, popup)
	{
		var textarea;
		
		if (!popup) 
		{
			textarea = document.forms[form_name].elements[text_name];
		} 
		else 
		{
			textarea = opener.document.forms[form_name].elements[text_name];
		}
		if (spaces) 
		{
			text = ' ' + text + ' ';
		}
		
		if (!isNaN(textarea.selectionStart))
		{
			var sel_start = textarea.selectionStart;
			var sel_end = textarea.selectionEnd;
	
			mozWrap(textarea, text, '')
			textarea.selectionStart = sel_start + text.length;
			textarea.selectionEnd = sel_end + text.length;
		}
		else if (textarea.createTextRange && textarea.caretPos)
		{
			if (baseHeight != textarea.caretPos.boundingHeight) 
			{
				textarea.focus();
				storeCaret(textarea);
			}
	
			var caret_pos = textarea.caretPos;
			caret_pos.text = caret_pos.text.charAt(caret_pos.text.length - 1) == ' ' ? caret_pos.text + text + ' ' : caret_pos.text + text;
		}
		else
		{
			textarea.value = textarea.value + text;
		}
		if (!popup) 
		{
			textarea.focus();
		}
	}
	
	/**
	* Add inline attachment at position
	*/
	function attach_inline(index, filename)
	{
		insert_text('[attachment=' + index + ']' + filename + '[/attachment]');
		document.forms[form_name].elements[text_name].focus();
	}
	
	/**
	* Add quote text to message
	*/
	function addquote(post_id, username)
	{
		var message_name = 'message_' + post_id;
		var theSelection = '';
		var divarea = false;
	
		if (document.all)
		{
			divarea = document.all[message_name];
		}
		else
		{
			divarea = document.getElementById(message_name);
		}
	
		// Get text selection - not only the post content :(
		if (window.getSelection)
		{
			theSelection = window.getSelection().toString();
		}
		else if (document.getSelection)
		{
			theSelection = document.getSelection();
		}
		else if (document.selection)
		{
			theSelection = document.selection.createRange().text;
		}
	
		if (theSelection == '' || typeof theSelection == 'undefined' || theSelection == null)
		{
			if (divarea.innerHTML)
			{
				theSelection = divarea.innerHTML.replace(/<br>/ig, '\n');
				theSelection = theSelection.replace(/<br\/>/ig, '\n');
				theSelection = theSelection.replace(/&lt\;/ig, '<');
				theSelection = theSelection.replace(/&gt\;/ig, '>');
				theSelection = theSelection.replace(/&amp\;/ig, '&');
				theSelection = theSelection.replace(/&nbsp\;/ig, ' ');
			}
			else if (document.all)
			{
				theSelection = divarea.innerText;
			}
			else if (divarea.textContent)
			{
				theSelection = divarea.textContent;
			}
			else if (divarea.firstChild.nodeValue)
			{
				theSelection = divarea.firstChild.nodeValue;
			}
		}
	
		if (theSelection)
		{
			insert_text('[quote="' + username + '"]' + theSelection + '[/quote]');
		}
	
		return;
	}
	
	/**
	* From http://www.massless.org/mozedit/
	*/
	function mozWrap(txtarea, open, close)
	{
		var selLength = txtarea.textLength;
		var selStart = txtarea.selectionStart;
		var selEnd = txtarea.selectionEnd;
		var scrollTop = txtarea.scrollTop;
	
		if (selEnd == 1 || selEnd == 2) 
		{
			selEnd = selLength;
		}
	
		var s1 = (txtarea.value).substring(0,selStart);
		var s2 = (txtarea.value).substring(selStart, selEnd)
		var s3 = (txtarea.value).substring(selEnd, selLength);
	
		txtarea.value = s1 + open + s2 + close + s3;
		txtarea.selectionStart = selEnd + open.length + close.length;
		txtarea.selectionEnd = txtarea.selectionStart;
		txtarea.focus();
		txtarea.scrollTop = scrollTop;
	
		return;
	}
	
	/**
	* Insert at Caret position. Code from
	* http://www.faqts.com/knowledge_base/view.phtml/aid/1052/fid/130
	*/
	function storeCaret(textEl)
	{
		if (textEl.createTextRange)
		{
			textEl.caretPos = document.selection.createRange().duplicate();
		}
	}
	
	/**
	* Color pallette
	*/
	function colorPalette(dir, width, height)
	{
		var r = 0, g = 0, b = 0;
		var numberList = new Array(6);
		var color = '';
	
		numberList[0] = '00';
		numberList[1] = '40';
		numberList[2] = '80';
		numberList[3] = 'BF';
		numberList[4] = 'FF';
	
		document.writeln('<table cellspacing="1" cellpadding="0" border="0">');
	
		for (r = 0; r < 5; r++)
		{
			if (dir == 'h')
			{
				document.writeln('<tr>');
			}
	
			for (g = 0; g < 5; g++)
			{
				if (dir == 'v')
				{
					document.writeln('<tr>');
				}
				
				for (b = 0; b < 5; b++)
				{
					color = String(numberList[r]) + String(numberList[g]) + String(numberList[b]);
					document.write('<td bgcolor="#' + color + '" style="width: ' + width + 'px; height: ' + height + 'px;">');
					document.write('<a href="#" onclick="bbfontstyle(\'[color=#' + color + ']\', \'[/color]\'); return false;"><img src="images/spacer.gif" width="' + width + '" height="' + height + '" alt="#' + color + '" title="#' + color + '" /></a>');
					document.writeln('</td>');
				}
	
				if (dir == 'v')
				{
					document.writeln('</tr>');
				}
			}
	
			if (dir == 'h')
			{
				document.writeln('</tr>');
			}
		}
		document.writeln('</table>');
	}
	
	
	/**
	* Caret Position object
	*/
	function caretPosition()
	{
		var start = null;
		var end = null;
	}
	
	
	/**
	* Get the caret position in an textarea
	*/
	function getCaretPosition(txtarea)
	{
		var caretPos = new caretPosition();
		
		// simple Gecko/Opera way
		if(txtarea.selectionStart || txtarea.selectionStart == 0)
		{
			caretPos.start = txtarea.selectionStart;
			caretPos.end = txtarea.selectionEnd;
		}
		// dirty and slow IE way
		else if(document.selection)
		{
		
			// get current selection
			var range = document.selection.createRange();
	
			// a new selection of the whole textarea
			var range_all = document.body.createTextRange();
			range_all.moveToElementText(txtarea);
			
			// calculate selection start point by moving beginning of range_all to beginning of range
			var sel_start;
			for (sel_start = 0; range_all.compareEndPoints('StartToStart', range) < 0; sel_start++)
			{		
				range_all.moveStart('character', 1);
			}
		
			txtarea.sel_start = sel_start;
		
			// we ignore the end value for IE, this is already dirty enough and we don't need it
			caretPos.start = txtarea.sel_start;
			caretPos.end = txtarea.sel_start;			
		}
	
		return caretPos;
	}
	
	function init_form () {
		initInsertions();
	}
	
	function init_reply_form() {
		form_name = 'reply_form_small';
		text_name = 'ADATA[MESSAGE]';
		$("#forum #form-comment-add input[TYPE=hidden]").attr("disabled", "disabled");
		$("#forum #form-comment-add #comment_ac, #forum #form-comment-add #comment_section, #forum #form-comment-add #comment_cat_tag").removeAttr("disabled");
		init_form();
	}
		
	var form_name = 'create_topics_form';
	var text_name = 'ADATA[MESSAGE]';
	var load_draft = false;
	var upload = false;

	// Define the bbCode tags
	var bbcode = new Array();
	var bbtags = new Array('[b]','[/b]','[i]','[/i]','[u]','[/u]','[quote]','[/quote]','[code]','[/code]','[list]','[/list]','[list=]','[/list]','[img]','[/img]','[url]','[/url]','[flash=]', '[/flash]','[size=]','[/size]');
	var imageTag = false;

	// Helpline messages
	var help_line = {
		b: 'Bold: [b]text[/b]',
		i: 'Italic: [i]text[/i]',
		u: 'Underlined: [u]text[/u]',
		q: 'Quote: [quote]text[/quote]',
		c: 'Code: [code]code[/code]',
		l: 'List: [list]text[/list]',
		o: 'Numbered list: [list=]text[/list]',
		p: 'Insert image: [img]http://image_url[/img]',
		w: 'Insert hyperlink: [url]http://url[/url] or [url=http://url]URL text[/url]',
		a: 'Insert attachment: [attachment=]filename.ext[/attachment]',
		s: 'Font color: [color=red]text[/color] You can also use this construction: color=#FF0000',
		f: 'Font size: [size=85]small text[/size]',
		e: 'List: add an element',
		d: 'Flash: [flash=width,height]http://url[/flash]'
			}

	var panels = new Array('');
	var show_panel = '';

	$("#forum .create_topic").click(function(){
		$("#forum .s-msg-edit, #forum .s-msg-quote, #forum .s-msg-reply, #forum .add-new-topic, #forum .add_new_post_button, #forum .s-msg-del, #forum .create_topic").hide();
		$("#forum .new-topic-cancel").show();
		$("#forum #form_topics").insertAfter('#forum #forum_cat_list_end');
		$("#forum #form_topics").show();
		form_name = 'create_topics_form';
		text_name = 'DATA[MESSAGE]';
		init_form();
		$("#forum #form_topics #PICT1").attr("name","DATA[PICT1]");
		location.href = '#NEWTOPIC';
		return 1;
	});
	$("#forum .forum_subscribe").click(function(){
		if (confirm($(this).attr("rel") + ' "' + $(this).attr("title") + '"?')) {
			$("#forum #forum_subscribe_form #subscribe_topic_id").attr("value", $(this).attr("href"));
			$("#forum #forum_subscribe_form #subscribe_message").attr("value", 1);
			$("#forum #forum_subscribe_form").submit();
		}
	});
	$("#forum .forum_unsubscribe").click(function(){
		if (confirm($(this).attr("rel") + ' "' + $(this).attr("title") + '"?')) {
			$("#forum #forum_subscribe_form #subscribe_topic_id").attr("value", $(this).attr("href"));
			$("#forum #forum_subscribe_form #unsubscribe_message").attr("value", 1);
			$("#forum #forum_subscribe_form").submit();
		}
	});
	$("#forum .new-topic-cancel").click(function(){
		$("#forum #form_topics").hide();
		$("#forum .s-msg-edit, #forum .s-msg-quote, #forum .s-msg-reply, #forum .add-new-topic, #forum .add_new_post_button, #forum .s-msg-del, #forum .create_topic").show();
	});
	$("#forum .insert_smiley").click(function(){
		insert_text($(this).attr("alt"), $(this).attr("href"));
	});
	$("#forum .insert_bbcode").click(function(){
		bbstyle($(this).attr("href"));
	});
	$("#forum #create_topics_form").submit(function(){
		//apply_rich_editor_text('create_topics_form', 'MESSAGE');
		res = generic_mandatory_check($(this).attr("name"), 'FORM_VALIDATOR', 'Validation Number')
  			  + generic_mandatory_check(form_name, '$NAME_NAME', 'Topic')
 			  + generic_mandatory_check(form_name, '$MESSAGE_NAME', '$MESSAGE_CAPTION');
 		if (res!=''){
 			alert(res);
 			return false;
 		}
 		return true;
	});
	$("#forum .clear_form").click(function(){
		var parent = $(this).parents("form").get(0);
		var parent_id = '#' + $(parent).attr("id");
		$(parent_id + " textarea").attr("value", "");
	});
	$("#forum .fold").click(function(){
		$("#forum .forum_comment_content2hide").hide();
		$("#forum .forum_attach_content2hide").hide();
		setCookie('forum_posts_opened', 0, "", "/");
	});
	$("#forum .unfold").click(function(){
		$("#forum .forum_comment_content2hide").show();
		$("#forum .forum_attach_content2hide").show();
		setCookie('forum_posts_opened', 1, "", "/");
	});
	if (!isNaN(getCookie('forum_posts_opened')))
	{
		if (getCookie('forum_posts_opened')=='1') {
			$("#forum .forum_comment_content2hide").show();
			$("#forum .forum_attach_content2hide").show();
		}
	}
	$("#forum .s-msg-cancel").click(function(){
		var parent = $(this).parents("div.forum_post").get(0);
		var parent_id = '#' + $(parent).attr("id");
		$("#forum #form-comment-edit, #form-comment-add").hide();
		$("#forum .s-msg-edit, #forum .s-msg-quote, #forum .s-msg-reply, #forum .add-new-topic, #forum .add_new_post_button, #forum .s-msg-del, #forum .create_topic").show();
	});
	$("#forum .add_new_post_button").click(function(){
		init_reply_form();
		$("#forum #form-comment-add #comment_catid").removeAttr("disabled");
		$("#forum #form-comment-add #comment_catid").attr("value", $(this).attr("rel"));
		$("#forum #form-comment-add #comment_ac").attr("value", "insert");
		$("#forum #form-comment-add #comment_MESSAGE").attr("value", "");
		$("#forum #form-comment-add").insertAfter('#forum #topic_posts_bar');
		$("#forum #form-comment-add").show();
		$("#forum #form-comment-add #PICT1").attr("name","ADATA[PICT1]");
		$("#forum .s-msg-edit, #forum .s-msg-quote, #forum .s-msg-reply, #forum .add-new-topic, #forum .add_new_post_button, #forum .s-msg-del, #forum .create_topic").hide();
		location.href = '#write-comment';
	});
	$("#forum .s-msg-reply").click(function(){
		init_reply_form();
		var parent = $(this).parents("div.forum_post").get(0);
		var parent_id = '#' + $(parent).attr("id");
		$("#forum " + parent_id + " .forum_comment_content2hide").toggle();
		$("#forum " + parent_id + " .forum_attach_content2hide").toggle();
		$("#forum #form-comment-add #comment_PARENT_ID, #forum #form-comment-add #comment_LEVEL, #forum #form-comment-add #comment_subject, #forum #form-comment-add #comment_username, #forum #form-comment-add #comment_catid").removeAttr("disabled");
		$("#forum #form-comment-add #comment_PARENT_ID").attr("value", $("#ID_" + $(parent).attr("id")).attr("value"));
		$("#forum #form-comment-add #comment_LEVEL").attr("value", parseInt($("#LEVEL_" + $(parent).attr("id")).attr("value")) + 1);
		$("#forum #form-comment-add #comment_ac").attr("value", "insert");
		$("#forum #form-comment-add #comment_MESSAGE").attr("value", "");
		$("#forum #form-comment-add").insertAfter('#forum #attach' + $("#ID_" + $(parent).attr("id")).attr("value"));
		$("#forum #form-comment-add").show();
		$("#forum #form-comment-add #PICT1").attr("name","ADATA[PICT1]");
		$("#forum .s-msg-edit, #forum .s-msg-quote, #forum .s-msg-reply, #forum .add-new-topic, #forum .add_new_post_button, #forum .s-msg-del, #forum .create_topic").hide();
		location.href = '#write-comment';
	});
	$("#forum .s-msg-quote").click(function(){
		init_reply_form();
		var parent = $(this).parents("div.forum_post").get(0);
		var parent_id = '#' + $(parent).attr("id");
		$("#forum " + parent_id + " .forum_comment_content2hide").toggle();
		$("#forum " + parent_id + " .forum_attach_content2hide").toggle();
		$("#forum #form-comment-add #comment_PARENT_ID, #forum #form-comment-add #comment_LEVEL, #forum #form-comment-add #comment_subject, #forum #form-comment-add #comment_username, #forum #form-comment-add #comment_catid").removeAttr("disabled");
		$("#forum #form-comment-add #comment_PARENT_ID").attr("value", $("#ID_" + $(parent).attr("id")).attr("value"));
		$("#forum #form-comment-add #comment_LEVEL").attr("value", parseInt($("#LEVEL_" + $(parent).attr("id")).attr("value")) + 1);
		$("#forum #form-comment-add #comment_ac").attr("value", "insert");
		$("#forum #form-comment-add #comment_MESSAGE").attr("value", "[quote=" + $("#AUTHOR_" + $(parent).attr("id")).attr("value") + "]" + $("#CODE_" + $(parent).attr("id")).attr("value") + "[/quote]");
		$("#forum #form-comment-add").insertAfter('#forum #attach' + $("#ID_" + $(parent).attr("id")).attr("value"));
		$("#forum #form-comment-add").show();
		$("#forum #form-comment-add #PICT1").attr("name","ADATA[PICT1]");
		$("#forum .s-msg-edit, #forum .s-msg-quote, #forum .s-msg-reply, #forum .add-new-topic, #forum .add_new_post_button, #forum .s-msg-del, #forum .create_topic").hide();
		location.href = '#write-comment';
	});
	$("#forum .s-msg-edit").click(function(){
		init_reply_form();
		var parent = $(this).parents("div.forum_post").get(0);
		var parent_id = '#' + $(parent).attr("id");
		$("#forum " + parent_id + " .forum_comment_content2hide").toggle();
		$("#forum " + parent_id + " .forum_attach_content2hide").toggle();
		$("#forum #form-comment-add #edit_ID").removeAttr("disabled");
		$("#forum #form-comment-add #edit_ID").attr("value", $("#ID_" + $(parent).attr("id")).attr("value"));
		$("#forum #form-comment-add #comment_ac").attr("value", "update");
		$("#forum #form-comment-add #comment_MESSAGE").attr("value", $("#CODE_" + $(parent).attr("id")).attr("value"));
		$("#forum #form-comment-add").insertAfter('#forum #attach' + $("#ID_" + $(parent).attr("id")).attr("value"));
		$("#forum #form-comment-add").show();
		$("#forum #form-comment-add #PICT1").attr("name","ADATA[PICT1]");
		$("#forum .s-msg-edit, #forum .s-msg-quote, #forum .s-msg-reply, #forum .add-new-topic, #forum .add_new_post_button, #forum .s-msg-del, #forum .create_topic").hide();
		location.href = '#write-comment';
	});
	$("#forum .post_header").click(function(){
		var parent = $(this).parents("div.forum_post").get(0);
		var parent_id = $(parent).attr("id");
		$("#forum #comment" + $("#ID_" + parent_id).attr("value")).toggle();
		$("#forum #attach" + $("#ID_" + parent_id).attr("value")).toggle();
	});
	
}

function init_bbcode_wysiwyg() {
	if(!$(".bbcode_wysiwyg").length)
		return;
	$(".bbcode_wysiwyg").bbcode_wysiwyg();
}

function init_comments() {
	if (!$("#comments").length)
		return;

	$(".s-msg-reply").click(function(){
		var parent = $(this).parents("div.info").get(0);
		var parent_id = '#' + $(parent).attr("id");
		$("#COMMENT").html('[quote=' + $("#AUTHOR_" + $(parent).attr("id")).text() + ']' + $("#SOURCE_" + $(parent).attr("id")).text() + '[/quote]');
		$("#comment_PARENT_ID").attr("value", $("#ID_" + $(parent).attr("id")).text());
		$("#comment_LEVEL").attr("value", parseInt($("#LEVEL_" + $(parent).attr("id")).text() + 1));
		$("#comment_PARENT_ID").removeAttr("disabled");
		$("#comment_LEVEL").removeAttr("disabled");
		$("#form-comment-add").insertAfter('#comment' + $("#ID_" + $(parent).attr("id")).text());
		$(".s-msg-reply, .s-msg-add, .s-msg-top").hide();
		$("#form-comment-add").show();
		setTimeout(function(){
			$("#comments").find(".bbcode_wysiwyg").each(function(i,obj){
				$(obj).bbcode_initIframe();
			});
		},1000);
		return false;
	});
	$(".s-msg-add").click(function(){
		$("#comment_PARENT_ID").attr("disabled", "disabled");
		$("#comment_LEVEL").attr("disabled", "disabled");
		$("#comment_PARENT_ID").attr("value", "");
		$("#comment_LEVEL").attr("value", "");
		$("#COMMENT").html("");
		$("#form-comment-add").insertAfter('#comments_form_start_position');
		$(".s-msg-reply, .s-msg-add, .s-msg-top").hide();
		$("#form-comment-add").show();
		setTimeout(function(){
			$("#comments").find(".bbcode_wysiwyg").each(function(i,obj){
				$(obj).bbcode_initIframe();
			});
		},1000);
		return false;
	});
	$(".s-msg-cancel").click(function(){
		$("#comment_PARENT_ID").attr("disabled", "disabled");
		$("#comment_LEVEL").attr("disabled", "disabled");
		$("#comment_PARENT_ID").attr("value", "");
		$("#comment_LEVEL").attr("value", "");
		$("#COMMENT").html("");
		$("#form-comment-add").hide();
		$("#form-comment-add").insertAfter('#comments_form_start_position');
		$(".s-msg-reply, .s-msg-add, .s-msg-top").show();
		return false;
	});
}

function init_lightbox() {
	if (!$(".lightbox").length)
		return ;
	$.each($("a.lightbox_single"),function(i,obj){
		$(obj).lightBox();
	});
	$(".lightbox").lightBox();
}

function init_after_login_return() {
	$('.after_login_return').click(function() {
		//alert("You should login");
		setCookie('after_login_return_url',document.location.href,'','/');
		//location.href="/login/";
	});
}

function init_after_logout_return() {
	$('.after_logout_return').click(function() {
		//alert("You should login");
		setCookie('after_logout_return_url',document.location.href,'','/');
		//location.href="/login/";
	});
	$('.after_logout_return2home').click(function() {
		//alert("You should login");
		setCookie('after_logout_return_url',$("SPAN#SITEHOME").text(),'','/');
		//location.href="/login/";
	});
}

function init_non_auth_message() {
	$(".non_auth").click(function(){
		alert($(this).attr("title"));
		location.href = $(this).attr("href");
	});
}

function init_gallery() {
		if (!$('div.gallery_full_list').length)
			return;
		jQuery.easing.easeOutQuart = function (x, t, b, c, d) {
			return -c * ((t=t/d-1)*t*t*t - 1) + b;
		};
			$('div.gallery_full_list').serialScroll({
				//target:'.gallery_full_list',
				items:'li', // Selector to the items ( relative to the matched elements, '#sections' in this case )
				prev:'.gallery_nav_prev',// Selector to the 'prev' button (absolute!, meaning it's relative to the document)
				next:'.gallery_nav_next',// Selector to the 'next' button (absolute too)
				axis:'x',// The default is 'y' scroll on both ways
				//navigation:'#greybox_m img.nav_first, #navigation_hidden a, #greybox_m img.nav_last',
				duration:700,// Length of the animation (if you scroll 2 axes and use queue, then each axis take half this time)
				force:true, // Force a scroll to the element specified by 'start' (some browsers don't reset on refreshes)
				
				//queue:false,// We scroll on both axes, scroll both at the same time.
				//event:'click',// On which event to react (click is the default, you probably won't need to specify it)
				//stop:false,// Each click will stop any previous animations of the target. (false by default)
				//lock:true, // Ignore events if already animating (true by default)		
				//start: 0, // On which element (index) to begin ( 0 is the default, redundant in this case )		
				//cycle:true,// Cycle endlessly ( constant velocity, true is the default )
				//step:1, // How many items to scroll each time ( 1 is the default, no need to specify )
				//jump:false, // If true, items become clickable (or w/e 'event' is, and when activated, the pane scrolls to them)
				//lazy:false,// (default) if true, the plugin looks for the items on each event(allows AJAX or JS content, or reordering)
				//interval:1000, // It's the number of milliseconds to automatically go to the next
				//constant:true, // constant speed
				
				onBefore:function( e, elem, $pane, $items, pos ){
					 //those arguments with a $ are jqueryfied, elem isn't.
					e.preventDefault();
					if( this.blur )
						this.blur();
				},
				onAfter:function( elem ){
					//'this' is the element being scrolled ($pane) not jqueryfied
				}
			});
}

function init_confirmations() {
	if (!$(".confirmation").length && !$(".open_confirmation").length)
		return;
	$(".confirmation").dialog({
		bgiframe: true,
		resizable: false,
		height: 350,
		autoOpen: false,
		modal: true,
		overlay: {
			backgroundColor: '#000',
			opacity: 0.5
		},
		buttons: {
			'I agree to terms and conditions': function() {
				$("#" + $(this).attr("rel")).attr('checked','checked');
				$(this).dialog('close');
			},
			Cancel: function() {
				$("#" + $(this).attr("rel")).removeAttr('checked');
				$(this).dialog('close');
			}
		}
	});
	$(".open_confirmation")
		.css({'cursor':'pointer'})
		.click(function() {
			$("#" + $(this).attr("rel")).dialog('open');
			return false;
		});
}

function init_msgbox() {
	$(".msgBox").each(function(i,obj){
		var height_val = $(obj).attr('height')?$(obj).attr('height'):350;
		var width_val = $(obj).attr('width')?$(obj).attr('width'):600;
		$(obj).dialog({
			height: height_val * 1,
			width: width_val * 1,
			autoOpen: false
		});
	});
	$(".open_msgBox")
		.css({'cursor':'pointer'})
		.click(function() {
			$("#" + $(this).attr("rel")).dialog('open');
			return false;
		});
}

function init_slideshow() {
	if (!$(".start_gallery_slideshow").length || !$(".start_slideshow_here").length)
		return;
	$VisualLightBoxParams$ = {autoPlay:true,borderSize:39,enableSlideshow:true,overlayOpacity:0,startZoom:true};
	init_lightslideshow();
	$(".start_slideshow_here").click();
	$(".start_gallery_slideshow")
		.css({'cursor':'pointer'})
		.click(function(){
			$("#firstimg").click();
		});
}

function init_on_focus_replace() {
	$.each($('.on_focus_replace'),function(i,obj){
		if(!$(obj).attr('title').length && $(obj).attr('value').length)
			$(obj).attr('title',$(obj).attr('value'));
		if(!$(obj).attr('value').length)
			$(obj).attr('value',$(obj).attr('title'));
	});		
	$('.on_focus_replace')
		.live('focus', function() {
			$(this).attr('value',($(this).attr('value')==$(this).attr('title')?'':$(this).attr('value')));
		})
		.live('blur', function() {
			$(this).attr('value',($(this).attr('value')==''?$(this).attr('title'):$(this).attr('value')));
		});
}
/*
function init_on_focus_replace() {
	$.each($('.on_focus_replace'),function(i,obj){
		if(!$(obj).attr('title').length && $(obj).attr('value').length)
			$(obj).attr('title',$(obj).attr('value'));
		if(!$(obj).attr('value').length)
			$(obj).attr('value',$(obj).attr('title'));
	});		
	$('.on_focus_replace')
		.focus(function() {
			$(this).attr('value',($(this).attr('value')==$(this).attr('title')?'':$(this).attr('value')));
		})
		.blur(function() {
			$(this).attr('value',($(this).attr('value')==''?$(this).attr('title'):$(this).attr('value')));
		});
}*/

function init_fading_tabs() {
	$.each($('.tabs_listing'),function(i,obj){
		$(obj).innerfade({
			speed: 2000, //tabs switching speed in milliseconds
			timeout: 4000, //timeout between switching on next tab in milliseconds
			containerheight: $(obj).css("height"), //tabs container height (important for absolute positioned containers)
			el: i //the key in the Buffer array for this tabs set
		});
	});

}

function correct_zindex4menu(selector4_zindex_correction){
	$(selector4_zindex_correction).css({'z-index':'20'});
	$(selector4_zindex_correction +' li').css({'z-index':'20'});
	$(selector4_zindex_correction +' li ul').css({'z-index':'30'});
	$(selector4_zindex_correction +' li ul li').css({'z-index':'30'});
}


function get_parent_div_of_class(element, class_name){
	while ($(element).parent().length){
		element = $(element).parent();
		if ($(element).hasClass(class_name))
			break;
	}
	/*while(pp = $(element).parent().length){
		
	}*/
	return element;
}



/////////////////////////////////////
///Mandatory fields validation
////////////////////////////////////


function luhn_check(number) {
	if (number=='4222222222222222') //Work around for Auth.net test card
      	return true;

  // Strip any non-digits (useful for credit card numbers with spaces and hyphens)
  var number=number.replace(/\D/g, '');
 
  // Set the string length and parity
  var number_length=number.length;
  var parity=number_length % 2;
 
  // Loop through each digit and do the maths
  var total=0;
  for (i=0; i < number_length; i++) {
    var digit=number.charAt(i);
    // Multiply alternate digits by two
    if (i % 2 == parity) {
      digit=digit * 2;
      // If the sum is two digits, add them together (in effect)
      if (digit > 9) {
        digit=digit - 9;
      }
    }
    // Total up the digits
    total = total + parseInt(digit);
  }
 
  // If the total mod 10 equals 0, the number is valid
  if (total % 10 == 0) {
    return true;
  } else {
    return false;
  }
}


function isValidCreditCard(type, ccnum) {
	if (!type)
		type = 'VISA';
	re = '';
   if (type == "VISA") {
   		if (ccnum=='4222222222222222') //Work around for Auth.net test card
      		return true;
      // Visa: length 16, prefix 4, dashes optional.
      var re = /^4\d{3}-?\d{4}-?\d{4}-?\d{4}$/;
   } else if (type == "MASTERCARD") {
      // Mastercard: length 16, prefix 51-55, dashes optional.
      var re = /^5[1-5]\d{2}-?\d{4}-?\d{4}-?\d{4}$/;
   } else if (type == "ISRACARD") {
      // Isracard: length 8-9, no known prefix, dashes optional.
      var re = /^\d{0,1}-?\d{4}-?\d{4}$/;
   } else if (type == "DISCOVER") {
      // Discover: length 16, prefix 6011, dashes optional.
      var re = /^6011-?\d{4}-?\d{4}-?\d{4}$/;
   } else if (type == "AMEX") {
      // American Express: length 15, prefix 34 or 37.
      var re = /^3[4,7]\d{13}$/;
   } else if (type == "DINERS") {
      // Diners: length 14, prefix 30, 36, or 38.
      var re = /^3[0,6,8]\d{12}$/;
   } else if (type == "JCB") {
      // JCB: length 16, prefix 35 , dashes optional.
      var re = /^35-?\d{4}-?\d{4}-?\d{4}$/;;
   }
   if (re=='' || ccnum=='')
   		 return false;
   if (!re.test(ccnum)) return false;
   if (type == "ISRACARD")
   		return true;
   // Remove all dashes for the checksum checks to eliminate negative numbers
   ccnum = ccnum.split("-").join("");
   // Checksum ("Mod 10")
   // Add even digits in even length strings or odd digits in odd length strings.
   var checksum = 0;
   for (var i=(2-(ccnum.length % 2)); i<=ccnum.length; i+=2) {
      checksum += parseInt(ccnum.charAt(i-1));
   }
   
   // Analyze odd digits in even length strings or even digits in odd length strings.
   for (var i=(ccnum.length % 2) + 1; i<ccnum.length; i+=2) {
      var digit = parseInt(ccnum.charAt(i-1)) * 2;
      if (digit < 10) { checksum += digit; } else { checksum += (digit-9); }
   }
   if ((checksum % 10) == 0) return true; else return false;
}

/* start form validation general function */
function validate_any_form(frm){
	
		$(frm).find("IFRAME.mandatory_selected").contents().find("body").removeClass('mandatory_selected');
		$(frm).find("INPUT, SELECT, TEXTAREA, LABEL, IFRAME").removeClass('mandatory_selected');
		$(frm).find("DIV.form_err_message").hide();
		$(frm).find("DIV.form_err_message DIV.checkbox_mandatory_error").hide();
		
		$("INPUT[name='FORM_VALIDATOR']").addClass('mandatory');
		
		var msg = '';
			

		if ($(frm).find("INPUT.mail, INPUT#EMAIL").length){
			email_filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

			$(frm).find("INPUT.mail, INPUT#EMAIL").each(function(){
				if(($(this).attr('value')!='')&& !email_filter.test($(this).attr('value'))){
					$(this).addClass('mandatory_selected');
					if (msg=='')
						msg = 'Entered e-mail is wrong';
				}
			});
} /* end emial checking */

/*check email by css */
if ($(frm).find(".validateemail").length) {
    email_filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

    $(frm).find(".validateemail").each(function () {
        if (($(this).attr('value') != '') && !email_filter.test($(this).attr('value'))) {
            $(this).addClass('mandatory_selected');
            if (msg == '')
                msg = 'Entered e-mail is wrong';
        }
    });
}


		$(frm).find("DIV.form_err_message SPAN.form_email_error").hide();
		if (msg!='')
			$(frm).find("DIV.form_err_message SPAN.form_email_error").show();
		

		$(frm).find("DIV.form_err_message SPAN.form_currency_error").hide();	
		$(frm).find("INPUT.currency").each(function(){
			
			if(($(this).attr('value')!='') && (Number($(this).attr('value')).toFixed(2) != $(this).attr('value'))){
				//alert(Number($(this).attr('value')).toFixed(2) + ':' + $(this).attr('value'));
				$(this).addClass('mandatory_selected');
				if (msg!='') msg+="\n<br>";
					msg+= 'Wrong number format for currency field';
				$(this.form).find("DIV.form_err_message SPAN.form_currency_error").show();
			}
		});
		

		$(frm).find("DIV.form_err_message SPAN.form_password_error").hide();		
		$(frm).find("DIV.form_err_message SPAN.form_mandatory_error").hide();		
		$(frm).find("DIV.form_err_message SPAN.form_cc_error").hide();		
		
		if (($(frm).find("INPUT[TYPE=password]").length>1) &&
			$(frm).find("INPUT#PASSWORD1").length &&
			$(frm).find("INPUT#PASSWORD2").length &&
			($(frm).find("INPUT#PASSWORD1").attr('value') != $(frm).find("INPUT#PASSWORD2").attr('value'))
		){

			$(frm).find("INPUT#PASSWORD1").addClass('mandatory_selected');
			$(frm).find("INPUT#PASSWORD2").addClass('mandatory_selected');
			$(frm).find("DIV.form_err_message SPAN.form_password_error").show();
			if (msg) msg+='<br>';
			msg+= 'Passwords do not match, please try again...';
		}
		
		var checkbox_mandatory_error = '';
		var checkbox_mandatory_selected = false;
		$(frm).find("INPUT[TYPE=checkbox].mandatory").each(function(i,obj){
			if(!$(obj).attr('checked')) {
				$(obj).addClass('mandatory_selected');
				$('LABEL[FOR=' + $(obj).attr("id") + ']').addClass('mandatory_selected');
				if ($(obj).attr("title")!='') {
					if (checkbox_mandatory_error) checkbox_mandatory_error+='<br>';
					if (msg) msg+='<br>';
					msg+= checkbox_mandatory_error+= $(obj).attr("title");
				} else {
					checkbox_mandatory_selected = true;
				}
			}
		});
		if (checkbox_mandatory_error.length > 0) {
			if (!$(frm).find("DIV.form_err_message DIV.checkbox_mandatory_error").length)
				$(frm).find("DIV.form_err_message").prepend('<div class="checkbox_mandatory_error"></div>')
			$(frm).find("DIV.form_err_message DIV.checkbox_mandatory_error").html(checkbox_mandatory_error).show();
			$(frm).find("DIV.form_err_message").show();
		}
		
		$("TEXTAREA.mandatory").each(function(i,obj){
			var val1 = $(obj).val();
			var val2 = $.trim($(obj).val());
			if(val2.length > 0 || val1 == val2)
				return;
			$(obj).val($.trim($(obj).val()));
			if($(obj).hasClass('editorBBCODE') && $(obj).data('bbcode_settings').editorVisible) {
			    $(obj).data('bbcode_settings').content = $(obj).val();
			    $(obj).bbcode2html();
			    $("#rte_" + $(obj).attr('id')).contents().find("body").html($(obj).data('bbcode_settings').content);
			}
		});
		if ($(frm).find("INPUT.mandatory, SELECT.mandatory, TEXTAREA.mandatory").not('[value!=""]').length || checkbox_mandatory_selected){
			if (msg) msg+='<br>';
			msg+= 'Please fill up missing fields below';
			$(frm).find("DIV.form_err_message SPAN.form_mandatory_error").show();
		}
		if ($(frm).find("INPUT.mandatory.on_focus_replace, TEXTAREA.mandatory.on_focus_replace").length){
			var err_on_focus_replace = false;
			$(frm).find("INPUT.mandatory.on_focus_replace, TEXTAREA.mandatory.on_focus_replace").each(function(i,obj){
				if($(obj).attr("value") == $(obj).attr("title")) {
					err_on_focus_replace = true;
					$(obj).addClass("mandatory_selected");
				}
			});
if (err_on_focus_replace) {
    msg = "";
				if (msg) msg+='<br>';
				msg+= 'Please fill up missing fields below';
				$(frm).find("DIV.form_err_message SPAN.form_mandatory_error").show();
			}
		}
		if ($(frm).find("INPUT#CC_NUMBER").length && $(frm).find("#CC_TYPE").length &&
			$(frm).find("INPUT#CC_NUMBER").hasClass('mandatory')){
			
			
			$(frm).find("DIV.form_err_message SPAN.form_cc_error").hide();
			cc_v = $(frm).find("INPUT.mandatory#CC_NUMBER").attr('value');
			cc_t = $(frm).find("#CC_TYPE").attr('value');
			if (!isValidCreditCard(cc_t, cc_v) || (cc_t!='ISRACARD' && !luhn_check(cc_v))){
				if (msg) msg+='<br>';
				msg+=' Credit Card is invalid';
				$(frm).find("DIV.form_err_message SPAN.form_cc_error").show();
				$(frm).find("INPUT.mandatory#CC_NUMBER").addClass('mandatory_selected');
			}
		
			
		}
	
		
		if (msg=='')
			return true;
		$(frm).find("INPUT.mandatory, SELECT.mandatory, TEXTAREA.mandatory").not('[value!=""]').addClass('mandatory_selected');
		$(frm).find(".mandatory_selected:first").focus();
		if (!$(frm).find("DIV.form_err_message").length){
			$(frm).prepend('<div class="form_err_message error_mesage">'+msg+'</div>');
		}
		$(frm).find("TEXTAREA.mandatory_selected.editorBBCODE").each(function(i,obj){
			var parent = $(obj).parents("*").get(0);
			$(parent).find("iframe.frm_editorBBCODE").addClass('mandatory_selected');
			$(parent).find("iframe.frm_editorBBCODE").contents().find("body").addClass('mandatory_selected');
		});
		$(frm).find("DIV.form_err_message").show();
		if ($(frm).find("DIV.form_err_message").html()=='')
			$(frm).find("DIV.form_err_message").html(msg);

		return false;
}

function init_form_validation(){

    

	if (!$("FORM:has(INPUT.mandatory), FORM:has(SELECT.mandatory), FORM:has(TEXTAREA.mandatory)").length)
		return;
	$("INPUT.currency").blur(function(){
		if (($(this).attr('value') != '') && (Number($(this).attr('value')).toFixed(2)!='0.00') && (Number($(this).attr('value')).toFixed(2)!='NaN'))
			$(this).attr('value', Number($(this).attr('value')).toFixed(2));
	});

	$("FORM:has(INPUT.mandatory), FORM:has(SELECT.mandatory), FORM:has(TEXTAREA.mandatory)").submit(function(){
		return validate_any_form(this);
});



	$("TD.form_title + TD.form_field:has(INPUT.mandatory)").prev().find("SPAN").text('*').css('color','red');

	$("TD.form_title + :not(TD.form_field:has(INPUT.mandatory))").prev().find("SPAN").html('&nbsp; ').css('padding-left', '2px');


	/* login page validation bind */
	$(".but_login").bind("click", function () {
	    return validate_any_form(this);
	});


}

function init_job_offers_menu() {
	$(".seemore")
		.css({'cursor':'pointer'})
		.click(function(){
			var parent = $(this).parents("div.left_items_container").get(0);
			$(parent).find("div.hidden").removeClass("hidden");
			parent = $(this).parents("div").get(0);
			$(parent).addClass("hidden");
		});
	$(".search_submit_link")
		.css({'cursor':'pointer'})
		.click(function(){
			var id = $(this).attr("rel");
			$("#" + id).attr("value", $(this).text());
			$("#search_frm").submit();
		});
}

/******* DIALOG RELATED ****************/

function updateTips(t) {
	tips.text(t).effect("highlight",{},1500);
}

		

function checkLength(o,n,min,max) {
	if ( o.val().length > max || o.val().length < min ) {
		o.addClass('ui-state-error');
		updateTips("Length of " + n + " must be between "+min+" and "+max+".");
		return false;
	}
	return true;
}

function checkRegexp(o,regexp,n) {
	if ( !( regexp.test( o.val() ) ) ) {
		o.addClass('ui-state-error');
		updateTips(n);
		return false;
	}
	return true;
}

function init_contacts_form_dialog(){
	
	if ($('.contact_login_dialog_open').length){
			$('.contact_login_dialog_open').click(function() {
				alert("You should login to contact the member!");
				setCookie('after_login_return_url',document.location.href,'','/');
				location.href="/login/";
				return false;
			});
		return;
	}
	
	if(!$("#contact_dialog").length)
		return false;

	$('.contact_dialog_open').click(function() {
		$("#SRC_ID").attr("value", $(this).attr("rel"));
		$("#SENDER_NAME").attr("value", $("#CURRENT_USER_NAME").text());
		$("#SENDER_EMAIL").attr("value", $("#CURRENT_USER_EMAIL").text());
		$("#COMMENTS").attr("value", '');
		$('#contact_dialog').dialog('open');
		return false;
	});

	var name = $("#SENDER_NAME"),
		email = $("#SENDER_EMAIL"),
		text = $("#COMMENTS"),
		//captcha = $("#dialog_captcha"),
		allFields = $([]).add(name).add(email).add(text);//.add(captcha);
			
	$("#contact_dialog").dialog({
		bgiframe: true,
		autoOpen: false,
		height: 430,
		modal: true,
		buttons: {
			'Submit': function() {
				var bValid = true;
				allFields.removeClass('ui-state-error');

				bValid = bValid && checkLength(name,"Name",3,50);
				bValid = bValid && checkLength(email,"E-Mail",6,80);
				//bValid = bValid && checkLength(captcha,"Validation Code",5,5);
				bValid = bValid && checkLength(text,"Details",5,255);

				//bValid = bValid && checkRegexp(name,/^[a-z]([0-9a-z_])+$/i,"Username may consist of a-z, 0-9, underscores, begin with a letter.");
				// From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
				bValid = bValid && checkRegexp(email,/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i,"eg. info@welcomebiz.com ");
				/*" ))))*/
				//bValid = bValid && checkRegexp(password,/^([0-9a-zA-Z])+$/,"Password field only allow : a-z 0-9");
			
				if (bValid) {
					//$("#post_contact").submit();
					$(this).dialog('close');
					$.post("/mail.php", $("#post_contact").serialize(),function(data){
						if (data) {
							$("#post_contact_confirm").html(data);
							$("#post_contact_confirm").dialog('open');
						}
					});
				}
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		},
		close: function() {
			allFields.removeClass('ui-state-error');
		}
	});

	$("#post_contact_confirm").dialog({
		bgiframe: true,
		resizable: false,
		height: 50,
		width: 300,
		autoOpen: false,
		modal: true,
		buttons: {
			'OK': function() {
				$(this).dialog('close');
			}
		}
	});

}



function init_mega_menu(){
	if (!$('UL.mega_menu LI').length)
		return;
	var mega_menu_Config = {    
     interval: 100,
     timeout: 100,
     sensitivity: 4,
     over: function () {$(this).addClass("hovering");},
     out: function (){ $(this).removeClass("hovering");}
	}
	$('UL.mega_menu LI').hoverIntent(mega_menu_Config);
}

function init_calendar_selectors(){
	
	if (!$('#calendar_month').length)
		return;	
	if (!$('#calendar_month_selector').length)
		return;
	if (!$('#calendar_year').length)
		return;	
	if (!$('#calendar_year_selector').length)
		return;
		
	$('#calendar_month_selector_close').click(function(){
		$('#calendar_month_selector').hide();
	});
	
	$('#calendar_year_selector_close').click(function(){
		$('#calendar_year_selector').hide();
	});

	$('#calendar_month').click(function (e){
		el = $('#calendar_month_selector');
		el.css('position', 'absolute');
		el.css('left', $(this).offset().left);
		el.css('top', e.pageY - el.height()/2);
		el.show();
	})
	$('#calendar_year').click(function (e){
		el = $('#calendar_year_selector');
		el.css('position', 'absolute');
		el.css('left', $(this).offset().left);
		el.css('top', e.pageY - el.height()/2);
		el.show();
	})
}


function init_panel_scrollers() {
	if (!$('div.box_in').length)
		return;
	jQuery.easing.easeOutQuart = function (x, t, b, c, d) {
			return -c * ((t=t/d-1)*t*t*t - 1) + b;
	};
	$('div.box_in').each(function(){
		var scroll_exclude = typeof($(this).attr('exclude'))=='undefined'?3:$(this).attr('exclude')*1;
		var pref_arrow_id = '#' + (typeof($(this).attr('prev_arrow'))=='undefined'?'categories_index_prev':$(this).attr('prev_arrow'));
		var next_arrow_id = '#' + (typeof($(this).attr('next_arrow'))=='undefined'?'categories_index_next':$(this).attr('next_arrow'));
		var scroll_step = typeof($(this).attr('step'))=='undefined'?4:$(this).attr('step')*1;
		var scroll_duration = typeof($(this).attr('duration'))=='undefined'?500:$(this).attr('duration')*1;
		var scroll_direction = typeof($(this).attr('direction'))=='undefined'?'x':$(this).attr('direction');
		var scroll_cycle = typeof($(this).attr('cycle'))=='undefined'?false:($(this).attr('cycle')?true:false);
		$(this).serialScroll({
				//target:'.gallery_full_list',
				items:'li', // Selector to the items ( relative to the matched elements, '#sections' in this case )
				prev: pref_arrow_id,// Selector to the 'prev' button (absolute!, meaning it's relative to the document)
				next: next_arrow_id,// Selector to the 'next' button (absolute too)
				axis: scroll_direction,// The default is 'y' scroll on both ways
				//navigation:'#greybox_m img.nav_first, #navigation_hidden a, #greybox_m img.nav_last',
				duration: scroll_duration,// Length of the animation (if you scroll 2 axes and use queue, then each axis take half this time)
				force:true, // Force a scroll to the element specified by 'start' (some browsers don't reset on refreshes)
				cycle: scroll_cycle, //don't pull back once you reach the end
				//queue:false,// We scroll on both axes, scroll both at the same time.
				//event:'click',// On which event to react (click is the default, you probably won't need to specify it)
				//stop:false,// Each click will stop any previous animations of the target. (false by default)
				//lock:true, // Ignore events if already animating (true by default)		
				//start: 0, // On which element (index) to begin ( 0 is the default, redundant in this case )
				exclude:scroll_exclude,//Exclude n elements before end		
				step: scroll_step, // How many items to scroll each time ( 1 is the default, no need to specify )
				//jump:false, // If true, items become clickable (or w/e 'event' is, and when activated, the pane scrolls to them)
				//lazy:false,// (default) if true, the plugin looks for the items on each event(allows AJAX or JS content, or reordering)
				//interval:1000, // It's the number of milliseconds to automatically go to the next
				//constant:true, // constant speed
				
				onBefore:function( e, elem, $pane, $items, pos ){
					 //those arguments with a $ are jqueryfied, elem isn't.
					e.preventDefault();
					if( this.blur )
						this.blur();
				},
				onAfter:function( elem ){
					//'this' is the element being scrolled ($pane) not jqueryfied
				}
		});
	});
}

function init_date_pickers(){
	//alert($(".date_picker").eq(0).attr('value'));
	//dateFormat: get_date_format()
	$(".date_picker").datepicker({showOn: 'button', buttonImage: 'img/show-calendar.gif', buttonImageOnly: true});
	
}

function get_date_fornmat() {
	var format = 'mm-dd-yy';
	if($("meta[http-equiv=Content-Type]").attr('content').replace('text/html; charset=','').toLowerCase() == 'windows-1251') {
		$.datepicker.regional['ru'] = {
			closeText: 'Закрыть',
			prevText: '&#x3c;Пред',
			nextText: 'След&#x3e;',
			currentText: 'Сегодня',
			monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь',
			'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
			monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн',
			'Июл','Авг','Сен','Окт','Ноя','Дек'],
			dayNames: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота'],
			dayNamesShort: ['вск','пнд','втр','срд','чтв','птн','сбт'],
			dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
			weekHeader: 'Не',
			dateFormat: 'dd.mm.yy',
			firstDay: 1,
			isRTL: false,
			showMonthAfterYear: false,
			yearSuffix: ''};
		$.datepicker.setDefaults($.datepicker.regional['ru']);
		format = 'dd-mm-yy';
	}
	if($("meta[http-equiv=Content-Type]").attr('content').replace('text/html; charset=','').toLowerCase() == 'windows-1255')
		format = 'dd-mm-yy';
	return format;
}

function copy_paypal_email(){
	if (!$('#PAYPAL_SAMEAS_BILL').attr('checked'))
		return;
	if (!$('#PAY_PAL_EMAIL').length)
		return;
	if (!$('FORM#checkout_form #EMAIL').length){
			alert('Can not find source EMAIL field');
			return false;
	}
	$('#PAY_PAL_EMAIL').attr('value', $('FORM#checkout_form #EMAIL').attr('value'));
}


function use_billing_data4shipping(){
	if (!$('FORM#checkout_form #copydata').length)
		return false;
	if (!$('FORM#checkout_form #copydata').attr('checked'))
		return false;
	return true;
}

function copy_shipping_data(){
	if (!use_billing_data4shipping())
		return false;
	
	$('FORM#checkout_form .form_block#billing').find('INPUT, SELECT, TEXTAREA').each(function(){
		if ($('FORM#checkout_form #SHIP' +  $(this).attr('ID')).length)
			$('FORM#checkout_form #SHIP' +  $(this).attr('ID')).attr('value', $(this).attr('value'));
	});
	$('FORM#checkout_form #SHIPEMAIL').attr('value', $('FORM#checkout_form #EMAIL').attr('value'));
	$('FORM#checkout_form #SHIPCOUNTRY').change();
	return true;
}


function get_shipping_data(){
	if (!$('FORM#checkout_form #delivery').length)
		return;
	prefix = use_billing_data4shipping()?'':'SHIP';
	country_value4ajax = country_value = 'US';
	zip_value = '';
	
	if ($('FORM#checkout_form #'+prefix+'COUNTRY').length)
		country_value4ajax = country_value = $('FORM#checkout_form #'+prefix+'COUNTRY').attr('value');
	if ($('FORM#checkout_form #'+prefix+'ZIPCODE').length)	
		zip_value = $('FORM#checkout_form #'+prefix+'ZIPCODE').attr('value');
	
	if (country_value=='USA')
		country_value4ajax = country_value = 'US';
	if ((country_value!='US') && (country_value!='CA') && (country_value!='UK'))
		country_value = 'INT';
	if (typeof(region_visual_settings[country_value])=='undefined')
		country_value = 'INT';
	if (typeof(region_visual_settings[country_value])=='undefined')
		country_value = 'US';
	if (typeof(region_visual_settings[country_value])=='undefined'){
		alert('Error: shipping setting for country '+ country_value + ' is not found');
		return;
	}
		

	if (region_visual_settings[country_value+'_is_gateway']!='0')
		$('FORM#checkout_form #RESIDENTIAL_SELECTION_BLOCK').show();
	else
		$('FORM#checkout_form #RESIDENTIAL_SELECTION_BLOCK').hide();
	
	if (region_visual_settings[country_value+'_is_breaks']!='0'){
		$('FORM#checkout_form #delivery').hide();
		$('FORM#checkout_form #DELIVERY_BLOCK_TITLE').hide();
	}
	else{
		$('FORM#checkout_form #delivery').show();
		$('FORM#checkout_form #DELIVERY_BLOCK_TITLE').show();
		if (zip_value!=''){
			settings_id = region_visual_settings[country_value];
			is_res = '';
			if ($('FORM#checkout_form #RESIDENTIAL').length && ($('FORM#checkout_form #RESIDENTIAL').attr('checked') || ($('FORM#checkout_form #RESIDENTIAL').attr('TYPE')=='hidden' && ($('FORM#checkout_form #RESIDENTIAL').val()!=0))))
				is_res = '1';
			$('FORM#checkout_form #SHIPPING_METHOD').hide();
			$('FORM#checkout_form #SHIPPING_DEFAULT_STATUS_TEXT').hide();
			$('FORM#checkout_form #SHIPPING_CALCULATING_STATUS_TEXT').show();
			selected = '';
			var userid = '-1';
			if ($('#USERID').length)
				userid = $('#USERID').val();
			$.get('/cms/?section=plain_list&ac=shipping_choices_result&MODULE_PARAMS=SS_ID%3D'+settings_id+'%26ENTIRE_LIST_TEMPLATE%3Dcheckout_shipping_list.html%26ITEM_TEMPLATE%3Dcheckout_shipping_item.html%26PAGE_IDX%3D0%26WHERE%3D%26NUMONPAGE%3D100&params[ZIP]='+
		     zip_value + '&params[COUNTRY]='+ country_value4ajax + '&params[RESIDENTIAL]='+ is_res+'&'+Math.random()+selected+'&userid='+userid, 
				function(data) {
					$('FORM#checkout_form #SHIPPING_METHOD').html(data);
					$('FORM#checkout_form #SHIPPING_CALCULATING_STATUS_TEXT').hide();
					$('FORM#checkout_form #SHIPPING_METHOD').show();
				});

			
		}
	}
	
	
}

function init_country_state_block(prefix){
	var class_prefix;
	class_prefix = prefix != ''?prefix.toLowerCase()+'_':'';
	if ($('FORM #'+prefix+'COUNTRY').length != 1)
		return ;
	$('FORM #'+prefix+'COUNTRY').change(function(){
		$('.'+class_prefix+'state').hide().removeClass('mandatory').removeClass('mandatory_selected').attr('disabled', true);
		$('.'+class_prefix+'state').attr('disabled', true);
		$('.'+class_prefix+'state_caption').hide();
		if ($('#'+prefix+'STATE_'+$(this).attr('value')).length){
			$('#'+prefix+'STATE_'+$(this).attr('value')).addClass('mandatory').show().attr('disabled', false);
			$('#'+prefix+'STATE_CAPTION_'+$(this).attr('value')).show();
		}
		else
		if ($('#'+prefix+'ALT_STATE').length){
			$('#'+prefix+'ALT_STATE').show().attr('disabled', false);
			$('#'+prefix+'STATE_CAPTION_ALT').show();
		}
	});
	$('FORM #'+prefix+'COUNTRY').change();
}

function set_non_mandatory_fields_behavior(condition, $parent, add_selector) {
	if(condition)
		$parent.find('INPUT' + add_selector + ', SELECT' + add_selector + ', TEXTAREA' + add_selector).removeClass('mandatory');
	else
		$parent.find('INPUT' + add_selector + ', SELECT' + add_selector + ', TEXTAREA' + add_selector).addClass('mandatory');
}

function init_checkout_form(){
	if (!$('FORM#checkout_form').length)
		return;

	$('FORM#checkout_form').submit(function(){
		copy_paypal_email();
		if (!copy_shipping_data()){
			if($('FORM#checkout_form A#shipping_link').hasClass('closed'))
				$('FORM#checkout_form A#shipping_link').click();
		}
	});
	
	//Blocks opening and closing
	$('FORM#checkout_form DIV.title_background_checkout A:not(FORM#checkout_form DIV.title_background_checkout A.menu)').click(function(){
		if ($(this).attr('href')=='')
			return false;	
		$(this).toggleClass('closed');
		$('#'+$(this).attr('href')).toggleClass('form_block_hidden');
		if ($(this).attr('href')!='shipping')
			return false;

		if (!$(this).hasClass('closed')){
			$('FORM#checkout_form #copydata').attr('checked', false);
			$('FORM#checkout_form #SELECT_SHIPPING_ADDR_DIV').show();
			$('FORM#checkout_form #SAVE_SHIPPING_ADDR_DIV').show();
			if ($('FORM#checkout_form #SA_ID').val()!='')
				$('FORM#checkout_form #SA_ID').change();
		}

		set_non_mandatory_fields_behavior($('FORM#checkout_form #copydata').attr('checked'), $('#' + $(this).attr('href')), '.non_mandatory');
		return false;
	});
	
	$('FORM#checkout_form DIV.title_background_checkout A.menu').click(function(){
		$('#PMETHOD').attr('value', $(this).attr('ID'));
		$('FORM#checkout_form DIV.title_background_checkout A.menu').removeClass('menu_opened');
		$(this).addClass('menu_opened');
		$('FORM#checkout_form DIV.payment_method').hide();
		$('FORM#checkout_form DIV.payment_method .mandatory').removeClass('mandatory');
		$('#'+$(this).attr('href')).show();
		set_non_mandatory_fields_behavior(false, $('#'+$(this).attr('href')), '.non_mandatory');
		var $block = $('FORM#checkout_form A.'+$(this).attr('href') + '_block');
		if ($block.length){
			if ($block.hasClass('closed'))
				$block.click();
		}
		$.each($('FORM#checkout_form DIV.title_background_checkout A.menu'),function(i,obj){
			var $fields = $('FORM#checkout_form DIV.'+$(obj).attr('href') + '_fields');
			if ($fields.length){
				set_non_mandatory_fields_behavior(!$(obj).hasClass('menu_opened'), $fields, '');
			}
		});
		return false;
	});
	
	if ($('FORM#checkout_form #COUNTRY').length || $('FORM#checkout_form #SHIPCOUNTRY').length)
			get_shipping_data();
	
	while ($('FORM#checkout_form #PMETHOD').length){
		tmp_id = $('FORM#checkout_form #PMETHOD').attr('value');
		if ((tmp_id!='') && $('#' + tmp_id).length){
			$('#' + tmp_id).click();
			break;
		}
		$($('FORM#checkout_form DIV.title_background_checkout A.menu').get(0)).click();
		break;
		
	}
	
	
	$('FORM#checkout_form #PAYPAL_SAMEAS_BILL').click(function(){
		copy_paypal_email();
	});
	
	$('FORM#checkout_form #ZIPCODE').blur(function(){
		if (use_billing_data4shipping())
			get_shipping_data();
	});
	
	$('FORM#checkout_form #SHIPZIPCODE').blur(function(){
		if (!use_billing_data4shipping())
			get_shipping_data();
	});
	
	$('FORM#checkout_form #RESIDENTIAL').click(get_shipping_data);
	
	$('FORM#checkout_form #copydata').click(function(){
		$('FORM#checkout_form #SHIPASBILL').attr('value', $(this).attr('checked')?1:0);
		tmp= $('FORM#checkout_form A#shipping_link');
		if (!tmp.length)
			return;
		if (copy_shipping_data()){
			$('#'+tmp.attr('href')).find('INPUT.non_mandatory, SELECT.non_mandatory, TEXTAREA.non_mandatory').removeClass('mandatory').removeClass('mandatory_selected');
			$('FORM#checkout_form #SELECT_SHIPPING_ADDR_DIV').hide();
			$('FORM#checkout_form #SAVE_SHIPPING_ADDR_DIV').hide();
			return;
		}
		$('FORM#checkout_form #SELECT_SHIPPING_ADDR_DIV').show();
		$('FORM#checkout_form #SAVE_SHIPPING_ADDR_DIV').show();
		if ($('FORM#checkout_form #SA_ID').val()!='')
			$('FORM#checkout_form #SA_ID').change();
		
		if (tmp.hasClass('closed'))
			tmp.click();
		$('#'+tmp.attr('href')).find('INPUT.non_mandatory, SELECT.non_mandatory, TEXTAREA.non_mandatory').addClass('mandatory');
	});
	
	
	$('FORM#checkout_form #change_cc').click(function(){
		$('FORM#checkout_form #cc_number_star').hide();
		$('FORM#checkout_form #cvv_star').hide();
		$(this).hide();
		$('FORM#checkout_form #CC_NUMBER').addClass('non_mandatory').addClass('mandatory').attr('disabled', false).show();
		$('FORM#checkout_form #CVV').addClass('non_mandatory').addClass('mandatory').attr('disabled', false).show();
		return false;
	})
	
	$('FORM#checkout_form #SHIPSAVENEW').click(function(){
		$('FORM#checkout_form INPUT#ADDRNAME').attr('disabled', $(this).attr('checked')?0:1);
		if ($(this).attr('checked'))
			$('FORM#checkout_form INPUT#ADDRNAME').attr('value', $('#SA_ID :selected').text());
	})
	$('FORM#checkout_form SELECT#SA_ID').change(function(){
		if ($(this).val()==''){
			$('FORM#checkout_form .form_block#shipping INPUT, FORM#checkout_form .form_block#shipping SELECT, FORM#checkout_form .form_block#shipping TEXTAREA').attr('disabled', 0);
			$('FORM#checkout_form .form_block#shipping SELECT').attr('selectedIndex', 0);
			$('FORM#checkout_form .form_block#shipping INPUT').attr('value', '');
			$('FORM#checkout_form .form_block#shipping SELECT').attr('selectedIndex', 0);
			$('FORM#checkout_form .form_block#shipping #SHIPCOUNTRY').change();
			$('FORM#checkout_form #SHIPSAVENEW').attr('checked', true);
			$('FORM#checkout_form INPUT#ADDRNAME').attr('disabled', 0);
			$('FORM#checkout_form INPUT#ADDRNAME').val($('#SA_ID :selected').text());
			return;
		}
		$('FORM#checkout_form .form_block#shipping INPUT, FORM#checkout_form .form_block#shipping SELECT, FORM#checkout_form .form_block#shipping TEXTAREA').attr('disabled', 1);
		$.getJSON('?section=checkout&ac=fulfill_form&SA_ID='+$(this).val(), function(data){
			for (var i in data){
				if (!$('#'+i).length)
					continue;
				$('FORM#checkout_form .form_block#shipping #'+i).attr('value', data[i]);
	 		}
	 		$('FORM#checkout_form .form_block#shipping INPUT, FORM#checkout_form .form_block#shipping SELECT, FORM#checkout_form .form_block#shipping TEXTAREA').attr('disabled', 0);
	 		$('FORM#checkout_form .form_block#shipping #SHIPCOUNTRY').change();
			$('FORM#checkout_form #SHIPSAVENEW').attr('checked', false);
			$('FORM#checkout_form INPUT#ADDRNAME').val('');
			$('FORM#checkout_form INPUT#ADDRNAME').attr('disabled', 1);
		});
	});
	
	
	if ($('FORM#checkout_form #SHIPASBILL').length && ($('FORM#checkout_form #SHIPASBILL').val()==0) && $('FORM#checkout_form #copydata').length && $('FORM#checkout_form #copydata').attr('checked')){
		$('FORM#checkout_form #copydata').attr('checked', false);
		$('FORM#checkout_form #copydata').click();
		$('FORM#checkout_form #copydata').attr('checked', false);
	}
	
	$("#CC_NUMBER").keyup(function(){
	   var ccnum = $(this).val();
	   var matches = new Array();
	   var valid_patterns = {};
	   var patterns = {
			   'VISA': 			[ '4' ],
			   'MASTERCARD': 	[ '5', '51', '52', '53', '54', '55' ],
			   'DISCOVER': 		[ '6', '60', '601', '6011' ],
			   'AMEX': 			[ '3', '34', '37' ],
			   'DINERS': 		[ '3', '30', '36', '38' ],
			   'JCB': 			[ '3', '35' ]
	   };
	   $("#CC_TYPE option").each(function(i,obj){
		   if(typeof(patterns[$(obj).attr("value")]) != 'undefined')
			   valid_patterns[$(obj).attr("value")] = { 'type': $(obj).attr("value"), 'patterns': patterns[$(obj).attr("value")] };
	   });
	   for(var i in valid_patterns) {
		   var type = valid_patterns[i]['type'];
		   var pts = valid_patterns[i]['patterns'];
		   $.each(pts, function(j,pt){
			   if(ccnum.substr(0,pt.length) == pt && typeof(matches[type]) == 'undefined')
				   matches[j] = type;
		   });
	   }
	   if(matches.length > 0 && $("#CC_TYPE option[value=" + matches.join('') + "]").length > 0)
		   return $("#CC_TYPE").val(matches.join(''));
	   if((ccnum.length == 8 || ccnum.length == 8) && $("#CC_TYPE option[value=ISRACARD]").length > 0)
		   return $("#CC_TYPE").val('ISRACARD');
	});
	
}

function init_wishlist(){
	$('.add2wishlist').click(function () {
		tmp = $(this).attr('id').split('-');
		if (tmp.length < 3){
			alert('ID should have 3 parts, e.g. addtowishlist-products-$ID');
			return false;
		}
		
		$('#'+$(this).attr('id') + '-adding-caption').show();
		$(this).hide();
		
		var section = $(tmp).get(1);
		
		$.get('index.php?'+Math.random(), { section: $(tmp).get(1), ac: "add2wishlist", ID: $(tmp).get(2) }, function(data) {
			tmp = data.split('-');
			if (tmp.length > 2 || !$('#add2wishlist-'+section+'-'+$(tmp).get(0) + '-adding-caption').length){
			   alert('Error: ' + tmp);	
			   return;
			}
			$('#add2wishlist-'+section+'-'+$(tmp).get(0) + '-adding-caption').hide();
			if (tmp.length < 2){
				$('#add2wishlist-'+section+'-'+$(tmp).get(0) + '-added-caption').show();
				$('#remove_from_wishlist-'+section+'-'+$(tmp).get(0)).show();
			}
			else
				alert($(tmp).get(1));
  			//$('#'+$(this).attr('id') + '-adding-caption').show();
		});
		return false;
	});
	$('.remove_from_wishlist').click(function () {
		tmp = $(this).attr('id').split('-');
		if (tmp.length < 3){
			alert('ID should have 3 parts, e.g. remove_from_wishlist-products-$ID');
			return false;
		}
		
		$('#'+$(this).attr('id') + '-removing-caption').show();
		$(this).hide();
		
		var section = $(tmp).get(1);
		
		$.get('index.php?'+Math.random(), { section: $(tmp).get(1), ac: "remove_from_wishlist", ID: $(tmp).get(2) }, function(data) {
			tmp = data.split('-');
			if (tmp.length > 2 || !$('#remove_from_wishlist-'+section+'-'+$(tmp).get(0) + '-removing-caption').length){
			   alert('Error: ' + tmp);	
			   return;
			}
			$('#remove_from_wishlist-'+section+'-'+$(tmp).get(0) + '-removing-caption').hide();
			if (tmp.length < 2){
				$('#remove_from_wishlist-'+section+'-'+$(tmp).get(0) + '-removed-caption').show();
				$('#add2wishlist-'+section+'-'+$(tmp).get(0)).show();
			}
			else
				alert($(tmp).get(1));
  			//$('#'+$(this).attr('id') + '-adding-caption').show();
		});
		return false;
	});
}


function validate_product_quantity(obj) {
	//Let's get parameters for validation
	var id = $(obj).get_part(0);
	if (!id){
		alert('An object with class product_quantity must have an ID that look like: {$ID}:{$PRICE_STR}:{$QUANTITY_BREAKS}:{$MIN_QUANTITY}:{$MAX_QUANTITY}');
		return false; //If id is empty, it's an HTML programmer error. 
	}
	var price = $(obj).get_part(1);
	var q_breaks = $(obj).get_part(2);
	var min_q = $(obj).get_part(3);
	var max_q = $(obj).get_part(4);
	
	//We're gonna need amaximal integer number. Let's get it by a bit shifting of -1 to the right.
	var maxInt = -1 >>> 1;
	
	//Let's make sure all parameter are fine and let's set the defaults
	price = (!price || isNaN(price) || (price <0))?0:price;
	q_breaks = (isNaN(q_breaks) || (q_breaks <1))?1:Math.round(q_breaks);
	min_q = (isNaN(min_q) || (min_q <1))?1:Math.round(min_q);
	max_q = (isNaN(max_q) || (max_q <min_q))?maxInt:Math.round(max_q);
	
	//Let's make the error messages block in case it's missing
	if(!$("DIV#ERR_" + id).length)
		$($(obj).parents("*").get(0)).prepend('<div class="qty_err_message error_mess" id="ERR_' + id + '"> \n'+
		'<span class="qty_is_not_number_error">The value of "Quantity" field must be numeric</span>\n'+
		'<span class="qty_q_breaks_error">This item must be ordered in multiplies of ' + q_breaks + '</span>\n'+
		'<span class="qty_min_q_error">Minimal quantity for this product is ' + min_q + '</span>\n'+
		'<span class="qty_max_q_error">Maximal quantity for this product is ' + max_q + '</span>\n' +
		'</div>');
	//Let's hide all the errors by default.
	$("DIV#ERR_" + id).hide();
	$("DIV#ERR_" + id + ' SPAN').hide();
	$(obj).removeClass("mandatory_selected");
	
	//Let's get something to validate. Jsut in case, you know :-) 
	var q_value = $(obj).attr("value");
	
	//This var will contain a selector to hilight once we find errors
	//If no errors found the var should remain empty
	var erros2show = '';
	
	if(isNaN(q_value)) {
		erros2show+= ", DIV#ERR_" + id + ' SPAN.qty_is_not_number_error ';
		q_value = 0;
	}

	q_value = Math.round(q_value);
	//if the quantity is numeric, let's see what we've got here...
	if (erros2show=='' && q_value >0) {
		//Let's round the quantity up, since fractions are not allowed anyway. 
		if((q_breaks >1) && Number($(obj).attr("value")) % q_breaks != 0) {
			erros2show+=", DIV#ERR_" + id +' SPAN.qty_q_breaks_error ';
			q_value = (q_breaks*Math.round(q_value/q_breaks));
			if (q_value==0)
				q_value = q_breaks;
		}
		
		if(q_value < min_q) {
			erros2show+=", DIV#ERR_" + id +' SPAN.qty_min_q_error ';
			q_value = min_q;
		}
		
		if(q_value > max_q) {
			erros2show+=", DIV#ERR_" + id +' SPAN.qty_max_q_error ';
			q_value = max_q;
		}
		
	}
	
	//Once we validated everything, let's assign corrected q_value and flash error messages if needed:
	$(obj).attr("value", q_value);	
	if (erros2show!=''){
		$("DIV#ERR_" + id+ ', ' + erros2show).show();
		$(obj).addClass('mandatory_selected');
	}
	
	
	if($("#PRICE_" + id).length > 0) {
			var total = price * (q_value<1?1:q_value);
			$("#PRICE_" + id).html(total.toFixed(2));
	}
	if ($(obj).parents("FORM").length && $($(obj).parents("FORM").get(0)).hasClass("validate4selected_items_failed"))
		validate_add2cart_form4selected_items($(obj).parents("FORM").get(0));
	return erros2show=='';
}

function validate_add2cart_form4selected_items(obj) {
	var is_add2cart_form = $(obj).find("INPUT[name='ac'][value='addtocart']").length > 0;
	if (!is_add2cart_form)
		return true;
	
	$(obj).find(".form_err_message, .form_err_message span").hide();
	$(obj).removeClass("validate4selected_items_failed");
	var products = 0;
	$(obj).find(".product_quantity").each(function(i,object){
		if ($(object).attr("value") > 0)
			products++;
	});
	if (!products) {
		if ($(obj).find(".form_err_message").length < 1)
			$(obj).find("input[type=submit], input[type=image]").before('<div class="form_err_message error_mess" align="center"><span class="form_field_error">Please, enter quantity for at least one product<br></span></div>');
		$(obj).find(".form_err_message, .form_err_message span").show();
		$(obj).addClass("validate4selected_items_failed");
		return false;
	}
	return true;
}


function init_product_inventory_check(){
	if (!$('.product_check_inventory').length)
		return;
	$('.product_check_inventory').click(function(){
		$('#INVENTORY_ERROR_MESSAGE').hide();
		var prod_id = $(this).attr('PROD_ID');
		if (prod_id==null){
			alert('Error: PROD_ID attribute is missing while product_check_inventory class is assigned');
			return false;
		}
		var quantity_field_id = $(this).attr('QUANTITY_FIELD_ID');
		if (quantity_field_id==null){
			alert('Error: QUANTITY_FIELD_ID attribute is missing while product_check_inventory class is assigned');
			return false;
		}
		var q = 1;
		quantity_field_id = quantity_field_id.replace(/(:|\.)/g,'\\$1');
		if ($('#'+quantity_field_id).length)
			q = $('#'+quantity_field_id).val();
			
		if (typeof(sitehome)=='undefined')
			sitehome = '/';
		var res= true;
		jQuery.ajax({
         url:    sitehome+'?section=produts&ac=inventory_verify&prod_id='+ prod_id+'&q='+q,
         success: function(result) {
                      if(result != 1){
                      	  $('#INVENTORY_ERROR_MESSAGE').show();
                          return res = false;
                      }
                  },
         async:   false
    	});         
    	return res;
	});
	
}
	
function init_product_quantity() {
	$("FORM:has(INPUT.product_quantity), FORM:has(SELECT.product_quantity)").submit(function(){
		if (validate_add2cart_form4selected_items($(this).get(0))){
			$(this).find('.qty_err_message').hide();
			$(this).find('.product_quantity').removeClass('mandatory_selected');
			return true;
		}
		return false;
	});
	$("FORM INPUT.product_quantity, FORM SELECT.product_quantity").blur(function(){
			validate_product_quantity($(this).get(0));
	}).keypress(function(event){
		if (event.keyCode==13){
			if (!validate_product_quantity($(this).get(0)))
				event.returnValue=false;
			else if (this.form)
				this.form.submit();
		}
		
	});
	
	$("FORM SELECT.product_quantity").change(function(){
		validate_product_quantity($(this).get(0));
	});

	
	$("FORM .product_buy_button").click(function(){
		
		
		var id = $(this).get_part(0);
		if (!id){
			alert('An object with class product_quantity must have an ID that look like: {$ID}:{$PRICE_STR}:{$QUANTITY_BREAKS}:{$MIN_QUANTITY}:{$MAX_QUANTITY}');
			return false; //If id is empty, it's an HTML programmer error. 
		}
		var price = $(this).get_part(1);
		var q_breaks = $(this).get_part(2);
		var min_q = $(this).get_part(3);
		var max_q = $(this).get_part(4);
		var q_id = id+":"+price+":"+q_breaks+":" + min_q + ":"+max_q;
		var q_id_esc = q_id.replace(/(:|\.)/g,'\\$1');
		
		// In some cases (e.g. pmember products index) duplicate ID-s might exist
		if ($(".product_quantity[ID='"+q_id_esc+"']").length > 1){
			var parent_form = $(this).attr('form');	
			if ($(parent_form).length && $(parent_form).find('#' + q_id_esc).length==1 && $($(parent_form).find('#' + q_id_esc)).val()=='0'){
				q_breaks = (isNaN(q_breaks) || (q_breaks <1))?1:Math.round(q_breaks);
				min_q = (isNaN(min_q) || (min_q <1))?1:Math.round(min_q);
				$($(parent_form).find('#' + q_id_esc)).val(q_breaks>min_q?q_breaks:min_q);
				return ;
			}
				
		}
	
		
		if (!$('#' + q_id_esc).length){
			alert('Buy button error: corresponding quantity field with ID = '+q_id_esc +' is not found');
			return false;
		}
		if ($('#'+q_id_esc).val()=='0'){
			q_breaks = (isNaN(q_breaks) || (q_breaks <1))?1:Math.round(q_breaks);
			min_q = (isNaN(min_q) || (min_q <1))?1:Math.round(min_q);
			$('#'+q_id_esc).val(q_breaks>min_q?q_breaks:min_q);
		}
	});
	
}

function init_limited_choice() {
	if(!$('input[type=checkbox].limited_choice').length)
		return;
	if(!$("#limited_choice_msgbox").length) {
		$("body").append('<div class="msgBox" id="limited_choice_msgbox" title="Warning!" width="300" height="100" style="display:none;">You can choose only <span id="limited_choice_limit">1</span> items</div>');
		$("#limited_choice_msgbox").dialog({
			height: 100,
			width: 300,
			autoOpen: false
		});
	}
	$('input[type=checkbox].limited_choice').click(function(){
		var classname = $(this).get_part(0,'rel');
		var length = $(this).get_part(1,'rel');
		var id = $(this).get_part(2,'rel');
		if(!id || !$('#' + id).length)
			id = 'limited_choice_msgbox';
		if($('.' + classname + ':checked').length > length) { 
			$("#limited_choice_limit").html(length);
			$('#' + id).dialog('open');
			return false; 
		}
	});
}

function init_contacts_dialog(){
	
	if ($('.contact_login_dialog_open').length){
			$('.contact_login_dialog_open').click(function() {
				//alert("You should login to contact the member!");
				setCookie('after_login_return_url',document.location.href,'','/');
				location.href=$("#SITEHOME").text() + "login/";
				return false;
			});
		return;
	}

	$('.contact_dialog_open').click(function() {
		$("#SRC_ID").attr("value", $(this).attr("rel"));
		$("#SENDER_NAME").attr("value", $("#CURRENT_USER_NAME").text());
		$("#SENDER_EMAIL").attr("value", $("#CURRENT_USER_EMAIL").text());
		$("#COMMENTS").attr("value", '');
		$('#contact_dialog').dialog('open');
		return false;
	});

	var name = $("#SENDER_NAME"),
		email = $("#SENDER_EMAIL"),
		text = $("#COMMENTS"),
		//captcha = $("#dialog_captcha"),
		allFields = $([]).add(name).add(email).add(text);//.add(captcha);
			
	$("#contact_dialog").dialog({
		bgiframe: true,
		autoOpen: false,
		height: 430,
		modal: true,
		buttons: {
			'Submit': function() {
				var bValid = true;
				allFields.removeClass('ui-state-error');

				bValid = bValid && checkLength(name,"Name",3,50);
				bValid = bValid && checkLength(email,"E-Mail",6,80);
				//bValid = bValid && checkLength(captcha,"Validation Code",5,5);
				bValid = bValid && checkLength(text,"Details",5,255);

				//bValid = bValid && checkRegexp(name,/^[a-z]([0-9a-z_])+$/i,"Username may consist of a-z, 0-9, underscores, begin with a letter.");
				// From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
				bValid = bValid && checkRegexp(email,/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i,"eg. info@welcomebiz.com ");
				/*" ))))*/
				//bValid = bValid && checkRegexp(password,/^([0-9a-zA-Z])+$/,"Password field only allow : a-z 0-9");
			
				if (bValid) {
					//$("#post_contact").submit();
					$(this).dialog('close');
					$.post("/mail.php", $("#post_contact").serialize(),function(data){
						if (data) {
							$("#post_contact_confirm").html(data);
							$("#post_contact_confirm").dialog('open');
						}
					});
				}
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		},
		close: function() {
			allFields.removeClass('ui-state-error');
		}
	});

	$("#post_contact_confirm").dialog({
		bgiframe: true,
		resizable: false,
		height: 50,
		width: 300,
		autoOpen: false,
		modal: true,
		buttons: {
			'OK': function() {
				$(this).dialog('close');
			}
		}
	});

}


function init_contact_form_dialog(){
	if (!$('div.contact_from_popup').length)
		return;
	$('div.contact_from_popup').hide();
	$('div.contact_from_popup').find('INPUT[type=submit]').hide();
	$('div.contact_from_popup').find('INPUT[type=image]').hide();
	
	$('.contact_from_popup_opener').click(function(){
		if ($(this).attr('rel'))
			$('#'+$(this).attr('rel')).dialog('open');
		else
			$('div.contact_from_popup').dialog('open');
		return false;
	});
	
	$('div.contact_from_popup').each(function(){
		if ($(this).attr('ID') == ''){
			alert('Form error! Div with class .contact_from_popup should have an ID!');
			return;
		}
		w = $(this).attr('width')?$(this).attr('width'):450;
		h = $(this).attr('height')?$(this).attr('height'):450;
		$(this).dialog({
			bgiframe: true,
			autoOpen: false,
			width : w *1,
			height: h *1,
			
			modal: true,
			buttons: {
			'Submit': function() {
				if ($(this).find('FORM:has(INPUT.mandatory), FORM:has(SELECT.mandatory), FORM:has(TEXTAREA.mandatory)').length){
					if (!validate_any_form($(this).find('FORM:has(INPUT.mandatory), FORM:has(SELECT.mandatory), FORM:has(TEXTAREA.mandatory)').get(0)))
						return ;
				}
				$(this).find('FORM').submit();
				//$(this).dialog('close');
				},
			Cancel: function() {
				$(this).dialog('close');
				}
			},
			close: function() {
				$(this).find("INPUT, SELECT, TEXTAREA, LABEL").removeClass('mandatory_selected');
				$(this).find("DIV.form_err_message").hide();
				$(this).find("DIV.form_err_message DIV.checkbox_mandatory_error").hide();
			}
		});
	})
}

function init_adialog()
{
	var $popupGeneral = $('div#popupGeneral');
	var $popupEvents = $('div.events-popup');
	
	/* general */
	$('.adialog').adialog();
	
	$('.form-submit-button').each(function(){
		$(this).click(function(){
			$(this).parents('form').submit();
		});
	});
	
	/* events */
	$('.event-dialog-opener').live('click', function(){
		var $item = $(this);
		
		if(!$item.attr('itemtag')) 
			return;
			
		$popupEvents.adialog('showmodal');
		$.post(
			'index.php',
			{section: 'events', ac: 'get_zoom_data', tag: $item.attr('itemtag')},
			function(response) {
				$popupEvents.find('h2:first').text(response.TITLE);
//				$popupEvents.find('div.date').text(response.DATE);
				$popupEvents.find('div.long-desc').html(response.LONG_DESC);
				$popupEvents.adialog('open');	
			},
			'json'
		);		
	});

	$('.open_compliance_dialog').live('click', function (){
		if (!$popupGeneral.size()){
			alert('panel with ID=popupGeneral is missing!');
		}
		var itemId = $(this).attr('rel');
		$.get('?section=index&ac=get_report&rep_id='+itemId, function(response){
			$popupGeneral.find('.popup-content').html(response);
			$popupGeneral.adialog('open');		
		});
		return false;
	});
	
	$('.open_compliance_dialog_correction_action').live('click', function (){
		if (!$popupGeneral.size()){
			alert('panel with ID=popupGeneral is missing!');
		}
		var itemId = $(this).attr('itemid');
		$.get('?section=index&ac=get_corr_action&itemId='+itemId, function(response){
			$popupGeneral.find('.popup-content').html(response);
			$popupGeneral.adialog('open');		
		});
		return false;
	});



}

function homeSlider(opt){
	var options = {
		parentItem: opt.parent,
		childItems: opt.children,
		next: opt.next,
		prev: opt.prev,
		speed: opt.speed
	}
	var itemWidth, positionCount = 1;
	itemWidth = $(options.childItems).width();
	$(options.next).click(function(){
		if(positionCount < ($(options.childItems).length - 1)){
			$(options.parentItem).animate({"left":"-="+itemWidth+"px"}, options.speed);
			positionCount++;
		}
	});
	$(options.prev).click(function(){
		if(positionCount > 1){
			$(options.parentItem).animate({"left":"+="+itemWidth+"px"}, options.speed);
			positionCount--;
		}
	});
}

function init_replicator()
{
	var $replicators = $('.replicator');
	
	$replicators.find('.minus').hide();
	if($replicators.size() > 1) {
		$replicators.find('.minus').css('display', 'inline-block');
	}
	
	$replicators.find('.plus').live('click', function(){
		var $replicator = $(this).parents('.replicator');
		var $replicatorClone = $replicator.clone();
		var $siblings = $replicator.siblings('.replicator');

		if($replicator.attr('max')) {
			if($siblings.size() >= $replicator.attr('max')-1)
			return;
		}

		$replicator.find('.minus').css('display', 'inline-block');
		
		$replicatorClone.find('input[type=text]').each(function(){
			$(this).val($(this).attr('title'));
		});
		$replicatorClone.find('.minus').css('display', 'inline-block');
		$replicatorClone.attr('id', '');
		$replicatorClone.val($replicatorClone.attr('title'));
		$replicatorClone.insertAfter($replicator);
		
	});
	
	$replicators.find('.minus').live('click', function(){
		var $replicator = $(this).parents('.replicator');
		var $siblings = $replicator.siblings('.replicator');
		
		if($siblings.size()) {
			$replicator.remove();
		}
		else {
			$replicator.find('input[type=text]').each(function(){
				$(this).val($(this).attr('title'));
			});			
			$replicator.find('.minus').hide();
		}
	});
}

function init_scrolls(){
	$('#Carousel').jcarousel({wrap:"both", scroll:1});
	$('#scroll-pane').jScrollPane({
		showArrows:true, 
		scrollbarWidth:10, 
		scrollbarMargin:10,
		dragMaxHeight:50
	});		
	$('#scroll-list-page, #scroll-list-small, #scroll-dd-window').jScrollPane({
		showArrows:true, 
		scrollbarWidth:20, 
		scrollbarMargin:10,
		dragMaxHeight:50
	});		
		
		
	$('#reqests-scroller').jScrollPane({
		showArrows:true, 
		scrollbarWidth:21, 
		scrollbarMargin:0,
		dragMaxHeight:50,
		trackClickRepeatFreq: 150
	});
	
	//-st!!//
	$('.notes_officers .reqests')
	.css({
	  'height':'710px',
	  'overflow': 'hidden',
	  'padding-right': '10px'
	})
	.jScrollPane({	
		showArrows:true, 
		scrollbarWidth:0, 
		scrollbarMargin:0,
		dragMaxHeight:0,
		trackClickRepeatFreq: 150
	});
	
	
	$('.notes_officers .reqests')
	  .parent()
	  .find('.jScrollPaneTrack')
	  .hide();
	$('.notes_officers .reqests')
	  .parent().prev('.next-prev-vert').find('a').bind('mousedown',
	    function() {
		  $(this).closest('.next-prev-vert')
		    .next().find('>a').eq($('.next-prev-vert a').index($(this)))
			.hide()
			.trigger('mousedown');
		  return false;
		}
	  );
	$('.notes_officers .reqests')
	  .parent().prev('.next-prev-vert').find('a').bind('mouseup',
	    function() {
		  $(this).closest('.next-prev-vert')
		    .next().find('>a').eq($('.next-prev-vert a').index($(this)))
			.hide()
			.trigger('mouseup');
		  return false;
		}
	  );
	//-st!!!//  
	$('#box_cont_scroll>ul>li ul')
	.css({
	  'height':'180px',
	  'overflow': 'hidden',
	  'padding-bottom': '10px'
	})
	.jScrollPane({	
		showArrows:true, 
		scrollbarWidth:0, 
		scrollbarMargin:0,
		dragMaxHeight:0,
		trackClickRepeatFreq: 150
	});
	$('#box_cont_scroll>ul>li ul')
	  .parent()
	  .find('.jScrollPaneTrack')
	  .hide();
	$('#box_cont_scroll>ul>li ul')
	  .parent().parent().prev('.next-prev-vert').find('a').bind('mousedown',
	    function() {
		  $(this).closest('.next-prev-vert')
		    .next().find('.jScrollPaneContainer>a').eq($(this).closest('.next-prev-vert').find('a').index($(this)))
			.trigger('mousedown');
		  return false;
		}
	  );
	$('#box_cont_scroll>ul>li ul')
	  .parent().parent().prev('.next-prev-vert').find('a').bind('mouseup',
	    function() {
		  $(this).closest('.next-prev-vert')
		    .next().find('.jScrollPaneContainer>a').eq($(this).closest('.next-prev-vert').find('a').index($(this)))
			.trigger('mouseup');
		  return false;
		}
	  );	  
	$('#box_cont_scroll>ul>li').append('<div class="last-st"></div>');
	
	
	
	/*************************************************************************/
	/****************************** TRAINING *********************************/
	/*************************************************************************/
	$('.courses_gray_box DIV.category_menu div.links')
	.css({
	  'height':'300px',
	  'overflow': 'hidden',
	  'padding-right': '10px'
	})
	.jScrollPane({	
		showArrows:true, 
		scrollbarWidth:0, 
		scrollbarMargin:0,
		dragMaxHeight:0,
		trackClickRepeatFreq: 150
	});	
	$('.courses_gray_box DIV.category_menu div.links')
	  .parent()
	  .find('.jScrollPaneTrack')
	  .hide();
	$('.courses_gray_box DIV.category_menu div.links')
	  .parents('div.cats_articles').prev('.next-prev-vert').find('a').bind('mousedown',
	    function() {
		  $(this).closest('.next-prev-vert')
		    .next().find('.jScrollPaneContainer>a').eq($('.next-prev-vert a').index($(this)))
			.hide()
			.trigger('mousedown');
		  return false;
		}
	  );
	$('.courses_gray_box DIV.category_menu div.links')
	 	.parents('div.cats_articles').prev('.next-prev-vert').find('a').bind('mouseup',
	    function() {
		  $(this).closest('.next-prev-vert')
		    .next().find('.jScrollPaneContainer>a').eq($('.next-prev-vert a').index($(this)))
			.hide()
			.trigger('mouseup');
		  return false;
		}
	  );	
}

function init_acc_course_test()
{
	/* mid_courses */
	var $infoBlockWrapper = $('.gray_box.training_gray_box');
	var $leftSwitch = $infoBlockWrapper.find('.box_title');
	var $scaleBlock = $infoBlockWrapper.find('.box_cont.scale');
	var $infoBlock = $infoBlockWrapper.find('.box_cont.info');
	
	
	$scaleBlock.find('.status li').removeClass('orange');
	$scaleBlock.find('.status li').each(function(idx){
		
		if(idx < parseInt($infoBlockWrapper.attr('marked'))) {
			$(this).addClass('green');
		}
		
		if(idx - parseInt($infoBlockWrapper.attr('marked')) == 0) {
			$(this).addClass('orange');
		}
	});
	
	$leftSwitch.find('li').click(function(e){
		$leftSwitch.find('li').toggleClass('sel');
		$scaleBlock.toggle();
		$infoBlock.toggle();
	});
	
	
	/* mid_exam */
	var $pollsWrapper = $('div.questions');
	
	$pollsWrapper.find('li.sub input').click(function(e){
		var $button = $(this);
		var $poll = $button.parents('ul:first');
		var $answer = $poll.find('input[type=radio]:checked');
		
		if($button.hasClass('progress') || !$answer.size()) 
			return;
		
		$button.addClass('progress');
		
		
		$.post(
			sitehome+'acc_bo/index.php',
			{section: 'training', ac: 'test_vote', PID: $poll.attr('poll'), answer: $answer.val(), 'courseId': $pollsWrapper.attr('courseId'), 'courseCatTag': $pollsWrapper.attr('courseCatTag')},
			function(response) {
				
				if(response) {
					if(response.a != response.c) {
						$poll.find('li.an'+response.a).addClass('wrong');
					}
					
					$poll.find('li.an'+response.c).addClass('correct');
					
					$poll.find('input[type=radio]').attr('disabled', 'disabled');
					$poll.find('li.sub input').fadeOut(500);
				}
			},
			'json'
		);
	});
}

function init_course_assign()
{
	var $courseCatsWrapper = $('.cats_articles div.links');
	var $courseCats = $courseCatsWrapper.find('div.l_0');
	var $popup = $('#assign_course_popup');
	var $popupInner = $popup.find('.popup-inner');
	var $messageBox = $popup.find('.message');
	
	var currentCourseCat = null;
	
	$courseCats.find('a.assign-course').click(function(e){
		$popupInner.html('');
		$messageBox.hide();
		
		currentCourseCat = $(this).attr('coursecat');
		
		$.post(
			'index.php',
			{section: 'training', ac: 'assign_course', f: 'getUsersList', courseCat: $(this).attr('courseCat')},
			function(response) {
				if(response) {
					$(response).each(function(idx){
						$popupInner.append('<a href="#" class="jsLink user-link" accid="'+this.ID+'">'+this.DISPLAY_NAME+'</a>');
					});
				}
			},
			'json'
		);
	});
	
	
	$popupInner.find('a').live('click', function(e){
		$messageBox.find('.message-inner').html('User <b>'+$(this).text()+'</b> assign to the course.');
		$messageBox.fadeIn(500);
		
		$(this).remove();
		
		
		$.post(
			'index.php',
			{section: 'training', ac: 'assign_course', f: 'assignUser', userId: $(this).attr('accid'), courseCatId: currentCourseCat, facilityId: $courseCatsWrapper.attr('facilityId')},
			function(response) {
				log(response);
			},
			'json'
		);
	});
}

//main jquery hook-up function
$(document).ready(
	function() {
		init_country_state_block('');
		init_country_state_block('SHIP');
		init_bbcode_wysiwyg();
		init_checkout_form();
		init_form_validation();
		init_lightbox();
		init_comments();
		init_forum();
		init_contacts_form_dialog();
		init_after_login_return();
		init_after_logout_return();
		init_non_auth_message();
		$(".jqueryui_tabs").tabs();
		
		init_mega_menu();
		init_fading_tabs();
		
		//Patch, that fixes z-index issue. Must be after init_fading_tabs
		correct_zindex4menu('UL.mega_menu');
		
		init_gallery();
		init_confirmations();
		init_msgbox();
		init_slideshow();
		init_on_focus_replace();
		init_job_offers_menu();
		
		init_date_pickers();
		
		init_calendar_selectors();
		
		init_panel_scrollers();
		init_wishlist();
		init_product_quantity();
		init_product_inventory_check();
		init_limited_choice();
		init_contacts_dialog();
		init_adialog();
		init_replicator();
		
		init_contact_form_dialog();
		init_scrolls();
		
		init_acc_course_test();
		init_course_assign();
		
		
		if (typeof(on_custom_jquery_init) != 'undefined')
			on_custom_jquery_init();
	}
	
	
);
