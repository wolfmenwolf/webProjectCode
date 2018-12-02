<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%!
    //访问数据库取得下级选项信息
    String getOptions(String selectedId) {
        int counter = 0;                            //计数器
        StringBuffer opts = new StringBuffer("{");  //保存选项信息
        String sql = "select * from select_menu where pid = ? order by seq asc";//定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, selectedId);     //设置参数
            rs = pstmt.executeQuery();          //执行查询，返回结果集
            while (rs.next()) {                 //遍历结果集
                //如果不是第一项，追加一个“,”用于分隔选项
                if (counter > 0) {
                    opts.append(",");
                }
                opts.append("'");
                opts.append(rs.getString("id"));
                opts.append("':'");
                opts.append(rs.getString("text"));
                opts.append("'");
                counter++;                      //计数器加1
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);         //关闭结果集
            DBUtils.close(pstmt);      //关闭PreparedStatement
            DBUtils.close(conn);       //关闭连接
        }
        opts.append("}");
        return opts.toString();
    }
%>
<%
    out.clear();                                            //清空当前的输出内容（空格和换行符）

    String selectedId = request.getParameter("selectedId"); //获取selectedId参数
    String optionsInfo = getOptions(selectedId);            //调用getOptions方法取得下级选项信息

    out.print(optionsInfo);                                 //输出下级选项信息
%>