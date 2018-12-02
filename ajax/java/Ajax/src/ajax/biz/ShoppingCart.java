package ajax.biz;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class ShoppingCart {
	private Map cartMap = null;	//保存Product的Map

	/**
	 * 购物车构造函数
	 */
	public ShoppingCart() {
		cartMap = new HashMap();
	}

	/**
	 * 检查是否购物车内已存在该产品
	 */
	public boolean existProduct(String productId) {
		Iterator hmKey = cartMap.keySet().iterator();
		while (hmKey.hasNext()) {
			String hmId = (String) hmKey.next();
			if (hmId.equals(productId)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 取得存放产品的cartMap
	 */
	public Map getCartMap() {
		return cartMap;
	}

	/**
	 * 取得购物车内产品总数量
	 */
	public int getProductsNum() {
		int productNum = 0;
		Iterator hmEntry = cartMap.values().iterator();
		while (hmEntry.hasNext()) {
			productNum += ((Product) hmEntry.next()).getProductsNum();
		}
		return productNum;
	}

	/**
	 * 添加产品进购物车
	 */
	public boolean addProduct(String productId) {
		if (existProduct(productId)) {// 产品已存在则增加数量
			Product product = (Product) cartMap.get(productId);
			product.setProductsNum(product.getProductsNum() + 1);
			return true;
		} else {// 否则新加入该产品
			Product product = new Product(productId);
			if (product.getProductId() == null) {
				return false;
			} else {
				cartMap.put(productId, product);
				return true;
			}
		}
	}

	/**
	 * 删除购物车内产品
	 */
	public void delProduct(String productId) {
		cartMap.remove(productId);
	}

	/**
	 * 取得购物车内产品总计金额
	 */
	public double getTotalPrice() {
		double totalPrice = 0;
		Iterator hmEntry = cartMap.values().iterator();
		while (hmEntry.hasNext()) {
			Product product = (Product) hmEntry.next();
			totalPrice += product.getProductsNum() * product.getProductPrice();
		}
		return totalPrice;
	}

	/**
	 * 清空购物车
	 */
	public void clearProduct() {
		cartMap.clear();
	}

}
