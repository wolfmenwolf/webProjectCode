<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                    //清空当前的输出内容（空格和换行符）
    String newSeq = request.getParameter("newSeq"); //获取新顺序信息
    String[] seqs = newSeq.split(",");              //将各节点信息切分成数组
    System.out.println(newSeq);
    String sql = "update sort_info set seq = ? where id = ?";//定义更新数据库的SQL语句
    Connection conn = null;                     //声明Connection对象
    PreparedStatement pstmt = null;             //声明PreparedStatement对象
    try {
        conn = DBUtils.getConnection();         //获取数据库连接
        pstmt = conn.prepareStatement(sql);     //根据sql创建PreparedStatement

        for (int i=0; i<seqs.length; i++) {
            String[] tmp = seqs[i].split("_");  //切分id和新顺序编号
            pstmt.setString(1, tmp[1]);         //设置新顺序参数
            pstmt.setString(2, tmp[0]);         //设置id参数
            pstmt.addBatch();                   //将当前pstmt加入批处理
        }
        pstmt.executeBatch();                   //执行批量操作
        out.print("OK");                        //输出OK表示保存成功
    } catch (SQLException e) {
        out.print("ERROR");                     //出现保存异常输出ERROR
        System.out.println(e.toString());
    } finally {
        DBUtils.close(pstmt);                   //关闭PreparedStatement
        DBUtils.close(conn);                    //关闭连接
    }
%>