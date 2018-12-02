<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*,java.sql.*,ajax.db.DBUtils"%>
<%!
    //创建新字符组合
    String createWord() {
        String word = null;                   //存放信息信息
        String sql = "select word from words where length(word) <= 5 order by rand() limit 2";   //定义查询数据库的SQL语句

        StringBuffer letters = new StringBuffer();
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            rs = pstmt.executeQuery();          //执行查询，返回结果集
            while (rs.next()) {                 //遍历结果集
                letters.append(rs.getString(1));//将单词追加到StringBuffer对象
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        word = parseLetter(letters.toString()); //解析字符串
        return word;
    }

    //解析字符串，按升序返回不重复的字符
    String parseLetter(String src) {
        Set s = new TreeSet();                      //声明Set对象（TreeSet有排序功能）

        //将字符串中字符加入Set对象
        for (int i = 0; i < src.length(); i++) {
            s.add(String.valueOf(src.charAt(i)));
        }

        StringBuffer result = new StringBuffer();   //声明保存结果的StringBuffer对象

        //将Set中的字符串追加到StringBuffer对象中
        Iterator it = s.iterator();
        while (it.hasNext()) {
            result.append((String) it.next());
        }
        return result.toString();                   //返回解析结果
    }
%>
<%
    out.clear();                                    //清空当前的输出内容（空格和换行符）
    out.print(createWord());                        //新生成一个字符组合写入响应体
%>