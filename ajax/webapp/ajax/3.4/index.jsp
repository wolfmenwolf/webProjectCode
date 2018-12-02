<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>系列产品特性速查</title>

<style type="text/css">
/* 页面字体样式 */
body, td, input {
    font-family:Arial;
    font-size:12px;
}

/* 表格基本样式 */
table.default {
    border-collapse:collapse;
}

/* 表格单元格样式 */
table.default td {
    border:1px solid black;
    padding:3px;
    height:27px;
}

/* 列头样式 */
table.default td.item {
    background:#006699;
    color:#fff;
    text-align:center;
}
</style>

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

//获取产品参数
function getParameters(id) {
    createXmlHttp();                            //创建XmlHttpRequest对象
    xmlHttp.onreadystatechange = showParameters;//设置回调函数
    xmlHttp.open("GET", "parameter.jsp?id=" + id, true);
    xmlHttp.send(null);
}

//显示产品特性
function showParameters() {
    if (xmlHttp.readyState == 4) {
        var params = eval("("+xmlHttp.responseText+")");    //使用服务器反馈信息创建对象
        //遍历对象中的信息，写入对应的页面位置
        for (var o in params) {
            document.getElementById(o).innerHTML = params[o];
        }
    }
}
</script>
</head>

<body>
<h1>系列产品特性速查</h1>
点击手机型号查看详细参数
<table class="default">
<tr>
<%
    String sql = "select id, type from mobiles";   //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {
            %>
            <td class="item" style="width:50px;cursor:hand" onclick="getParameters('<%=rs.getString("id")%>')"><%=rs.getString("type")%></td>
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
</tr>
</table>

<table class="default" style="margin-top:10px;width:286px">
<tr>
    <td width="40%" class="item">参数项</td>
    <td width="60%" class="item">参数值</td>
</tr>
<tr>
    <td>型号</td>
    <td id="type"></td>
</tr>
<tr>
    <td>网络</td>
    <td id="network"></td>
</tr>
<tr>
    <td>颜色</td>
    <td id="color"></td>
</tr>
<tr>
    <td>上市年份</td>
    <td id="saleyear"></td>
</tr>
<tr>
    <td>铃声</td>
    <td id="ring"></td>
</tr>
<tr>
    <td>屏幕</td>
    <td id="screen"></td>
</tr>
</table>
</body>
</html>
