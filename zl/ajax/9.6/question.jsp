<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*,java.sql.*,ajax.db.DBUtils"%>

<%!
    String[] questions = {"1","2","3","4"};     //保存考试试题编号及出题顺序
    Map questionCache = new HashMap();          //用于缓存试题信息的Map

    /* 获取试题信息 */
    String getQuestion(String questionId) {

        //先从缓存试题信息的Map查找
        String cacheQuestion = (String) questionCache.get(questionId);
        if (cacheQuestion!=null) {
            return cacheQuestion;
        }

        //缓存中没有则从数据库读取
        String question = null;
        String sql = "select content from questions where id = ?";   //定义SQL语句

        Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();     //获取数据库连接
            pstmt = conn.prepareStatement(sql); //根据sql创建PreparedStatement
            pstmt.setString(1, questionId);     //设置参数
            rs = pstmt.executeQuery();
            if (rs.next()) {
                question = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }

        questionCache.put(questionId, question);//将试题放入缓存中
        return question;
    }
%>

<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）
    String startExam = request.getParameter("start");   //获取start参数表示刚开始考试
    String quesNum = request.getParameter("get");       //获取请求的试题序号

    //根据参数执行不同的操作
    if ("true".equals(startExam)) {
        out.println(questions.length);                  //开始考试时输出试题总数
    } else if (quesNum!=null) {
        int qnum = Integer.parseInt(quesNum);
        if (qnum < questions.length) {
            out.print(getQuestion(questions[qnum]));    //输出客户端请求的试题信息
        }
    }
%>