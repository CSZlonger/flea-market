package com.wfuhui.modules.goods.api;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.wfuhui.common.annotation.AuthIgnore;
import com.wfuhui.common.utils.Query;
import com.wfuhui.common.utils.R;
import com.wfuhui.modules.goods.entity.GoodsEntity;
import com.wfuhui.modules.goods.service.GoodsService;

/**
 * 商品接口
 *
 */
@RestController
@RequestMapping("/api/goods")
public class ApiGoodsController {
	
	@Autowired
	private GoodsService goodsService;
	
	/**
	 * 查询列表
	 * @param map
	 * @return
	 */
	@AuthIgnore
	@GetMapping("list")
    public R list(@RequestParam Map<String, Object> map){
		map.put("status", 2);
		Query query = new Query(map);
    	List<GoodsEntity> goodsList = goodsService.queryList(query);
    	Integer total = goodsService.queryTotal(map);
        return R.ok().put("goodsList", goodsList).put("total", total);
    }
    
	/**
	 * 详情
	 * @param id
	 * @return
	 */
	@AuthIgnore
    @GetMapping("detail")
    public R detail(int id){
    	GoodsEntity goods = goodsService.queryObject(id);
    	return R.ok().put("goods", goods);
    }
    
	/**
	 * 保存
	 */
	@RequestMapping("/save")
	public R save(@RequestAttribute("userId") Long userId, @RequestBody GoodsEntity goods){
		goods.setMemberId(userId);
		goods.setStatus(1);
		goods.setCreateTime(new Date());
		goodsService.save(goods);
		
		return R.ok();
	}
	
	/**
	 * 查询发布
	 * @param userId
	 * @param map
	 * @return
	 */
	@GetMapping("mine")
	public R mine(@RequestAttribute("userId") Long userId, @RequestParam Map<String, Object> map) {
		map.put("memberId", userId);
		Query query = new Query(map);
    	List<GoodsEntity> goodsList = goodsService.queryList(query);
    	Integer total = goodsService.queryTotal(map);
        return R.ok().put("goodsList", goodsList).put("total", total);
	}
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@GetMapping("delete")
    public R delete(int id){
		goodsService.delete(id);
    	return R.ok();
    }
}
