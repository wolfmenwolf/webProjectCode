// JavaScript Document
$(function(){
	$('#trident .href').click(function(){
		$('#trident').addClass('target');
		$('#geckos').removeClass('target');
		$('#presto').removeClass('target');
		$('#webkit').removeClass('target');
	});
	$('#geckos .href').click(function(){
		$('#trident').removeClass('target');
		$('#geckos').addClass('target');
		$('#presto').removeClass('target');
		$('#webkit').removeClass('target');
	});
	$('#presto .href').click(function(){
		$('#trident').removeClass('target');
		$('#geckos').removeClass('target');
		$('#presto').addClass('target');
		$('#webkit').removeClass('target');
	});
	$('#webkit .href').click(function(){
		$('#trident').removeClass('target');
		$('#geckos').removeClass('target');
		$('#presto').removeClass('target');
		$('#webkit').addClass('target');
	});
});