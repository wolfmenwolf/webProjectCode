<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.Enumeration"%>
<%
    out.clear();                                    //清空当前的输出内容（空格和换行符）

    out.println("服务器接收到以下参数");

    //遍历并显示所有提交到服务器的参数
    Enumeration e = request.getParameterNames();
    while(e.hasMoreElements()){
        String parameterName = (String) e.nextElement();
        String parameterValue = (String) request.getParameter(parameterName);
        out.println(parameterName + " : " + parameterValue);
    }
%>