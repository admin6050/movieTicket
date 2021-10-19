package com.app.mapper;

import com.app.entity.Movies;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MoviesMapper {

    /**
     * 查询电影总条数
     */
    int queryAllCount(String movieName);
    /**
     * 根据电影名模糊查询电影列表
     * @return 电影列表
     */
    List<Movies> queryMoviesByLike(@Param("start")int start ,@Param("end")int end,@Param("movieName") String movieName);
    /**
     * 带有翻页功能并且id desc 的模糊查询
     */
    List<Movies> queryMoviesByDesc(@Param("start")int start ,@Param("end")int end,@Param("movieName") String movieName);

    /**
     * 根据类型,id desc 查询电影列表
     */
    List<Movies> queryListByType(String type);

    /**
     * 根据id查询电影
     */
     Movies queryById(Integer id);

    /**
     * 新增一个电影
     * @param movies
     * @return
     */
     int insertMovie(Movies movies);
    /**
     * 修改一个电影
     */
     int updateMovie(Movies movies);

     int deleteById(int id);

    /**
     * 模糊查询电影,不用排除最受期待,不包含分页,直查询10条
     */
    List<Movies> queryMovies10(String movieName);

}
