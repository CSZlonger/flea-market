package com.wfuhui.modules.goods.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wfuhui.modules.goods.dao.GoodsDao;
import com.wfuhui.modules.goods.dao.GoodsPicDao;
import com.wfuhui.modules.goods.entity.GoodsEntity;
import com.wfuhui.modules.goods.entity.GoodsPicEntity;
import com.wfuhui.modules.goods.service.GoodsService;
import com.wfuhui.modules.member.dao.MemberDao;
import com.wfuhui.modules.member.entity.MemberEntity;


@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private GoodsPicDao goodsPicDao;
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public GoodsEntity queryObject(Integer id){
		String[] picUrls = goodsPicDao.queryByGoodsId(id);
		GoodsEntity goods = goodsDao.queryObject(id);
		goods.setPicUrls(picUrls);
		MemberEntity member = memberDao.queryObject(goods.getMemberId());
		goods.setMember(member);
		return goods;
	}
	
	@Override
	public List<GoodsEntity> queryList(Map<String, Object> map){
		List<GoodsEntity> goodsList = goodsDao.queryList(map);
		return goodsList;
	}
	
	@Override
	public int queryTotal(Map<String, Object> map){
		return goodsDao.queryTotal(map);
	}
	
	@Override
	public void save(GoodsEntity goods){
		goodsDao.save(goods);
		if (goods.getPicUrls() != null) {
			String[] picUrls = goods.getPicUrls();
			for (String picUrl : picUrls) {
				GoodsPicEntity goodsPic = new GoodsPicEntity();
				goodsPic.setGoodsId(goods.getId());
				goodsPic.setPicUrl(picUrl);
				goodsPicDao.save(goodsPic);
			}
		}
	}
	
	@Override
	public void update(GoodsEntity goods){
		if (goods.getPicUrls() != null) {
			String[] picUrls = goodsPicDao.queryByGoodsId(goods.getId());
			boolean e = isQualsPic(picUrls, goods.getPicUrls());
			if (!e) {
				goodsPicDao.deleteByGoodsId(goods.getId());
				for (String picUrl : goods.getPicUrls()) {
					GoodsPicEntity goodsPic = new GoodsPicEntity();
					goodsPic.setGoodsId(goods.getId());
					goodsPic.setPicUrl(picUrl);
					goodsPicDao.save(goodsPic);
				}
			}
		}
		goodsDao.update(goods);
	}
	
	private boolean isQualsPic(String[] picUrls, String[] picUrls2) {
		if (picUrls.length == picUrls2.length) {
			for (int i = 0; i < picUrls.length; i++) {
				if (!picUrls[i].equals(picUrls2[i])) {
					return false;
				}
			}
			return true;
		}
		return false;
	}
	
	@Override
	public void delete(Integer id){
		goodsDao.delete(id);
	}
	
	@Override
	public void deleteBatch(Integer[] ids){
		goodsDao.deleteBatch(ids);
	}
	
	@Override
	public void updateStatus(Integer status, Integer[] ids) {
		goodsDao.updateStatus(status, ids);
	}
}
