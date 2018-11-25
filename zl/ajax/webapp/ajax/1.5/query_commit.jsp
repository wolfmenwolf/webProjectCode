<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.Enumeration"%>
<%
    out.clear();                                            //清空当前的输出内容（空格和换行符）

    request.setCharacterEncoding("UTF-8");                  //设置请求对象字符集为UTF-8

    //遍历并显示所有提交到服务器的参数
    Enumeration e = request.getParameterNames();
    while(e.hasMoreElements()){
        String parameterName = (String) e.nextElement();
        String parameterValue = (String) request.getParameter(parameterName);
        out.print("参数名称：" + parameterName + "<br />");
        out.print("参数内容：" + parameterValue + "<br />");
    }
%>