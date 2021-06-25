package com.wfuhui.modules.member.dao;

import org.apache.ibatis.annotations.Mapper;

import com.wfuhui.modules.member.entity.MemberAddressEntity;
import com.wfuhui.modules.sys.dao.BaseDao;

/**
 * 用户地址
 * 
 */
@Mapper
public interface MemberAddressDao extends BaseDao<MemberAddressEntity> {

	void updateByUserId(MemberAddressEntity t);
	
}
