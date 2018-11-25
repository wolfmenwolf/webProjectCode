onmessage=function(event){
    var intArray=new Array(200);
    for(var i=0;i<200;i++)
        intArray[i]=parseInt(Math.random()*200);
    var worker;
    //创建子线程
    worker=new Worker("worker2.js");
    //把随机数组提交给子线程进行挑选工作
    worker.postMessage(JSON.stringify(intArray));
    worker.onmessage = function(event) {
        //把挑选结果返回主页面
        postMessage(event.data);
    }
}
