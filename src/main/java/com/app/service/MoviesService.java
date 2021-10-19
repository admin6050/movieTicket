package com.app.service;


import com.app.entity.Movies;
import com.app.entity.Ticket;
import com.app.util.PageInfo;

import java.util.List;

/**
 * 电影service
 */
public interface MoviesService {
    /**
     * 查询电影总条数
     */
    int queryAllCount(String movieName);
    /**
     * 根据电影名模糊查询电影列表
     */
    public List<Movies> listMovie(PageInfo pageInfo, String movieName);
    /**
     * 带有翻页功能并且id desc 的模糊查询
     */
    public List<Movies> listMovieByDesc(PageInfo pageInfo, String movieName);
    /**
     * 根据类型查询电影列表
     */
    public List<Movies> queryListByType(String type);
    /**
     * 根据id查询电影
     */
    public Movies getById(String id);
    /**
     * 新增一个电影
     */
    public int add(Movies movies);
    /**
     * 修改一个电影
     */
    public int update(Movies movies);
    /**
     * 删除一个电影
     */
    public int delete(String id);

    /**
     * 设置一个电影属性
     * 是否最受期待
     * 是否好评入潮
     * 是否今日票房
     */
    public void update(String id,String column);

    /**
     * 根据电影id查询某个电影所有票
     */
    public List<Ticket> getTicketByMovieId(String movieid);

    /**
     * 创建某个电影的所有电影票
     */
    public void createTickets(String movieid);

    /**
     * 模糊查询电影,不用排除最受期待,不包含分页，限定1-10
     */
    List<Movies> queryMovies10(String movieName);
}
