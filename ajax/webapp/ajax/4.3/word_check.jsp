<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%!
    //检查数据库中是否存在对应单词
    boolean checkWord(String word) {
        boolean result = false;                 //保存检查结果，初始为false
        String detail = null;                   //存放信息信息

        String sql = "select id from words where word = ?";   //定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, word);           //设置参数
            rs = pstmt.executeQuery();          //执行查询，返回结果集
            if (rs.next()) {
                result = true;                  //查询结果集存在时，result为true
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        return result;                          //返回检查结果
    }
%>
<%
    out.clear();                                //清空当前的输出内容（空格和换行符）

    String word = request.getParameter("word"); //获取用户输入的word参数

    StringBuffer result = new StringBuffer();   //用于保存检查结果

    //根据checkWord方法调用结果设置检查结果输出信息
    if (checkWord(word)) {
        result.append("<span class='right'>");  //样式为right
        result.append(word);
        result.append("</span>");
    } else {
        result.append("<span class='wrong'>");  //样式为wrong
        result.append(word);
        result.append("</span>");
    }

    out.print(result.toString());               //输出检查结果
%>