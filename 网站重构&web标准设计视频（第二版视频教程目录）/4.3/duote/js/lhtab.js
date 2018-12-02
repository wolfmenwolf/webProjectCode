function d(i){
	var i;
	document.getElementById("tabt").className="tabtD"+i;
	window.name=i;//window.name°æ
}
onload=function(){
	var a=document.links;
	for(var i=0;i<a.length;i++)a[i].onfocus=function(){this.blur();}
}
