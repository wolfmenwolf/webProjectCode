<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>服务器监测系统</title>

<style type="text/css">
/* 页面字体样式 */
body, td, input, textarea {
    font-family:Arial;
    font-size:12px;
}

/* 表格基本样式 */
table.default {
    border-collapse:collapse;
    border:1px solid black;
    width:700px;
}

/* 表格单元格样式 */
table.default td {
    border:1px solid black;
    padding:3px;
}

/* 列头样式 */
table.default td.item {
    background:#006699;
    color:#fff;
    text-align:center;
    height:25px;
}

/* 检查正常样式 */
span.ok {
    background:#006600;
    padding:3px;
    color:#FFFFFF;
}

/* 检查错误样式 */
span.error {
    background:#FF0000;
    padding:3px;
    color:#FFFFFF;
}

/* div统一样式 */
div {
    margin:5px;
}
</style>

<script type="text/javascript">
var serverArray = new Array();      //用于保存server信息的数组
var canCheck = false;               //是否可循环检查服务器的标志

//用于创建XMLHttpRequest对象
function createXmlHttp() {
    var xmlHttp;                    //用于保存XMLHttpRequest对象
    //根据window.XMLHttpRequest对象是否存在使用不同的创建方式
    if (window.XMLHttpRequest) {
       xmlHttp = new XMLHttpRequest();                  //FireFox、Opera等浏览器支持的创建方式
    } else {
       xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器支持的创建方式
    }
    return xmlHttp;
}

//按格式获取当前时间
function getNowTime() {
    var now = new Date();
    var nowDate = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
    var nowTime = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();
    return nowDate + " " + nowTime;
}

//测试服务器状态
function checkServer(id, time, url) {
    var xmlHttp = createXmlHttp();                      //创建新的XMLHttpRequest对象
    //编写回调处理函数
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4) {
            //将检查时间写入页面
            document.getElementById("lastchecktime" + id).innerHTML = getNowTime();
            var result = xmlHttp.responseText;          //获取服务器响应
            //如果检查结果不包含error（表示正常）且canCheck为true时继续检查
            if (result.indexOf("error") == -1 && canCheck) {
                //在设置好的时间间隔后再次检查服务器
                setTimeout("checkServer('" + id + "'," + time + ",'" + url + "')", time);
            }
            document.getElementById("checkresult" + id).innerHTML = result; //将结果写入页面
        }
    };
    xmlHttp.open("POST", "server_monitor.jsp", true);
    xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlHttp.send("url=" + encodeURIComponent(url) + 
                 "&timestamp=" + new Date().getTime());//发送包含URL参数的请求体
}

//注册服务器地址到数组中
function regUrl(id, time, url) {
    serverArray.push(eval("({id:'" + id + "',time:" + time + ",url:'" + url + "'})"));
}

//进入检查状态
function startCheck() {
    canCheck = true;                                            //设置检查标记为true
    document.getElementById("status").innerHTML = "正在检查";   //改写状态文本
    //循环读取server数组中的服务器信息，按照每个服务器设定的时间调用checkServer函数
    for (var i=0; i<serverArray.length; i++) {
        var obj = serverArray[i];
        setTimeout("checkServer('" + obj.id + "'," + obj.time + ",'" + obj.url + "')", obj.time);
    }
}

//停止检查
function stopCheck() {
    canCheck = false;                                           //设置检查标记为false
    document.getElementById("status").innerHTML = "停止检查";   //改写状态文本
}
</script>
</head>

<body>
<h1>服务器监测系统</h1>

<div>
    <input type="button" value="开始检查" onclick="startCheck()">
    <input type="button" value="停止检查" onclick="stopCheck()">
    检查状态：<span id="status">停止检查</span>
</div>

<table class="default">
<tr>
    <td class="item" width="10%">服务器名</td>
    <td class="item" width="40%">检测地址</td>
    <td class="item" width="10%">检查间隔</td>
    <td class="item" width="20%">最后检查时间</td>
    <td class="item" width="20%">服务器状态</td>
<%
    String sql = "select * from servers order by id asc";   //定义查询服务器信息的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        //遍历结果集，显示服务器信息
        while (rs.next()) {
            String id = rs.getString("id");
            String name = rs.getString("name");
            String url = rs.getString("url");
            int time = rs.getInt("checktime");
            %>
            <tr>
                <td>
                    <script type="text/javascript">
                        //注册当前服务器
                        regUrl('<%=id%>',<%=time%>,'<%=url%>');
                    </script>
                    <%=name%>
                </td>
                <td><%=url%></td>
                <td align="center"><%=time/1000%> 秒</td>
                <td align="center" id="lastchecktime<%=id%>"></td>
                <td align="center" id="checkresult<%=id%>"></td>
            </tr>
            <%
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                  //关闭结果集
        DBUtils.close(pstmt);               //关闭PreparedStatement
        DBUtils.close(conn);                //关闭连接
    }
%>
</table>
</body>
</html>