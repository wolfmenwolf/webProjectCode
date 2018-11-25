<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                                //清空当前的输出内容（空格和换行符）
    String id = request.getParameter("id");                     //获取产品id
    String diamonds = request.getParameter("diamonds");         //获取投票钻石数

    StringBuffer info = new StringBuffer("{'id':" + id + ",");  //用于保存返回结果信息（JSON格式）

    //定义更新数据库的SQL语句
    String sql = "update rating set totaltimes = totaltimes + 1, totaldiamonds = totaldiamonds + ? where id = ?";
    String sql2 = "select * from rating where id = ?";//定义查询数据库的SQL语句

    Connection conn = null;                         //声明Connection对象
    PreparedStatement pstmt = null;                 //声明PreparedStatement对象
    ResultSet rs = null;                            //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();             //获取数据库连接
        pstmt = conn.prepareStatement(sql);         //根据sql创建PreparedStatement
        pstmt.setInt(1, Integer.parseInt(diamonds));//设置钻石数
        pstmt.setInt(2, Integer.parseInt(id));      //设置id
        pstmt.executeUpdate();                      //执行更新
        pstmt.close();                              //关闭PreparedStatement

        pstmt = conn.prepareStatement(sql2);        //创建查询PreparedStatement
        pstmt.setInt(1, Integer.parseInt(id));      //设置参数
        rs = pstmt.executeQuery();                  //执行查询，返回结果集

        if (rs.next()) {
            info.append("'totaltimes':" + rs.getInt("totaltimes") + ",");
            info.append("'totaldiamonds':" + rs.getInt("totaldiamonds"));
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                  //关闭结果集
        DBUtils.close(pstmt);               //关闭PreparedStatement
        DBUtils.close(conn);                //关闭连接
    }
    info.append("}");
    out.print(info.toString());             //输出投票结果信息
%>