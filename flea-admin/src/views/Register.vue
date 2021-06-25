<template>
    <div>
      <el-container>
        <el-header>
          <el-link :underline="false" href="/#/">用户注册</el-link>
        </el-header>
        <el-main>
          <el-row :gutter="20">
          <el-col :span="8" :offset="6">
            <el-image :src="loginImg"></el-image>
          </el-col>
          <el-col :span="10">
              <el-card class="box-card login-box">
                <div slot="header">
                  <span>用户注册</span>
                </div>
                <el-form>
                  <el-form-item>
                      <el-input v-model="registerForm.loginName" placeholder="用户名"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-input v-model="registerForm.password" placeholder="密码" type="password"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-input v-model="registerForm.realName" placeholder="姓名"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-input v-model="registerForm.mobile" placeholder="手机"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-input v-model="registerForm.email" placeholder="邮箱"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-button type="primary" @click="register">注册</el-button>
                      <el-button @click="login">登录</el-button>
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
  name: "Register",
  data() {
    return {
      errorMsg: '',
      loginImg: require('../assets/img/login-banner.jpg'),
      user: null,
      registerForm: {
        loginName: "",
        password: "",
        realName: "",
        mobile: "",
        email: ""
      },
    };
  },
  methods: {
      login(){
        this.$router.push("/login");
      },
      register(){
        
        var that = this;
        var data = this.registerForm;
        this.$axios({
            method: 'post',
            url: 'http://127.0.0.1:10001/api/register',
            data: data
        }).then(function(r){
            console.log(r)
            if(r.data.code == 0){//注册成功
              that.$router.push("/login");
            }else{
              that.errorMsg = r.data.msg;
              that.$message.error(r.data.msg);
            }
        })
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