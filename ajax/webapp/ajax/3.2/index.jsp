<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>购物车</title>

<style type="text/css">
/* 页面字体样式 */
body, td, input {
    font-family:Arial;
    font-size:12px;
}

/* 表格基本样式 */
table.default {
    border-collapse:collapse;
    width:500px;
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

/* 购物车div样式 */
#shoppingcart {
    margin-top:20px;
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

//刷新购物车
function refreshCart() {
    sendRequest("");
}

//向购物车添加产品
function addProduct(pid) {
    sendRequest("&action=add&pid=" + pid);
}

//清空购物车
function emptyCart() {
    sendRequest("&action=empty");
}

//删除购物车内单件产品
function delProduct(pid) {
    sendRequest("&action=del&pid=" + pid);
}

//向服务器发送操作请求
function sendRequest(params) {
    createXmlHttp();                        //创建XmlHttpRequest对象
    xmlHttp.onreadystatechange = showCartInfo;
    xmlHttp.open("GET", "cart.jsp?timestamp=" + new Date().getTime() + params, true);
    xmlHttp.send(null);
}

//将服务器响应信息写入购物车div中
function showCartInfo() {
    if (xmlHttp.readyState == 4) {
        document.getElementById("shoppingcart").innerHTML = xmlHttp.responseText;
    }
}
</script>
</head>

<body onload="refreshCart()">
<h1>购物车</h1>
<table class="default">
<tr>
    <td class="item" width="35%">产品名称</td>
    <td class="item" width="20%">价格</td>
    <td class="item" width="45%">放入购物车</td>
</tr>
<%
    String sql = "select pid, pname, price from products";   //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {                 //遍历结果集，显示产品信息
            %>
            <tr>
                <td><%=rs.getString("pname")%></td>
                <td align="center"><%=rs.getDouble("price")%> 元</td>
                <td align="center"><input type="button" value="加入购物车" onclick="addProduct('<%=rs.getString("pid")%>')"></td>
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

<!-- 购物车信息 -->
<div id="shoppingcart">
</div>
</body>
</html>
