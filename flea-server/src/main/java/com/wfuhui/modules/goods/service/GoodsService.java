package com.wfuhui.modules.goods.service;

import java.util.List;
import java.util.Map;

import com.wfuhui.modules.goods.entity.GoodsEntity;

/**
 * 商品
 * 
 */
public interface GoodsService {
	
	GoodsEntity queryObject(Integer id);
	
	List<GoodsEntity> queryList(Map<String, Object> map);
	
	int queryTotal(Map<String, Object> map);
	
	void save(GoodsEntity goods);
	
	void update(GoodsEntity goods);
	
	void delete(Integer id);
	
	void deleteBatch(Integer[] ids);
	
	void updateStatus(Integer status, Integer[] ids);
}
