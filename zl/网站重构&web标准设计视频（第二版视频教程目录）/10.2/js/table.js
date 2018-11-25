window.onload = function(){
	var click = document.getElementById('click');
	click.onclick = function(){
		alert('my name is Adam!!!');
		alert(typeof click);
	}
	
	var tbody = document.getElementsByTagName('tbody')[0];
	var trs = tbody.getElementsByTagName('tr');
	
	for(var i=0;i<trs.length;i++){
		if(i%2 == 1){
			trs[i].className+="even";	
		}
		trs[i].onmouseover = function(){
			this.className+=" over"
		}
		trs[i].onmouseout = function(){
			this.className=this.className.replace(" over"," ");
		}
	}
	
	var caption = document.getElementById('title');
	//caption.style.background = "#DBECF4";
	caption.className = 'even';
}