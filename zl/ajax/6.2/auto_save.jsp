<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils,java.text.SimpleDateFormat,java.util.Date"%>
<%!
    //保存用户输入内容
    void saveContent(String userName, String content) {
        String sql = "update draft set draft = ? where username = ?";//定义更新数据库的SQL语句
        String sqlInsert = "insert into draft(username, draft) values (?,?)";//定义插入SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, content);        //设置草稿内容
            pstmt.setString(2, userName);       //设置用户名
            int rows = pstmt.executeUpdate();   //执行更新
            //如果返回值为0，表示记录尚不存在，改为执行插入语句
            if (rows == 0) {
                pstmt.close();                  //关闭PreparedStatement
                pstmt = conn.prepareStatement(sqlInsert);//根据sql创建PreparedStatement
                pstmt.setString(1, userName);   //设置用户名
                pstmt.setString(2, content);    //设置草稿内容
                pstmt.executeUpdate();          //执行插入
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //获取保存的草稿内容
    String getContent(String userName) {
        String content = null;                  //用于保存草稿内容
        String sql = "select draft from draft where username = ?";   //定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, userName);       //设置用户名
            rs = pstmt.executeQuery();          //执行查询
            if (rs.next()) {
                content = rs.getString(1);      //保存获取到的内容
            }
            //如果内容未获取成功，将其改为空字符串
            if (content == null) {
                content = "";
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        return content;
    }

    //按格式获取当前时间
    String getNowDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("MM月dd日 HH:mm:ss"); //声明输出格式
        return formatter.format(new Date());
    }

%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）
    request.setCharacterEncoding("UTF-8");              //设置请求体字符编码格式为UTF-8

    String userName = request.getParameter("userName"); //获取用户名
    String content = request.getParameter("content");   //获取用户输入的文本
    String action = request.getParameter("action");     //获取要执行的操作

    //执行保存操作
    if ("save".equals(action)) {
        saveContent(userName, content);                 //保存文本
        out.print("最后保存于 " + getNowDate() + "。"); //输出最后保存时间
    //执行恢复保存结果操作
    } else if ("restore".equals(action)) {
        out.print(getContent(userName));
    //显示用户最终提交内容
    } else {
        %>
        <div>用户名：<%=userName%></div>
        <div>提交内容：</div>
        <div><%=content%></div>
        <%
    }
%>