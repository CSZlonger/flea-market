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
                      <el-menu router default-active="2">
                        <el-menu-item route="user" index="1">用户信息</el-menu-item>
                        <el-menu-item route="publish" index="2">发布物品</el-menu-item>
                        <el-menu-item route="publishMine" index="3">我的发布</el-menu-item>
                        <el-menu-item route="order" index="4">我的订单</el-menu-item>
                      </el-menu>
                    </div>
                  </el-col>
                  <el-col :span="20">
                  <el-form :model="goods" label-width="120px">
                            <el-form-item label="图片">
                                <el-upload
                                class="avatar-uploader"
                                action="http://127.0.0.1:10001/api/fileupload/upload"
                                list-type="picture-card"
                                multiple
                                :file-list="fileList"
                                :on-remove="imgRemove"
                                :on-success="handleAvatarSuccess"
                                :before-upload="beforeAvatarUpload">
                                <i class="el-icon-plus avatar-uploader-icon"></i>
                                </el-upload>

                            </el-form-item>
                        <el-form-item label="商品名称">
                            <el-input v-model="goods.goodsName"></el-input>
                        </el-form-item>
                        <el-form-item label="分类">
                            <el-select v-model="goods.categoryId" placeholder="请选择">
                                <el-option
                                v-for="item in categoryList"
                                :key="item.id"
                                :label="item.categoryName"
                                :value="item.id">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="价格">
                            <el-input v-model="goods.price"></el-input>
                        </el-form-item>
                        <el-form-item label="备注">
                            <el-input type="textarea" v-model="goods.describe"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="onSubmit">保存</el-button>
                        </el-form-item>
                        </el-form>
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
      goods: {},
      page: 1,
			pageSize: 8,
      fileList: [],
      categoryList: []
    };
  },
  components: {
    mainHeader
  },
  methods:{
    getUser: function(){
      var that = this;
      this.$axios.get("http://127.0.0.1:10001" + "/api/member/info", {params: {}, headers:{ token: localStorage.getItem("ftoken") }}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code == 0){
            that.member = r.member;
          }
        }
      )
    },
    queryCategory(){
        var that = this;
        this.$axios.get('http://127.0.0.1:10001/category/listAll',
        {
            headers:{ token: localStorage.getItem("ftoken") }
        }).then(function(res){
            if(res.data.code == 0){//成功
              that.categoryList = res.data.categoryList
            }else{
              
            }
        })
    },
    onSubmit(e){
        var that = this;
        var data = this.goods;
        data.picUrls = this.fileList.map(function(item, index){
            return item.url
        })
        data.picUrl = data.picUrls[0]
        this.$axios.post('http://127.0.0.1:10001/api/goods/save', 
            data,
            {
                headers: {'token': localStorage.getItem("ftoken")}
            }
        ).then(function(res){
            console.log(res)
            if(res.data.code == 0){//成功
              that.$message({
                  message: '发布成功',
                  type: 'success'
              })
            }else{
                that.errorMsg = res.data.msg;
                that.$message.error(res.data.msg);
            }
        })
    },
    handleAvatarSuccess(e){
      this.fileList.push({
          url: e.url
      });
    },
    beforeAvatarUpload(e){

    },
    initImage(picUrls){
      this.fileList = picUrls.map(function(item, index){
          return {url: picUrls[index]}
      })
    },
    imgRemove(file, fileList){
        this.fileList = fileList;
    },
  },
  created(){
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