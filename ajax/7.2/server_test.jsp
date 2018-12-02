<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%
    out.clear();                                //清空当前的输出内容（空格和换行符）
    String info = request.getParameter("info"); //获取info参数值
    out.print("成功接收到客户端信息：" + info); //输出响应结果
%>
