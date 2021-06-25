<template>
    <div id="Index">
        <el-container>
            <el-header><el-link :underline="false" href="/#/">二手交易市场</el-link>

              <span style="float: right">
              <el-link type="primary" :underline="false" href="/#/login" v-if="!user">登录</el-link>
              <el-link type="primary" :underline="false" href="/#/order" v-if="user">欢迎，{{user.loginName}}</el-link>
              </span>
            </el-header>
            <el-container>
              <el-main>
                <el-form label-width="120px">
                <el-form-item label="联系人">
                    <el-input v-model="orderShipment.realName"></el-input>
                </el-form-item>
                <el-form-item label="电话">
                    <el-input v-model="orderShipment.mobile"></el-input>
                </el-form-item>
                <el-form-item label="详细地址">
                    <el-input v-model="orderShipment.address"></el-input>
                </el-form-item>
                </el-form>
                <el-table
                  :data="goodsList"
                  style="width: 100%">
                  <el-table-column
                      prop="picUrl"
                      label="图片">
                      <template slot-scope="scope">
                          <el-image
                              style="width: 80px; height: 80px"
                              :src="scope.row.picUrl"></el-image>
                      </template>
                  </el-table-column>
                  <el-table-column
                      prop="goodsName"
                      label="商品名">
                  </el-table-column>
                  <el-table-column
                      prop="price"
                      label="价格">
                  </el-table-column>
                  <el-table-column
                      prop="num"
                      label="数量">
                   </el-table-column>
                  </el-table>
                  <div style="margin-top: 20px; display: flex; align-items: center">
                    <div class="price" style="flex: 1; text-align: right">￥{{totalAmount}}</div>
                  <el-button type="danger" @click="buy">立即购买</el-button>
                  </div>
              </el-main>
            </el-container>
        </el-container>
    </div>
</template>
<script>
export default {
  name: "Index",
  data() {
    return {
      goodsList: [],
      user: null,
      totalAmount: 0,
      orderShipment: {}
    };
  },
  methods:{
    buy: function(){
      if(this.goodsList.length == 0){
        alert("请先选择商品")
        return
      }
      var orderGoodsList = [];
      for(var i = 0; i < this.goodsList.length; i++){
        var orderGoods = {
            goodsId: this.goodsList[i].id,
            goodsName: this.goodsList[i].goodsName,
            price: this.goodsList[i].price,
            picUrl: this.goodsList[i].picUrl,
            num: 1
          }
        orderGoodsList.push(orderGoods);
      }
      var data = {
        totalAmount: this.totalAmount,
        orderGoodsList: orderGoodsList,
        orderShipment: this.orderShipment
      }

      var that = this;

      this.$axios.post("http://127.0.0.1:10001" + "/api/order/create", data, {headers: {token: localStorage.getItem("ftoken")}}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code === 0){
              alert("下单成功");
              that.$router.push({path: "orderPay", query: {id: r.id}});
            }else{
              alert(r.msg);
            }
        }
      )
    }
      
  },
  created(){
    var user = localStorage.getItem("fuser");
    if(user){
        this.user = JSON.parse(user);
    }else{
        
    }
    // 获取下单数据
    var goodsList = localStorage.getItem('payGoods');
    if (goodsList) {
      this.goodsList = JSON.parse(goodsList);
      var totalAmount = 0;
      for(var i = 0; i < this.goodsList.length; i++){
        totalAmount += this.goodsList[i].price * this.goodsList[i].num;
      }
      this.totalAmount = totalAmount;
    }
  }
};
</script>

<style scoped>
.el-header, .el-footer {
  background-color: #e3e4e5;
  color: #333;
  line-height: 60px;
}

</style>