<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.GetMethod"%>
<%
    out.clear();                                    //清空当前的输出内容（空格和换行符）

    boolean serverOK = false;                       //检查结果标识，默认为false
    String url = request.getParameter("url");       //获取URL地址
    HttpClient client = new HttpClient();           //创建Http客户端对象
    GetMethod method = new GetMethod(url);          //创建一个Get请求方法
    try {
        int statusCode = client.executeMethod(method);  //执行Get请求方法，获取结果状态
        //如果状态为HttpStatus.SC_OK，即200，则设置检查结果为true
        if (statusCode == HttpStatus.SC_OK) {
            serverOK = true;
        }
    } catch (Exception e) {
    } finally {
        method.releaseConnection();                 //释放Http连接
    }

    //根据serverOK标识输出不同信息
    if (serverOK) {
        out.println("<span class='ok'>检查正常</span>");
    } else {
        out.println("<span class='error'>出现异常</span>");
    }
%>