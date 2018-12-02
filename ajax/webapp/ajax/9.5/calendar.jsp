<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils,org.json.simple.JSONObject,org.json.simple.JSONArray"%>
<%!
    //获取目标月份任务信息
    String getTasks(String month) {
        JSONArray array = new JSONArray();      //新建JSON数组对象
        String sql = "select id, task, builddate from schedule where builddate like ? order by id asc";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, month + "-%");   //设置参数
            rs = pstmt.executeQuery();
            while (rs.next()) {
                //使用数据库结果集生成JSON对象，并加入到JSON数组中
                JSONObject obj = new JSONObject();
                obj.put("id", rs.getString(1));
                obj.put("task", rs.getString(2));
                obj.put("builddate", rs.getString(3));
                array.add(obj);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        return array.toString();
    }

    //添加新任务
    int addTask(String taskInfo, String buildDate) {
        int newId = -1;                         //用于保存新任务编号
        String sql = "insert into schedule(task, builddate) values(?,?)";   //定义插入数据的SQL语句

        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, taskInfo);       //设置参数
            pstmt.setString(2, buildDate);      //设置参数
            pstmt.executeUpdate();
            pstmt.close();

            //获取刚插入数据的新id
            pstmt = conn.prepareStatement("select last_insert_id()");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                newId = rs.getInt(1);           //获取新id
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        return newId;
    }

    //删除任务 
    void delTask(String taskId) {
        String sql = "delete from schedule where id = ?";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, taskId);         //设置参数
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //更新任务
    void updateTask(String taskId, String taskInfo) {
        String sql = "update schedule set task = ? where id = ?";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, taskInfo);       //设置参数
            pstmt.setString(2, taskId);         //设置参数
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }
%>
<%
    out.clear();                                                //清空当前的输出内容（空格和换行符）
    request.setCharacterEncoding("UTF-8");                      //设置请求字符集为UTF-8

    String action = request.getParameter("action");             //获取action信息

    //根据action不同执行不同的操作
    if ("addTask".equals(action)) {                             //新建任务
        String taskInfo = request.getParameter("taskInfo");
        String buildDate = request.getParameter("buildDate");
        out.print(addTask(taskInfo,buildDate));
    } else if ("getTasks".equals(action)) {                     //获取整月任务信息
        String month = request.getParameter("month");
        String result = getTasks(month);
        out.println(result);
    } else if ("delTask".equals(action)) {                      //删除任务
        String taskId = request.getParameter("taskId");
        delTask(taskId);
    } else if ("updateTask".equals(action)) {                   //更新任务信息
        String taskId = request.getParameter("taskId");
        String taskInfo = request.getParameter("taskInfo");
        updateTask(taskId, taskInfo);
    }
%>