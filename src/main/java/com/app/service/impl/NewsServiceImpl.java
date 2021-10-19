package com.app.service.impl;

import com.app.entity.News;
import com.app.mapper.NewsMapper;
import com.app.service.NewsService;
import com.app.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class NewsServiceImpl implements NewsService {
    @Autowired
    private NewsMapper newsMapper;

    /**
     * 查询新闻总条数
     */
    public int queryAllCount(String title){
        return newsMapper.queryAllCount(title);
    }

    /**
     * 根据标题模糊查询新闻
     */
    public List<News> listNews(PageInfo pageInfo, String title){
        int begin = (pageInfo.getCurPageNo()-1)*pageInfo.getPageSize();//limit参数
        int end=pageInfo.getPageSize();//limit参数
        //进行查询
        return newsMapper.listMovie(begin,end,title);
    }


    /**
     * 根据id查询新闻对象
     */
    public News getById(String id){
        return newsMapper.getById(Integer.parseInt(id));
    }
    /**
     * 新增一个新闻
     */
    public int add(News news){
        int i=0;
        try {
            news.setPublishdate(new Date());
            i= newsMapper.add(news);
        }catch (Exception e){
            e.printStackTrace();

        }
        return i;
    }
    /**
     * 修改一个新闻
     */
    public int update(News news){
        return newsMapper.update(news);
    }
    /**
     * 删除一个新闻
     */
    public int delete(String id){
        return newsMapper.delete(Integer.parseInt(id));
    }

    /**
     * 获取最新的三条新闻
     */
    public List<News> latestListNews(){

        return newsMapper.latestListNews();
    }
}