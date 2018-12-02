<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils,org.json.simple.JSONObject,org.json.simple.JSONArray"%>
<%!
    //取得所有愿望
    String getWishes() {
        JSONArray array = new JSONArray();      //声明JSON数组
        String sql = "select id, username, wish, wishtime, colorsuit from wishes order by id asc";   //定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            rs = pstmt.executeQuery();
            while (rs.next()) {
                //使用数据库结果集生成JSON对象，并加入到JSON数组中
                JSONObject obj = new JSONObject();
                obj.put("id", rs.getString(1));
                obj.put("username", rs.getString(2));
                obj.put("wish", rs.getString(3));
                obj.put("wishtime", rs.getString(4));
                obj.put("colorsuit", new Integer(rs.getInt(5)));
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

    //记录新愿望
    void addWish(String username, String wish, String color) {
        String sql = "insert into wishes(username, wish, wishtime, colorsuit) values(?,?,now(),?)";   //定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, username);       //设置参数
            pstmt.setString(2, wish);           //设置参数
            pstmt.setString(3, color);          //设置参数
            pstmt.executeUpdate();              //执行插入
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //获取数据库时间
    String getDBTime() {
        String dbTime = "";                     //返回结果
        String sql = "select now()";            //定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dbTime = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        return dbTime;
    }
%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）
    request.setCharacterEncoding("UTF-8");              //设置请求字符集为UTF-8

    String action = request.getParameter("action");     //获取action参数

    //根据action不同执行不同操作
    if ("getWishes".equals(action)) {
        out.print(getWishes());
    } else if ("sendWish".equals(action)) {             //记录新愿望
        String username = request.getParameter("username");
        String wish = request.getParameter("wish");
        String color = request.getParameter("color");
        addWish(username, wish, color);
        out.print(getDBTime());                         //返回保存时间
    }
%>