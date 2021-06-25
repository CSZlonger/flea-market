package com.wfuhui.modules.goods.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.wfuhui.modules.goods.entity.GoodsEntity;
import com.wfuhui.modules.sys.dao.BaseDao;

/**
 * 商品
 * 
 */
@Mapper
public interface GoodsDao extends BaseDao<GoodsEntity> {

	void updateStatus(@Param("status")Integer status, @Param("ids")Integer[] ids);
}
