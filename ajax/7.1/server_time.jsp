<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*,java.text.*"%>
<%!
    //按格式获取服务器当前时间
    String getNowDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");   //设置时间格式
        return formatter.format(new Date());
    }
%>
<%
    out.clear();                                    //清空当前的输出内容（空格和换行符）
    out.println(getNowDate());                      //输入当前时间
%>