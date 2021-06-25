$(function () {
	
	var columns = [
        { checkbox: true, align: 'center' },
      	{ title: '图片', field: 'picUrl',
			formatter: function (value, row, index) {
				return '<img width="60px" height="60px" src="'+value+'" />';
			}	
		}, 
		{ title: '商品名称', field: 'goodsName'},
		{ title: '分类', field: 'category.categoryName'},
		{ title: '价格', field: 'price'},
		{ title: '状态', field: 'status', formatter: function(value, row){
			if(value == 0){
				return '<span class="label label-default">已下架</span>';
			}else if(value == 1){
				return '<span class="label label-primary">待审核</span>';
			}else if(value == 2){
				return '<span class="label label-primary">出售中</span>';
			}else if(value == 3){
				return '<span class="label label-primary">已卖出</span>';
			}
			return '';
		}},
		{ title: '发布者', field: 'member.nickname'},
		{ title: '创建时间', field: 'createTime'}
		];
	
	$("#table").bootstrapTable({
        url: baseURL + 'goods/list',
        cache: false,
        striped: true,
        pagination: true,
        pageSize: 10,
        pageNumber: 1,
        sidePagination: 'server',
        columns: columns,
        queryParams: function (params) {
        	return {
	        	page: params.offset / params.limit + 1,
	        	limit: params.limit,
	        	goodsName: vm.q.goodsName
        	}
        }
	});
	
});

var vm = new Vue({
	el:'#app',
	data:{
		showList: true,
		title: null,
		goods: {
			picUrls: []
		},
		categoryList: [],
		q:{
			goodsName: ''
		}
	},
	methods: {
		query: function () {
			vm.reload();
		},
		add: function(){
			vm.showList = false;
			vm.title = "新增";
			vm.goods = {
				picUrls: [],
				categoryId : ""
			};
			
			this.getCategoryList();
		},
		update: function (event) {
			var id = getSelectedVal("id");
			if(id == null){
				return ;
			}
			vm.showList = false;
            vm.title = "修改";
            vm.goods = {
    			picUrls: []
    		};
            
            vm.getInfo(id);
            this.getCategoryList();
		},
		saveOrUpdate: function (event) {
			if(vm.validator()){
				return;
			}
			
			var url = vm.goods.id == null ? "goods/save" : "goods/update";
			vm.goods.picUrl = vm.goods.picUrls[0];
			vm.goods.describe = ue.getContent();
			$.ajax({
				type: "POST",
			    url: baseURL + url,
                contentType: "application/json",
			    data: JSON.stringify(vm.goods),
			    success: function(r){
			    	if(r.code === 0){
						alert('操作成功', function(index){
							vm.reload();
						});
					}else{
						alert(r.msg);
					}
				}
			});
		},
		del: function (event) {
			var ids = getSelectedVals("id");
			if(ids == null){
				return ;
			}
			
			confirm('确定要删除选中的记录？', function(){
				$.ajax({
					type: "POST",
				    url: baseURL + "goods/delete",
                    contentType: "application/json",
				    data: JSON.stringify(ids),
				    success: function(r){
						if(r.code == 0){
							alert('操作成功', function(index){
								vm.reload();
							});
						}else{
							alert(r.msg);
						}
					}
				});
			});
		},
		upper: function(){
			var ids = getSelectedVals("id");
			if(ids == null){
				return ;
			}
			confirm('确定要上架选中的记录？', function(){
			$.ajax({
				type: "POST",
			    url: baseURL + "goods/upper",
                contentType: "application/json",
			    data: JSON.stringify(ids),
			    success: function(r){
					if(r.code == 0){
						alert('操作成功', function(index){
							vm.reload();
						});
					}else{
						alert(r.msg);
					}
				}
			});
			});
		},
		lower: function(){
			var ids = getSelectedVals("id");
			if(ids == null){
				return ;
			}
			confirm('确定要下架选中的记录？', function(){
			$.ajax({
				type: "POST",
			    url: baseURL + "goods/lower",
                contentType: "application/json",
			    data: JSON.stringify(ids),
			    success: function(r){
					if(r.code == 0){
						alert('操作成功', function(index){
							vm.reload();
						});
					}else{
						alert(r.msg);
					}
				}
			});
			});
		},
		getInfo: function(id){
			$.get(baseURL + "goods/info/"+id, function(r){
                vm.goods = r.goods;
                ue.setContent(r.goods.describe);
            });
		},
		getCategoryList: function(){
			$.get(baseURL + "category/getAll", function(r){
				vm.categoryList = r.categoryList;
			});
		},
		reload: function (event) {
			vm.showList = true;
			$('#table').bootstrapTable('refresh',  {pageNumber: 1});
		},
		validator: function () {
            if(vm.goods.picUrls.length == 0){
                alert("请选择商品图片");
                return true;
            }

            if(isBlank(vm.goods.goodsName)){
                alert("请填写商品名称");
                return true;
            }
            
            if(isBlank(vm.goods.price)){
                alert("请填写价格");
                return true;
            }
        }
	}
});