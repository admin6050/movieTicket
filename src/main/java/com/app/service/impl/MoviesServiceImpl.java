package com.app.service.impl;

import com.app.entity.Movies;
import com.app.entity.Ticket;
import com.app.mapper.MoviesMapper;
import com.app.mapper.TicketMapper;
import com.app.service.MoviesService;
import com.app.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.Timestamp;
import java.util.Date;
import java.util.List;

@Service
public class MoviesServiceImpl implements MoviesService {
    @Autowired
    private MoviesMapper moviesMapper;
    @Autowired
    private TicketMapper ticketMapper;
    /**
     * 查询电影总条数
     */
    public int queryAllCount(String movieName){
        return moviesMapper.queryAllCount(movieName);
    }
    /**
     * 根据电影名模糊查询电影列表
     */
    public List<Movies> listMovie(PageInfo pageInfo, String movieName){
        /*if (StringUtilsEx.isNotEmpty(movieName)){//判断movieName不是空的话
        }*/
        int begin = (pageInfo.getCurPageNo()-1)*pageInfo.getPageSize();//limit参数
        int end=pageInfo.getPageSize();//limit参数
        //进行查询
        return moviesMapper.queryMoviesByLike(begin,end,movieName);
    }
    /**
     * 带有翻页功能并且id desc 的模糊查询
     * 正在热映
     */
    public List<Movies> listMovieByDesc(PageInfo pageInfo, String movieName){
        int begin = (pageInfo.getCurPageNo()-1)*pageInfo.getPageSize();//limit参数
        int end=pageInfo.getPageSize();//limit参数
        //进行查询
        return moviesMapper.queryMoviesByDesc(begin,end,movieName);
    }
    /**
     * 根据类型,id desc 查询电影列表
     */
    public List<Movies> queryListByType(String type){
        //id desc

        if (type.equals("zsqd")||type.equals("hprc")||type.equals("jrpf")){
            return moviesMapper.queryListByType(type);
        }
        return null;
    }
    /**
     * 根据id查询电影
     */
    public Movies getById(String id){
        return moviesMapper.queryById(Integer.parseInt(id));
    }
    /**
     * 新增一个电影
     */
    public int add(Movies movies){
        return moviesMapper.insertMovie(movies);
    }
    /**
     * 修改一个电影
     */
    public int update(Movies movies){
        return moviesMapper.updateMovie(movies);
    }
    /**
     * 删除一个电影
     */
    public int delete(String id){
        return moviesMapper.deleteById(Integer.parseInt(id));
    }

    /**
     * 设置一个电影属性
     * 是否最受期待
     * 是否好评入潮
     * 是否今日票房
     */
    public void update(String id,String column){
        Movies movies = getById(id);
        if (column.equals("zsqd")){
            movies.setIszsqd("1");
        }else if (column.equals("hprc")){
            movies.setIshprc("1");
        }else if (column.equals("jrpf")){
            movies.setIsjrpf("1");
        }
        movies.setUpdatedate(new Date());
        moviesMapper.updateMovie(movies);
    }

    /**
     * 根据电影id查询某个电影所有票
     */
    public List<Ticket> getTicketByMovieId(String movieid){
        int id=Integer.parseInt(movieid);
        return ticketMapper.queryTicketByMovieId(id);
    }

    /**
     * 创建某个电影的所有电影票
     */
    public void createTickets(String movieid){
        Movies m = getById(movieid);//获得这个电影的信息
        for (int i=0;i<36;i++){//插入36张票的记录
            Ticket ticket = new Ticket();
            ticket.setMovieid(Integer.parseInt(movieid));
            ticket.setMoviename(m.getMovieName());
            ticket.setOccupy("空余座位");
            ticket.setSeat(i+1+"座");
            ticket.setStatus("待出票");
            ticketMapper.insertTicket(ticket);
        }
    }


    /**
     * 模糊查询电影,不用排除最受期待,不包含分页，限定1-10
     */
    public List<Movies> queryMovies10(String movieName){
        return moviesMapper.queryMovies10(movieName);
    }
}