package com.app.controller;
import com.app.core.ReturnVoCommon;
import com.app.entity.Movies;
import com.app.entity.News;
import com.app.service.NewsService;
import com.app.util.PageInfo;
import com.app.util.StringUtilsEx;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 新闻controller
 */
@RequestMapping("/news")
@Controller
public class NewsController {
    @Autowired
    private NewsService newsService;


    /**
     * 新闻列表带翻页功能
     * page: 当前第几页
     * rows:每页大小
     */
    @RequestMapping("/list")
    @ResponseBody
    public Map<String,Object> list(String title,Integer page,Integer rows) {
        Map<String,Object> map = new HashMap<String,Object>();
        PageInfo pageInfo = new PageInfo();//自定义类
        //前端已经判断过了,一定会传.所以用这个
        pageInfo.setCurPageNo(page);
        pageInfo.setPageSize(rows);
        //查询新闻总条数
        int total = newsService.queryAllCount(title);
        pageInfo.setTotalCount(total);
        List<News> list = newsService.listNews(pageInfo,title);
        map.put("rows",list);
        map.put("total",pageInfo.getTotalCount());//总行数
        return map;
    }

    /**
     * 根据主键查询一个新闻
     */
     @RequestMapping("/getById")
     @ResponseBody
     public News getById(String id){
        return newsService.getById(id);
     }

    /**
     * 增加或修改一个新闻
     */
    @RequestMapping("/add")
    @ResponseBody
    public ReturnVoCommon add(News new1) {
        ReturnVoCommon returnVoCommon = new ReturnVoCommon();

        try{
            if (StringUtilsEx.isEmpty(new1.getId())){//为空时是增加
                newsService.add(new1);
            }else {//id不为空就是修改
                newsService.update(new1);
            }
        }catch (Exception e){
            System.out.println(e);
            returnVoCommon.setCode(-1);
            returnVoCommon.setErrMsg("操作失败!");
        }
        return returnVoCommon;
    }


    /**
     * 删除一个用户
     */
    @RequestMapping("/delete")
    @ResponseBody
    public ReturnVoCommon delete(String id) {
        ReturnVoCommon returnVoCommon = new ReturnVoCommon();
        try{
            newsService.delete(id);
        }catch (Exception e){
            returnVoCommon.setCode(-1);
            returnVoCommon.setErrMsg("删除失败!");
        }
        return returnVoCommon;
    }
}
