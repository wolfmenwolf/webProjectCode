<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<script type="text/javascript" src="bbs.js"></script>
<link href="bbs.css" type="text/css" rel="stylesheet">
<title>无刷新显示回帖</title>
</head>

<body>
<h1>无刷新显示回帖</h1>
<div id="statusDiv" style="display:none"></div>
<div id="thread">
<%
    String sql = "select * from bbs_post where threadid = 1 order by id asc";   //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {
            %>
            <div class="post" id="post<%=rs.getString("id")%>">
                <div class="post_title"><%=rs.getString("title")%> [<%=rs.getString("username")%>]</div>
                <div class="post_content"><pre><%=rs.getString("content")%></pre></div>
            </div>
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
</div>

<table class="reply">
<tr>
    <td colspan="2" class="title">回帖<input type="hidden" name="threadid" id="threadid" value="1"></td>
</tr>
<tr>
    <td>姓名：</td>
    <td><input type="text" name="username" id="username"></td>
</tr>
<tr>
    <td>标题：</td>
    <td><input type="text" name="post_title" id="post_title"></td>
</tr>
<tr>
    <td>内容：</td>
    <td><textarea name="post_content" id="post_content"></textarea></td>
</tr>
<tr>
    <td colspan="2"><input type="button" onclick="submitPost()" value="提交"></td>
</tr>
</table>
</body>
</html>
