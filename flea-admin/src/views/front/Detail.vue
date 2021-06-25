<template>
    <div id="Index">
        <el-container>
            <el-header><el-link :underline="false" href="/#/">二手交易市场</el-link>

              <span style="float: right">
              <el-link type="primary" :underline="false" href="/#/login" v-if="!user">登录</el-link>
              <el-link type="primary" :underline="false" href="/#/order" v-if="user">欢迎，{{user.loginName}}</el-link>
              <el-link type="primary" :underline="false" href="/#/cart" v-if="user" style="margin-left: 20px">购物车</el-link>
              <el-link type="primary" :underline="false" href="/#/admin_index" style="margin-left: 20px">管理端</el-link>
              </span>
            </el-header>
            <el-container>
              <el-main>
                <el-row :gutter="20">
                <el-col :span="6">
                  <div class="grid-content bg-purple">
                    <el-image
                      style="width: 250px; height: 250px"
                      :src="goods.picUrl"></el-image>
                  </div>
                </el-col>
                <el-col :span="18">
                  <div class="grid-content bg-purple">
                    <div>
                      <el-avatar :src="goods.member.avatarUrl" style="vertical-align: middle; margin-right: 6px"></el-avatar>{{goods.member.nickname}}({{goods.member.mobile}})
                    </div>
                    <div>
                      <p>{{goods.goodsName}}</p>  
                      <p>价格：{{goods.price}}</p>  
                    </div>
                    <div>
                      <el-button type="warning" @click="addShopCart">加入购物车</el-button>
                      <el-button type="danger" @click="buy">立即购买</el-button>
                    </div>
                  </div>
                </el-col>
              </el-row>
              <el-row>
                <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
                <el-tab-pane label="详情" name="1">
                  <div v-html="goods.describe"></div>
                </el-tab-pane>
                <el-tab-pane label="评价" name="2">
                  <div style="margin-bottom: 10px; text-align: right">
                    <el-button @click="dialogFormVisible = true" type="primary">评价</el-button>
                  </div>
                  <div class="comment" v-for="(comment, index) in evaluations" :key="index">
                    <img class="media-object avatar" :src="comment.member.avatarUrl" alt="">
                    <div class="content">
                      {{comment.content}}
                    </div>
                    <div class="time">
                      <div>{{comment.createTime}}</div>
                    </div>
                    <hr>
                  </div>
                  
                  <el-dialog title="评价" :visible.sync="dialogFormVisible">
                  <el-form>
                    <el-form-item>
                      <el-input type="textarea" v-model="content" autocomplete="off" placeholder="留言内容"></el-input>
                    </el-form-item>
                  </el-form>
                  <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="confirm">确 定</el-button>
                  </div>
                </el-dialog>
                </el-tab-pane>
              </el-tabs>
              </el-row>

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
      categories: [],
      goods: {
        member: {}
      },
      user: null,
      page: 1,
			pageSize: 8,
      activeName: '2',
      evaluations: [],
      content: '',
      dialogFormVisible: false
    };
  },
  methods:{
    handleClick(e){
      console.log(e)
    },
    getGoods: function(id){
      var that = this;
      this.$axios.get("http://127.0.0.1:10001" + "/api/goods/detail", {params: {id: id}}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code == 0){
            that.goods = r.goods;
          }
        }
      )
    },
    getEvaluation: function(id){
      var that = this;
      this.$axios.get("http://127.0.0.1:10001" + "/api/order/evaluation/list", {params: {goodsId: id}}).then(
        function(res){
          var r = res.data;
          if(r.code == 0){
            that.evaluations = r.evaluations;
          }
        }
      )
    },
    confirm(){
      var that = this;
      var data = {
        content: this.content,
        goodsId: this.goods.id
      };
      this.$axios.post('http://127.0.0.1:10001//api/order/evaluation/save', 
          data,
          {
              headers: {'token': localStorage.getItem("ftoken")}
          }
      ).then(function(res){
          if(res.data.code == 0){//成功
            that.dialogFormVisible = false
            that.getEvaluation();
          }else{
            that.$message.error(res.data.msg);
          }
      })
    },
    addShopCart: function (e) {
      var user = localStorage.getItem("fuser");
      if(!user){
          this.$router.push("login");
          return;
      }
      // 加入购物车
      var goodsList = localStorage.getItem("shopCart");
      var goods = this.goods;
      var num = 1;
      var isExist = false;
      if (goodsList) {
        goodsList = JSON.parse(goodsList);
        for (var i = 0; i < goodsList.length; i++) {
          if (goodsList[i].id == goods.id) {
            num = goodsList[i].num + 1;
            isExist = true;
            break;
          }
        }
        var temp = {
          id: goods.id,
          goodsName: goods.goodsName,
          picUrl: goods.picUrl,
          price: goods.price,
          num: num
        }
        goodsList.push(temp);
      } else {
        goodsList = [{
          id: goods.id,
          goodsName: goods.goodsName,
          picUrl: goods.picUrl,
          price: goods.price,
          num: 1
        }];
      }
      localStorage.setItem("shopCart", JSON.stringify(goodsList));
      alert("加入购物车成功");
    },
    buy: function(){
      var user = localStorage.getItem("fuser");
      if(!user){
          this.$router.push("login");
          return;
      }
      var that = this;
      var goods = this.goods;
      var goodsList = [{
          id: goods.id,
          goodsName: goods.goodsName,
          picUrl: goods.picUrl,
          price: goods.price,
          num: 1
      }];
      localStorage.setItem("payGoods", JSON.stringify(goodsList));
      this.$router.push("orderConfirm");
      return;
      var data = {
        totalAmount: that.goods.price,
        orderGoodsList: [{
          goodsId: that.goods.id,
          goodsName: that.goods.goodsName,
          price: that.goods.price,
          picUrl: that.goods.picUrl,
          num: 1
        }]
      }

      this.$axios.post("http://127.0.0.1:10001" + "/api/order/create", data, {headers: {token: localStorage.getItem("ftoken")}}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code === 0){
              alert("下单成功");
              that.$router.push("order");
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

    var id = this.$route.query.id;
    this.getGoods(id)
    this.getEvaluation(id)
  }
};
</script>

<style scoped>
.el-header, .el-footer {
  background-color: #e3e4e5;
  color: #333;
  line-height: 60px;
}

.time{
  color: #999;
  font-size: 12px
}

.avatar{
  width: 30px;
  height: 30px;
  border-radius: 50%;
}

.comment{
  display: flex;
  align-items: center;
  border-bottom: 1px solid #ddd;
  padding: 10px;
}

.comment .content{
  flex: 1;
  padding-left: 6px;
}


.comment:last-child {
border-bottom: none;
}
</style>