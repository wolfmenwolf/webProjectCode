<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>信息排序</title>

<style type="text/css">
/* 移动节点的样式 */
#movableNode{
    position:absolute;
}

/* 指示箭头的样式 */
#arrDestInditcator{
    position:absolute;
    display:none;
    width:100px;
}

/* 列表整体样式 */
#arrangableNodes,#movableNode ul{
    padding-left:0px;
    margin-left:0px;
    margin-top:0px;
    padding-top:0px;
}

/* 列表项样式 */
#arrangableNodes li,#movableNode li{
    list-style-type:none;
    cursor:default;
}
</style>

<!-- 引入sort.js -->
<script type="text/javascript" src="sort.js"></script>

<script type="text/javascript">
var xmlHttp;    //用于保存XMLHttpRequest对象的全局变量

//用于创建XMLHttpRequest对象
function createXmlHttp() {
    //根据window.XMLHttpRequest对象是否存在使用不同的创建方式
    if (window.XMLHttpRequest) {
       xmlHttp = new XMLHttpRequest();                  //FireFox、Opera等浏览器支持的创建方式
    } else {
       xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器支持的创建方式
    }
}

//保存节点当前顺序
function saveNodes() {
    var nodes = document.getElementById("arrangableNodes").getElementsByTagName('li');
    var newSeq = "";
    for(var i=1; i<=nodes.length; i++){
        if (i > 1) {
            newSeq = newSeq + ",";
        }
        newSeq = newSeq + nodes[i-1].id + "_" + i;
    }
    createXmlHttp();                            //创建XmlHttpRequest对象
    xmlHttp.onreadystatechange = saveOver;      //设置回调函数
    xmlHttp.open("POST", "sort_info.jsp", true);
    //设置POST请求体类型
    xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlHttp.send("newSeq=" + encodeURI(newSeq));//发送包含新顺序的节点信息
}

//保存信息完毕后的回调函数
function saveOver() {
    if (xmlHttp.readyState == 4) {
        if (xmlHttp.responseText == "OK") {
            alert("保存成功。");
        } else {
            alert("保存失败。");
        }
    }
}
</script>
</head>

<body>
<h1>信息排序</h1>

<ul id="arrangableNodes">
<%
    String sql = "select * from sort_info order by seq asc";   //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {
            %>
            <li id="<%=rs.getString("id")%>"><%=rs.getString("info")%></li>
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
</ul>
<p>
	<input type="button" onclick="saveNodes();" value="保存">
</p>
<div id="movableNode"><ul></ul></div>
<div id="arrDestInditcator"><img src="insert.gif"></div>

</body>
</html>
