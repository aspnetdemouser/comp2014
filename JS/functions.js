//Work-around for bo:
function validate_form(){
	return true;	
}

//Following function is used for AJAX on-the-fly database ID validation
var global_responce_var;
function check_db_reference_callback(AJAX_responce_text){
	//alert(AJAX_responce_text);
	global_responce_var = AJAX_responce_text;
}


function check_db_reference(frm_name, field_name, field_caption){
	if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		return '';
	if (typeof(document.forms[frm_name].elements['section']) == 'undefined')
		return '';

	if (typeof(document.forms[frm_name].elements['PLAIN_NAMES['+field_name+']']) == 'undefined')
		return '';
	plain_name = document.forms[frm_name].elements['PLAIN_NAMES['+field_name+']'].value;
	if (!plain_name)
		return;
	if (typeof(document.forms[frm_name].elements['REFERENCE_TABLES['+plain_name+']']) == 'undefined')
		return '';
	if (typeof(document.forms[frm_name].elements['REFERENCE_FIELDS['+plain_name+']']) == 'undefined')
		return '';
	section_name = document.forms[frm_name].elements['section'].value;
	reference_table = document.forms[frm_name].elements['REFERENCE_TABLES['+plain_name+']'].value;
	reference_field = document.forms[frm_name].elements['REFERENCE_FIELDS['+plain_name+']'].value;
	if (!reference_field)
		return '';
	global_responce_var ='';
	curr_value = document.forms[frm_name].elements[field_name].value;
	if (!curr_value)
		return '';
	res = open_with_ajax('index.php?section='+section_name+'&ac=validate_reference&table='+reference_table+'&field='+reference_field+'&value='+curr_value, '', 'check_db_reference_callback', false);
	if (res){
		//alert(res)
		return field_caption + ' "' + curr_value + '" does not exist \n';
	}
	return '';
}


function check_cc_number(frm_name, field_name, field_caption, cc_type_name) {
	var res = generic_mandatory_check(frm_name, field_name, field_caption);
	if (res)
		return res;

	if (typeof(document.forms[frm_name].elements[field_name])=='undefined')
		return '';

	if (typeof(document.forms[frm_name].elements[field_name].value)=='undefined')
		return '';

	if (typeof(document.forms[frm_name].elements[cc_type_name])=='undefined')
		return '';

	if (typeof(document.forms[frm_name].elements[cc_type_name].value)=='undefined')
		return '';

	var cc_num = document.forms[frm_name].elements[field_name].value;
	var cc_type=document.forms[frm_name].elements[cc_type_name].value;

	cc_parametr={};
	cc_parametr["VISA"]={};
	cc_parametr["VISA"].val_len=1;
	cc_parametr["VISA"].val={};
	cc_parametr["VISA"].val_sht=1;
	cc_parametr["VISA"].val[1]="4";
	cc_parametr["VISA"].len={};
	cc_parametr["VISA"].len_sht=2;
	cc_parametr["VISA"].len[1]=13;
	cc_parametr["VISA"].len[2]=16;
	cc_parametr["MASTERCARD"]={};
	cc_parametr["MASTERCARD"].val_len=2;
	cc_parametr["MASTERCARD"].val={};
	cc_parametr["MASTERCARD"].val_sht=5;
	cc_parametr["MASTERCARD"].val[1]="51";
	cc_parametr["MASTERCARD"].val[2]="52";
	cc_parametr["MASTERCARD"].val[3]="53";
	cc_parametr["MASTERCARD"].val[4]="54";
	cc_parametr["MASTERCARD"].val[5]="55";
	cc_parametr["MASTERCARD"].len={};
	cc_parametr["MASTERCARD"].len_sht=1;
	cc_parametr["MASTERCARD"].len[1]=16;
	cc_parametr["AMEX"]={};
	cc_parametr["AMEX"].val_len=2;
	cc_parametr["AMEX"].val={};
	cc_parametr["AMEX"].val_sht=2;
	cc_parametr["AMEX"].val[1]="34";
	cc_parametr["AMEX"].val[2]="37";
	cc_parametr["AMEX"].len={};
	cc_parametr["AMEX"].len_sht=2;
	cc_parametr["AMEX"].len[1]=15;
	cc_parametr["AMEX"].len[2]=16;
	cc_parametr["DISCOVER"]={};
	cc_parametr["DISCOVER"].val_len=4;
	cc_parametr["DISCOVER"].val={};
	cc_parametr["DISCOVER"].val_sht=1;
	cc_parametr["DISCOVER"].val[1]="6011";
	cc_parametr["DISCOVER"].len={};
	cc_parametr["DISCOVER"].len_sht=1;
	cc_parametr["DISCOVER"].len[1]=16;
	cc_parametr["DINERS"]={};
	cc_parametr["DINERS"].val_len=2;
	cc_parametr["DINERS"].val={};
	cc_parametr["DINERS"].val_sht=2;
	cc_parametr["DINERS"].val[1]="36";
	cc_parametr["DINERS"].val[2]="38";
	cc_parametr["DINERS"].len={};
	cc_parametr["DINERS"].len_sht=2;
	cc_parametr["DINERS"].len[1]=14;
	cc_parametr["DINERS"].len[2]=16;
	cc_parametr["JCB"]={};
	cc_parametr["JCB"].val_len=1;
	cc_parametr["JCB"].val={};
	cc_parametr["JCB"].val_sht=1;
	cc_parametr["JCB"].val[1]="3";
	cc_parametr["JCB"].len={};
	cc_parametr["JCB"].len_sht=2;
	cc_parametr["JCB"].len[1]=15;
	cc_parametr["JCB"].len[2]=16;

	var flag_len_ok=false;
	for (var i=1; i<=cc_parametr[cc_type].len_sht; i++) {
		if (cc_parametr[cc_type].len[i]==cc_num.length)
			flag_len_ok=true;
	}

	if (!flag_len_ok)
		return field_caption+' has a wrong length \n ';

	var flag_src_ok=false;
	for (var i=1; i<=cc_parametr[cc_type].val_sht; i++) {
		if (cc_parametr[cc_type].val[i]==cc_num.substring(0, cc_parametr[cc_type].val_len))
			flag_src_ok=true;
	}

	if (!flag_src_ok)
		return field_caption+' is Invalid \n ';
	return '';
}

function LookOnlyDefault(frm_name){
	if(document.forms[frm_name].search_IS_DEFAULT.checked === true){
		document.forms[frm_name].search_NAME_EN.disabled = true;
		document.forms[frm_name].search_TAG.disabled = true;
		document.forms[frm_name].search_ENABLED.disabled = true;
	}
	else{
		document.forms[frm_name].search_NAME_EN.disabled = false;
		document.forms[frm_name].search_TAG.disabled = false;
		document.forms[frm_name].search_ENABLED.disabled = false;
	}
}

/*function apply_rich_editor_text(frm_name, field_name)

{
	if (typeof(save_in_textarea_all)!='undefined' && (typeof(text_areas_already_saved) == 'undefined')){
			text_areas_already_saved = true;
			save_in_textarea_all();
		}
	return '';
}

*/

function check_text_mandatory(frm_name, field_name, field_caption)
{
	/*//apply_rich_editor_text(frm_name, field_name);
	if ((typeof(FCKeditorAPI) != 'undefined')  && (instance = FCKeditorAPI.GetInstance(field_name)))
	 {
  		if (instance.GetHTML()=='')
			{
				return '"' + field_caption + '" is missing \n';
	   		}
	 }
	else*/
	if (typeof(document.forms[frm_name].elements[field_name])=='undefined')
		return '';
	else
	if ((typeof(document.forms[frm_name].elements[field_name].value) != 'undefined') &&
		(typeof(document.forms[frm_name].elements[field_name].value.length) != 'undefined')){
			if ((typeof(get_rich) != 'undefined') && (typeof(get_editor_id) != 'undefined')){
				editor_id = get_editor_id(field_name);
				if (editor_id){
					rich_content = get_rich(field_name);
					//alert(rich_content);
					if (rich_content)
						return '';
					return '"' + field_caption + '" is missing \n';
				}
			}
			if (document.forms[frm_name].elements[field_name].value.length == 0)
				return '"' + field_caption + '" is missing \n';

		}
    return '';
}

function check_radio_mandatory(frm_name, field_name, field_caption)

{
	if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		return '';
	res = true;
	if (typeof(document.forms[frm_name].elements[field_name].length) != 'undefined')
	   {
	    if ((document.forms[frm_name].elements[field_name][0].type=='hidden') &&
			(document.forms[frm_name].elements[field_name].length==2))
			return '';
	    res = false;
	    for (i = 0; i < document.forms[frm_name].elements[field_name].length; i++)
		{
			if (document.forms[frm_name].elements[field_name][i].checked)
			  {
				res = true;
				break;

			  }
		 }
	  }
	 else
	if (!document.forms[frm_name].elements[field_name].checked)
		  res = false;
	if (!res)
		return '"' + field_caption + '" is missing\n';
	return '';
}


function text_email_check(frm_name, field_name, field_caption)

{
	return '';
	if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		return '';
	acc_l = document.forms[frm_name].elements[field_name].value.length;
	if (acc_l > 0)
		{
			e_len = document.forms[frm_name].elements[field_name].value.length;
     		at_pos = document.forms[frm_name].elements[field_name].value.indexOf('@');
	 		dot_pos = document.forms[frm_name].elements[field_name].value.indexOf('.');
     		if ((at_pos <0) || (dot_pos <0) || ((dot_pos - at_pos) == 1)   ||
				(document.forms[frm_name].elements[field_name].value.charAt(e_len-1) == '.'))
				return 'Value entered for "' +field_caption + '" doesn\'t seem to be a correct e-mail\n';
			}
	return '';
}

function generic_mandatory_check(frm_name, field_name, field_caption){
   
	if ($($('FORM[NAME='+frm_name+']').find("INPUT[name='"+field_name+"'], SELECT[name='"+field_name+"'], TEXTAREA[name='"+field_name+"']")).hasClass('non_mandatory'))
		return '';
	$($('FORM[NAME='+frm_name+']').find("INPUT[name='"+field_name+"']")).addClass('mandatory');
	$($('FORM[NAME='+frm_name+']').find("SELECT[name='"+field_name+"']")).addClass('mandatory');
	$($('FORM[NAME='+frm_name+']').find("TEXTAREA[name='"+field_name+"']")).addClass('mandatory');
	
	return '';
	var tpy;
	tpy = null;
	if (typeof(document.forms[frm_name].elements)=='undefined')
		return 'Invalid form name or form is not defined: ' + frm_name + ' also you might have more then one form with this name under IE';
	if (typeof(document.forms[frm_name].elements[field_name])!='undefined'){
		if (typeof(document.forms[frm_name].elements[field_name].type) != 'undefined')
			tpy=document.forms[frm_name].elements[field_name].type;
		else{
			if (typeof(document.forms[frm_name].elements[field_name].length) != 'undefined')
				tpy = document.forms[frm_name].elements[field_name][0].type;
		}
	}

	if(tpy == undefined || tpy == null )
		return '';
	if (tpy=='unknown')
	 return '';
	if (tpy=='radio'){

		return check_radio_mandatory(frm_name, field_name, field_caption);
	}

	if ((tpy=='text') || (tpy=='password') || (tpy=='select-one') || (tpy=='select') || (tpy=='hidden') || (tpy=='file') ||  (tpy=='textarea'))
		return check_text_mandatory(frm_name, field_name, field_caption) + check_db_reference(frm_name, field_name, field_caption);
	if (tpy=='checkbox')
		return check_radio_mandatory(frm_name, field_name, field_caption);
	return tpy + "\n";
}




function get_payment_value(frm_name)

{
	if (typeof(document.forms[frm_name].elements['PMETH']) == 'undefined')
		return false;
	pmeth_field = document.forms[frm_name].elements['PMETH'];
	var pmeth_value = 0;
	if (typeof(pmeth_field.value)=='undefined')
		{
			for(i=0; i< pmeth_field.length; i++)
				if (pmeth_field[i].checked)
					{
						pmeth_value = pmeth_field[i].value;
						break;
					}
		}
	else
		pmeth_value = pmeth_field.value;
	return pmeth_value;
}

function cc_validation(frm_name, field_name, field_caption)
{

	pmeth_value = get_payment_value(frm_name);
	if (!pmeth_value)
		return check_text_mandatory(frm_name, 'CC', 'Credit Card');

	if (pmeth_value != CC_CHOICE_VALUE)
		return '';

	if (typeof(document.forms[frm_name].elements[cc_field_name]) == 'undefined')
		return '';

	var cc_field = document.forms[frm_name].elements[cc_field_name];
	var acc_l = cc_field.value.length;

	if (acc_l<=0)
		return 'The credit card number can not be empty\n';
	if (acc_l < 15)
      {
	      	return 'The credit card number is too short.\n';
      }


     for (i=0; i<acc_l; i++)
	  {
	      ch = cc_field.value.charAt(i);
	       if ((ch<'0') ||(ch>'9'))
	  			return 'Credit card number should not contain any characters except digits!\n';
     }

	if (typeof(document.forms[frm_name].elements['CCTYPE']) == 'undefined')
		return 'Credit Card Type field is missing. Please call tech. support!';

	var cc_type = document.forms[frm_name].elements['CCTYPE'];
	chars_arr = new Array();
	chars_arr[visa_val]='4';
	chars_arr[mastercard_val]='5';
	chars_arr[amex_val]='3';
	chars_arr[discover_val]='6';
    req_char = 0;
	if (chars_arr[cc_type.value])
		req_char = chars_arr[cc_type.value];
	if (req_char && (cc_field.value.charAt(0) != req_char))
	      return 'Credit Card Type field is missing. Please call tech. support!\n';
	return '';
}



function checkTZ(frm_name, field_name, CC_CHOICE_VALUE){
	pmeth_value = get_payment_value(frm_name);
	if (!pmeth_value)
		return '';
	if (pmeth_value != CC_CHOICE_VALUE)
		return '';

	if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		return '';
	var tz_field = document.forms[frm_name].elements[field_name];
	var acc_l = tz_field.value.length;
	if (acc_l > 0)
	{
	      for (i=0; i<acc_l; i++){
	      	ch = document.forms[frm_name].elements[field_name].value.charAt(i);
	      	if ((ch<'0') ||(ch>'9')){
	    	  return 'Card Holder ID should be numeric';
		  	}
	      }

   }
	return '';
}


function cvv_validation(frm_name, field_name, CC_CHOICE_VALUE)

{
	pmeth_value = get_payment_value(frm_name);
	if (!pmeth_value)
		return check_text_mandatory(frm_name, field_name, 'CVV2');

	if (pmeth_value != CC_CHOICE_VALUE)
		return '';

	if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		return '';
	res = check_text_mandatory(frm_name, field_name, 'CVV2');
	if (res!='')
		return res;

	cvv_field = document.forms[frm_name].elements[field_name];


	acc_l = cvv_field.value.length;
    for (i=0; i<acc_l; i++)
		{
      		 ch = cvv_field.value.charAt(i);
		     if ((ch<'0') ||(ch>'9'))
		  		return 'CVV2 number should not contain any characters except digits!\n';
		}
	return '';
}


function state_valiation(frm_name, field_name, prefix, usa_value, canada_value)

{
	tmp = field_name.split('][');
	if (tmp.length==3)
		country_field_name = tmp[0]+']['+ tmp[1] +'][' + prefix + 'COUNTRY]';
	else
		country_field_name = prefix + 'COUNTRY';
	if (
			(typeof(document.forms[frm_name].elements[prefix + 'COUNTRY']) == 'undefined')	||
			(typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		)
		return'';
	var country_field = document.forms[frm_name].elements[country_field_name];
	var this_field = document.forms[frm_name].elements[field_name];

	ex_word = ' ';
	if (prefix =='SHIP')
		ex_word = ' (shipping information) '

	if 	(
		(country_field.value == usa_value) &&
    	((this_field.selectedIndex==0)|| (this_field.selectedIndex>54))
   		)
   			return 'State'+ex_word+'is missing  if USA is selected \n';
	if  ((country_field.value == canada_value) && (this_field.selectedIndex<56))
		   return 'Province'+ex_word+'is missing if Canada is selected\n';
	return '';
}


function get_ship_is_bill_value(frm_name)

{
	if (typeof(document.forms[frm_name].elements['SHIPISBILL']) == 'undefined')
		return false;
	ship_is_bill = document.forms[frm_name].elements['SHIPISBILL'];
	if (typeof(ship_is_bill.length)=='undefined')
		return ship_is_bill.value;
	for(i=0; i< ship_is_bill.length; i++)
		{
			if (ship_is_bill[i].checked)
				return ship_is_bill[i].value;
		}
	return false;

}

function shipping_field_mandatory(frm_name, shipisbill_value, field_name, field_caption)

{
	sh_value = get_ship_is_bill_value(frm_name);
	if (!sh_value)
		return 'Shipping method selection is missing. Call tech support!';
	if (sh_value == shipisbill_value)
		return '';
	if ( (typeof(document.forms[frm_name].shipping_hidden)!='undefined')  &&
		 (document.forms[frm_name].shipping_hidden.value!=0))
		return '';
	return check_text_mandatory(frm_name, field_name, field_caption +' (shipping information) ');
}

function ship_state_valiation(frm_name, field_name, shipisbill_value, usa_value, canada_value)

{
	sh_value = get_ship_is_bill_value(frm_name);
	if (!sh_value)
		return 'Shipping method selection is missing. Call tech support!\n';
	if (sh_value == shipisbill_value)
		return '';
	if ( (typeof(document.forms[frm_name].shipping_hidden)!='undefined')  &&
		 (document.forms[frm_name].shipping_hidden.value!=0))
		return '';

	return state_valiation(frm_name, field_name, 'SHIP', usa_value, canada_value)
}


function zipcode_validation(frm_name, field_name,  field_caption, prefix, usa_value)

{
	if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
			return '';

	tmp = field_name.split('][');
	if (tmp.length==3)
		country_field_name = tmp[0]+']['+ tmp[1] +'][' + prefix + 'COUNTRY]';
	else
		country_field_name = prefix + 'COUNTRY';
	if ((typeof(document.forms[frm_name].elements[country_field_name]) == 'undefined'))
			return text_number_check(frm_name, field_name, field_caption);

	zip_field = document.forms[frm_name].elements[field_name];
	if (zip_field.value.length > 10)
		return 'ZIP code cannot be longer then 10 characters\n';

	country_field = document.forms[frm_name].elements[country_field_name];

	if (country_field.value==usa_value)
		return text_number_check(frm_name, field_name, field_caption);

	acc_l = zip_field.value.length;
	if (acc_l > 0)
		{
	      for (i=0; i<acc_l; i++)
		  {
		      ch = zip_field.value.charAt(i);
		      flg=false;
		      if ((ch>='A') &&(ch<='Z'))
		         flg= true;
		      if ((ch>='a') &&(ch<='z'))
		         flg= true;
		      if ((ch>='0') &&(ch<='9'))
		         flg= true;
		      if (ch=='-')
		         flg= true;
		      if (ch==' ')
		         flg= true;
		      if (!flg)
	  			return 'Field '+field_caption+' should be alpha numeric \n';
		  }
		}
	return '';
}

function ship_zipcode_validation(frm_name, field_name,  field_caption, shipisbill_value, usa_value)
{
	sh_value = get_ship_is_bill_value(frm_name);
	if (!sh_value)
		return 'Shipping method selection is missing. Call tech support!\n'
	if (sh_value == shipisbill_value)
		return '';
	if ( (typeof(document.forms[frm_name].shipping_hidden)!='undefined')  &&
		 (document.forms[frm_name].shipping_hidden.value!=0))
		return '';
	return zipcode_validation(frm_name, field_name,  field_caption, 'SHIP', usa_value)
}

function oracle_mandatory(frm_name, field_name, field_caption, oracle_value)

{
	pmeth_value = get_payment_value(frm_name);
	if (!pmeth_value)
		return '';
	if (pmeth_value != oracle_value)
		return '';
	return check_text_mandatory(frm_name, field_name, field_caption);
}


function intagio_mandatory(frm_name, field_name, field_caption, intagio_value)

{
	pmeth_value = get_payment_value(frm_name);
	if (!pmeth_value)
		return '';
	if (pmeth_value != intagio_value)
		return '';
	return check_text_mandatory(frm_name, field_name, 'INTAGIO User ID and password are mandatory');
}


function itex_mandatory(frm_name, field_name, field_caption, itex_value)

{
	pmeth_value = get_payment_value(frm_name);
	if (!pmeth_value)
		return '';
	if (pmeth_value != itex_value)
		return '';
	return check_text_mandatory(frm_name, field_name, 'ITEX User ID and password are mandatory');
}

function text_number_check(frm_name, field_name, field_caption)

{
	if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		return '';
	if (typeof(document.forms[frm_name].elements[field_name].value) == 'undefined')
		return '';
	acc_l = document.forms[frm_name].elements[field_name].value.length;
	if (acc_l > 0)
	  {
	    for (i=0; i<acc_l; i++)
		{
		  	ch = document.forms[frm_name].elements[field_name].value.charAt(i);
	    	if (((ch<'0') ||(ch>'9')) && (ch!='-') && (ch!='.'))
			  	{
					return '"' + field_caption + '" should be numeric\n';
				}
		}
	  }
	return '';
}

function dd_mandatory_check(frm_name, field_name, field_caption)

{
  if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		return '';
  if (document.forms[frm_name].elements[field_name].value < 0)
		return '"' + field_caption + '" is missing\n';
  return '';
}

function date_format_check(frm_name, field_name, field_caption)

{
	if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		return '';
	if (document.forms[frm_name].elements[field_name].value.length == 0)
		return '';
	if ( (document.forms[frm_name].elements[field_name].value.length != 10) ||
		 ( (document.forms[frm_name].elements[field_name].value.charAt(2) != '-') &&
		   (document.forms[frm_name].elements[field_name].value.charAt(2) != '.') &&
		   (document.forms[frm_name].elements[field_name].value.charAt(2) != '/')

		 ) ||
		 (
		 	(document.forms[frm_name].elements[field_name].value.charAt(5) != '-') &&
		 	(document.forms[frm_name].elements[field_name].value.charAt(5) != '.') &&
		 	(document.forms[frm_name].elements[field_name].value.charAt(5) != '/')
		 )
	   )
		  return 'Invalid date format for "' + field_caption + '", must be MM-DD-YYYY\n';
	  if (eval(document.forms[frm_name].elements[field_name].value.substr(6, 4) +
	  		   document.forms[frm_name].elements[field_name].value.substr(0, 2) +
			   document.forms[frm_name].elements[field_name].value.substr(3, 2)) == 0)
	 	 return  'Invalid date format for "' + field_caption + '", only digits are allowed \n';
	return '';
}


///added by Andrew
function time_format_check(frm_name, field_name, field_caption)

{
	if (typeof(document.forms[frm_name].elements[field_name]) == 'undefined')
		return '';
	if (document.forms[frm_name].elements[field_name].value.length == 0)
		return '';

	timeval = document.forms[frm_name].elements[field_name].value;
	//var timeformat=new RegExp("^\\d{1,2}:\\d{1,2}:*\\d{0,2}$", "g");
var timeformat=new RegExp("^\\d{1,2}:\\d{1,2}", "g");
	if (timeval.search(timeformat)==-1) //if match failed
		return 'Invalid time format for "' + field_caption + '", must be HH:MM (hours and minutes separated by ":", only digits are allowed) \n';

	return '';
}
////////


function get_element_by_id(element_id){
	var DOM=(document.getElementById)?true:false;
 	var IE4=(document.all)?true:false;
 	var element = (DOM)?document.getElementById(element_id):((IE4)?document.all[element_id]:null);
 	return element;
}


function set_inner_html(element_id, text){
	element = get_element_by_id(element_id);
 	if (element)
 		element.innerHTML = text;
}

function SetVisibleById(element_id, show) {
 var DOM=(document.getElementById)?true:false;
 var IE4=(document.all)?true:false;
 var element = (DOM)?document.getElementById(element_id):((IE4)?document.all[element_id]:null);
 if (element == null)
 	return;
 var divstyle = element.style;
  if (show == 2) {
  	if (divstyle.display != 'inline') divstyle.display='inline';
 } else if (show == 1) {
 	if (divstyle.display != '') divstyle.display='';
 } else if (show == 0) {
 	if (divstyle.display != 'none') divstyle.display='none';
 }
}

function SetVisibleFormFieldByName(formName,elementName, show) {

 var DOM=(document.getElementById)?true:false;
 var IE4=(document.all)?true:false;
 var element = document.forms[formName].elements[elementName];
  if (show == 2) {
	element.style.display='inline';
 } else if (show == 1) {
 	element.style.display='';
 } else if (show == 0) {
 	element.style.display='none';
 }
}



//Toggles the visibility of the element with the given name
//If visible, make hidden. If hidden, make visible.
function ShowHideById(element_id) {
 var divstyle = document.getElementById(element_id).style;
 if (divstyle.display != 'none')
 	divstyle.display = 'none';
 else
 	divstyle.display = '';
}


function toggle_visible(element_id1, element_id2)

{
	ShowHideById(element_id1);
	ShowHideById(element_id2);
}


function setCookie(name, value, expires, path, domain, secure) {
		var curCookie = name + "=" + escape(value) +
				((expires) ? "; expires=" + expires.toGMTString() : "") +
				((path) ? "; path=" + path : "") +
				((domain) ? "; domain=" + domain : "") +
				((secure) ? "; secure" : "");
		document.cookie = curCookie;
	}

// name - name of the desired cookie
// * return string containing value of specified cookie or null if cookie does not exist
function getCookie(name) {
		var dc = document.cookie;
		var prefix = name + "=";
		var begin = dc.indexOf("; " + prefix);
		tmp = begin;
		while(true){
			tmp = dc.indexOf("; " + prefix, tmp+1);
			if (tmp>0){
				begin=tmp;
				continue;
			}
			break;
		}
		if (begin == -1) {
			begin = dc.indexOf(prefix);
			if (begin != 0) return null;
		} else
			begin += 2;
		var end = document.cookie.indexOf(";", begin);
		if (end == -1)
			end = dc.length;
		return unescape(dc.substring(begin + prefix.length, end));
	}

function getCookie_as_int(name){
	if (!isNaN(getCookie(name))){
			if (getCookie(name)=='1')
				return 1;
		}
	return 0;
}

/*
function getCookie(name) {
	var cookie = " " + document.cookie;
	alert(cookie);
	var search = " " + name + "=";
	var setStr = null;
	var offset = 0;
	var end = 0;
	if (cookie.length > 0) {
		offset = cookie.indexOf(search);
		if (offset != -1) {
			offset += search.length;
			end = cookie.indexOf(";", offset)
			if (end == -1) {
				end = cookie.length;
			}
			setStr = unescape(cookie.substring(offset, end));
		}
	}
	return(setStr);
}*/


function getCookie_as_int(name){
	if (!isNaN(getCookie(name))){
			if (getCookie(name)=='1')
				return 1;
	}
	return 0;
}

function deleteall(form_name)
	{
		document.forms[form_name].elements['ac'].value = 'delete';
		if ( confirm('Delete is irreversible, are you sure?') )
	   		document.forms[form_name].submit();
	}

function deleteall_custom(form_name, action)
	{
		document.forms[form_name].elements['ac'].value = action;
		if ( confirm('Delete is irreversible, are you sure?') )
	   		document.forms[form_name].submit();
	}

function deleteall_NEW(form_name)
	{
		document.forms[form_name].elements['ac'].value = 'delete';
		if ( confirm('Delete is irreversible, are you sure?') )
	   		document.forms[form_name].submit();
	}


function updateall(form_name)

{
	$($('FORM[NAME='+form_name+']').find("INPUT[name='ac']")).attr('value', 'update');
	$('FORM[NAME='+form_name+']').submit();
	return;
}


function printall(form_name)

{
	document.forms[form_name].elements['ac'].value = 'print';
	document.forms[form_name].submit();
}

function updateall_custom(form_name, action)

{
	$($('FORM[NAME='+form_name+']').find("INPUT[name='ac']")).attr('value', action);
	$('FORM[NAME='+form_name+']').submit();
	return;
}

function select_all(table_name){
	var all = $("input[name='SELECTED[" + table_name + "][]']").length;
	var checked = $("input[name='SELECTED[" + table_name + "][]']:checked").length;
	if((all - checked) > checked)
		$("input[name='SELECTED[" + table_name + "][]']").attr("checked","checked");
	else
		$("input[name='SELECTED[" + table_name + "][]']").removeAttr("checked");
}

function add_mandatory_field(field_name, field_caption)

{
	i = 0;
	if (typeof(mandatory_fields_arr) != 'undefined')
		i = mandatory_fields_arr.length;
	mandatory_fields_arr[i] = field_name;
	mandatory_fields_names_arr[i] = field_caption;

}

var mandatory_fields_arr = new Array();
var mandatory_fields_names_arr = new Array();

function do_clone(form_name)
{
	document.forms[form_name].ac.value = 'clone';
	document.forms[form_name].submit();
}

function OpenWindowXY(url, name, l, t, w, h){
	popupWin=window.open(url, name, 'scrollbars=yes,width='+w+',height='+h+',left='+l+',top='+t);
	popupWin.focus();
}

function OpenWindow(url, name)
{
	 popupWin=window.open(url, name, 'scrollbars=yes,width=600,height=400,left=50,top=100');
}

// functions for wor with CSS classes - Vallar_FE
function GetClassCSS(element_id){
		var DOM=(document.getElementById)?true:false;
        var IE4=(document.all)?true:false;
		var element = (DOM)?document.getElementById(element_id):((IE4)?document.all[element_id]:null);
		return element.className;
}

function GetClassCSS_CurrentItem(element){
		return element.className;
}

function GetClassRule(theClass,element){
	 var DOM=(document.getElementById)?true:false;
     var IE4=(document.all)?true:false;
	 var cssRules = (IE4)?'rules':((DOM)?'cssRules':null);
	 if(cssRules != null){
	   for (var S = 0; S < document.styleSheets.length; S++){
	   	 for (var R = 0; R < document.styleSheets[S][cssRules].length; R++) {
	        if (document.styleSheets[S][cssRules][R].selectorText.toLocaleLowerCase() == theClass.toLocaleLowerCase()) {
	            return document.styleSheets[S][cssRules][R].style[element];
	        }
	     }
	   }
	 }

}

function ChangeCSS(theClass,element,value) {
	 var DOM=(document.getElementById)?true:false;
     var IE4=(document.all)?true:false;
	 var cssRules = (IE4)?'rules':((DOM)?'cssRules':null);
	 if(cssRules != null){
	   for (var S = 0; S < document.styleSheets.length; S++){
	     for (var R = 0; R < document.styleSheets[S][cssRules].length; R++) {
	        if (document.styleSheets[S][cssRules][R].selectorText.toLocaleLowerCase() == theClass.toLocaleLowerCase()) {
	            document.styleSheets[S][cssRules][R].style[element] = value;
	            return true;
	        }
	     }
	   }
	 }
}


	function HideTemplates(){
		if(GetClassRule('.template_link_to_file','display')!='none'){
			ChangeCSS('.template_link_to_file','display','none');
			ChangeCSS('.template_link_to_file_img','display','block');
			setCookie('templates_hide', '1');
		}
		else{
			ChangeCSS('.template_link_to_file','display','block');
			ChangeCSS('.template_link_to_file_img','display','none');
			setCookie('templates_hide', '0');
		}
	}

    function popup(fileName,x,y,wn) {
            smallWin = window.open(fileName,'more_imgs'+wn,'scrollbars=yes,status=no,resizable=yes,width=' + x + ',height=' + y + '');
          }


    function submit_and_go(next_page){
	if (confirm('This will also save current changes, continue?'))
		{
			document.main_interface_form.NEXT_PAGE.value = next_page;
			document.main_interface_form.submit();
		}
	}

	function ChangePlusPict(plusPict,minusPict,val){

	}

	var xml_perLevelIDS = new Array();

	function xml_AddPerLevelIDS(ids,level){
		ids = ids.split(',');
		if(xml_perLevelIDS[level] == undefined){
			xml_perLevelIDS[level] = new Array()
		}
		if(ids.length > 0 && xml_perLevelIDS[level]){
			for(i = 0; i<ids.length; i++){
				xml_perLevelIDS[level][xml_perLevelIDS[level].length] = ids[i];
			}
		}
	}

	function HideIDS(id_string,level){
	 var DOM=(document.getElementById)?true:false;
     var IE4=(document.all)?true:false;
		if(xml_perLevelIDS[level] == undefined){
			return '';
		}
		ids = id_string.split(',');
		if(ids.length > 0 && xml_perLevelIDS[level]){
			for(i = 0; i<xml_perLevelIDS[level].length; i++){
				element_id = xml_perLevelIDS[level][i];
				element = (DOM)?document.getElementById(element_id):((IE4)?document.all[element_id]:null);
				element.style.display = 'none';
			}

			for(i = 0; i<ids.length; i++){
				element_id = ids[i];
				element = (DOM)?document.getElementById(element_id):((IE4)?document.all[element_id]:null);
				if(element.style.display == 'none'){
				element.style.display = '';
				}
				else{
				element.style.display = 'none'
				}
			}
		}
	}


function get_radio_value(form_name, field_name){
	if (typeof(document.forms[form_name].elements[field_name]) == 'undefined')
		return;
	if ((typeof(document.forms[form_name].elements[field_name].checked) == 'undefined') &&
		(typeof(document.forms[form_name].elements[field_name].length) != 'undefined')){
			for (i=0; i< document.forms[form_name].elements[field_name].length; i++)
			  if (document.forms[form_name].elements[field_name][i].checked)
			  	return document.forms[form_name].elements[field_name][i].value;
	}
	else
	if (document.forms[form_name].elements[field_name].checked)
	 return  document.forms[form_name].elements[field_name].value;
	return null;
}

function set_radio_value(form_name, field_name, value){
	if (typeof(document.forms[form_name].elements[field_name]) == 'undefined')
		return;
	if ((typeof(document.forms[form_name].elements[field_name].checked) == 'undefined') &&
		(typeof(document.forms[form_name].elements[field_name].length) != 'undefined')){
		for(i=0; i<document.forms[form_name].elements[field_name].length; i++)
			if (document.forms[form_name].elements[field_name][i].value == value){
				document.forms[form_name].elements[field_name][i].checked = true;
				break;
			}
		return;
	}
	if (typeof(document.forms[form_name].elements[field_name].checked) != 'undefined')
		document.forms[form_name].elements[field_name].checked = document.forms[form_name].elements[field_name].value == value;
}


function is_array(form_name, element_name){
	return typeof(document.forms[form_name].elements[element_name].length) != 'undefined';
}

function hidecat(){
	catbox = document.getElementById("pu_cats");
	catbox.style.visibility='hidden';
	catbox.style.zIndex=-1;
}
function showcat(){
	catbox = document.getElementById("pu_cats");
	catbox.style.visibility='visible';
	catbox.style.zIndex=2;
}

function hidecat2(){
	catbox = document.getElementById("pu_cats");
	catbox.style.visibility='hidden';
	//catbox.style.zIndex=-1;
}
function showcat2(){
	catbox = document.getElementById("pu_cats");
	catbox.style.visibility='visible';
	//catbox.style.zIndex=2;
}

//Currently used on JWR
function font_sizer_4class(css_class_name, inc){
	var curr_fnt_size = GetClassRule(css_class_name, 'fontSize');


	var fnt_size_int = curr_fnt_size.substring(0, curr_fnt_size.length-2);
	var fnt_unit = curr_fnt_size.substring(curr_fnt_size.length-2);
	fnt_size_int = parseInt(fnt_size_int) + parseInt(inc);
	ChangeCSS(css_class_name, 'fontSize', fnt_size_int + fnt_unit);
}

function font_set_4class(css_class_name, font_size, units){
	ChangeCSS(css_class_name, 'fontSize', font_size+units);
}


/*
var initSize = 1;
var tags = new Array('div','td','tr','p','b','span','table','strong','emphasis','a','h1',
'h2','h3','pre','sub','sup','i','th','cp','ul','ol','li','dt','dd');
var pixelArray = new Array('8','10','12','14','16','18','20');
var emArray = new Array('0.7','0.9','1.0','1.5','2.0','2.5','3');


//Font Size changes:
function font_sizer(inc,unit) {
	if (!document.getElementById)
	 return;
	var size = initSize;
	size += inc;
	if (size < 0 ) {
		size = 0;
	}
	if (size > 6 ) {
		size = 6;
	}
	initSize = size;
	getBody = document.getElementsByTagName('body')[0];
	for (i = 0 ; i < tags.length ; i++ ) {
		getallTags = getBody.getElementsByTagName(tags[i]);
		for (k = 0 ; k < getallTags.length ; k++)
	 	getallTags[k].style.fontSize = (unit=='px') ? pixelArray[size]+unit: emArray[size]+unit;
	}
}
*/


// Add to favorits:
function CreateBookmarkLink() {
	if (window.sidebar) {
		// Mozilla Firefox Bookmark
		window.sidebar.addPanel(document.title, location.href,"");
	}
	else
	if( window.external ) {
		// IE Favorite
		window.external.AddFavorite(location.href, document.title);
	}else
	if(window.opera && window.print) {
		// Opera Hotlist
		return true;
	}
}

//Make us your homepage
//this.style.behavior='url(#default#homepage)';this.setHomePage('$SITEHOME');


//Following function finds an absolute position of an element.
function findPos(obj) {
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		do {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
		} while (obj = obj.offsetParent);
	}
	return [curleft,curtop];
}

//<!--onKeyPress="if (event.keyCode==13) if((this.value - 10*Math.floor(this.value/10))!=0) {this.value=(10*Math.round(this.value/10)); if (this.value==0) this.value=10;   alert('This item must be ordered in multiples of 10 '); event.returnValue=false; } "; onblur="if((this.value - 10*Math.floor(this.value/10))!=0) {this.value=(10*Math.round(this.value/10)); if (this.value==0) this.value=10;   alert('This item must be ordered in multiples of 10 '); event.returnValue=false; }"-->
function check_q_breaks(input, q_break, message)
{
	quantity = Number(input.value);
	q_break = Number(q_break);

	if (message == null){
		message = 'This item must be ordered in multiples of ' + q_break;
	}
	//alert(q_break);
	if(((quantity * 1) % q_break) == 0)
		return true;

	quantity=(q_break*Math.round(quantity/q_break));

	if (quantity==0)
		quantity=q_break;
	input.value = quantity;

	if (message)
		alert(message);
	return false;
}

function is_array( mixed_var ) {
    return ( mixed_var instanceof Array );
}


function form_copy_and_submit(form_src_name, form_dst_name, cursor_src, cursor_dst, exclude_fields, validate_before_submit_name, submit_dst, submit_via_jax, async) {
	if ((typeof(document.forms[form_src_name]) == 'undefined') || (typeof(document.forms[form_dst_name]) == 'undefined'))
		return'';

	form_src = document.forms[form_src_name];
	form_dst = document.forms[form_dst_name];
	elements_src = form_src.elements;
	exclude = is_array(exclude_fields);


	for(i=0; i < elements_src.length; i++)
	{

		if(elements_src[i].name.substr(0, cursor_src.length) == cursor_src)
		{

			pattern_text = "\[[\w]*\]";
			var pattern = new RegExp(cursor_src+"\\[(([\\w])+)\]", "g");
			clear_name = elements_src[i].name.replace(pattern, "$1");

			// Create a text field
			new_field_name = cursor_dst+'['+clear_name+']';
			new_field_value = elements_src[i].value;
			if(elements_src[i].type == 'checkbox')
			{
				if(!elements_src[i].checked)
				new_field_value = 0;
			}
			if(typeof(form_dst.elements[new_field_name]) == 'undefined')
			{
				if(navigator.appVersion.indexOf("MSIE") != -1)
				{
				add_field = document.createElement('<input type="hidden" name="'+new_field_name+'">');
				}
				else
				{
				add_field = document.createElement('INPUT');
			 	add_field.type = 'hidden';
			 	add_field.setAttribute('Name', new_field_name);
				}
			 	add_field.setAttribute('value', new_field_value);
			 	form_dst.appendChild(add_field);
			}
			else
			{
				form_dst.elements[new_field_name].value = new_field_value;
			}

		}
	}
	if(submit_dst)
	{
		if(validate_before_submit_name && typeof(validate_before_submit_name) == 'function')
		{
			if(!validate_before_submit_name(form_dst_name))
			return false;
		}

		if(submit_via_jax)
		{
			submit_params = form_elements2get_params(form_dst_name);
			jax_responce = open_with_ajax('index.php', '', false, false, submit_params);

			if(jax_responce.length)
			return true;

			return false;
		}
		else
		{
			form_dst.submit();
		}
	}

}

function form_elements2get_params(form_name)
{
	if(typeof(document.forms[form_name]) == 'undefined')
		return new array();

	form = document.forms[form_name];
	elements = form.elements;

	params_str = '';

	for(i=0; i < elements.length; i++)
	{
		value = elements[i].value;
		params_str += elements[i].name+'='+escape(value)+'&';
	}

    return params_str;
}


function rating_stars(id, rate, hover, hover_rate)
{
	for(i=1; i <=5; i++)
	{
		curr_img = get_element_by_id('rate_star_'+i+'_'+id);
		curr_img.src = 'images/stars/star_gray_lite' + rate + '.gif';
		/*if(rate >= i)
		else curr_img.src = 'images/stars/star_gray_lite.gif';*/

		if(hover)
		{
			if(hover_rate)
			{
				if(hover_rate >= i) curr_img.src = 'images/stars/star_red' + rate + '.gif';
			}
		}
	}
	//alert(id);

}


function get_form_field(form, field_name){
	form =  (typeof(form) == "string") ? document.forms[form] : form;
	if(typeof(form.elements[field_name]) == "undefined")
		return false;
	return form.elements[field_name];
}

//Universal function for viewing objects
//Added by GenNa 17:11 12.03.2009
//Gena, you can't add a function with a name "print"!!! For Christ sake, what were you thinking? 
//I renamed the following code
//function print (str) { 
var doc;
function print4debug (str) {
	if (!doc) {
		doc = window.open('about:blank');
		doc = doc.document;
		doc.open();
	}
	doc.write(str);
}
function print_r (obj, NewWin) {
	var str = '';
	for (var key in obj) {
		if (str!='') str+= '\n';
		str+= key + '\t' + obj[key];
	}
	if (NewWin) print4debug(str);
	else window.alert(str);
}

//Javascript equivalent to PHP's count()
//Added by GenNa 17:11 12.03.2009
function count( mixed_var, mode ) {
    var key, cnt = 0;
 
    if( mode == 'COUNT_RECURSIVE' ) mode = 1;
    if( mode != 1 ) mode = 0;
 
    for (key in mixed_var){
        cnt++;
        if( mode==1 && mixed_var[key] && (mixed_var[key].constructor === Array || mixed_var[key].constructor === Object) ){
            cnt += count(mixed_var[key], 1);
        }
    }
 
    return cnt;
}

//Javascript equivalent to PHP's isset()
//Added by GenNa 17:11 12.03.2009
function isset( mixed_var ) {
    var i = 0, argc = arguments.length, argv = arguments, set=true;
 
    for (i = 0; i< argc; i++){
        if( argv[i] === undefined ){
            set = false;
            break;
        }
    }
 
    return set;
}

//Javascript equivalent to PHP's function_exists()
//Added by GenNa 21:11 18.03.2009
function function_exists( function_name ) {
    if (typeof function_name == 'string'){
        return (typeof window[function_name] == 'function');
    } else{
        return (function_name instanceof Function);
    }
}

//Javascript equivalent to PHP's empty()
//Added by GenNa 21:11 18.03.2009
function empty( mixed_var ) { 
 
    return ( mixed_var === "" || mixed_var === 0   || mixed_var === "0" || mixed_var === null  || mixed_var === false  ||  ( is_array(mixed_var) && mixed_var.length === 0 ) );
}

//Javascript equivalent to PHP's in_array()
//Added by GenNa 21:11 24.03.2010
function in_array (needle, haystack, argStrict) {
  var key = '', strict = !!argStrict;

  if (strict) {
      for (key in haystack) {
          if (haystack[key] === needle) {
              return true;
          }
      }
  } else {
      for (key in haystack) {
          if (haystack[key] == needle) {
              return true;
          }
      }
  }

  return false;
}

function open_video(video_div_id, sitehome, id, default_dir, clip, type){
		set_inner_html(video_div_id, open_with_ajax(sitehome+'?section=plain_list&ac=video&params[page_idx]=0&params[no_write]=1&params[autostart]=1&$MKTIME&MODULE_PARAMS=NUMONPAGE%3d1%26ENTIRE_LIST_TEMPLATE%3d'+video_div_id+'_list.html%26ITEM_TEMPLATE%3d'+video_div_id+'_item.html%26EX_WHERE%3d%20AND%20a.`ID`%3d%3d'+id, video_div_id, '', false));
		
		//if (type != 'file')
			return;
		var so = new SWFObject(sitehome+"js/flvplayer.swf?theFile="+sitehome+default_dir+"files/video_clips/"+clip+"&defaultImage="+sitehome+"picts/video_clips/graphic.jpg&theVolume=75&startPlayingOnload=no&popUpHelp=no&bufferSeconds=2&videoSmoothing=yes","flvplayer","370","280","8","#000000");
		so.addParam("movie",sitehome+"js/flvplayer.swf?theFile="+sitehome+default_dir+"files/video_clips/"+clip+"&defaultImage="+sitehome+"picts/video_clips/graphic.jpg&theVolume=75&startPlayingOnload=no&popUpHelp=no&bufferSeconds=2&videoSmoothing=yes");
		so.addParam("bgcolor","#000000");
		so.write("flashcontent");
}
