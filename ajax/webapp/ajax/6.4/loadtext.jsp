<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）

    String idStr = request.getParameter("id");          //获取id参数
    String pageNumStr = request.getParameter("pageNum");//获取pageNum参数

    int id = Integer.parseInt(idStr);                   //设置id
    int pageNum = 1;                                    //初始化pageNum

    //设置pageNum
    if (pageNumStr != null) {
        pageNum = Integer.parseInt(pageNumStr);
    }

    String text = null;                                 //用于保存文章信息

    String sql = "select text from articles where id = ?"; //定义查询数据库的SQL语句
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        pstmt.setInt(1, id);                //设置参数
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        if (rs.next()) {
            text = rs.getString(1);
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                  //关闭结果集
        DBUtils.close(pstmt);               //关闭PreparedStatement
        DBUtils.close(conn);                //关闭连接
    }

    //根据分页表示对文章分页，返回结果的前2位是总页数，第3-4位是当前页数
    if (text != null) {
        String[] parts = text.split("<!-- CUTPAGE -->");
        int partsLen = parts.length;
        //设置请求页数不得大于总页数
        if (pageNum > partsLen) {
            pageNum = partsLen;
        }
        //对1位数的总页数补0并输出
        if (partsLen < 10) {
            out.print("0" + partsLen);
        } else {
            out.print(partsLen);
        }
        //对1位数的当前页数补0并输出
        if (pageNum < 10) {
            out.print("0" + pageNum);
        } else {
            out.print(pageNum);
        }
        out.print(parts[pageNum-1]);    //输出请求的当前页面文本
    }
%>