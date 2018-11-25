<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                    //清空当前的输出内容（空格和换行符）

    String sql = "select * from album";             //定义查询数据库的SQL语句

    StringBuffer picInfo = new StringBuffer("[");   //保存查询结果
    int counter = 0;                                //计数器

    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集

        //遍历结果集，生成JSON格式的查询结果
        while (rs.next()) {
            if (counter > 0) {
                picInfo.append(",");
            }
            picInfo.append("{");
            picInfo.append("'id':'");
            picInfo.append(rs.getString("id"));
            picInfo.append("','name':'");
            picInfo.append(rs.getString("name"));
            picInfo.append("','width':'");
            picInfo.append(rs.getString("width"));
            picInfo.append("','height':'");
            picInfo.append(rs.getString("height"));
            picInfo.append("'}");
            counter++;                      //计数器加1
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                  //关闭结果集
        DBUtils.close(pstmt);               //关闭PreparedStatement
        DBUtils.close(conn);                //关闭连接
    }
    picInfo.append("]");
    out.print(picInfo.toString());          //返回查询结果
%>