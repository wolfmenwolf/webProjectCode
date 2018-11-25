<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils,org.json.simple.JSONObject,org.json.simple.JSONArray"%>
<%!
    String sessionKey = "_LOGIN_USER_";             //session内登录key

    //用户登录
    String login(String userName, String password, HttpSession session) {
        StringBuffer result = new StringBuffer();
        String sql = "select id, name, password from task_users where name = ?";//定义SQL语句
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
                    session.setAttribute(sessionKey, rs.getString("id")); //设置session值
                    result.append("1");                         //结果第一个字符设置为1
                    result.append("<div>欢迎用户 " + userName + " 登录系统。</div>");
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
        return result.toString();
    }

    //获取任务列表
    String getLists(String userId) {
        JSONArray array = new JSONArray();      //定义JSON数组
        StringBuffer result = new StringBuffer("[");
        String sql = "select id, listname from task_lists where userid = ? order by listname asc";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, userId);         //设置参数
            rs = pstmt.executeQuery();
            //遍历结果集，给JSON数组中加入JSONObject
            while (rs.next()) {
                JSONObject obj = new JSONObject();
                obj.put("id", rs.getString(1));
                obj.put("name", rs.getString(2));
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

    //获取任务
    String getTasks(String userId, String listId) {
        JSONArray array = new JSONArray();      //定义JSON数组
        String sql = "select id, taskname, status from task_tasks where userid = ? and listid = ? order by taskname asc";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, userId);         //设置参数
            pstmt.setString(2, listId);         //设置参数
            rs = pstmt.executeQuery();
            //遍历结果集，给JSON数组中加入JSONObject
            while (rs.next()) {
                JSONObject obj = new JSONObject();
                obj.put("id", rs.getString(1));
                obj.put("name", rs.getString(2));
                obj.put("status", rs.getString(3));
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

    //改变任务状态
    void changeTaskStatus(String userId, String taskId, String status) {
        String sql = "update task_tasks set status = ? where userid = ? and id = ?";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, status);         //设置参数
            pstmt.setString(2, userId);         //设置参数
            pstmt.setString(3, taskId);         //设置参数
            pstmt.executeUpdate();              //执行更新
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //添加任务列表
    void addList(String userId, String listName) {
        String sql = "insert into task_lists(userid, listname) values(?,?)";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, userId);         //设置参数
            pstmt.setString(2, listName);       //设置参数
            pstmt.executeUpdate();              //执行插入
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //删除任务列表
    void delList(String userId, String listId) {
        String sql1 = "delete from task_tasks where userid = ? and listid = ?"; //删除任务SQL
        String sql2 = "delete from task_lists where userid = ? and id = ?";     //删除列表SQL
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql1);//根据sql1创建PreparedStatement
            pstmt.setString(1, userId);         //设置参数
            pstmt.setString(2, listId);         //设置参数
            pstmt.executeUpdate();              //执行删除
            pstmt.close();                      //关闭
            pstmt = conn.prepareStatement(sql2);//根据sql2创建PreparedStatement
            pstmt.setString(1, userId);         //设置参数
            pstmt.setString(2, listId);         //设置参数
            pstmt.executeUpdate();              //执行删除
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //更新任务列表
    void updateList(String userId, String listId, String listName) {
        String sql = "update task_lists set listname = ? where userid = ? and id = ?";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, listName);       //设置参数
            pstmt.setString(2, userId);         //设置参数
            pstmt.setString(3, listId);         //设置参数
            pstmt.executeUpdate();              //执行更新
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //添加任务
    void addTask(String userId, String listId, String taskName) {
        String sql = "insert into task_tasks(userid, listid, taskname) values(?,?,?)";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, userId);         //设置参数
            pstmt.setString(2, listId);         //设置参数
            pstmt.setString(3, taskName);       //设置参数
            pstmt.executeUpdate();              //执行插入
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //删除任务
    void delTask(String userId, String taskId) {
        String sql = "delete from task_tasks where userid = ? and id = ?";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, userId);         //设置参数
            pstmt.setString(2, taskId);         //设置参数
            pstmt.executeUpdate();              //执行删除
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //更新任务
    void updateTask(String userId, String taskId, String taskName) {
        String sql = "update task_tasks set taskname = ? where userid = ? and id = ?";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, taskName);       //设置参数
            pstmt.setString(2, userId);         //设置参数
            pstmt.setString(3, taskId);         //设置参数
            pstmt.executeUpdate();              //执行更新
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }
%>
<%
    out.clear();                                            //清空当前的输出内容（空格和换行符）
    request.setCharacterEncoding("UTF-8");                  //设置请求字符集为UTF-8
    String userId = (String) session.getAttribute(sessionKey);  //获取当前登录用户编号

    String action = request.getParameter("action");         //获取title

    //根据action参数不同执行不同的操作
    if ("login".equals(action)) {                           //登录操作
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String result = login(userName, password, session);
        out.print(result);
    } else if ("logout".equals(action)) {                   //退出操作
        session.removeAttribute(sessionKey);
    } else if ("getLists".equals(action)) {                 //获取任务列表
        out.print(getLists(userId));
    } else if ("getTasks".equals(action)) {                 //获取任务
        String listId = request.getParameter("listId");
        out.print(getTasks(userId, listId));
    } else if ("changeTaskStatus".equals(action)) {         //改变任务状态
        String taskId = request.getParameter("taskId");
        String status = request.getParameter("status");
        changeTaskStatus(userId, taskId, status);
        out.print("任务状态修改成功。");
    } else if ("addList".equals(action)) {                  //添加任务列表
        String listName = request.getParameter("listName");
        addList(userId, listName);
        out.print("列表添加成功。");
    } else if ("delList".equals(action)) {                  //删除任务列表
        String listId = request.getParameter("listId");
        delList(userId, listId);
        out.print("列表删除成功。");
    } else if ("updateList".equals(action)) {               //更新任务列表
        String listId = request.getParameter("listId");
        String listName = request.getParameter("listName");
        updateList(userId, listId, listName);
        out.print("列表更新成功。");
    } else if ("addTask".equals(action)) {                  //添加任务
        String listId = request.getParameter("listId");
        String taskName = request.getParameter("taskName");
        addTask(userId, listId, taskName);
        out.print("任务添加成功。");
    } else if ("delTask".equals(action)) {                  //删除任务
        String taskId = request.getParameter("taskId");
        delTask(userId, taskId);
        out.print("任务删除成功。");
    } else if ("updateTask".equals(action)) {               //更新任务
        String taskId = request.getParameter("taskId");
        String taskName = request.getParameter("taskName");
        updateTask(userId, taskId, taskName);
        out.print("任务更新成功。");
    }
%>