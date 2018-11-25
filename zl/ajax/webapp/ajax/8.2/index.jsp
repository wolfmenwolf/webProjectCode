<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>天气情况查询</title>

<style type="text/css">
/* 页面字体样式 */
body, td, input, select {
    font-family:Arial;
    font-size:12px;
}

/* 表格基本样式 */
table.default {
    border-collapse:collapse;
    width:300px;
}

/* 表格单元格样式 */
table.default td {
    border:1px solid black;
    padding:3px;
    height:30px;
}

/* 列头样式 */
table.default td.item {
    background:#006699;
    color:#fff;
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

//加载天气信息
function loadWeather(cityCode) {
    if (cityCode != "") {
        createXmlHttp();                                    //创建XmlHttpRequest对象
        xmlHttp.onreadystatechange = loadWeatherCallback;   //设置回调函数
        xmlHttp.open("GET", "weather.jsp?cityCode=" + cityCode, true);
        xmlHttp.send(null);
    }
}

//加载天气信息的回调函数
function loadWeatherCallback() {
    if (xmlHttp.readyState == 4) {
        var weatherInfo = eval("(" + xmlHttp.responseText + ")");   //解析JSON格式的服务器响应
        //遍历JSON对象，将信息写入页面
        for (o in weatherInfo) {
            document.getElementById(o).innerHTML = weatherInfo[o];
        }
    }
}
</script>
</head>

<body>
<h1>天气情况查询</h1>

<select id="citySel" onchange="loadWeather(this.value)">
<option value="">--请选择城市--</option>
<%
    String sql = "select code, name, chinese from weather_citycode order by name asc";   //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {                 //遍历结果集
            %>
            <option value="<%=rs.getString("code")%>"><%=rs.getString("name")%> [<%=rs.getString("chinese")%>]</option>
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
</select>

<table class="default">
<tr>
	<td class="item" width="35%">天气状况：</td>
	<td width="65%" id="condition"></td>
</tr>
<tr>
	<td class="item">最后更新日期：</td>
	<td id="lastBuildDate"></td>
</tr>
<tr>
	<td class="item">感觉气温：</td>
	<td id="chill"></td>
</tr>
<tr>
	<td class="item">实际气温：</td>
	<td id="temp"></td>
</tr>
<tr>
	<td class="item">最低气温：</td>
	<td id="low"></td>
</tr>
<tr>
	<td class="item">最高气温：</td>
	<td id="high"></td>
</tr>
<tr>
	<td class="item">风向：</td>
	<td id="direction"></td>
</tr>
<tr>
	<td class="item">风速：</td>
	<td id="speed"></td>
</tr>
<tr>
	<td class="item">湿度：</td>
	<td id="humidity"></td>
</tr>
<tr>
	<td class="item">能见度：</td>
	<td id="visibility"></td>
</tr>
<tr>
	<td class="item">日出：</td>
	<td id="sunrise"></td>
</tr>
<tr>
	<td class="item">日落：</td>
	<td id="sunset"></td>
</tr>
</table>

</body>
</html>
