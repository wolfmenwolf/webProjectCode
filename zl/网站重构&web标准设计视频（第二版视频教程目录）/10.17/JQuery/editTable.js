$(function(){ 
	$('tbody > tr:odd').addClass('odd');
	
	$('tbody > tr').hover(function(){
		$(this).addClass('hover');						   
	},function(){
		$(this).removeClass('hover');
	});
	//获取XHTML文档中的td元素节点
	var tdObj = $('tbody td');
	//给td元素节点绑定一个点击事件
	tdObj.click(function(){
		//创建一个input文本框
		var inputObj = $('<input type="text" />');
		
		var tdObj = $(this);
		if(tdObj.children('input').length > 0){
			return false;
		}
		//获取到td标签中的文本
		var inputText = tdObj.text();
		//将td标签中的文本赋值到input文本框中
		inputObj.val(inputText)
				.width(tdObj.width())
				.css({
					font:'11px Verdana, Arial, Helvetica, sans-serif',
					border:'none',
					background:'#ff6'
				});
		//将td标签中的文本清空
		tdObj.text(" ");
		//将input文本框插入到td标签中
		inputObj.appendTo(tdObj)
				.focus()
				.select();
		//
		inputObj.click(function(){
			return false;
		});
		
		inputObj.keyup(function(e){
			//取回被按下的字符
			var keyCode = e.which;
			if(keyCode == 13){
				var newInputText = $(this).val();
				tdObj.text(newInputText);
				alert('数据更新成功！');
			}
			
			if(keyCode == 27){
				tdObj.text(inputText);
			}
		});
		
	});

});