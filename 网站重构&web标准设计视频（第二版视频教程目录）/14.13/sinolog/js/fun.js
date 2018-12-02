//导航栏选择状态
$(function(){
	var $menu_li = $('.menu_main li ');
	$menu_li.click(function(){
		$(this).addClass('selected').siblings().removeClass('selected');
	});
});

//显示隐藏菜单
$(function(){
	var $btn_show_hide = $('.btn_show_hide');
	$btn_show_hide.toggle(function(){
		$(this).text('显示菜单');					   
		$('.west').hide();
		$('.east').css({left:'0'});	
		$('.breadcrumbs').css({left:'0'});
	},function(){	
		$(this).text('隐藏菜单');
		$('.west').show();
		$('.east').css({left:'200px'});	
		$('.breadcrumbs').css({left:'200px'});
	});
});

//展开折叠按钮
$(function(){ 
	$('.btn_all_show').click(function(){
		$('.menu_sub dd').show();
		$('.menu_sub dt').css({background:'url(images/icon.png) no-repeat  10px -86px'});
	});
	$('.btn_all_hide').click(function(){
		$('.menu_sub dd').hide();
		$('.menu_sub dt').css({background:'url(images/icon.png) no-repeat  10px -56px'});
	});
});

//动态加载展开折叠
$(function(){ 
	$('.menu_main a').click(function(){
		$('.menu_sub').load($(this).attr('id'));
		$('.east_inner').html('');
		$('.breadcrumbs').hide();
		$('.east').css({background:'#fff url(images/welcome.gif) no-repeat',top:'100px'});
	});
});

//展开折叠菜单
function addMenuSub(obj){
	$(obj).toggleClass('icon');  
	$(obj).nextAll().toggle();
}

//动态加载内容区域
function addContent(obj){ 
	$('.east_inner').load($(obj).attr('id'));
	$('.east').css({background:'#fff',top:'125px'});
	$('.breadcrumbs').show();
	$('.breadcrumbs li:eq(2)').text($(obj).text());
	$('.breadcrumbs li:eq(1)').text($(obj).parent().prev().text());
}







