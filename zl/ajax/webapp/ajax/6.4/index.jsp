<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>提前加载分页文章</title>

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

/* 分页链接span样式 */
span.pageLink {
    font-size:12px;
    margin:3px;
    font-weight:bold;
    padding:2px;
    border:1px solid #003366;
}

/* 分页链接样式 */
span.pageLink a {
    color:#003366;
    font-weight:normal;
    text-decoration:none;
}

/* div统一样式 */
div {
    margin-top:10px;
}

/* 文章容器样式 */
#container {
    width:600px;
    font-size:14px;
}

/* 分页div样式 */
#pageDiv {
    text-align:right;
}
</style>

<script type="text/javascript">
var xmlHttp;            //用于保存XMLHttpRequest对象的全局变量
var cacheXmlHttp;       //用于保存缓存用XMLHttpRequest对象的全局变量
var currId;             //保存当前文章编号
var cachedId;           //用于保存缓存的文章编号
var cachedPageNum = 0;  //缓存的文章页序号
var cachedText;         //缓存的文章内容

//用于创建XMLHttpRequest对象
function createXmlHttp() {
    //根据window.XMLHttpRequest对象是否存在使用不同的创建方式
    if (window.XMLHttpRequest) {
       xmlHttp = new XMLHttpRequest();                  //FireFox、Opera等浏览器支持的创建方式
    } else {
       xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器支持的创建方式
    }
}

//用于创建缓存用XMLHttpRequest对象
function createCacheXmlHttp() {
    //根据window.XMLHttpRequest对象是否存在使用不同的创建方式
    if (window.XMLHttpRequest) {
       cacheXmlHttp = new XMLHttpRequest();                  //FireFox、Opera等浏览器支持的创建方式
    } else {
       cacheXmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器支持的创建方式
    }
}

//获取文章信息
function loadText(id, pageNum) {
    currId = id;                                //设置当前加载文章编号

    //如果页数信息不存在，默认设置为1
    if (!pageNum) {
        pageNum = 1;
    }

    //如果缓存命中，则直接从缓存读取
    if (cachedId == id && cachedPageNum == pageNum) {
        var result = cachedText;                //从缓存中获取文章信息

        //结果前2位数为总页数，第3-4位为当前显示页数
        var pageTotal = parseInt(result.substr(0,2),10);
        var pageNum = parseInt(result.substr(2,2),10);

        buildPageInfo(pageTotal, pageNum);      //根据总页数和当前页数建立各分页链接
        var text = result.substr(4);            //去掉前4位，剩下的内容为文章部分
        document.getElementById("textDiv").innerHTML = text;    //将文章写入页面
        return;                                 //结束函数调用
    }

    createXmlHttp();                            //创建XmlHttpRequest对象
    xmlHttp.onreadystatechange = showText;      //设置回调函数
    xmlHttp.open("GET", "loadtext.jsp?id=" + id + "&pageNum=" + pageNum, true);
    xmlHttp.send(null);
}

//显示加载的文章
function showText() {
    if (xmlHttp.readyState == 4) {
        var result = xmlHttp.responseText;      //获取服务器响应结果

        //结果前2位数为总页数，第3-4位为当前显示页数
        var pageTotal = parseInt(result.substr(0,2),10);
        var pageNum = parseInt(result.substr(2,2),10);

        buildPageInfo(pageTotal, pageNum);      //根据总页数和当前页数建立各分页链接
        var text = result.substr(4);            //去掉前4位，剩下的内容为文章部分
        document.getElementById("textDiv").innerHTML = text;    //将文章写入页面
    }
}

//根据总页数和当前页数建立各分页链接
function buildPageInfo(pageTotal, pageNum) {
    var pageInfo = "";                          //保存页面片断

    //从1到总页数进行循环创建链接节点
    for (var i=1; i<=pageTotal; i++) {
        pageInfo += "<span class='pageLink'>";  //每个节点使用一个span
        if (i==pageNum) {
            pageInfo += pageNum;                //当前页无链接
        } else {
            pageInfo += "<a href='#' onclick='loadText(" + currId + "," + i + ")'>" + i + "</a>";
        }
        pageInfo += "</span>";
    }
    document.getElementById("pageDiv").innerHTML = pageInfo;    //将创建好的页面片断写入页面

    //如果当前页面不是最后一页，缓存下一页内容
    if (pageNum < pageTotal) {
        cacheNextPage(currId, pageNum + 1);
    }
}

//缓存下一页信息
function cacheNextPage(id, pageNum) {
    cachedId = id;                                   //保存缓存的id
    cachedPageNum = pageNum;
    createCacheXmlHttp();                            //创建XmlHttpRequest对象
    cacheXmlHttp.onreadystatechange = saveCacheText; //设置回调函数
    cacheXmlHttp.open("GET", "loadtext.jsp?id=" + id + "&pageNum=" + pageNum, true);
    cacheXmlHttp.send(null);
}

//保存缓存文章信息
function saveCacheText() {
    if (cacheXmlHttp.readyState == 4) {
        cachedText = cacheXmlHttp.responseText;     //将文章写入缓存变量
    }
}
</script>
</head>

<body>
<h1>提前加载分页文章</h1>

<table class="default">
<tr>
    <td class="item">标题</td>
    <td class="item">作者</td>
    <td class="item">阅读</td>
</tr>
<%
    String sql = "select id, title, author from articles";   //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {
            %>
            <tr>
                <td><%=rs.getString("title")%></td>
                <td><%=rs.getString("author")%></td>
                <td><input type="button" value="阅读" onclick="loadText(<%=rs.getString("id")%>)"></td>
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

<div id="container">
文章内容：
<div id="pageDiv"></div>
<div id="textDiv"></div>
</div>
</body>
</html>
