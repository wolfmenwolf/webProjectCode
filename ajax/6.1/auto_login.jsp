<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%!
    String sessionKey = "_LOGIN_USER_";             //session内登录key
%>
<%
    request.setCharacterEncoding("UTF-8");          //设置请求体字符编码格式为UTF-8
    out.clear();                                    //清空当前的输出内容（空格和换行符）

    String action = request.getParameter("action");         //获取action参数
    String userName = request.getParameter("userName");     //获取userName参数
    String password = request.getParameter("password");     //获取password参数

    StringBuffer result = new StringBuffer();       //保存输出信息

    //处理登录请求
    if ("login".equals(action)) {
        String sql = "select username, password from users where username = ?";//定义查询数据库的SQL语句
        Connection conn = null;                     //声明Connection对象
        PreparedStatement pstmt = null;             //声明PreparedStatement对象
        ResultSet rs = null;                        //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();         //获取数据库连接
            pstmt = conn.prepareStatement(sql);     //根据sql创建PreparedStatement
            pstmt.setString(1, userName);           //设置参数
            rs = pstmt.executeQuery();              //执行查询，返回结果集
            if (rs.next()) {
                String dbPass = rs.getString("password");       //获取密码
                //根据密码匹配结果设置不同输出结果
                if (dbPass.equals(password)) {                  //登录成功
                    session.setAttribute(sessionKey, userName); //设置session值
                    result.append("1");                         //结果第一个字符设置为1
                    result.append("欢迎用户 " + userName + " 登录系统。");
                    result.append("<input type='button' value='退出' onclick='logout()'>");
                } else {                                        //登录失败
                    result.append("0");                         //结果第一个字符设置为0
                    result.append("密码错误。");
                }
            } else {                                            //登录失败
                result.append("0");                             //结果第一个字符设置为0
                result.append("该用户不存在。");
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    //处理检查登录情况请求
    } else if ("check".equals(action)) {
        String loginUser = (String) session.getAttribute(sessionKey);   //获取当前登录用户
        //根据是否有登录用户输入不同结果
        if (loginUser == null) {
            result.append("当前没有登录用户。");
        } else {
            result.append("当前登录用户为 " + loginUser);
        }
    //处理退出请求
    } else if ("logout".equals(action)) {
        session.removeAttribute(sessionKey);    //将session中登录信息清除
    }

    out.print(result.toString());               //输出响应结果
%>