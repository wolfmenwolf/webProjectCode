<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<table class="default">
<tr>
    <td width="40%" class="item">歌手</td>
    <td width="60%" class="item">CD名称</td>
</tr>
<%
    request.setCharacterEncoding("UTF-8");          //设置请求体字符编码格式为UTF-8
    int counter = 0;                                //查询计数器

    String key = request.getParameter("key");       //获取key参数

    String sql = "select * from cd_info where singer like ? or cdname like ?";//定义查询数据库的SQL语句
    Connection conn = null;                     //声明Connection对象
    PreparedStatement pstmt = null;             //声明PreparedStatement对象
    ResultSet rs = null;                        //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();         //获取数据库连接
        pstmt = conn.prepareStatement(sql);     //根据sql创建PreparedStatement
        pstmt.setString(1, "%" + key + "%");    //设置参数
        pstmt.setString(2, "%" + key + "%");    //设置参数
        rs = pstmt.executeQuery();              //执行查询，返回结果集
        while (rs.next()) {
            counter++;
            %>
            <tr>
                <td><%=rs.getString("singer")%></td>
                <td><%=rs.getString("cdname")%></td>
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

    //如果没有找到匹配CD，计数器为0，显示下面的提示信息
    if (counter == 0) {
        %>
        <tr>
            <td colspan="3" style="height:50px" align="center">没有找到包含该关键词的CD。</td>
        </tr>
        <%
    }
%>
</table>