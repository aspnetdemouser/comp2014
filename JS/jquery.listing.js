/* =========================================================

// jquery.innerfade.js

// Datum: 2007-01-29
// Firma: Medienfreunde Hofmann & Baldes GbR
// Autor: Torsten Baldes
// Mail: t.baldes@medienfreunde.com
// Web: http://medienfreunde.com

// based on the work of Matt Oakes http://portfolio.gizone.co.uk/applications/slideshow/

// ========================================================= */

var CurrentTabsListingTimeOut = new Array();
var $scroll_elements = new Array();
var scroll_settings = new Array();

(function($) {

$.fn.innerfade = function(options) {

	this.each(function(){
		
		var settings = {
			animationtype: 'fade',
			speed: 'normal',
			timeout: 2000,
			type: 'sequence',
			containerheight: 'auto',
			runningclass: 'innerfade',
			classname: 'tabs_listing',
			use_tabs: 1,
			main_tab: 0,
			related_tabs: [],
			el: 0
		};
		
		if(options)
			$.extend(settings, options);
		
		scroll_settings[settings.el] = settings;
		var elements = $(this).children();
		$scroll_elements[settings.el] = $(this);
		if(settings.use_tabs)
			$.innerfade.fill_tabs(elements, settings, settings.classname, this);
		
		if (elements.length > 1) {
		
			$(this).css('position', 'relative');
	
			$(this).css('height', settings.containerheight);
			$(this).addClass(settings.runningclass);
			
			for ( var i = 0; i < elements.length; i++ )
				$(elements[i]).css({'z-index':String(elements.length-i),'position':'absolute'}).hide();
			
			$.innerfade.set_links(elements, settings, 0, 0, this);
		
			if ( settings.type == 'sequence' ) {
				CurrentTabsListingTimeOut[settings.el] = setTimeout(function(){
					$.innerfade.next(elements, this, settings, 1, 0);
				}, settings.timeout);
				$(elements[0]).show();
			} else if ( settings.type == 'random' ) {
				CurrentTabsListingTimeOut[settings.el] = setTimeout(function(){
					do { current = Math.floor ( Math.random ( ) * ( elements.length ) ); } while ( current == 0 )
					$.innerfade.next(elements, this, settings, current, 0);
				}, settings.timeout);
				$(elements[0]).show();
			}	else {
				alert('type must either be \'sequence\' or \'random\'');
			}
			
		}
		
	});
};


$.innerfade = function() {}
$.innerfade.fill_tabs = function (elements, settings, className, scroll_el) {

	var tabs = new Array();
	var ids = new Array();
	for ( var i = 0; i < elements.length; i++ ) {
		ids[i] = $(elements[i]).attr("id");
		tabs[i] = $('#' + ids[i] + '_tab').html();
	}
	var parent = $scroll_elements[settings.el].parents("*").get(0);
	var i = 0;
	while ($(parent).find('ul.' + className + '_tabs').length < 1) {
		parent = $(parent).parents("*").get(0);
		if(i>50)
			return true;
		i++;
	}
	for ( var i = 0; i < elements.length; i++ ) {
		var active = (i==0)?' active':'';
		$(parent).find('ul.' + className + '_tabs').append('<li class="tabs_listing_tab' + active + '" id="tab_' + ids[i] + '" rel="' + ids[i] + '">' + tabs[i] + '</li>');
	}
	$(parent).find('ul.' + className + '_tabs').attr("rel",settings.el);
	if (elements.length > 1) {
		$(parent).find('ul.' + className + '_tabs li.tabs_listing_tab')
		.css({'cursor':'pointer'})
		.click(function(){
			clearTimeout(CurrentTabsListingTimeOut[settings.el]);
			if (settings.main_tab)
				$.each(settings.related_tabs,function(i,obj){
					clearTimeout(CurrentTabsListingTimeOut[obj]);
				});
			var parent = $(this).parents("ul").get(0);
			var children = $(parent).children();
			var current_id = $(this).attr('rel');
			var scrolling_el_id = $(parent).attr('rel');
			for ( var i = 0; i< children.length; i++ ) {
				if ($(children[i]).attr("rel") == current_id)
					var current = i;
				if ($(children[i]).hasClass("active"))
					var last = i;
			}
			$.innerfade.next($scroll_elements[scrolling_el_id].children(), $scroll_elements[scrolling_el_id], scroll_settings[scrolling_el_id], current, last, true);
			if (settings.main_tab)
				$.each(settings.related_tabs,function(i,obj){
					$.innerfade.next($scroll_elements[obj].children(), $scroll_elements[obj], scroll_settings[obj], current, last, true);
				});
			clearTimeout(CurrentTabsListingTimeOut[settings.el]);
			if (settings.main_tab)
				$.each(settings.related_tabs,function(i,obj){
					clearTimeout(CurrentTabsListingTimeOut[obj]);
				});
		});
	}
	var $click_box;
	if ($(parent).find('div.' + settings.classname + '_box').length > 0) {
		var click_box_id = $(parent).find('div.' + settings.classname + '_box').get(0);
		$click_box = $(click_box_id);
	}
	else 
		$click_box = $scroll_elements[settings.el];
	$click_box.click(function() {
		if (typeof($(this).attr('href')) != 'undefined' && $(this).attr('href') != '')
			location.href = $(this).attr('href');
	});
}
$.innerfade.stop_scrolling = function (el) {

	$(el).innerfade = function() {};
}
$.innerfade.switch_tabs = function (elements, settings, current, last, scroll_el) {
	$('#tab_' + $(elements[last]).attr("id")).removeClass("active");
	$('#tab_' + $(elements[current]).attr("id")).addClass("active");
	$.innerfade.set_links(elements, settings, current, last, scroll_el);
}
$.innerfade.set_links = function (elements, settings, current, last, scroll_el) {
	var $click_box;
	var parent = $scroll_elements[settings.el].parents("*").get(0);
	if ($(parent).find('div.' + settings.classname + '_box').length > 0) {
		var click_box_id = $(parent).find('div.' + settings.classname + '_box').get(0);
		$click_box = $(click_box_id);
	}
	else 
		$click_box = $scroll_elements[settings.el];
	if ($('#PROMO_LINK_' + $(elements[current]).attr("id")).length > 0) {
		$click_box
			.css({'cursor':'pointer'})
			.attr('href',$('#PROMO_LINK_' + $(elements[current]).attr("id")).attr('href'));
	} else {
		$click_box
			.css({'cursor':'default'})
			.removeAttr('href');
	}
}
$.innerfade.next = function (elements, scroll_el, settings, current, last, fast) {

	if ( settings.animationtype == 'slide' && !fast ) {
		$(elements[last]).slideUp(settings.speed, $(elements[current]).slideDown(settings.speed));
		$.innerfade.switch_tabs(elements, settings, current, last, scroll_el);
	} else if ( settings.animationtype == 'fade' && !fast ) {
		$(elements[last]).fadeOut(settings.speed);
		$(elements[current]).fadeIn(settings.speed);
		$.innerfade.switch_tabs(elements, settings, current, last, scroll_el);
	} else if ( fast ) {
		$(elements[last]).hide();
		$(elements[current]).show();
		$.innerfade.switch_tabs(elements, settings, current, last, scroll_el);
	} else {
		alert('animationtype must either be \'slide\' or \'fade\'');
	};
	
	if ( settings.type == 'sequence' ) {
		if ( ( current + 1 ) < elements.length ) {
			current = current + 1;
			last = current - 1;
		} else {
			current = 0;
			last = elements.length - 1;
		};
	}	else if ( settings.type == 'random' ) {
		last = current;
		while (	current == last ) {
			current = Math.floor ( Math.random ( ) * ( elements.length ) );
		};
	}	else {
		alert('type must either be \'sequence\' or \'random\'');
	};
	CurrentTabsListingTimeOut[settings.el] = setTimeout((function(){$.innerfade.next(elements, scroll_el, settings, current, last);}), settings.timeout);
};
})(jQuery);
/* 	$('#about').innerfade({
	 speed: 2000,
	 timeout: 3000,
	 containerheight: '120px',
	});
*/