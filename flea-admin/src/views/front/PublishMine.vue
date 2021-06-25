<template>
    <div id="Index">
        <el-container>
            <el-header><mainHeader></mainHeader>
            </el-header>
            <el-container>
              <el-main>
                <el-row style="margin-top: 20px" :gutter="20">
                  <el-col :span="4">
                    <div>
                      <el-menu router default-active="3">
                        <el-menu-item route="user" index="1">用户信息</el-menu-item>
                        <el-menu-item route="publish" index="2">发布物品</el-menu-item>
                        <el-menu-item route="order" index="3">我的发布</el-menu-item>
                        <el-menu-item route="order" index="4">我的订单</el-menu-item>
                      </el-menu>
                    </div>
                  </el-col>
                  <el-col :span="20">
                  <el-table
                        :data="goodsList"
                        style="width: 100%">
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
                        <el-table-column
                            prop="opt"
                            label="操作">
                            <template slot-scope="scope">
                              <el-link @click="del(scope.row.id)">删除</el-link>
                             
                            </template>
                        </el-table-column>
                        </el-table>
                  </el-col>
                </el-row>
              </el-main>
            </el-container>
        </el-container>
    </div>
</template>
<script>
import mainHeader from '../../components/main-header'
export default {
  name: "Index",
  data() {
    return {
      user: null,
      page: 1,
			pageSize: 8,
      goodsList: [],
      categoryList: []
    };
  },
  components: {
    mainHeader
  },
  methods:{
    getGoods: function(){
      var that = this;
      this.$axios.get("http://127.0.0.1:10001" + "/api/goods/mine", {params: {}, headers:{ token: localStorage.getItem("ftoken") }}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code == 0){
            that.goodsList = r.goodsList;
          }
        }
      )
    },
    
    handleAvatarSuccess(e){
      console.log(e)
      this.goods.picUrl = e.url
    },
    beforeAvatarUpload(e){

    },

    del(id){
      var that = this;
      this.$axios.get("http://127.0.0.1:10001" + "/api/goods/delete", {params: {id: id}, headers:{ token: localStorage.getItem("ftoken") }}).then(
        function(res){
          
          if(r.code == 0){
            that.getGoods()
          }
        }
      )
    }
    
  },
  created(){
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

</style>