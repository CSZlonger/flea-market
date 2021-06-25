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
              <el-main style="text-align: center">
                  <img alt="" :src="payImg" style="width: 300px; margin: 0 auto;">
        	        <div><span style="color: #d9534f;">￥{{order.totalAmount}}</span></div>
                  <div>
                  <el-button type="danger" @click="pay">立即支付</el-button>
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
      order: {},
      payImg: require('../../assets/img/pay.jpg'),
    };
  },
  methods:{
    pay: function(){
      var that = this;
      this.$axios.get("http://127.0.0.1:10001" + "/api/order/pay", {params: {id: that.order.id}, headers:{ token: localStorage.getItem("ftoken") }}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code == 0){
            alert("支付成功");
            that.$router.push("order");
          }
        }
      )
    },
    getOrder: function(id){
      var that = this;
      this.$axios.get("http://127.0.0.1:10001" + "/api/order/detail", {params: {id: id}, headers:{ token: localStorage.getItem("ftoken") }}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code == 0){
            that.order = r.order;
          }
        }
      )
    },
      
  },
  created(){
    var user = localStorage.getItem("fuser");
    if(user){
        this.user = JSON.parse(user);
    }else{
        
    }
    var id = this.$route.query.id;
    this.getOrder(id)
    
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