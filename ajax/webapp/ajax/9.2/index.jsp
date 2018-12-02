<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>自定义个人门户</title>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/iutil.js"></script>
<script type="text/javascript" src="js/idrag.js"></script>
<script type="text/javascript" src="js/idrop.js"></script>
<script type="text/javascript" src="js/isortables.js"></script>

<style type="text/css">
/* 页面字体样式 */
body, input {
    font-family:Arial;
    font-size:12px;
}

/* 分栏样式 */
div.column {
    width:200px;
    background-color:#006699;
    margin:4px;
    float:left;
    min-height:80px;
}

/* 模块样式 */
div.item {
    margin:8px;
    background:#FFF;
    color:#666;
}

/* 模块拖拽区域样式 */
div.handle {
    background:#FF9933;
    padding:3px;
    color:#333;
    font-weight:bold;
    cursor:move;
}

/* 移动目标区域预览样式 */
.helper {
    border:1px dotted #ccc;
}
</style>
<script type="text/javascript">
//页面加载完毕初始化各分栏节点
$(document).ready(
    function () {
        $('div.column').Sortable(
            {
                accept:'item',              //分栏内部模块的class名称
                helperclass:'helper',       //预览移动位置的class名称
                opacity:0.8,                //移动过程中的不透明度设置
                handle:'.handle'            //移动手柄元素标识
            }
        );
    }
);

//向服务器提交模块位置信息
function save() {
    var serial = $.SortSerialize();         //将模块信息序列化
    $.ajax(
        {
            type:"POST",                    //发送POST请求
            url:"portal.jsp",               //目标地址
            data:serial.hash,               //发送的内容体
            success:function() {            //成功后的回调函数
                alert("模块位置保存完毕。");
            }
        }
    );
}

</script>
</head>

<body>
<h1>自定义个人门户</h1>
<div style="margin:20px">
    <input type="button" onclick="save()" value="保存模块布局">
</div>
<%
    List column1 = new ArrayList();         //用于保存分栏1的List
    List column2 = new ArrayList();         //用于保存分栏2的List
    List column3 = new ArrayList();         //用于保存分栏3的List

    String sql = "select * from portal order by seq asc";   //定义查询数据库的SQL语句
    int currentColumn = 0;
    Connection conn = null;                 //声明Connection对象
    PreparedStatement pstmt = null;         //声明PreparedStatement对象
    ResultSet rs = null;                    //声明ResultSet对象
    try {
        conn = DBUtils.getConnection();     //获取数据库连接
        pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
        rs = pstmt.executeQuery();          //执行查询，返回结果集
        while (rs.next()) {                 //遍历结果集
            int column = rs.getInt("col");
            Map m = new HashMap();          //声明保存模块信息的Map
            m.put("id", rs.getString("id"));
            m.put("name", rs.getString("name"));
            m.put("height", rs.getString("height"));
            //根据分栏编号保存到不同List中
            if (column == 1) {
                column1.add(m);
            } else if (column == 2) {
                column2.add(m);
            } else {
                column3.add(m);
            }
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
        DBUtils.close(rs);                  //关闭结果集
        DBUtils.close(pstmt);               //关闭PreparedStatement
        DBUtils.close(conn);                //关闭连接
    }
%>
<div class="column" id="column1">
<%
    //循环从分栏1的List中获取模块信息
    for (int i=0; i<column1.size(); i++) {
        Map m = (Map)column1.get(i);
        %>
        <div class="item" id="item<%=m.get("id")%>" style="height:<%=m.get("height")%>px"><div class="handle"><%=m.get("name")%></div></div>
        <%
    }
%>
</div>

<div class="column" id="column2">
<%
    //循环从分栏2的List中获取模块信息
    for (int i=0; i<column2.size(); i++) {
        Map m = (Map)column2.get(i);
        %>
        <div class="item" id="item<%=m.get("id")%>" style="height:<%=m.get("height")%>px"><div class="handle"><%=m.get("name")%></div></div>
        <%
    }
%>
</div>

<div class="column" id="column3">
<%
    //循环从分栏3的List中获取模块信息
    for (int i=0; i<column3.size(); i++) {
        Map m = (Map)column3.get(i);
        %>
        <div class="item" id="item<%=m.get("id")%>" style="height:<%=m.get("height")%>px"><div class="handle"><%=m.get("name")%></div></div>
        <%
    }
%>
</div>

</body>
</html>