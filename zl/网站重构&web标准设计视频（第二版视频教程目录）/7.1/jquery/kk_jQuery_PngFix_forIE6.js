$(function() { 
	if($.browser.msie&&$.browser.version=="6.0") { 
		$("img[@src*=png]").each(function() { 
			var s=this.src; 
			this.src="space.gif"; 
			this.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(src="+s+", sizingmethod=scale)"; 
		}); 
	} 
});