<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    request.setCharacterEncoding("UTF-8");

    String email = request.getParameter("email");           //获取email参数

    String sql = "select * from mail_list where email = ?"; //定义查询数据库的SQL语句
    String sql2 = "insert into mail_list(email) values (?)";//定义插入新数据的SQL语句

    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        pstmt.setString(1, email);          //设置参数
        rs = pstmt.executeQuery();          //执行查询，返回结果集

        //如果结果集包含数据，表示用户已订阅过邮件
        if (rs.next()) {
            out.print("您的邮件地址已订阅了本站信息，不必重新订阅。");
        } else {
            //否则表示用户是首次订阅，执行插入新数据的SQL语句
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, email);
            pstmt.executeUpdate();
            out.print("邮件订阅成功，感谢您对本站的关注。");
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                  //关闭结果集
        DBUtils.close(pstmt);               //关闭PreparedStatement
        DBUtils.close(conn);                //关闭连接
    }
%>