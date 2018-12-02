<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*,java.text.*"%>
<%!
    //按格式获取当前时间
    String getNowDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return formatter.format(new Date());
    }

    Random random = new Random();                   //生成随机类

    //获取随机数
    double getRandomNum() {
        //生成随机boolean值决定随机数的正负值
        if (random.nextBoolean()) {
            return random.nextDouble();
        } else {
            return 0 - random.nextDouble();
        }
    }

    NumberFormat nf = new DecimalFormat("#.##");    //数字输出格式

    //设定股票初始价格
    double priceA = 25.3;
    double priceB = 43.5;
    double priceC = 12.2;
%>
<%

    //随机为股票增减价格
    priceA += getRandomNum();
    priceB += getRandomNum();
    priceC += getRandomNum();

    out.clear();                                    //清空当前的输出内容（空格和换行符）

    //将格式化后的价格以JSON格式输出
    StringBuffer result = new StringBuffer("{");
    result.append("'priceA':'" + nf.format(priceA) + "'");
    result.append(",'priceB':'" + nf.format(priceB) + "'");
    result.append(",'priceC':'" + nf.format(priceC) + "'");
    result.append(",'lastUpdateTime':'" + getNowDate() + "'");
    result.append("}");

    out.println(result.toString());                 //将结果写入响应体
%>