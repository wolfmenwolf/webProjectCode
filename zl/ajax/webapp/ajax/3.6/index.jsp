<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>产品评级</title>

<style type="text/css">
/* 页面字体样式 */
body, td, input {
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
    height:27px;
}

/* 列头样式 */
table.default td.item {
    background:#006699;
    color:#fff;
    text-align:center;
}

/* 评级最外层列表样式 */
.rating {
    list-style:none;
    margin:0px;
    padding:0px;
    width:100px;
    height:20px;
    position:relative;
    background:url('rating.gif') top left repeat-x; 
}

/* 评级列表项样式 */
.rating li {
    padding:0px;
    margin:0px;
    float:left;
}

/* 评级列表项内超链接样式 */
.rating li a {
    display:block;
    width:20px;
    height:20px;
    text-decoration:none;
    text-indent:-1000px;
    z-index:20;
    position:absolute;
    padding:0px;
}

/* 评级列表项内超链接被鼠标覆盖时样式 */
.rating li a:hover {
    background:url('rating.gif') left bottom;
    z-index:2;
    left:0px;
}

/* 1钻-5钻的样式 */
.rating a.diamond1 { left:0px; }
.rating a.diamond1:hover { width:20px; }
.rating a.diamond2 { left:20px; }
.rating a.diamond2:hover { width:40px; }
.rating a.diamond3 { left:40px; }
.rating a.diamond3:hover { width:60px; }
.rating a.diamond4 { left:60px; }
.rating a.diamond4:hover { width:80px; }
.rating a.diamond5 { left:80px; }
.rating a.diamond5:hover { width:100px; }

/* 当前等级样式 */
.rating li.current-rating {
    background:url('rating.gif') left center;
    position:relative;
    height:20px;
    display:block;
    text-indent:-1000px;
    z-index:1;
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
function vote(id, diamonds) {
    createXmlHttp();                            //创建XmlHttpRequest对象
    xmlHttp.onreadystatechange = showRating;    //设置回调函数
    xmlHttp.open("GET", "vote.jsp?id=" + id + "&diamonds=" + diamonds, true);
    xmlHttp.send(null);
}

//显示投票结果
function showRating() {
    if (xmlHttp.readyState == 4) {
        var rating = eval("("+xmlHttp.responseText+")");    //解析服务器反馈信息（JSON格式）
        //将信息写入页面
        document.getElementById("rating-" + rating.id).innerHTML = "投票人数：" + rating.totaltimes + "，钻石总数：" + rating.totaldiamonds;
    }
}
</script>
</head>

<body>
<h1>产品评级</h1>

<table class="default">
<tr>
    <td width="40%" class="item">产品</td>
    <td width="60%" class="item">等级</td>
</tr>
<%
    String sql = "select * from rating";    //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {
            int id = rs.getInt("id");       //获取产品id
            long len = 0;                   //保存当前等级的显示长度
            double totalTimes = rs.getDouble("totaltimes");         //获取总投票数
            double totalDiamonds = rs.getDouble("totaldiamonds");   //获取总钻石数

            //当投票次数大于0时，计算当前等级的显示长度
            if (totalTimes > 0) {
                len = Math.round(totalDiamonds / totalTimes * 20);
            }
            %>
            <tr>
            <td><%=rs.getString("name")%></td>
            <td align="center" id="rating-<%=id%>">
            <ul class="rating">
                <li class="current-rating" style="width:<%=len%>px"></li>
                <li><a href="#" onclick="vote('<%=id%>','1');return false;" title="1 钻" class="diamond1">1</a></li>
                <li><a href="#" onclick="vote('<%=id%>','2');return false;" title="2 钻" class="diamond2">2</a></li>
                <li><a href="#" onclick="vote('<%=id%>','3');return false;" title="3 钻" class="diamond3">3</a></li>
                <li><a href="#" onclick="vote('<%=id%>','4');return false;" title="4 钻" class="diamond4">4</a></li>
                <li><a href="#" onclick="vote('<%=id%>','5');return false;" title="5 钻" class="diamond5">5</a></li>
            </ul>
            </td>
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
