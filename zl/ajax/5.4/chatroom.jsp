<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    request.setCharacterEncoding("UTF-8");          //设置请求体字符编码格式为UTF-8
    out.clear();                                    //清空当前的输出内容（空格和换行符）

    String action = request.getParameter("action"); //获取操作类型
    int lastId = Integer.parseInt(request.getParameter("lastId"));  //获取客户最后读取发言id

    //处理发言请求
    if ("send".equals(action)) {
        String userName = request.getParameter("userName");         //获取用户名
        String msg = request.getParameter("msg");                   //获取用户发言信息

        String insertSql = "insert into chatmsg(username, chatmsg) values (?,?)";//定义保存发言的SQL语句
        Connection conn = null;                                     //声明Connection对象
        PreparedStatement pstmt = null;                             //声明PreparedStatement对象
        ResultSet rs = null;                                        //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();                         //获取数据库连接
            pstmt = conn.prepareStatement(insertSql);               //根据sql创建PreparedStatement
            pstmt.setString(1, userName);                           //设置用户名
            pstmt.setString(2, msg);                                //设置发言
            pstmt.executeUpdate();                                  //写入数据库
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                                      //关闭结果集
            DBUtils.close(pstmt);                                   //关闭PreparedStatement
            DBUtils.close(conn);                                    //关闭连接
        }
    }

    String sql = "select id, username, chatmsg from chatmsg where id > ? order by id asc";//定义查询数据库的SQL语句

    StringBuffer newMsg = new StringBuffer("{'msg':'");             //保存查询结果

    Connection conn = null;                     //声明Connection对象
    PreparedStatement pstmt = null;             //声明PreparedStatement对象
    ResultSet rs = null;                        //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();         //获取数据库连接
        pstmt = conn.prepareStatement(sql);     //根据sql创建PreparedStatement
        pstmt.setInt(1, lastId);                //设置参数
        rs = pstmt.executeQuery();              //执行查询，返回结果集

        //遍历结果集，创建发言信息
        while (rs.next()) {
            lastId = rs.getInt("id");           //将id设置为lastId
            newMsg.append("<div class=\"oneMsg\"><span class=\"userName\">");
            newMsg.append(rs.getString("username"));
            newMsg.append("</span> 说：");
            newMsg.append(rs.getString("chatmsg"));
            newMsg.append("</div>");
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                      //关闭结果集
        DBUtils.close(pstmt);                   //关闭PreparedStatement
        DBUtils.close(conn);                    //关闭连接
    }
    newMsg.append("','lastId':");
    newMsg.append(lastId);                      //将最后的id值写入查询结果
    newMsg.append("}");
    out.print(newMsg.toString());               //输出查询结果
%>