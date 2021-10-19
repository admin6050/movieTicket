<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head></head>
<body>
<div class="layui-fluid" xmlns:v-on="http://www.w3.org/1999/xhtml">

    <div class="layui-row">
        <div class="layui-col-xs12">
            <div class="layui-card">
                <div class="layui-card-header">新闻详情</div>
                <div class="layui-card-div newsAdd">
                    <form class="layui-form">
                        <div class="layui-form-item">
                            <label class="layui-form-label">标题</label>
                            <div class="layui-input-block">
                                <input type="text" name="title" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">内容</label>
                            <div class="layui-input-block">
                                <textarea id="detail" style="display: none"></textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">作者</label>
                            <div class="layui-input-block">
                                <input type="text" name="author" class="layui-input">
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
    var $ = layui.jquery;
    var layer = layui.layer;
    var layeditRef, layeditIndex;
    var newsAdd = new Vue({
        el: '.newsAdd',
        data: {
            errMag: ''
        },
        methods: {
            //修改电影
            loadData: function () {
                window.id = layui.router().search.id;
                if (!id)/*新增页面*/
                    return;
                /*修改页面*/
                $.post("/news/getById.do", {id: id}, function (data) {/*后端返回的值data*/
                    $("input[name='title']").val(data.title);
                    $("input[name='author']").val(data.author);
                    setTimeout(function () {
                        layeditRef.setContent(layeditIndex, data.content, false);
                    }, 100);
                }, 'json');
            },
            /*提交，需要判断是修改还是新增电影。*/
            ajaxSubmit: function () {
                var obj = {};
                if (!$("input[name='title']").val()) {
                    this.errMag = '站内新闻标题不允许为空!';
                    return;
                }
                obj.title = $("input[name='title']").val();
                obj.author = $("input[name='author']").val();
                obj.content = layeditRef.getContent(layeditIndex);
                if (window.id) {//id存在的时候,更新
                    obj.id = id;
                }
                $.ajax({
                    url: '/news/add.do',
                    type: 'POST',
                    data: obj,
                    dataType: 'JSON',
                    aysyn: 'true',
                    success: function (data) {
                        //debugger;
                        //data=JSON.stringify(data);
                        if (data.code != 0) {
                            alert("保存失败!");
                            return;
                        }
                        alert("保存成功!");
                        location.href = "/#/news/query";
                    }
                });
            },
            back: function () {
                location.href = "/#/news/query";
            }
        }
    });
	layui.use(['form', 'jquery', 'layedit'], function () {
		var form = layui.form;
		form.render();
		layeditRef = layui.layedit;
		layeditIndex = layeditRef.build('detail', {
			tool: [
				'strong',//加粗
				'italic',//斜体
				'underline',//下划线
				'del',//删除线
				'|',//分割线
				'left',//左对齐
				'center',//居中
				'right',//右对齐
				'link',//超链接
				'unlink',//清楚链接
				'face'   //表情
			]
		});
	});
    newsAdd.loadData();
</script>
</body>
</html>