<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils,org.json.simple.JSONObject,org.json.simple.JSONArray"%>
<%!
    //根据索引标记获取名片列表
    String getAddressList(String indexKey) {
        JSONArray array = new JSONArray();          //生成一个JSONArray对象

        //根据参数不同选择不同的SQL语句
        String sql = null;
        if ("".equals(indexKey)) {
            //获取全部名片
            sql = "select id, name from address order by name asc";
        } else {
            //获取与索引匹配的名片
            sql = "select id, name from address where firstpy(name) = ? order by name asc";
        }
        Connection conn = null;                     //声明Connection对象
        PreparedStatement pstmt = null;             //声明PreparedStatement对象
        ResultSet rs = null;                        //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();         //获取数据库连接
            pstmt = conn.prepareStatement(sql);     //根据sql创建PreparedStatement
            if (!"".equals(indexKey)) {
                pstmt.setString(1, indexKey);
            }
            rs = pstmt.executeQuery();
            while (rs.next()) {                     //遍历结果集
                JSONObject obj = new JSONObject();  //创建一个JSONObject对象
                obj.put("id", rs.getString(1));
                obj.put("name", rs.getString(2));
                array.add(obj);                     //将JSONObject对象放入JSONArray对象中
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                      //关闭结果集
            DBUtils.close(pstmt);                   //关闭PreparedStatement
            DBUtils.close(conn);                    //关闭连接
        }
        return array.toString();                    //以JSON格式返回信息
    }

    //获取名片详细信息
    String getAddress(String id) {
        JSONObject obj = new JSONObject();      //创建一个JSONObject对象
        String sql = "select id, name, tel, email from address where id = ?";//定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, id);             //设置参数
            rs = pstmt.executeQuery();
            if (rs.next()) {
                obj.put("id", rs.getString(1));
                obj.put("name", rs.getString(2));
                obj.put("tel", rs.getString(3));
                obj.put("email", rs.getString(4));
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        return obj.toString();                  //以JSON格式返回信息
    }

    //添加名片信息
    void addAddress(String name, String tel, String email) {
        String sql = "insert into address(name, tel, email) values(?,?,?)";//定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, name);
            pstmt.setString(2, tel);
            pstmt.setString(3, email);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //删除名片信息
    void delAddress(String id) {
        String sql = "delete from address where id = ?";//定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //更新名片信息
    void updateAddress(String id, String name, String tel, String email) {
        String sql = "update address set name = ?, tel = ?, email = ? where id = ?";//定义SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, name);
            pstmt.setString(2, tel);
            pstmt.setString(3, email);
            pstmt.setString(4, id);
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
    out.clear();                                            //清空当前的输出内容（空格和换行符）
    request.setCharacterEncoding("UTF-8");                  //设置请求字符集为UTF-8

    String action = request.getParameter("action");         //获取action参数

    //根据action参数不同执行不同的数据库操作
    if ("getAddressList".equals(action)) {                  //执行根据索引标记获取名片列表操作
        String indexKey = request.getParameter("indexKey");
        out.print(getAddressList(indexKey));
    } else if ("getAddress".equals(action)) {               //执行获取名片详细信息操作
        String id = request.getParameter("id");
        out.print(getAddress(id));
    } else if ("addAddress".equals(action)) {               //执行添加名片信息操作
        String name = request.getParameter("name");
        String tel = request.getParameter("tel");
        String email = request.getParameter("email");
        addAddress(name, tel, email);
        out.print("用户信息保存成功。");
    } else if ("delAddress".equals(action)) {               //执行删除名片信息操作
        String id = request.getParameter("id");
        delAddress(id);
        out.print("用户信息删除成功。");
    } else if ("updateAddress".equals(action)) {            //执行更新名片信息操作
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String tel = request.getParameter("tel");
        String email = request.getParameter("email");
        updateAddress(id, name, tel, email);
        out.print("用户信息保存成功。");
    }
%>