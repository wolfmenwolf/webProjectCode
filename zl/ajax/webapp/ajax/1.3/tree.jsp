<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）
    String parentId = request.getParameter("parentId"); //获取要加载的节点编号

    //创建用于保存xmlTree信息的StringBuffer对象
    StringBuffer xmlTree= new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    xmlTree.append("<tree>");                           //xmlTree根节点为<tree>

    /*
    根据请求的目标节点返回不同的结果
    isFolder属性标识当前节点是否为目录，true表示目录，false表示普通节点
    link属性用于设置普通节点的目标链接地址
    */

    String sql = "select * from tree where pid = ?";//定义查询数据库的SQL语句

    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        pstmt.setString(1, parentId);       //设置参数
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {                 //遍历结果集创建item节点
            xmlTree.append("<item id=\"");
            xmlTree.append(rs.getString("id"));
            xmlTree.append("\" isFolder=\"");
            xmlTree.append(rs.getString("isfolder"));
            String link = rs.getString("link");
            //当link字段数据存在时才加入link属性信息
            if (link != null && !"".equals(link)) {
                xmlTree.append("\" link=\"");
                xmlTree.append(link);
            }
            xmlTree.append("\">");
            xmlTree.append(rs.getString("text"));
            xmlTree.append("</item>");
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);         //关闭结果集
        DBUtils.close(pstmt);      //关闭PreparedStatement
        DBUtils.close(conn);       //关闭连接
    }

    xmlTree.append("</tree>");     //xmlTree根节点的结束标签
    out.print(xmlTree.toString()); //输出xmlTree
%>