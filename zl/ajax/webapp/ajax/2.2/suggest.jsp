<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                    //清空当前的输出内容（空格和换行符）

    String info = request.getParameter("info");     //获取info参数
    int counter = 0;                                //计数器

    String sql = "select info from suggest_info where info like ?";//定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        pstmt.setString(1, info + "%");     //设置参数
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {
            //当不是第一次循环时，输出“|”作为分隔符
            if (counter > 0) {
                out.print("|");
            }
            counter++;                      //计数器加1
            out.print(rs.getString(1));     //输出提示信息
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                  //关闭结果集
        DBUtils.close(pstmt);               //关闭PreparedStatement
        DBUtils.close(conn);                //关闭连接
    }
%>