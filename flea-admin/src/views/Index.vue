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
                <el-carousel height="250px; margin-bottom: 20px">
                  <el-carousel-item v-for="(item, index) in adverts" :key="index">
                    <el-image :src="item.picUrl" style="width: 100%; height: 100%"></el-image>
                  </el-carousel-item>
                </el-carousel>

                <el-row style="margin-top: 20px" :gutter="20">
                  <el-col :span="4">
                    <div>
                      <el-menu>
                        <el-menu-item @click="selCategory(-1)">全部</el-menu-item>
                        <el-menu-item @click="selCategory(c.id)" v-for="(c, index) in categories" :key="index">{{c.categoryName}}</el-menu-item>
                      </el-menu>
                    </div>
                  </el-col>
                  <el-col :span="20">
                    <el-row :gutter="20">
                      <el-col :span="4" v-for="(o, index) in goodses" :key="index" style="margin-bottom: 20px">
                      <el-card :body-style="{ padding: '0px' }">
                        <img :src="o.picUrl" class="image" style="width: 100%" @click="detail(o.id)">
                        <div style="padding: 14px;">
                          <div>{{o.goodsName}}</div>
                          <div style="color: #f56c6c">￥{{o.price}}</div>
                          <div style="font-size: 12px">
                            <el-avatar :src="o.member.avatarUrl" style="vertical-align: middle; margin-right: 6px"></el-avatar>{{o.member.nickname}}
                          </div>
                        </div>
                      </el-card>
                    </el-col>
                    </el-row>
                  <el-pagination
                  @current-change="handleCurrentChange"
                  :current-page="page"
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
      categories: [],
      goodses: [],
      user: null,
      page: 1,
      pageSize: 12,
      adverts: [],
      total: 0,
      logoImg: require('../assets/logo.png'),
      q: ''
    };
  },
  methods:{
    query(){
      var q = this.q;
      this.$router.push({path: "goods", query: {q: q}});
    },
    //查询广告
    getAdvert: function(){
      var that = this;
      this.$axios({url: "http://127.0.0.1:10001" + "/api/advert/list", data: {}}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code == 0){
            that.adverts = r.advertList;
          }
        }
      )
    },
    
    getCategory: function(){
      var that = this;
      this.$axios({url: "http://127.0.0.1:10001" + "/api/category/list", data: {}}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code == 0){
            that.categories = r.categoryList;
          }
        }
      )
    },

    detail(id){
      this.$router.push({path: "detail", query: {id: id}});
    },

    getGoods: function(categoryId){
      var that = this;
      var page = this.page
      var pageSize = this.pageSize
      this.$axios.get("http://127.0.0.1:10001" + "/api/goods/list", {params: {categoryId: categoryId, page: page, limit: pageSize}}).then(
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
    handleCurrentChange(e){
      this.page = e;
      this.getGoods();
    },
  },
  
  created(){
    var user = localStorage.getItem("fuser");
    if(user){
        this.user = JSON.parse(user);
    }else{
        
    }
    this.getAdvert();
    this.getCategory();
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