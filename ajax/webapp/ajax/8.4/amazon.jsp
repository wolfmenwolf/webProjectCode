<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*,java.io.*,org.dom4j.*,org.dom4j.io.*"%>
<%@ page import="java.sql.*,ajax.db.DBUtils,ajax.util.XMLUtils"%>
<%
    out.clear();                                    //清空当前的输出内容（空格和换行符）

    String browseNodeId = request.getParameter("browseNodeId");//获取要浏览的browseNodeId参数

    //创建用于保存xmlTree信息的StringBuffer对象
    StringBuffer xmlTree= new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    xmlTree.append("<tree>");                           //xmlTree根节点为<tree>

    //如果获取的是第一层目录，从数据库中读取并生成
    if ("0".equals(browseNodeId)) {
        String sql = "select * from amazon_categories order by seq asc";//定义查询数据库的SQL语句

        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            rs = pstmt.executeQuery();          //执行查询，返回结果集
            while (rs.next()) {                 //遍历结果集创建item节点
                xmlTree.append("<item id=\"");
                xmlTree.append(rs.getString("id"));
                xmlTree.append("\" isFolder=\"");
                xmlTree.append(true);
                xmlTree.append("\">");
                xmlTree.append(XMLUtils.escapeXML(rs.getString("name")));
                xmlTree.append("</item>");
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);         //关闭结果集
            DBUtils.close(pstmt);      //关闭PreparedStatement
            DBUtils.close(conn);       //关闭连接
        }
    //否则使用DOM4j从远程读取信息
    } else {
        String myAccessKeyId = "0WTFYB410YD3GXRYR602";  //从Amazon申请的访问keyId
        //访问的目标URL
        String url = "http://webservices.amazon.com/onca/xml?Service=AWSECommerceService&AWSAccessKeyId=" + myAccessKeyId + "&Operation=BrowseNodeLookup&BrowseNodeId=" + browseNodeId;

        SAXReader reader = new SAXReader();     //创建一个SAXReader对象
        Document doc = reader.read(url);        //从远程读取并解析XML

        //设置访问BrowseNodeId属性的XPath
        XPath xpath1 = doc.createXPath("//am:Children/am:BrowseNode/am:BrowseNodeId");
        xpath1.setNamespaceURIs(Collections.singletonMap("am", "http://webservices.amazon.com/AWSECommerceService/2005-10-05"));

        //设置访问Name属性的XPath
        XPath xpath2 = doc.createXPath("//am:Children/am:BrowseNode/am:Name");
        xpath2.setNamespaceURIs(Collections.singletonMap("am", "http://webservices.amazon.com/AWSECommerceService/2005-10-05"));

        List idNodes = xpath1.selectNodes(doc);     //使用XPath获取BrowseNodeId节点列表
        List nameNodes = xpath2.selectNodes(doc);   //使用XPath获取Name节点列表

        int nodeSize = idNodes.size();              //获取列表长度

        //如果列表长度为0，表示当前请求的节点为叶子节点
        if (nodeSize == 0) {
            //设置读取叶子节点编号的XPath
            xpath1 = doc.createXPath("//am:BrowseNodes/am:BrowseNode/am:BrowseNodeId");
            xpath1.setNamespaceURIs(Collections.singletonMap("am", "http://webservices.amazon.com/AWSECommerceService/2005-10-05"));
            //设置读取叶子节点名称的XPath
            xpath2 = doc.createXPath("//am:BrowseNodes/am:BrowseNode/am:Name");
            xpath2.setNamespaceURIs(Collections.singletonMap("am", "http://webservices.amazon.com/AWSECommerceService/2005-10-05"));
            //将叶子节点写入xmlTree
            xmlTree.append("<item id=\"");
            xmlTree.append(xpath1.selectSingleNode(doc).getText());
            xmlTree.append("\" isFolder=\"");
            xmlTree.append("false");                //注意设置isFolder为false
            xmlTree.append("\">");
            xmlTree.append(XMLUtils.escapeXML(xpath2.selectSingleNode(doc).getText()));
            xmlTree.append("</item>");
        //否则请求节点为目录节点，需要遍历读取其信息
        } else {
            //遍历节点列表，读取节点信息，写入xmlTree
            for (int i=0; i<nodeSize; i++) {
                Node idNode = (Node) idNodes.get(i);
                Node nameNode = (Node) nameNodes.get(i);
                xmlTree.append("<item id=\"");
                xmlTree.append(idNode.getText());
                xmlTree.append("\" isFolder=\"");
                xmlTree.append("true");
                xmlTree.append("\">");
                xmlTree.append(XMLUtils.escapeXML(nameNode.getText()));
                xmlTree.append("</item>");
            }
        }
    }

    xmlTree.append("</tree>");     //xmlTree根节点的结束标签
    out.print(xmlTree.toString()); //输出xmlTree
%>