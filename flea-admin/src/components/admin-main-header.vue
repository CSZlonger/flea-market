<template>
  <div style="width: 100%">
    二手交易市场
    <span style="float: right">
      <el-link type="primary" :underline="false" v-if="user">欢迎，{{user.username}}</el-link>
      <el-link type="primary" :underline="false" @click="logout()" style="margin-left: 20px">退出</el-link>
    </span>
  </div>
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
        localStorage.removeItem("atoken");
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

    }
  }
</script>
