<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%!
    //根据传入的邮编获取地区信息
    String getAreaInfo(String postalCode) {
        String areaInfo = null;

        String sql = "select * from postalcode where code like ?";//定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, postalCode);     //设置参数
            rs = pstmt.executeQuery();          //执行查询，返回结果集
            if (rs.next()) {
                areaInfo = rs.getString("area") + "|" + rs.getString("city");
            } else {
                rs.close();
                //如果没有查询到地区信息，取邮编前4位补“00”继续查询
                pstmt.setString(1, postalCode.substring(0,4) + "00");
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    areaInfo = rs.getString("area") + "|" + rs.getString("city");
                }
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);         //关闭结果集
            DBUtils.close(pstmt);      //关闭PreparedStatement
            DBUtils.close(conn);       //关闭连接
        }
        return areaInfo;
    }
%>
<%
    out.clear();                                            //清空当前的输出内容（空格和换行符）
    String postalCode = request.getParameter("postalCode"); //获取邮政编码
    String areaInfo = getAreaInfo(postalCode);              //根据邮政编码获取地区信息

    //如果获取失败，发回的响应将不包含任何内容
    if (areaInfo == null) {
        out.print("");
    } else {
        out.print(areaInfo);
    }
%>