<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>动态加载的FAQ</title>

<script type="text/javascript">
var xmlHttp;    //用于保存XMLHttpRequest对象的全局变量
var currFaqId;  //用于保存当前想要获取的FAQ编号

//用于创建XMLHttpRequest对象
function createXmlHttp() {
    //根据window.XMLHttpRequest对象是否存在使用不同的创建方式
    if (window.XMLHttpRequest) {
       xmlHttp = new XMLHttpRequest();                  //FireFox、Opera等浏览器支持的创建方式
    } else {
       xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器支持的创建方式
    }
}

//获取FAQ信息的调用函数
function loadFAQ(faqId) {
    currFaqId = faqId;                              //记录当前想要获取的FAQ编号
    var currFaqDetail = getFaqDetailDiv(faqId);     //获取对应的faqDetail节点

    if (currFaqDetail.style.display == "none") {
        currFaqDetail.style.display = "block";      //设置div状态为“显示”

        //判断FAQ详细信息是否已存在，如果不存在则从服务器获取
        if (currFaqDetail.innerHTML == "") {
            createXmlHttp();                        //创建XmlHttpRequest对象
            xmlHttp.onreadystatechange = loadFAQCallback;
            xmlHttp.open("GET", "read_faq.jsp?faqId=" + faqId, true);
            xmlHttp.send(null);
        }
    } else {
        currFaqDetail.style.display = "none";       //设置div状态为“隐藏”
    }
}

//获取FAQ信息的回调函数
function loadFAQCallback() {
    if (xmlHttp.readyState == 4) {
        getFaqDetailDiv(currFaqId).innerHTML = xmlHttp.responseText;//将FAQ信息写入到对应的DIV中
    }
}

//根据faqId取得对应的DIV节点
function getFaqDetailDiv(faqId) {
    return document.getElementById("faqDetail" + faqId);
}
</script>
</head>

<body>
<h1>FAQ（常见问题）</h1>

<%
    String sql = "select id, faq from faq order by id asc";   //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {                 //遍历结果集
            %>
            <div>
                <a href="#" onclick="loadFAQ(<%=rs.getInt(1)%>);return false;">
                    <%=rs.getString(2)%>
                </a>
            </div>
            <div id="faqDetail<%=rs.getInt(1)%>" style="display:none"></div>
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

</body>
</html>
