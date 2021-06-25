<template>
    <div>
      <el-container>
        <el-header>
          <el-link :underline="false" href="/#/">二手交易市场</el-link>
        </el-header>
        <el-main>
          <el-row :gutter="20">
          <el-col :span="8" :offset="6">
            <el-image :src="loginImg"></el-image>
          </el-col>
          <el-col :span="10">
              <el-card class="box-card login-box">
                <div slot="header">
                  <span>用户登录</span>
                </div>
                <el-form>
                  <el-form-item>
                      <el-input v-model="loginForm.loginName" placeholder="用户名"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-input v-model="loginForm.password" placeholder="密码" type="password"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-button type="primary" @click="login">登录</el-button>
                      <el-button @click="register">注册</el-button>
                  </el-form-item>
                </el-form>
              </el-card>
          </el-col>
          </el-row>
        </el-main>
      </el-container>
    </div>
</template>
<script>
export default {
  name: "Login",
  data() {
    return {
      errorMsg: '',
      loginImg: require('../assets/img/login-banner.jpg'),
      user: null,
      loginForm: {
        loginName: "",
        password: "",
      },
      loginBg: {
        
      }
    };
  },
  methods: {
      login(){
        var that = this;
        var data = "loginName="+that.loginForm.loginName+"&password="+that.loginForm.password+"&captcha=";
        this.$axios({
            method: 'post',
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            },
            url: 'http://127.0.0.1:10001/api/login',
            data: data
        }).then(function(res){
            console.log(res)
            if(res.data.code == 0){//登录成功
              localStorage.setItem("ftoken", res.data.token);
              localStorage.setItem("fuser", JSON.stringify(res.data.member));
              that.$router.push("/");
            }else{
              that.errorMsg = res.data.msg;
              that.$message.error(res.data.msg);
            }
        })
        
      },
      register(){
        this.$router.push("register");
      }
  },
  created(){
    
  }
};
</script>

<style scoped>
.login-box{
  width: 350px;
  margin-top: 20px;
}
.el-header, .el-footer {
  background-color: #e3e4e5;
  color: #333;
  line-height: 60px;
}
</style>