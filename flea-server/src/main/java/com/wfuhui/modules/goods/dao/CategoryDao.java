package com.wfuhui.modules.goods.dao;

import org.apache.ibatis.annotations.Mapper;

import com.wfuhui.modules.goods.entity.CategoryEntity;
import com.wfuhui.modules.sys.dao.BaseDao;

/**
 * 分类
 * 
 */
@Mapper
public interface CategoryDao extends BaseDao<CategoryEntity> {

	
}
