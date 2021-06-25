<template>
    <div id="Index">
        <el-container>
            <el-header><el-link :underline="false" href="/#/">二手交易市场</el-link>

              <span style="float: right">
              <el-link type="primary" :underline="false" href="/#/login" v-if="!user">登录</el-link>
              <el-link type="primary" :underline="false" href="/#/user" v-if="user">欢迎，{{user.loginName}}</el-link>
              <el-link type="primary" :underline="false" href="/#/cart" v-if="user" style="margin-left: 20px">购物车</el-link>
              <el-link type="primary" :underline="false" href="/#/admin_index" style="margin-left: 20px" target="_blank">管理端</el-link>
              </span>
            </el-header>
            <el-container>
              <el-main>

                <div style="padding: 20px; display: flex; justify-content: center;">
                  <el-input v-model="q" placeholder="请输入商品名称" style="max-width: 600px"></el-input>
                  <el-button @click="query">查找</el-button>
                </div>

                <el-row style="margin-top: 20px" :gutter="20">
                  <el-col :span="24">
                    <el-row :gutter="20">
                      <el-col :span="4" v-for="(o, index) in goodses" :key="index" style="margin-bottom: 20px">
                      <el-card :body-style="{ padding: '0px' }" >
                        <img :src="o.picUrl" class="image" style="width: 100%">
                        <div style="padding: 14px;">
                          <div>{{o.goodsName}}</div>
                          <div style="color: #f56c6c">￥{{o.price}}</div>
                          <div class="bottom clearfix">
                            <el-button type="text" class="button" @click="detail(o.id)">立即下单</el-button>
                          </div>
                        </div>
                      </el-card>
                    </el-col>
                    </el-row>
                  <el-pagination
                  style="margin-top: 20px"
                  background
                  layout="prev, pager, next"
                  :total="total">
                </el-pagination>
                </el-col>
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
      goodses: [],
      user: null,
      page: 1,
      pageSize: 50,
      total: 0,
      q: ''
    };
  },
  methods:{
    detail(id){
      this.$router.push({path: "detail", query: {id: id}});
    },

    query(){
      this.getGoods();
    },

    getGoods: function(){
      var that = this;
      var page = this.page
      var pageSize = this.pageSize
      var q = this.q;
      this.$axios.get("http://127.0.0.1:10001" + "/api/goods/list", {params: {goodsName: q, page: page, limit: pageSize}}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code == 0){
            that.goodses = r.goodsList;
            that.total = r.total;
          }
        }
      )
    },

    selCategory(id){
      this.getGoods(id);
    },
  },
  
  created(){
    var user = localStorage.getItem("fuser");
    if(user){
        this.user = JSON.parse(user);
    }else{
        
    }
    var q = this.$route.query.q;
    this.q = q;
    this.getGoods();
  }
};
</script>

<style scoped>
.el-header, .el-footer {
  background-color: #e3e4e5;
  color: #333;
  line-height: 60px;
}

.el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 150px;
  margin: 0;
}

.el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
}
</style>