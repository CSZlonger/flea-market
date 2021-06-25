<template>
    <div>
        <el-container>
            <el-header>
            <mainHeader></mainHeader>
            </el-header>
            <el-container>
                <mainSidebar :active="activeIndex"></mainSidebar>
                <el-main>
                        <div v-if="showList">
                    <el-form :inline="true" :model="q" class="demo-form-inline">
                        <el-form-item label="分类名称">
                            <el-input v-model="q.categoryName" placeholder="分类名称"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="query">查询</el-button>
                            <el-button type="warning" @click="add">新增</el-button>
                            <el-button type="success" @click="update">修改</el-button>
                            <el-button type="danger" @click="del">删除</el-button>
                        </el-form-item>
                    </el-form>
                        <el-table
                        :data="categoryList"
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
                                    style="width: 50px"
                                    :src="scope.row.picUrl"></el-image>
                            </template>
                        </el-table-column>
                        <el-table-column
                            prop="categoryName"
                            label="分类名称"
                            >
                        </el-table-column>
                        <el-table-column
                            prop="sort"
                            label="排序">
                        </el-table-column>
                        <el-table-column
                            prop="createTime"
                            label="创建时间"
                            >
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
                        <el-form :model="category" label-width="120px">
                            <el-form-item label="图片">
                                <el-upload
                                class="avatar-uploader"
                                action="http://127.0.0.1:10001/api/fileupload/upload"
                                :show-file-list="false"
                                :on-success="handleAvatarSuccess"
                                :before-upload="beforeAvatarUpload">
                                <img v-if="category.picUrl" :src="category.picUrl" class="avatar">
                                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                </el-upload>
                            </el-form-item>
                        <el-form-item label="分类名称">
                            <el-input v-model="category.categoryName"></el-input>
                        </el-form-item>
                        <el-form-item label="排序">
                            <el-input v-model="category.sort"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="onSubmit">保存</el-button>
                            <el-button @click="cancel">取消</el-button>
                        </el-form-item>
                        </el-form>
                        </div>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>
<script>
import mainHeader from '../../../components/admin-main-header'
import mainSidebar from '../../../components/admin-main-sidebar'
export default {
  name: "AdminCategory",
  data() {
    return {
      categoryList: [],
      q: {
          categoryName: '',
          page: 1,
        limit: 10
      },
      category: {
          picUrl: ''
      },
      showList: true,
      activeIndex: "4",
      total: 0
    };
  },
  components: {
    mainHeader,
    mainSidebar
  },
  methods:{
      query(){
        var that = this;
        this.$axios.get('http://127.0.0.1:10001/category/list',
        {headers: {
            'token': localStorage.getItem("atoken")
        },
            params: that.q
        }).then(function(res){
            if(res.data.code == 0){//成功
              that.categoryList = res.data.rows
              that.total = res.data.total
            }else{
              
            }
        })
      },
      onSubmit(e){
        var that = this;
        var data = this.category;
        var action = data.id == null ? "save" : "update";;
        this.$axios.post('http://127.0.0.1:10001/category/' + action, 
            data,
            {
                headers: {'token': localStorage.getItem("atoken")}
            }
        ).then(function(res){
            console.log(res)
            if(res.data.code == 0){//成功
              that.showList = true;
              that.query();
            }else{
              that.errorMsg = res.data.msg;
              that.$message.error(res.data.msg);
            }
        })
      },
      add(){
          this.showList = false
      },
      getInfo(id){
        var that = this;
        this.$axios.get('http://127.0.0.1:10001/category/info/'+id,
        {headers: {
            'token': localStorage.getItem("atoken")
        },
            params: {}
        }).then(function(res){
            if(res.data.code == 0){//成功
              that.category = res.data.category
            }else{
              
            }
        })
      },
      update(){
        if(this.ids.length != 1){
        this.$message.info("请选择一条数据");
        return;
        }
        this.showList = false
        this.getInfo(this.ids[0])
      },
      cancel(){
          this.showList = true
      },
      del(){
        if(this.ids.length == 0){
            this.$message.info("请选择数据");
            return;
        }
        var that = this;
        this.$axios.post('http://127.0.0.1:10001/category/delete',
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
          this.category.picUrl = e.url
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
      handleCurrentChange(e){
          this.q.page = e;
          this.query();
      },
      handleSizeChange(e){
          this.q.limt = e;
          this.query();
      },
      logout(e){
        localStorage.removeItem("auser");
        this.$router.push("admin_login");
      }
  },
  created(){
    var user = localStorage.getItem("auser");
    if(user){
        this.user = JSON.parse(user);
    }else{
        this.$router.push("admin_login");
    }
    this.query()
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