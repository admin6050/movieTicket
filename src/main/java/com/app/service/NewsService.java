package com.app.service;

import com.app.entity.News;
import com.app.util.PageInfo;

import java.util.List;

/**
 * 新闻service
 */
public interface NewsService {

    /**
     * 查询新闻总条数
     */
    int queryAllCount(String title);
    /**
     * 根据标题模糊查询新闻
     */
    List<News> listNews(PageInfo pageInfo, String title);

    /**
     * 根据id查询新闻对象
     */
    News getById(String id);

    /**
     * 新增一个新闻
     */
    int add(News news);

    /**
     * 修改一个新闻
     */
    int update(News news);

    /**
     * 删除一个新闻
     */
    int delete(String id);
    /**
     * 获取最新的三条新闻
     */
    List<News> latestListNews();
}
