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
				<div class="layui-card-header">电影信息查询</div>
				<div class="layui-card-body moviesList">
					<div class="layui-row">
						<div class="layui-inline">
							<label class="layui-form-label">电影名称</label>
							<div class="layui-inline"><%--id的moviename不能和后台movieName一样--%>
								<input type="text" class="layui-input" id="moviename" name="moviename">
							</div>
							<button v-on:click="loadData" class="layui-btn layui-btn-normal">查询</button>
						</div>
					</div>
					<table class="layui-table">
						<thead>
							<tr>
								<th>ID</th>
								<th>电影名称</th>
								<th>导演</th>
								<th>时长</th>
								<th>语言</th>
								<th>首映日期</th>
								<th>票房</th>
								<th>票价</th>
								<th>属性</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
                            <tr v-for="item in dataSource">
                                <td>{{item.id}}</td>
                                <td>{{item.movieName}}</td>
                                <td>{{item.director}}</td>
								<td>{{item.time}}</td>
								<td>{{item.language}}</td>
								<td>{{item.publishDate}}</td>
								<td>{{item.boxOffice}}</td>
								<td>{{item.ticketPrice}}</td>
								<td>
									<button v-on:click="updateDate" data-mid="{{item.id}}" data-type="zsqd" class="layui-btn layui-btn-normal">最受期待</button>
									<button v-on:click="updateDate" data-mid="{{item.id}}" data-type="hprc" class="layui-btn layui-btn-normal">好评如潮</button>
									<button v-on:click="updateDate" data-mid="{{item.id}}" data-type="jrpf" class="layui-btn layui-btn-normal">今日票房</button>
								</td>
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
		el:'.moviesList',//生效范围
		data:{
			dataSource: []
		},
		methods: {
			//查询所有电影
			loadData: function(page,rows){
				var moviename=$("#moviename").val();
				page = page?page:1;
				rows = rows?rows:5;
				this.$http({/*传到接口的值*/
					url: 'movies/list.do',
					data:{
						movieName:moviename,
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
			//删除一个电影
			removeData:function (e) {
				if (!confirm("您确定要删除该电影吗？")){//否
					return;
				}
				this.$http({
					url: 'movies/delete.do?id='+e.target.dataset.id,
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
			//修改电影
			modifyData: function (e) {
				location.href='/#/movies/add?/id='+e.target.dataset.id;
			},
			/*设置一个电影属性
			* 是否最受期待
			* 是否好评入潮
			* 是否今日票房*/
			updateDate: function (e) {
				var mid = e.target.dataset.mid;
				var column = e.target.dataset.type;
				this.$http({
					url: 'movies/update.do?id='+mid+'&column='+column,
					data:{}
				}).then(function (res) {
					var data = res.data;
					if (data.code==0){
						alert("属性修改成功!");
						return;
					}
					alert("属性修改失败!")
					location.reload();
				});
			}
		}
	});
	vm.loadData();
</script>
</body>
</html>