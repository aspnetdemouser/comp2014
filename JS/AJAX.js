
var AJAX_result_object_id;
var AJAX_request;

var AJAX_callback_on_ready = null;


function processStateChange () {
	//alert(AJAX_request.readyState);

	if (AJAX_request.readyState == 4) { // Complete
		if (AJAX_request.status == 200){  // OK response
			 	if (AJAX_callback_on_ready){
					eval(AJAX_callback_on_ready + "(AJAX_request.responseText);");
				}
				else if (AJAX_result_object_id){
					if (document.getElementById(AJAX_result_object_id)==null){
						alert('Target object with ID '+AJAX_result_object_id+' doesn\'t exist. Change parameters and try again.');
						return;
					}
	  				document.getElementById(AJAX_result_object_id).innerHTML = AJAX_request.responseText;
				}
		}
		else
			alert("Problem: " + AJAX_request.statusText);
		//alert(AJAX_request.status);
	}
}


function open_with_ajax(url, output_ID, callback_func, async, post_params){
	
	if (typeof(async) == 'undefined')
		async = true;

	if (typeof(post_params) == 'undefined')
		post_params = "";
	
	if (typeof(jQuery) != 'undefined') {  
		sURL = url;
		bAsync = async;
		sMethod = post_params==''?'GET':'POST';
    	$.ajax({ url: sURL,
    			async : bAsync,
    			type: sMethod,
    			data : post_params,
  				success: function(data){
    				if (output_ID != '' && $('#'+ output_ID).length){
    					$('#'+ output_ID).html(data);
    				}
    				if (typeof(callback_func) != 'undefined' && callback_func!='')
    					eval(callback_func + "(data);");
  				}
			});
		return;
	}
	
	
	

	AJAX_result_object_id = output_ID;
	AJAX_callback_on_ready = callback_func;
	if (window.XMLHttpRequest) { // Non-IE browsers
		AJAX_request = new XMLHttpRequest();
	 	//try {
	 		if (async)
	  			AJAX_request.onreadystatechange = processStateChange;
      	 	AJAX_request.open((post_params!='')?"POST":"GET", url, async);
      	 	AJAX_request.setRequestHeader('Content-Type',  'application/x-www-form-urlencoded');
      	 	//AJAX_request.setRequestHeader('X-Referer', document.location);
      	 	AJAX_request.send(post_params);
      	 	if (!async){
      	 		return AJAX_request.responseText;
      	 	}
      	//} catch (e) {alert(e);}

	}else if (window.ActiveXObject) { // IE

	  AJAX_request = new ActiveXObject("Microsoft.XMLHTTP");
	  if (AJAX_request){
	  	if (async)
	  		AJAX_request.onreadystatechange = processStateChange;
      	AJAX_request.open((post_params!='')?"POST":"GET", url, async);
      	AJAX_request.setRequestHeader('Content-Type',  'application/x-www-form-urlencoded');
      	//AJAX_request.setRequestHeader('X-Referer', document.location);
      	res = AJAX_request.send(post_params);
	  	if (!async)
	  	 return AJAX_request.responseText;
	  }
    }

    if ((typeof(AJAX_request) == 'undefined') || !AJAX_request){
    	alert('AJAX is not suported!!!');
    	return null;
    }
}

