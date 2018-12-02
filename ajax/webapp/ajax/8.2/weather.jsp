<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*,java.io.*,org.dom4j.*,org.dom4j.io.*"%>
<%!
    //根据风向角度转换为风向信息
    String getDirection(String degreeStr) {
        int degree = Integer.parseInt(degreeStr);
        String direction = null;
        if(degree > 337 && degree <= 360) {
            direction = "北风";
        } else if(degree >= 0 && degree <= 22) {
            direction = "北风";
        } else if(degree > 22 && degree <= 67) {
            direction = "东北风";
        } else if(degree > 67 && degree <= 112) {
            direction = "东风";
        } else if(degree > 112 && degree <= 157) {
            direction = "东南风";
        } else if(degree > 157 && degree <= 202) {
            direction = "南风";
        } else if(degree > 202 && degree <= 247) {
            direction = "西南风";
        } else if(degree > 247 && degree <= 292) {
            direction = "西风";
        } else if(degree > 292 && degree <= 337) {
            direction = "西北风";
        }
        return direction;
    }
%>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）

    String cityCode = request.getParameter("cityCode"); //获取城市代码

    SAXReader reader = new SAXReader();                 //创建一个SAXReader
    //使用Reader解析远程服务器RSS信息
    Document doc = reader.read("http://xml.weather.yahoo.com/forecastrss?p="+cityCode+"&u=c");

    //将需要进一步处理的信息转换为Node对象
    Node lastBuildDateNode = doc.selectSingleNode("//rss/channel/lastBuildDate");
    Node windNode = doc.selectSingleNode("//rss/channel/yweather:wind");
    Node atmosphereNode = doc.selectSingleNode("//rss/channel/yweather:atmosphere");
    Node astronomyNode = doc.selectSingleNode("//rss/channel/yweather:astronomy");
    Node conditionNode = doc.selectSingleNode("//rss/channel/item/yweather:condition");
    Node forecastNode = doc.selectSingleNode("//rss/channel/item/yweather:forecast");

    //获取需要的信息
    String lastBuildDate = lastBuildDateNode.getText();                 //最后更新日期
    String chill = "N/A";
    String direction = "N/A";
    String speed = "N/A";
    if (windNode != null) {
        chill = windNode.valueOf("@chill") + "℃";                      //感觉气温
        direction = getDirection(windNode.valueOf("@direction"));       //风向
        speed = windNode.valueOf("@speed") + "Kph";                     //风速
    }
    String humidity = "N/A";
    String visibility = "N/A";
    if (atmosphereNode != null) {
        humidity = atmosphereNode.valueOf("@humidity") + "%";           //湿度
        visibility = Double.parseDouble(atmosphereNode.valueOf("@visibility"))/100 + "km";//能见度
    }
    String sunrise = astronomyNode.valueOf("@sunrise");                 //日出时间
    String sunset = astronomyNode.valueOf("@sunset");                   //日落时间
    String condition = "N/A";
    String temp = "N/A";
    if (conditionNode != null) {
        condition = conditionNode.valueOf("@text");                     //天气状况
        temp = conditionNode.valueOf("@temp") + "℃";                   //实际气温
    }
    String low = forecastNode.valueOf("@low") + "℃";                   //最低气温
    String high = forecastNode.valueOf("@high") + "℃";                 //最高气温

    //将信息拼接为JSON格式
    StringBuffer result = new StringBuffer("{");
    result.append("'lastBuildDate':'" + lastBuildDate + "',");
    result.append("'chill':'" + chill + "',");
    result.append("'direction':'" + direction + "',");
    result.append("'speed':'" + speed + "',");
    result.append("'humidity':'" + humidity + "',");
    result.append("'visibility':'" + visibility + "',");
    result.append("'sunrise':'" + sunrise + "',");
    result.append("'sunset':'" + sunset + "',");
    result.append("'condition':'" + condition + "',");
    result.append("'temp':'" + temp + "',");
    result.append("'low':'" + low + "',");
    result.append("'high':'" + high + "'");
    result.append("}");

    out.print(result.toString());     //输出天气信息
%>