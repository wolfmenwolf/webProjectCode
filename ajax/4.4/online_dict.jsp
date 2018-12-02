<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%!
    //查询数据库返回单词解释
    String getExplain(String word) {
        String explain = null;                   //存放信息信息

        String sql = "select chinese from words where word = ?";   //定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, word);           //设置参数
            rs = pstmt.executeQuery();          //执行查询，返回结果集
            if (rs.next()) {
                explain = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        return explain;
    }
%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）

    String word = request.getParameter("word");         //获取word参数
    String explain = getExplain(word);                  //调用getExplain方法获取关键词详细信息

    //当解释存在时写入响应体
    if (explain != null) {
        out.print(word + "：" + explain);
    }
%>