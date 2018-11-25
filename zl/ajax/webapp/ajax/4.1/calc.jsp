<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%
    out.clear();                            //清空当前的输出内容（空格和换行符）
    request.setCharacterEncoding("UTF-8");  //设置请求体字符集编码

    double data1 = Double.parseDouble(request.getParameter("data1"));           //获取data1
    double data2 = Double.parseDouble(request.getParameter("data2"));           //获取data2
    String operation = request.getParameter("operation");                       //获取操作符

    double result = 0;                      //操作结果

    //根据不同操作符进行计算
    if ("+".equals(operation)) {
        result = data1 + data2;
    } else if ("-".equals(operation)) {
        result = data1 - data2;
    } else if ("*".equals(operation)) {
        result = data1 * data2;
    } else if ("/".equals(operation)) {
        result = data1 / data2;
    }

    //将结果转换为int类型，用于去掉无用的小数部分，例如将3.0改为3
    int resultInt = (int) result;

    //如果转为int后与原始结果相同，则输出int形式，否则输出原式结果
    if (resultInt == result) {
        out.print(resultInt);
    } else {
        out.print(result);
    }
%>