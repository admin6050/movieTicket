<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head></head>
<body>
<div class="layui-fluid" xmlns:v-on="http://www.w3.org/1999/xhtml">

	<div class="layui-row">
		<div class="layui-col-xs12">
			<div class="layui-card">
				<div class="layui-card-header">注册用户信息列表</div>
				<div class="layui-card-body usersList">
					<table class="layui-table">
						<thead>
							<tr>
								<th>ID</th>
								<th>用户名</th>
								<th>密码</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
                            <tr v-for="item in dataSource">
                                <td>{{item.id}}</td>
                                <td>{{item.name}}</td>
                                <td>{{item.password}}</td>
                                <td>
                                    <button v-on:click="removeData" data-id="{{item.id}}" class="layui-btn layui-btn-danger">移除</button>
                                </td>
                            </tr>
						</tbody>
					</table>
					<div id="laypageDemo"></div>
				</div>
			</div>
		</div>
	</div>

</div>

<script>

	var $=layui.jquery;
	var vm = new Vue({
		el:'.usersList',//生效范围
		data:{
			dataSource: []
		},
		methods: {
			//查询所有用户
			loadData: function(page,rows){
				page = page?page:1;
				rows = rows?rows:5;
				this.$http({
					url: 'users/list.do',
					data:{
						page:page,
						rows:rows
					}
				}).then(function(res){
					var data = res.data;
					vm.dataSource = data.rows;
					layui.use('laypage',function(){
						var laypage = layui.laypage;
						laypage.render({
							elem: 'laypageDemo',
							count: data.total,
							limit: rows,
							curr: page,
							jump: function(obj,first){
								//首次不执行
								if(!first){
									vm.loadData(obj.curr,obj.limit);
								}
							}
						})
					});
				});
			},
			//删除一个用户
			removeData:function (e) {
				if (!confirm("您确定要删除该用户吗？")){//否
					return;
				}
				this.$http({
					url: 'users/delete.do?id='+e.target.dataset.id,
					data:{}
				}).then(function (res) {
					var data = res.data;
					if (data.code!=0){
						alert(data.errMsg);
						return;
					}
					alert("删除成功!");
					location.reload();
				})
			}
		}
	});
	vm.loadData();
</script>
</body>
</html>