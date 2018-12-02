<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils,java.util.*"%>
<%!
    void updatePortal(String[] column1, String[] column2, String[] column3) {
        int counter = 1;
        String sql = "update portal set seq = ?, col = ? where id = ?";   //定义更新数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            if (column1 != null) {
                for (int i=0; i<column1.length; i++) {
                    pstmt.setInt(1, counter++);
                    pstmt.setInt(2, 1);
                    pstmt.setString(3, column1[i].substring(4));
                    pstmt.addBatch();
                }
            }
            if (column2 != null) {
                for (int i=0; i<column2.length; i++) {
                    pstmt.setInt(1, counter++);
                    pstmt.setInt(2, 2);
                    pstmt.setString(3, column2[i].substring(4));
                    pstmt.addBatch();
                }
            }
            if (column3 != null) {
                for (int i=0; i<column3.length; i++) {
                    pstmt.setInt(1, counter++);
                    pstmt.setInt(2, 3);
                    pstmt.setString(3, column3[i].substring(4));
                    pstmt.addBatch();
                }
            }
            pstmt.executeBatch();
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }
%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）
    request.setCharacterEncoding("UTF-8");              //设置请求字符集为UTF-8

    String[] column1 = request.getParameterValues("column1[]");
    String[] column2 = request.getParameterValues("column2[]");
    String[] column3 = request.getParameterValues("column3[]");
    updatePortal(column1, column2, column3);
%>