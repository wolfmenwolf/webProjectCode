<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）
    request.setCharacterEncoding("UTF-8");              //设置请求字符集为UTF-8

    String title = request.getParameter("title");       //获取title
    String content = request.getParameter("content");   //获取content
    String userName = request.getParameter("username"); //获取username
    String threadId = request.getParameter("threadid"); //获取threadid

    String sql = "insert into bbs_post(title,content,username,threadid) values (?,?,?,?)";   //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        pstmt.setString(1, title);          //设置title
        pstmt.setString(2, content);        //设置content
        pstmt.setString(3, userName);       //设置userName
        pstmt.setString(4, threadId);       //设置threadId
        pstmt.executeUpdate();              //执行insert操作
        pstmt.close();

        //获取刚插入数据的新id
        pstmt = conn.prepareStatement("select last_insert_id()");
        rs = pstmt.executeQuery();
        if (rs.next()) {
            out.print(rs.getString(1));     //输出新id
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                  //关闭结果集
        DBUtils.close(pstmt);               //关闭PreparedStatement
        DBUtils.close(conn);                //关闭连接
    }
%>