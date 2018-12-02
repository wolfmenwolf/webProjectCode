<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.GetMethod"%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）

    String url = request.getParameter("url");           //获取URL地址
    HttpClient client = new HttpClient();               //创建Http客户端对象
    GetMethod method = new GetMethod(url);              //创建一个Get请求方法
    try {
        client.executeMethod(method);                   //执行Get请求方法
        byte[] responseBody = method.getResponseBody(); //获取响应结果
        out.print(new String(responseBody, "UTF-8"));   //将获取的结果以UTF-8编码输出到响应体
    } catch (Exception e) {
    } finally {
        method.releaseConnection();                     //释放Http连接
    }
%>