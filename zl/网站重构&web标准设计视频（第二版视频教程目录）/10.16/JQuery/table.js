$(function(){ 
	$('tbody > tr:odd').addClass('odd');
	
	$('tbody > tr').hover(function(){
		$(this).addClass('hover');						   
	},function(){
		$(this).removeClass('hover');
	}).click(function(){
		if($(this).hasClass('checked')){
			$(this).removeClass('checked')
				   .find(':checkbox').attr('checked',false)
				   .end()
				   .removeClass('hover');
		}else{
			$(this).addClass('checked')
				   .find(':checkbox').attr('checked',true);
		}
	});
	
	$(':checkbox').css({width:'13px',height:'13px'});
	
	$('.search').focus(function(){
		$(this).addClass('highligth');
	}).blur(function(){
		$(this).removeClass('highligth');
	});
	
	$('.delete_btn,.edit_btn').click(function(){
		return false;
	})
});