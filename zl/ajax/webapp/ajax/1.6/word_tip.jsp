<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%!
    //查询数据库返回关键词详细信息
    String getDetail(String keyword) {
        String detail = null;                   //存放信息信息

        String sql = "select detail from word_tip where keyword = ?";   //定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, keyword);        //设置参数
            rs = pstmt.executeQuery();          //执行查询，返回结果集
            if (rs.next()) {
                detail = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        return detail;
    }
%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）

    String keyword = request.getParameter("keyword");   //获取keyword参数
    String detail = getDetail(keyword);                 //调用getDetail方法获取关键词详细信息

    //当详细信息存在时写入响应体
    if (detail != null) {
        out.print(detail);
    }
%>