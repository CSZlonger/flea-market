package com.wfuhui.modules.goods.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.wfuhui.modules.goods.dao.CartDao;
import com.wfuhui.modules.goods.entity.CartEntity;
import com.wfuhui.modules.goods.service.CartService;



@Service("cartService")
public class CartServiceImpl implements CartService {
	@Autowired
	private CartDao cartDao;
	
	@Override
	public CartEntity queryObject(Integer id){
		return cartDao.queryObject(id);
	}
	
	@Override
	public List<CartEntity> queryList(Map<String, Object> map){
		return cartDao.queryList(map);
	}
	
	@Override
	public int queryTotal(Map<String, Object> map){
		return cartDao.queryTotal(map);
	}
	
	@Override
	public void save(CartEntity cart){
		CartEntity c = cartDao.queryByGoodsId(cart.getGoodsId());
		if(c != null) {
			cartDao.addNum(cart.getGoodsId());
		}else {
			cartDao.save(cart);
		}
	}
	
	@Override
	public void update(CartEntity cart){
		cartDao.update(cart);
	}
	
	@Override
	public void delete(Integer id){
		cartDao.delete(id);
	}
	
	@Override
	public void deleteBatch(Integer[] ids){
		cartDao.deleteBatch(ids);
	}
	
}
