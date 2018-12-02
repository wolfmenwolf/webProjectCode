<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                    //清空当前的输出内容（空格和换行符）

    String faqIdStr = request.getParameter("faqId");//获取faqId参数
    String faqDetail = null;                        //用于保存FAQ详细信息

    if (faqIdStr != null) {
        int faqId = Integer.parseInt(faqIdStr);     //将获取的faqId参数转换为数字

        String sql = "select detail from faq where id = ?"; //定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setInt(1, faqId);             //设置参数
            rs = pstmt.executeQuery();          //执行查询，返回结果集
            if (rs.next()) {
                faqDetail = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //根据faqDetail是否包含正确内容决定输出的信息
    if (faqDetail != null) {
        out.println(faqDetail);
    } else {
        out.println("无法获取FAQ详细信息");
    }
%>