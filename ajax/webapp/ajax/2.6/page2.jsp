<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<p>这里是page2的内容。</p>
<%
    for (int i=1; i<=5; i++) {
        out.println("循环 " + i + "<br />");
    }
    Thread.sleep(1000);     //休眠1秒钟，让加载提示信息多显示1秒
%>