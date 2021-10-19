<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head></head>
<body>
<div class="layui-fluid" xmlns:v-on="http://www.w3.org/1999/xhtml">

	<div class="layui-row">
		<div class="layui-col-xs12">
			<div class="layui-card">
				<div class="layui-card-header">站内新闻管理</div>
				<div class="layui-card-body newsList">
					<div class="layui-row">
						<div class="layui-inline">
							<label class="layui-form-label">标题</label>
							<div class="layui-inline"><%--id的moviename不能和后台movieName一样--%>
								<input type="text" class="layui-input" id="titleQuery" name="titleQuery">
							</div>
							<button v-on:click="loadData" class="layui-btn layui-btn-normal">查询</button>
						</div>
					</div>
					<table class="layui-table">
						<thead>
							<tr>
								<th>ID</th>
								<th>标题</th>
								<th>作者</th>
								<th>发布时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
                            <tr v-for="item in dataSource">
                                <td>{{item.id}}</td>
                                <td>{{item.title}}</td>
                                <td>{{item.author}}</td>
								<td>{{item.publishdate}}</td>
                                <td>
                                    <button v-on:click="modifyData" data-id="{{item.id}}" class="layui-btn layui-btn-normal">修改</button>
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
		el:'.newsList',//生效范围
		data:{
			dataSource: []
		},
		methods: {
			//查询所有用户
			loadData: function(page,rows){
				var titleA=$("#titleQuery").val();
				page = page?page:1;
				rows = rows?rows:5;
				this.$http({/*传到接口的值*/
					url: 'news/list.do',
					data:{
						title:titleA,
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
						});
					});
				})
			},
			//删除一个新闻
			removeData:function (e) {
				if (!confirm("您确定要删除该新闻吗？")){//否
					return;
				}
				this.$http({
					url: 'news/delete.do?id='+e.target.dataset.id,
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
			},
			//修改新闻
			modifyData: function (e) {
				location.href='/#/news/add?/id='+e.target.dataset.id;
			}
		}
	});
	vm.loadData();
</script>
</body>
</html>