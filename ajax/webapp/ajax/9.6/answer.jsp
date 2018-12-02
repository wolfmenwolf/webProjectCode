<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*,ajax.db.DBUtils"%>
<%@ page import="java.util.*,java.io.*,org.dom4j.*,org.dom4j.io.*"%>

<%!
    Map rightAnswerCache = new HashMap();   //用于缓存答案的Map
    String marker = "^$$^";                 //答案分段标记
    String RIGHT = "RIGHT";                 //正确变量
    String WRONG = "WRONG";                 //错误变量

    //获取正确答案
    String getRightAnswer(String questionId) throws DocumentException {

        //先从缓存答案的Map查找
        String cacheAnswer = (String) rightAnswerCache.get(questionId);
        if (cacheAnswer!=null) {
            return cacheAnswer;
        }

        //缓存中没有则从数据库中读取
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

        //使用Dom4jAPI解析试题信息
        StringBuffer rightAnswer = new StringBuffer(marker);
        SAXReader reader = new SAXReader();     //创建一个SAXReader
        Document doc = reader.read(new StringReader(question)); //解析试题信息
        Node node = doc.selectSingleNode("//question");         //获取question节点
        String type = node.valueOf("@type");                    //获取type属性
        List options = doc.selectNodes("//option");             //获取option选项

        //遍历选项，将正确答案连接在一起，中间用答案分段标记marker变量分隔
        for (int i=0; i<options.size(); i++) {
            Node option = (Node) options.get(i);
            //mark属性为“1”表示该选项为正确答案
            if ("1".equals(option.valueOf("@mark"))) {
                rightAnswer.append(option.getText());
                rightAnswer.append(marker);
            }
        }

        //将正确答案放入缓存
        rightAnswerCache.put(questionId, rightAnswer.toString());
        return rightAnswer.toString();
    }

    //生成用户答案
    String getUserAnswer(String[] answers) {
        if (answers==null) return null;
        //将用户答案连接在一起，中间用答案分段标记marker变量分隔
        StringBuffer userAnswer = new StringBuffer(marker);
        for (int i=0; i<answers.length; i++) {
            userAnswer.append(answers[i]);
            userAnswer.append(marker);
        }
        return userAnswer.toString();
    }
%>

<%
    out.clear();                                            //清空当前的输出内容（空格和换行符）
    request.setCharacterEncoding("UTF-8");                  //设置请求字符集为UTF-8

    String questionId = request.getParameter("questionId"); //获取问题编号

    String rightAnswer = getRightAnswer(questionId);        //获取正确答案
    String userAnswer = getUserAnswer(request.getParameterValues("answer"));    //获取用户答案

    //比对答案是否正确，决定输出内容
    if (rightAnswer.equals(userAnswer)) {
        out.print(RIGHT);
    } else {
        out.print(WRONG);
    }
%>