package com.wfuhui.modules.goods.service;

import com.wfuhui.modules.goods.entity.CartEntity;

import java.util.List;
import java.util.Map;

/**
 * 购物车
 * 
 */
public interface CartService {
	
	CartEntity queryObject(Integer id);
	
	List<CartEntity> queryList(Map<String, Object> map);
	
	int queryTotal(Map<String, Object> map);
	
	void save(CartEntity cart);
	
	void update(CartEntity cart);
	
	void delete(Integer id);
	
	void deleteBatch(Integer[] ids);
}
