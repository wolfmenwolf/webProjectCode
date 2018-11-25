var Checker = new function() {
    this._url = "checker.jsp";          //服务器端文件地址
    this._infoDivSuffix = "CheckDiv";   //提示信息div的统一后缀

    //检查普通输入信息
    this.checkNode = function(_node) {
        var nodeId = _node.id;          //获取节点id

        if (_node.value!="") {
            var xmlHttp=this.createXmlHttp();                       //创建XmlHttpRequest对象
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    //调用showInfo方法显示服务器反馈信息
                    Checker.showInfo(nodeId + Checker._infoDivSuffix, xmlHttp.responseText);
                }
            }
            xmlHttp.open("POST", this._url, true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("name=" + encodeURIComponent(_node.id) + 
                         "&value=" + encodeURIComponent(_node.value));//发送包含用户输入信息的请求体
        }
    }

    //显示服务器反馈信息
    this.showInfo = function(_infoDivId, text) {
        var infoDiv = document.getElementById(_infoDivId);  //获取显示信息的div
        var status = text.substr(0,1);      //反馈信息的第一个字符表示信息类型
        if (status == "1") {
            infoDiv.className = "ok";       //检查结果正常
        } else {
            infoDiv.className = "warning";  //检查结果需要用户修改
        }
        infoDiv.innerHTML = text.substr(1); //写回详细信息
    }

    //用于创建XMLHttpRequest对象
    this.createXmlHttp = function() {
        var xmlHttp = null;
        //根据window.XMLHttpRequest对象是否存在使用不同的创建方式
        if (window.XMLHttpRequest) {
           xmlHttp = new XMLHttpRequest();                  //FireFox、Opera等浏览器支持的创建方式
        } else {
           xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器支持的创建方式
        }
        return xmlHttp;
    }

    //检查两次输入的密码是否一致
    this.checkPassword = function() {
        var p1 = document.getElementById("password").value;     //获取密码
        var p2 = document.getElementById("password2").value;    //获取验证密码

        //当两部分密码都输入完毕后进行判断
        if (p1 != "" && p2 != "") {
            if (p1 != p2) {
                this.showInfo("password2" + Checker._infoDivSuffix, "0密码验证与密码不一致。");
            } else {
                this.showInfo("password2" + Checker._infoDivSuffix, "1");
            }
        } else if (p1 != null) {
            this.showInfo("password" + Checker._infoDivSuffix, "1");
        }
    }
}