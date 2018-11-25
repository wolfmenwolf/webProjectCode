<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%!
    //检查单词在数据库中是否存在
    boolean checkWord(String word) {
        boolean result = false;                 //存放检查结果

        String sql = "select id from words where word = ?";   //定义查询数据库的SQL语句
        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, word);           //设置参数
            rs = pstmt.executeQuery();          //执行查询，返回结果集
            if (rs.next()) {
                result = true;
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
        return result;
    }

    //解析单词，去除常见标点
    String parseWord (String srcWord) {
        String lastChar = srcWord.substring(srcWord.length()-1);    //获取单词最后的字符

        //如果最后的字符是常见标点，则去掉后返回，否则直接返回原字符
        if (".".equals(lastChar) || ",".equals(lastChar) ||
            "!".equals(lastChar) || "?".equals(lastChar)) {
            return srcWord.substring(0,srcWord.length()-1);
        } else {
            return srcWord;
        }
    }
%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）

    String text = request.getParameter("text");         //获取用户输入的文本

    StringBuffer result = new StringBuffer();           //用于保存结果的StringBuffer
    String[] words = text.split(" ");                   //将字符用空格分隔为字符串数组

    String srcWord = null;                              //保存原始字符
    String word = null;                                 //保存去除标点后的字符

    //遍历每个单词，在数据库中查找是否存在
    for (int i=0; i<words.length; i++) {
        srcWord = words[i];

        //当切分的字符不包含内容时跳过本次循环
        if ("".equals(srcWord)) {
            continue;
        }
        word = parseWord(srcWord);                      //去除标点

        //检查单词是否存在，不存在时将单词放在span标签内返回
        if (checkWord(word)) {
            result.append(srcWord);
        } else {
            result.append("<span class='warn'>");
            result.append(srcWord);
            result.append("</span>");
        }
        result.append(" ");                             //每个单词后增加一个空格
    }

    out.print(result.toString());                       //将检查结果写入响应体
%>