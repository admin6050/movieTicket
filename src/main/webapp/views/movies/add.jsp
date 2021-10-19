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
				<div class="layui-card-header">电影信息</div>
				<div class="layui-card-div movieadd">
					<form class="layui-form">
						<div class="layui-form-item">
							<label class="layui-form-label">电影名称</label>
							<div class="layui-input-block">
								<input type="text" name="moviename" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">电影简介</label>
							<div class="layui-input-block">
								<input type="text" name="description" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">封面图片</label>
							<div class="layui-input-block">
								<input type="text" name="imgpath" class="layui-input">
								<button class="layui-btn" type="button" v-on:click="openDiaLog" style="position: absolute;top: 0;right: 6px; cursor: pointer;">上传</button>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">票价</label>
							<div class="layui-input-block">
								<input type="number" name="ticketPrice" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">导演</label>
							<div class="layui-input-block">
								<input type="text" name="director" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">时长</label>
							<div class="layui-input-block">
								<input type="text" name="time" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">语言</label>
							<div class="layui-input-block">
								<select name="language" >
									<option value="中文">中文</option>
									<option value="英文">英文</option>
									<option value="日语">日语</option>
									<option value="法语">法语</option>
									<option value="粤语">粤语</option>
								</select>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">首映日期</label>
							<div class="layui-input-block">
								<input type="text" name="publishDate" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">票房(万)</label>
							<div class="layui-input-block">
								<input type="number" name="boxOffice" class="layui-input">
							</div>
						</div>
						<div style="color: red;text-align: center;">
							{{errMag}}
						</div>
						<div class="layui-form-item">
							<div style="text-align: center;" class="layui-input-block">
								<button type="button" class="layui-btn" v-on:click="ajaxSubmit">提交</button>
								<button type="button" class="layui-btn" v-on:click="back">返回</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</div>

<script>
	layui.use(['form','jquery'],function () {
		var form=layui.form;
		form.render();
	});
	var $ = layui.jquery;
	var layer = layui.layer;
	var movieAdd = new Vue({
		el:'.movieadd',
		data:{
			errMag:''
		},
		methods:{
			//修改电影
			loadData: function(){
				window.id=layui.router().search.id;
				if (!id)/*新增页面*/
					return;
				/*修改页面*/
				$.post("/movies/getById.do",{id:id},function(data){/*后端返回的值data*/
					$("input[name='moviename']").val(data.movieName);
					$("input[name='description']").val(data.description);
					$("input[name='imgpath']").val(data.imgpath);
					$("input[name='ticketPrice']").val(data.ticketPrice);
					$("input[name='director']").val(data.director);
					$("input[name='time']").val(data.time);
					$("select[name='language']").next().find('.layui-input').eq(0).val(data.language);
					$("input[name='publishDate']").val(data.publishDate);
					$("input[name='boxOffice']").val(data.boxOffice);
				},'json');
			},
			/*提交，需要判断是修改还是新增电影。*/
			ajaxSubmit:function () {
				var obj = {};
				if(!$("input[name='moviename']").val()){
					this.errMag = '电影名称不允许为空!';
					return;
				}
				obj.movieName = $("input[name='moviename']").val();
				obj.description = $("input[name='description']").val();
				obj.imgpath = $("input[name='imgpath']").val();
				obj.ticketPrice = $("input[name='ticketPrice']").val();
				obj.director = $("input[name='director']").val();
				obj.time = $("input[name='time']").val();
				obj.language = $("select[name='language']").next().find('.layui-input').eq(0).val();
				obj.publishDate = $("input[name='publishDate']").val();
				obj.boxOffice = $("input[name='boxOffice']").val();
				if (window.id){//id存在的时候
					obj.id=id;
				}
				$.ajax({
					url:'/movies/add.do',
					type:'POST',
					data:obj,
					dataType:'JSON',
					aysyn:'true',
					success:function (data) {
						//debugger;
						//data=JSON.stringify(data);
						if (data.code!=0){
							alert("保存失败!");
							return;
						}
						alert("保存成功!");
						location.href="/#/movies/query";
					}
				});
			},
			back: function () {
				location.href="/#/movies/query";
			},
			openDiaLog: function () {
				layer.open({
					title:'上传图片',
					area:['400px','300px'],
					shade: 0,
					type: 1,
					content: '<iframe style="width: 100%;height: 90%;border:0" src="/views/movies/file.jsp"></iframe>'
				});
			}
		}
	});
	movieAdd.loadData();
	//显示图片路径
	function setImg(img) {
		$("input[name='imgpath']").val(img);
	}
</script>
</body>
</html>