package ajax.biz;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ajax.db.DBUtils;

public class Product {
    private String productId = null;		//产品编号
    private String productName = null;		//产品名称
    private double productPrice = 0;		//产品价格
    private int productsNum = 0;			//产品数量

    /**
     * 通过产品ID构造一个产品
     */
    public Product(String productId) {
        String sql = "select pid, pname, price from products where pid = ?";
    	Connection conn = null;                 //声明Connection对象
        PreparedStatement pstmt = null;         //声明PreparedStatement对象
        ResultSet rs = null;                    //声明ResultSet对象
        try {
            conn = DBUtils.getConnection();		//获取数据库连接
            pstmt = conn.prepareStatement(sql);	//根据sql创建PreparedStatement
            pstmt.setString(1, productId);		//设置参数

            rs = pstmt.executeQuery();			//执行查询，返回结果集
            if (rs.next()) {
                this.productId = rs.getString(1);
                this.productName = rs.getString(2);
                this.productPrice = rs.getDouble(3);
                this.productsNum = 1;
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            DBUtils.close(rs);                  //关闭结果集
            DBUtils.close(pstmt);               //关闭PreparedStatement
            DBUtils.close(conn);                //关闭连接
        }
    }

    //获取产品编号
    public String getProductId() {
        return productId;
    }

    //设置产品编号
    public void setProductId(String productId) {
        this.productId = productId;
    }

    //获取产品名称
    public String getProductName() {
        return productName;
    }

    //获取产品价格
    public double getProductPrice() {
        return productPrice;
    }

    //获取产品数量
    public int getProductsNum() {
        return productsNum;
    }

    //设置产品数量
    public void setProductsNum(int productsNum) {
        this.productsNum = productsNum;
	}

}