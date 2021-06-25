package com.wfuhui.modules.goods.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wfuhui.common.utils.R;
import com.wfuhui.modules.goods.entity.CartEntity;
import com.wfuhui.modules.goods.service.CartService;

/**
 * 购物车接口
 *
 */
@RestController
@RequestMapping("/api/cart")
public class ApiCartController {
	
	@Autowired
	private CartService cartService;
	
	/**
	 * 保存
	 * @return
	 */
    @PostMapping("save")
    public R save(@RequestBody CartEntity cart, @RequestAttribute("userId") Long userId){
    	cart.setMemberId(userId);
    	cartService.save(cart);
        return R.ok();
    }
    
    /**
     * 列表
     * @param userId
     * @return
     */
    @GetMapping("list")
    public R list(@RequestAttribute("userId") Long userId){
    	Map<String, Object> params = new HashMap<String, Object>();
    	params.put("memberId", userId);
    	List<CartEntity> cartList = cartService.queryList(params);
        return R.ok().put("cartList", cartList);
    }
    
    /**
     * 删除
     * @param id
     * @return
     */
    @GetMapping("del")
    public R del(Integer id) {
    	cartService.delete(id);
    	return R.ok();
    }
    
    /**
     * 更新
     * @param cart
     * @param userId
     * @return
     */
    @PostMapping("update")
    public R update(@RequestBody CartEntity cart, @RequestAttribute("userId") Long userId) {
    	cartService.update(cart);
    	return R.ok();
    }
}
