(function($){
	$.adialog = {}
	$.adialog.defaults = {
		openers: [],
		closers: [],
		innerClosers: '.close, .close-button',
		modal: 1,
		modalClickClose: 1,
		autoOpen: 0
	}
	
	$.fn.adialog = function(settings) {
			
			var settings, action;
			var $adialog = this;
			var $modalOverlay = $('#modalOverlay').size() ? $('#modalOverlay') : $('<div id="modalOverlay"></div>').css({display: 'none', position: 'absolute', 'z-index': 9999, left: 0, top: 0, width: '100%', height: '100%', background: '#000000', opacity: 0.7, filter: 'alpha(opacity=70)'}).appendTo('body');
			var $outerOpeners = $('.dialogopener, .do');

			if(typeof(settings) == 'object') {
				settings = jQuery.extend({}, $.adialog.defaults, settings);
			}
			else {
				action = settings;
				settings = $.adialog.defaults;
			}
			
			return this.each(function(){
				
				var $item = $(this);
				var $modalOverlayLocal = $modalOverlay.clone();
				
				initItem();
				
				if(action == undefined && typeof(settings) == 'object') {
					if(settings.openers) {
						initOpeners();
						initClosers();
					}
				}
				else {
					switch(action) {
						case 'open':
							showItem();
							break;
						case 'showmodal':
							showModal();
							break;
						case 'hidemodal':
							hideModal();
							break;
						case 'close':
							hideItem();
							break;
					}
				}
				
				if(settings.autoOpen) {
					showItem();
				}
				

				/* Init dialog openers */
				function initOpeners()
				{
					if(typeof(settings.openers) == 'object' && settings.openers.length == undefined) {
						settings.openers = [settings.openers];
					}
					
					if($item.attr('id')) {
						var $outerOpenersLocal = $outerOpeners.filter('[dialog='+$item.attr('id')+']');

						
						if($outerOpenersLocal.size()) {
							$outerOpenersLocal.click(showItem);
						}
					}
					
					$(settings.openers).each(function(){
						var openerData = this;
						
						if(typeof(openerData) == 'object') {
							if(openerData.jquery) {
								openerData.live('click', showItem);
							}
							else if(openerData.event && openerData.object) {
								if(openerData.object.jquery) {
									openerData.object.live(openerData.event, showItem);
								}
							}							
							else if($(openerData).size()) {
								$(openerData).live('click', showItem);
							}
						}
					});
				}

				/* Init dialog closers */
				function initClosers()
				{
					if(typeof(settings.closers) == 'object' && settings.closers.length == undefined) {
						settings.closers = [settings.closers];
					}
					
					$(settings.closers).each(function(){
						var closerData = this;
						
						if(typeof(closerData) == 'object') {
							if(closerData.jquery) {
								closerData.live('click', hideItem);
							}
							else if(closerData.event && closerData.object) {
								if(closerData.object.jquery) {
									closerData.object.live(closerData.event, hideItem);
								}
							}							
							else if($(closerData).size()) {
								$(closerData).live('click', hideItem);
							}
						}
					});
					
					if(typeof(settings.innerClosers) == 'string') {
						$item.find(settings.innerClosers).each(function(){
							$(this).click(hideItem);
						});
					}					
				}

				/* Show dialog */
				function showItem()
				{
					if(settings.modal) {
						$modalOverlay.show();
					}
					$item.show();					
				}
				
				/* Hide dialog */
				function hideItem()
				{
					$item.hide();					
					$modalOverlay.hide();					
				}
				
				/* Show modal */
				function showModal()
				{
					$modalOverlay.show();
				}
				
				/* Hide dialog */
				function hideModal()
				{
					$modalOverlay.hide();					
				}
								
				/* Position dialog at the center of the screen */
				function positionItem()
				{
					var offsetX = $(window).width() / 2 - $item.outerWidth(true) / 2;
					var offsetY = $(window).height() / 2 - $item.outerHeight(true) / 2;		
					
					$item.css({left: offsetX, top: offsetY < 10 ? 10 + $(window).scrollTop() :offsetY + $(window).scrollTop()});

					$modalOverlay.css({width: $(window).width(), height: $(document).height()});				
				}				
				
				/* Init dialog item  */
				function initItemEvents()
				{
					/* Generic listeners */
					$(window).resize(positionItem);			
					
					if(settings.modalClickClose) {
						$modalOverlay.click(hideItem);
					}					
				}
				
				/* Init dialog item  */
				function initItem()
				{
					$item.detach();
					$item.css({position: 'absolute', 'z-index': 10000});
					$item.hide().appendTo('body');
					
					positionItem();	
					
					initItemEvents();				
				}				
			});				
	};
			
})(jQuery);