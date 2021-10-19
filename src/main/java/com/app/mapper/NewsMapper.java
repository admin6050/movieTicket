package com.app.mapper;


import com.app.entity.News;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NewsMapper {

    /**
     * 查询新闻总条数
     */
    int queryAllCount(String title);
    /**
     * 根据标题模糊查询新闻
     */
    List<News> listMovie(@Param("begin") int begin,@Param("end") int end,@Param("title") String title);

    /**
     * 根据id查询新闻对象
     */
    News getById(int id);

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
    int delete(int id);

    /**
     * 获取最新的三条新闻
     */
    List<News> latestListNews();
}