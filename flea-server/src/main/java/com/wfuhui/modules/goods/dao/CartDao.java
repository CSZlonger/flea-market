package com.wfuhui.modules.goods.dao;

import com.wfuhui.modules.goods.entity.CartEntity;
import com.wfuhui.modules.sys.dao.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 购物车
 * 
 */
@Mapper
public interface CartDao extends BaseDao<CartEntity> {

	CartEntity queryByGoodsId(Integer goodsId);

	void addNum(Integer goodsId);

	void deleteByGoodsId(@Param("memberId")Long memberId, @Param("goodsId")Integer goodsId);
	
}
