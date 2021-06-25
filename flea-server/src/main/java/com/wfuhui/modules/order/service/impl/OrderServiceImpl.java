package com.wfuhui.modules.order.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wfuhui.common.utils.OrderNumberUtil;
import com.wfuhui.modules.goods.dao.GoodsDao;
import com.wfuhui.modules.goods.entity.GoodsEntity;
import com.wfuhui.modules.member.dao.MemberDao;
import com.wfuhui.modules.order.dao.OrderDao;
import com.wfuhui.modules.order.dao.OrderGoodsDao;
import com.wfuhui.modules.order.dao.OrderShipmentDao;
import com.wfuhui.modules.order.entity.OrderEntity;
import com.wfuhui.modules.order.entity.OrderGoodsEntity;
import com.wfuhui.modules.order.entity.OrderShipmentEntity;
import com.wfuhui.modules.order.service.OrderService;



@Service("orderService")
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderGoodsDao orderGoodsDao;
	@Autowired
	private OrderShipmentDao orderShipmentDao;
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public OrderEntity queryObject(Integer id){
		OrderEntity order = orderDao.queryObject(id);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderId", order.getId());
		List<OrderGoodsEntity> orderGoodsList = orderGoodsDao.queryList(params);
		order.setOrderGoodsList(orderGoodsList);
		OrderShipmentEntity orderShipment = orderShipmentDao.queryByOrderId(id);
		order.setOrderShipment(orderShipment);
		order.setMember(memberDao.queryObject(order.getMemberId()));
		return order;
	}
	
	@Override
	public List<OrderEntity> queryList(Map<String, Object> map){
		List<OrderEntity> orderList = orderDao.queryList(map);
		for (OrderEntity orderEntity : orderList) {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("orderId", orderEntity.getId());
			List<OrderGoodsEntity> orderGoodsList = orderGoodsDao.queryList(params);
			orderEntity.setOrderGoodsList(orderGoodsList);
		}
		return orderList;
	}
	
	@Override
	public int queryTotal(Map<String, Object> map){
		return orderDao.queryTotal(map);
	}
	
	@Override
	public void save(OrderEntity order){
		orderDao.save(order);
	}
	
	@Override
	public void update(OrderEntity order){
		orderDao.update(order);
	}
	
	@Override
	public void delete(Integer orderId){
		orderDao.delete(orderId);
	}
	
	@Override
	public void deleteBatch(Integer[] orderIds){
		orderDao.deleteBatch(orderIds);
	}

	@Override
	@Transactional
	public void createOrder(OrderEntity order) {
		order.setOrderNumber(OrderNumberUtil.getOrderNumber());
		orderDao.save(order);
		List<OrderGoodsEntity> orderGoodsList = order.getOrderGoodsList();
		for (OrderGoodsEntity orderGoodsEntity : orderGoodsList) {
			orderGoodsEntity.setOrderId(order.getId());
			orderGoodsDao.save(orderGoodsEntity);
		}
		OrderShipmentEntity orderShipment = order.getOrderShipment();
		if(orderShipment != null) {
			orderShipment.setOrderId(order.getId());
			orderShipmentDao.save(orderShipment);
		}
	}

	@Override
	public void updateByOrderNumber(OrderEntity order) {
		orderDao.updateByOrderNumber(order);
	}

	@Override
	public List<Map<String, String>> queryOrderCount() {
		return orderDao.queryOrderCount();
	}

	@Override
	@Transactional
	public void pay(OrderEntity order) {
		orderDao.update(order);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderId", order.getId());
		List<OrderGoodsEntity> orderGoodsList = orderGoodsDao.queryList(params);
		for (OrderGoodsEntity orderGoods : orderGoodsList) {
			GoodsEntity goods = new GoodsEntity();
			goods.setId(orderGoods.getGoodsId());
			goods.setStatus(3);
			goodsDao.update(goods);
		}
	}
	
}
