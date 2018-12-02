<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*,ajax.db.DBUtils,ajax.biz.*"%>
<jsp:useBean id="cart" scope="session" class="ajax.biz.ShoppingCart"/>
<%
    out.clear();                                        //清空当前的输出内容（空格和换行符）
    String action = request.getParameter("action");     //获取操作
    String pid = request.getParameter("pid");           //获取产品编号

    if ("add".equals(action)) {
        cart.addProduct(pid);                           //增加新产品到购物车
    } else if ("empty".equals(action)) {
        cart.clearProduct();                            //清空购物车
    } else if ("del".equals(action)) {
        cart.delProduct(pid);                           //删除产品
    }
%>
<table class="default">
<tr>
    <td width="35%" class="item">产品名称</td>
    <td width="20%" class="item">价格</td>
    <td width="15%" class="item">数量</td>
    <td width="15%" class="item">小计</td>
    <td width="15%" class="item">删除</td>
</tr>
<%
    if (cart.getProductsNum() != 0) {//当购物车内有产品时

        //取得存放产品信息的HashMap并显示
        Map cartMap = cart.getCartMap();
        Iterator mapKey = cartMap.keySet().iterator();
        while (mapKey.hasNext()) {
            Product product = (Product)cartMap.get((String)mapKey.next());
            %>
            <tr>
                <td><%=product.getProductName()%></td>
                <td align="center"><%=product.getProductPrice()%> 元</td>
                <td align="center"><%=product.getProductsNum()%></td>
                <td align="center" style="color:red;"><%=product.getProductPrice() * product.getProductsNum()%> 元</td>
                <td align="center"><input type="button" onclick="delProduct('<%=product.getProductId()%>')" value="删除"></td>
            </tr>
            <%
        }
        %>
        <tr style="font-weight:bold">
             <td>总计</td>
             <td></td>
             <td align="center"><%=cart.getProductsNum()%></td>
             <td align="center"><%=cart.getTotalPrice()%> 元</td>
             <td></td>
        <tr>
            <td colspan="5" style="text-align:right"><input type="button" value="清空购物车" onclick="emptyCart();"></td>
        </tr>
        <%
    } else {//购物车内没有产品时
        %>
        <tr>
            <td colspan="5" style="height:50px" align="center">您还没有选择任何产品</td>
        </tr>
        <%
    }
%>
</table>