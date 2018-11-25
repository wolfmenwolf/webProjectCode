<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                                        //清空当前的输出内容（空格和换行符）
    int offset = Integer.parseInt(request.getParameter("offset"));      //获取起始id
    int pageSize = Integer.parseInt(request.getParameter("page_size")); //获取要读取的信息数量
%><?xml version="1.0" encoding="UTF-8"?>
<ajax-response>
<response type="object" id="data_grid_updater">
<rows update_ui="true">
<%
    String sql = "select * from live_grid where id between ? and ? order by id asc";   //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        pstmt.setInt(1, offset + 1);        //设置开始id
        pstmt.setInt(2, offset + pageSize); //设置结束id
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {
            %>
            <tr>
                <td><%=rs.getInt("id")%></td>
                <td convert_spaces="true"><%=rs.getString("title")%></td>
                <td><%=rs.getFloat("price")%></td>
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
</rows>
</response>
</ajax-response>