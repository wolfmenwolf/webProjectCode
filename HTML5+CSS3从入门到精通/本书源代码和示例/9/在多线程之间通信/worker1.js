onmessage = function(event) {
	var intArray=new Array(200);    
	for(var i=0;i<200;i++)
		intArray[i]=parseInt(Math.random()*200);
	postMessage(JSON.stringify(intArray));
	close();
}

