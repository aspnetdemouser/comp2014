//v1.0
//Copyright 2006 Adobe Systems, Inc. All rights reserved.
var isIE  = (navigator.appVersion.indexOf("MSIE") != -1) ? true : false;
var isWin = (navigator.appVersion.toLowerCase().indexOf("win") != -1) ? true : false;
var isOpera = (navigator.userAgent.indexOf("Opera") != -1) ? true : false;


function AC_AddExtension(src, ext)
{
  if (src.indexOf('?') != -1)
    return src.replace(/\?/, ext+'?'); 
  else
    return src + ext;
}

function AC_Generateobj(objAttrs, params, embedAttrs) 
{ 

  var str = '';
  if (isIE && isWin && !isOpera)
  {
    str += '<object ';
    for (var i in objAttrs)
    {
      str += i + '="' + objAttrs[i] + '" ';
    }
    str += '>';
    for (var i in params)
    {
      str += '<param name="' + i + '" value="' + params[i] + '" /> ';
    }
    str += '</object>';
  }
  else
  {
    str += '<embed ';
    for (var i in embedAttrs)
    {
      str += i + '="' + embedAttrs[i] + '" ';
    }
    str += '> </embed>';
  }
  if (arguments.length>3 && arguments[3])
  	return str;
  document.write(str);
  
}




function AC_FL_RunContent2str(){
  var ret = 
    AC_GetArgs
    (  arguments, "movie", "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
     , "application/x-shockwave-flash"
    );
  return AC_Generateobj(ret.objAttrs, ret.params, ret.embedAttrs, true);
}

function AC_FL_RunContent(){
  var ret = 
    AC_GetArgs
    (  arguments, "movie", "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
     , "application/x-shockwave-flash"
    );
  AC_Generateobj(ret.objAttrs, ret.params, ret.embedAttrs);
}

function AC_SW_RunContent(){
  var ret = 
    AC_GetArgs
    (  arguments, ".dcr", "src", "clsid:166B1BCA-3F9C-11CF-8075-444553540000"
     , null
    );
  AC_Generateobj(ret.objAttrs, ret.params, ret.embedAttrs);
}

function AC_GetArgs(args, srcParamName, classid, mimeType){
  var ret = new Object();
  ret.embedAttrs = new Object();
  ret.params = new Object();
  ret.objAttrs = new Object();
  for (var i=0; i < args.length; i=i+2){
    var currArg = args[i].toLowerCase();    

    switch (currArg){	
      case "classid":
        break;
      case "pluginspage":
        ret.embedAttrs[args[i]] = args[i+1];
        break;
      case "src":
      case "movie":	
//        args[i+1] = AC_AddExtension(args[i+1], ext);
        ret.embedAttrs["src"] = args[i+1];
        ret.params[srcParamName] = args[i+1];
        break;
      case "onafterupdate":
      case "onbeforeupdate":
      case "onblur":
      case "oncellchange":
      case "onclick":
      case "ondblClick":
      case "ondrag":
      case "ondragend":
      case "ondragenter":
      case "ondragleave":
      case "ondragover":
      case "ondrop":
      case "onfinish":
      case "onfocus":
      case "onhelp":
      case "onmousedown":
      case "onmouseup":
      case "onmouseover":
      case "onmousemove":
      case "onmouseout":
      case "onkeypress":
      case "onkeydown":
      case "onkeyup":
      case "onload":
      case "onlosecapture":
      case "onpropertychange":
      case "onreadystatechange":
      case "onrowsdelete":
      case "onrowenter":
      case "onrowexit":
      case "onrowsinserted":
      case "onstart":
      case "onscroll":
      case "onbeforeeditfocus":
      case "onactivate":
      case "onbeforedeactivate":
      case "ondeactivate":
      case "type":
      case "codebase":
        ret.objAttrs[args[i]] = args[i+1];
        break;
      case "width":
      case "height":
      case "align":
      case "vspace": 
      case "hspace":
      case "class":
      case "title":
      case "accesskey":
      case "name":
      case "id":
      case "tabindex":
        ret.embedAttrs[args[i]] = ret.objAttrs[args[i]] = args[i+1];
        break;
      default:
        ret.embedAttrs[args[i]] = ret.params[args[i]] = args[i+1];
    }
  }
  ret.objAttrs["classid"] = classid;
  if (mimeType) ret.embedAttrs["type"] = mimeType;
  return ret;
}


function setFullScreen(vid){
	fs = window.open("ap.html?"+vid,'',
		"toolbar=no,width="+screen.availWidth+",height="+screen.availHeight+",status=no,resizable=yes,fullscreen=yes,scrollbars=no");
	fs.focus();
}

function closeFullScreen() {
	window.close();
}


var overOutFlash = [];
var overState = [];

window.onload = function() {
	var count = overOutFlash.length;
	for(var i=0; i<count; i++) {
		initFlashOverOut(overOutFlash[i]);		
	}
}

function initFlashOverOut(sId) {	
	var oFlashContainer = document.getElementById(sId).parentNode;	
	if (oFlashContainer==null)
	  return;
	overState[sId] = false;
	oFlashContainer.objId = sId;

	oFlashContainer.onmouseover = onFlashOver;
	oFlashContainer.onmouseout = onFlashOut;
}

function onFlashOver() {
	var sId = this.objId;
	if(!overState[sId]) {
		setTimeout(function() {
			if(overState[sId])
				return;
			if (document.getElementById(sId)==null)
				return;
			if (typeof(document.getElementById(sId).sendFromJS)=='undefined')
				return;
			overState[sId] = true;
			document.getElementById(sId).sendFromJS(true);
		}, 100);
	}
}


function onFlashOut() {
	var sId = this.objId;
	if(overState[sId]) {
		setTimeout(function() {
			if(!overState[sId])
				return;
			if (document.getElementById(sId)==null)
				return;
			if (typeof(document.getElementById(sId).sendFromJS)=='undefined')
				return;
			
			overState[sId] = false;
			document.getElementById(sId).sendFromJS(false);
		}, 100);
	}
}