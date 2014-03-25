jQuery.extend({
	part : 
	function(str, i, separator) 
	{
		//console.log(this);
		if(!separator)	
			separator = ':';
		if(!i)	
			i = 0;
			
		var parts = str.split(separator);
		if (parts.length <= i)
			return false;
		return parts[i];
	}
});


jQuery.fn.extend({
	get_part :
	function(i, aName, separator)
	{
		if(!i)	
			i = 0;
		if(!aName)
			aName = 'id';
		if(!separator)	
			separator = ':';
		return jQuery.part($(this).attr(aName), i, separator);
	}
});


jQuery.extend({
	chunk : 
	function(str, chunk, separator) 
	{
		//console.log(this);
		if(!str) 
			return ;
		if(!separator)	
			separator = ':';
		if(!chunk)	
			chunk = 0;
			
		chunks = str.split(separator);
		return chunks[chunk];
	}
});


jQuery.fn.extend({
	chunkId :
	function(chunk, separator)
	{
		return jQuery.chunk($(this).attr('id'), chunk, separator);
	}
});



jQuery.extend({
	sendPostForm: 
	function($form, $element, addData, callback) {
		
		var url = $form.attr('action');
		var post = {};
		var params = $form.serializeArray();
		
		jQuery.each(params, function(i, obj){
			post[obj.name] = obj.value;
		});
		
		if(typeof(addData == 'object')) {
			for(add in addData) {
				post[add] = addData[add];
			}
		}
		
		$element.load(url, post, callback);
		
		return true;
		
	}
});


jQuery.fn.extend({
	sendPostForm: 
	function($form) {
	
		var $element = $(this);
		var url = $form.attr('action');
		var post = {};
		var params = $form.serializeArray();
		
		jQuery.each(params, function(i, obj){
			post[obj.name] = obj.value;
		});
		
		$element.load(url, post);
		return true;
		
	}
});