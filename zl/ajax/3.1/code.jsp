<%@ page contentType="image/png" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*" %><%
//设置页面不缓存
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);

int width=40;   //设置图片宽度
int height=20;  //设置图片高度

//创建缓存图象
BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

Graphics g = image.getGraphics();               //获取图形

g.setColor(new Color(000, 102, 153));           //设置背景色
g.fillRect(0, 0, width, height);                //填充背景

g.setColor(new Color(000, 000, 000));           //设置边框颜色
g.drawRect(0, 0, width-1, height-1);            //绘制边框

g.setFont(new Font("Arial", Font.PLAIN, 16));   //设定字体

Random random = new Random();                   //生成随机类

//随机产生3位数字验证码
StringBuffer sbRan = new StringBuffer();        //保存验证码文本
for (int i=0; i<3; i++){
    String ranNum = String.valueOf(random.nextInt(10));
    sbRan.append(ranNum);
    //将验证码绘制到图象中
    g.setColor(new Color(255, 255, 255));
    g.drawString(ranNum, 10 * i + 5, 16);
}

g.dispose();                                                //部署图象

session.setAttribute("_CODE_", sbRan.toString());           //将验证码保存在session对象中供对比

ImageIO.write(image, "PNG", response.getOutputStream());    //输出图象到页面

%>