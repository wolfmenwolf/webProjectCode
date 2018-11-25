<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）
    String id = request.getParameter("id");             //获取产品id

    StringBuffer params = new StringBuffer("{");        //用于保存产品信息（JSON格式）
    String sql = "select type, network, color, saleyear, ring, screen from mobiles where id = ?";//定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        pstmt.setString(1, id);             //设置参数
        rs = pstmt.executeQuery();          //执行查询，返回结果集

        //通过ResultSetMetaData自动获取字段名称，作为JSON名值对中的名称部分
        ResultSetMetaData meta = rs.getMetaData();
        int count = meta.getColumnCount();
        if (rs.next()) {
            for (int i = 0; i < count; i++) {
                if (i > 0) {
                    params.append(",");
                }
                params.append("'");
                params.append(meta.getColumnLabel(i + 1));
                params.append("':'");
                params.append(rs.getString(i + 1));
                params.append("'");
            }
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                  //关闭结果集
        DBUtils.close(pstmt);               //关闭PreparedStatement
        DBUtils.close(conn);                //关闭连接
    }
    params.append("}");
    out.print(params.toString());
%>