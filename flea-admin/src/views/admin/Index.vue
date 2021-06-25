<template>
    <div>
        <el-container>
            <el-header>二手交易市场

              <span style="float: right">
              <el-link type="primary" :underline="false" v-if="user">欢迎，{{user.username}}</el-link>
              <el-link type="primary" :underline="false" style="margin-left: 20px" @click="logout()">退出</el-link>
              </span>
            </el-header>
            <el-container>
                <el-aside width="200px">
                    <el-menu
                        default-active="1"
                        class="el-menu-vertical-demo"
                        :style="asideStyle"
                        router>
                        <el-menu-item index="1" route="admin_index">
                            <i class="el-icon-menu"></i>
                            <span slot="title">统计分析</span>
                        </el-menu-item>
                        <el-menu-item index="2" route="admin_member">
                            <i class="el-icon-menu"></i>
                            <span slot="title">会员管理</span>
                        </el-menu-item>
                        <el-menu-item index="2" route="admin_advert">
                            <i class="el-icon-menu"></i>
                            <span slot="title">广告管理</span>
                        </el-menu-item>
                        <el-menu-item index="2" route="admin_category">
                            <i class="el-icon-menu"></i>
                            <span slot="title">分类管理</span>
                        </el-menu-item>
                        <el-menu-item index="3" route="admin_goods">
                            <i class="el-icon-menu"></i>
                            <span slot="title">商品管理</span>
                        </el-menu-item>
                        <el-menu-item index="4" route="admin_order">
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
                    <el-row :gutter="12">
                      <el-col :span="8">
                        <el-card shadow="always">
                          商品数量
                          <div>{{statistics.goodsTotal}}</div>
                        </el-card>
                      </el-col>
                      <el-col :span="8">
                        <el-card shadow="always">
                          用户数量
                          <div>{{statistics.userTotal}}</div>
                        </el-card>
                      </el-col>
                      <el-col :span="8">
                        <el-card shadow="always">
                          订单数量
                          <div>{{statistics.orderTotal}}</div>
                        </el-card>
                      </el-col>
                    </el-row>
                  <el-row>
                    <div id="main" style="width: 100%;height:400px;"></div>
                  </el-row>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>
<script>
import echarts from 'echarts'
export default {
  name: "AdminIndex",
  data() {
    return {
      statistics: {},
      user: null,
      asideStyle: {
        height: '500px'
      }
    };
  },
  methods:{
    logout: function(){
      localStorage.removeItem("auser");
      app.user = null;
    },
    query: function() {
      var that = this;
      this.$axios.get("http://127.0.0.1:10001" + "/order/statistics", {headers: {
            'token': localStorage.getItem("atoken")
        }}).then(
        function(res){
          var r = res.data;
          console.log(r)
          if(r.code == 0){
            that.statistics = r.statistics;
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('main'));

            // 指定图表的配置项和数据
            var option = {
                title: {
                    text: ''
                },
                tooltip: {},
                legend: {
                    data:['销量']
                },
                xAxis: {
                    data: r.statistics.orderCountList.map(function(v){return v.createTime})
                },
                yAxis: {
                    minInterval: 1,
                },
                series: [{
                    name: '订单数量',
                    type:'line',
                    data: r.statistics.orderCountList.map(function(v){return v.count})
                }]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
          }
        }
      )
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