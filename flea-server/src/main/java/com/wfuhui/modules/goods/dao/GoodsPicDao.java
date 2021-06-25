package com.wfuhui.modules.goods.dao;

import org.apache.ibatis.annotations.Mapper;

import com.wfuhui.modules.goods.entity.GoodsPicEntity;
import com.wfuhui.modules.sys.dao.BaseDao;

/**
 * 商品图片
 * 
 */
@Mapper
public interface GoodsPicDao extends BaseDao<GoodsPicEntity> {

	String[] queryByGoodsId(Integer goodsId);

	void deleteByGoodsId(Integer goodsId);
	
}
