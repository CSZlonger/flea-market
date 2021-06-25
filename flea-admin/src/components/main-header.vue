<template>
  <el-header style="width: 100%"><el-link :underline="false" href="/#/">二手交易市场</el-link>
    <span style="float: right">
    <el-link type="primary" :underline="false" href="/#/login" v-if="!user">登录</el-link>
    <el-link type="primary" :underline="false" href="/#/user" v-if="user">欢迎，{{user.loginName}}</el-link>
    <el-link type="primary" :underline="false" href="/#/cart" v-if="user" style="margin-left: 20px">购物车</el-link>
    <el-link type="primary" :underline="false" @click="logout()" style="margin-left: 20px">退出</el-link>
    <el-link type="primary" :underline="false" href="/#/admin_index" style="margin-left: 20px" target="_blank">管理端</el-link>
    </span>
  </el-header>
</template>

<script>
  export default {
    data () {
      return {
        user: null
      }
    },
    methods: {
      logout(){
        localStorage.removeItem("ftoken");
        localStorage.removeItem("fuser");
        this.$router.push("/");
      }
    },
    created(){
      var user = localStorage.getItem("fuser");
      if(user){
          this.user = JSON.parse(user);
      }else{
          
      }

    }
  }
</script>
