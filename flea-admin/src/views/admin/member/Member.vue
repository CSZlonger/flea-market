<template>
    <div>
        <el-container>
            <el-header>
                <mainHeader></mainHeader>
            </el-header>
            <el-container>
                <mainSidebar :active="active"></mainSidebar>
                <el-main>
                    <el-form :inline="true" :model="q" class="demo-form-inline">
                        <el-form-item label="昵称">
                            <el-input v-model="q.nickname" placeholder="昵称"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="query">查询</el-button>
                        </el-form-item>
                    </el-form>
                        <el-table
                        :data="memberList"
                        style="width: 100%">
                        <el-table-column
                            prop="avatarUrl"
                            label="头像"
                            >
                            <template slot-scope="scope">
                                <el-image
                                    style="width: 30px; height: 30px"
                                    :src="scope.row.avatarUrl"></el-image>
                            </template>
                        </el-table-column>
                        <el-table-column
                            prop="nickname"
                            label="昵称"
                            >
                        </el-table-column>
                        <el-table-column
                            prop="loginName"
                            label="登录名"
                            >
                        </el-table-column>
                        <el-table-column
                            prop="realName"
                            label="姓名"
                            >
                        </el-table-column>
                        <el-table-column
                            prop="mobile"
                            label="手机号"
                            >
                        </el-table-column>
                        <el-table-column
                            prop="createTime"
                            label="注册时间"
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
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>
<script>
import mainHeader from '../../../components/admin-main-header'
import mainSidebar from '../../../components/admin-main-sidebar'
export default {
  name: "AdminMember",
  data() {
    return {
      q:{
        nickname: '',
        page: 1,
        limit: 10
      },
      memberList: [],
      active: '2',
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
        this.$axios.get('http://127.0.0.1:10001/member/list',
        {    
            params: that.q,
            headers: {'token': localStorage.getItem("atoken")}
        }).then(function(res){
            if(res.data.code == 0){//成功
              that.memberList = res.data.rows
              that.total = res.data.total
            }else{
              
            }
        })
      },
      handleCurrentChange(e){
          this.q.page = e;
          this.query();
      },
      handleSizeChange(e){
          this.q.limt = e;
          this.query();
      }
  },
  created(){
    var user = localStorage.getItem("auser");
    if(user){
        this.user = JSON.parse(user);
    }else{
        this.$router.push("admin_login");
        return;
    }
    this.query();
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