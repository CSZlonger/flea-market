<template>
    <div>
        <el-container>
            <el-header>二手交易市场
              <span style="float: right">
              <el-link type="primary" :underline="false" v-if="user">欢迎，{{user.username}}</el-link>
              <el-link type="primary" :underline="false" @click="logout()" style="margin-left: 20px">退出</el-link>
              </span>
            </el-header>
            <el-container>
                <el-aside width="200px">
                    <el-menu
                        default-active="5"
                        :style="asideStyle"
                        router>
                        <el-menu-item index="1" route="/admin_index">
                            <i class="el-icon-menu"></i>
                            <span slot="title">统计分析</span>
                        </el-menu-item>
                        <el-menu-item index="2" route="admin_member">
                            <i class="el-icon-menu"></i>
                            <span slot="title">会员管理</span>
                        </el-menu-item>
                        <el-menu-item index="3" route="admin_advert">
                            <i class="el-icon-menu"></i>
                            <span slot="title">广告管理</span>
                        </el-menu-item>
                        <el-menu-item index="4" route="admin_category">
                            <i class="el-icon-menu"></i>
                            <span slot="title">分类管理</span>
                        </el-menu-item>
                        <el-menu-item index="5" route="admin_goods">
                            <i class="el-icon-menu"></i>
                            <span slot="title">商品管理</span>
                        </el-menu-item>
                        <el-menu-item index="6" route="admin_order">
                            <i class="el-icon-menu"></i>
                            <span slot="title">订单管理</span>
                        </el-menu-item>
                        <el-menu-item index="99" route="admin_user">
                          <i class="el-icon-menu"></i>
                          <span slot="title">管理员管理</span>
                      </el-menu-item>
                    </el-menu>
                </el-aside>
                <el-main>
                     <div v-if="showList">
                    <el-form :inline="true" :model="q" class="demo-form-inline">
                        <el-form-item label="商品名称">
                            <el-input v-model="q.goodsName" placeholder="商品名称"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="query">查询</el-button>
                            <el-button type="success" @click="upper">审核通过</el-button>
                            <el-button type="warning" @click="lower">审核失败</el-button>
                            <el-button type="danger" @click="del">删除</el-button>
                        </el-form-item>
                    </el-form>
                        <el-table
                        :data="goodsList"
                        style="width: 100%"
                        @selection-change="handleSelectionChange">
                        <el-table-column
                          type="selection"
                          width="55">
                        </el-table-column>
                        <el-table-column
                            prop="picUrl"
                            label="图片"
                            >
                            <template slot-scope="scope">
                                <el-image
                                    style="width: 80px; height: 80px"
                                    :src="scope.row.picUrl"></el-image>
                            </template>
                        </el-table-column>
                        <el-table-column
                            prop="goodsName"
                            label="商品名称"
                            >
                        </el-table-column>
                        <el-table-column
                            prop="category.categoryName"
                            label="分类">
                        </el-table-column>
                        <el-table-column
                            prop="price"
                            label="价格">
                        </el-table-column>
                        <el-table-column
                            prop="member.nickname"
                            label="发布者">
                        </el-table-column>
                        <el-table-column
                            prop="status"
                            label="状态">
                            <template slot-scope="scope">
                              <el-tag type="info" v-if="scope.row.status == 0">已下架</el-tag>
                              <el-tag type="primary" v-if="scope.row.status == 1">待审核</el-tag>
                              <el-tag type="success" v-if="scope.row.status == 2">出售中</el-tag>
                              <el-tag type="warning" v-if="scope.row.status == 3">已出售</el-tag>
                            </template>
                        </el-table-column>
                        <el-table-column
                            prop="createTime"
                            label="创建时间">
                        </el-table-column>
                        </el-table>
                        <el-pagination
                            @size-change="handleSizeChange"
                            @current-change="handleCurrentChange"
                            :current-page="q.page"
                            :page-sizes="[10, 50, 100]"
                            :page-size="q.limit"
                            layout="total, sizes, prev, pager, next, jumper"
                            :total="total">
                        </el-pagination>
                     </div>
                        <div v-if="!showList">
                        
                    </div>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>
<script>
export default {
  name: "Goods",
  data() {
    return {
      goodsList: [],
      total: 0,
      categoryList: [],
      q: {
        goodsName: '',
        page: 1,
        limit: 10
      },
      asideStyle: {
        height: '500px'
      },
      goods: {
          picUrl: ''
      },
      showList: true
    };
  },
  methods:{
      handleCurrentChange(e){
          this.q.page = e;
          this.query();
      },
      handleSizeChange(e){
          this.q.limt = e;
          this.query();
      },
      query(){
        var that = this;
        this.$axios.get('http://127.0.0.1:10001/goods/list',
        { headers:{ token: localStorage.getItem("atoken") },
          params: that.q
        }).then(function(res){
            if(res.data.code == 0){//成功
              that.goodsList = res.data.rows
              that.total = res.data.total
            }else{
              
            }
        })
      },
      queryCategory(){
        var that = this;
        this.$axios.get('http://127.0.0.1:10001/category/listAll',
        {
            headers:{ token: localStorage.getItem("atoken") }
        }).then(function(res){
            if(res.data.code == 0){//成功
              that.categoryList = res.data.categoryList
            }else{
              
            }
        })
      },
      add(){
          this.showList = false
      },
      cancel(){
          this.showList = true
      },
      update(){

      },
      upper(){
        if(this.ids.length == 0){
            this.$message.info("请选择数据");
            return;
        }
        var that = this;
        this.$axios.post('http://127.0.0.1:10001/goods/upper',
        that.ids,
        {
            headers: {'token': localStorage.getItem("atoken")}
        }).then(function(res){
            console.log(res)
            if(res.data.code == 0){//成功
              that.query();
            }else{
              that.errorMsg = res.data.msg;
              that.$message.error(res.data.msg);
            }
        })
      },
      lower(){
        if(this.ids.length == 0){
            this.$message.info("请选择数据");
            return;
        }
        var that = this;
        this.$axios.post('http://127.0.0.1:10001/goods/lower',
        that.ids,
        {
            headers: {'token': localStorage.getItem("atoken")}
        }).then(function(res){
            console.log(res)
            if(res.data.code == 0){//成功
              that.query();
            }else{
              that.errorMsg = res.data.msg;
              that.$message.error(res.data.msg);
            }
        })
      },
      del(){
        if(this.ids.length == 0){
            this.$message.info("请选择数据");
            return;
        }
        var that = this;
        this.$axios.post('http://127.0.0.1:10001/goods/delete',
        that.ids,
        {
            headers: {'token': localStorage.getItem("atoken")}
        }).then(function(res){
            console.log(res)
            if(res.data.code == 0){//成功
              that.query();
            }else{
              that.errorMsg = res.data.msg;
              that.$message.error(res.data.msg);
            }
        })
      },
      handleAvatarSuccess(e){
          console.log(e)
          this.goods.picUrl = e.url
      },
      beforeAvatarUpload(e){

      },
      handleSelectionChange(e){
        var ids = [];
        for(var i = 0; i < e.length; i++){
            ids.push(e[i].id)
        }
        this.ids = ids;
      },
      logout(){
        localStorage.removeItem("atoken");
        localStorage.removeItem("auser");
        this.$router.push("admin_login");
      }
  },
  created(){
    var docHeight = document.documentElement.clientHeight;
    this.asideStyle.height = docHeight - 76 + "px";
    var user = localStorage.getItem("auser");
    if(user){
        this.user = JSON.parse(user);
    }else{
        this.$router.push("admin_login");
    }
    this.query();
    this.queryCategory();
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