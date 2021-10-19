package com.app.controller;

import com.app.entity.Movies;
import com.app.entity.News;
import com.app.entity.Ticket;
import com.app.service.MoviesService;
import com.app.service.NewsService;
import com.app.util.Consts;
import com.app.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 前端页面
 */
@Controller
@RequestMapping("/front")
public class IndexController {
    @Autowired
    private MoviesService moviesService;
    @Autowired
    private NewsService newsService;

    /*注册用户登录到，index.jsp,set进去前端可以使用了*/
    @RequestMapping("/index")
    public ModelAndView index(String movieName) {
        ModelAndView modelAndView = new ModelAndView();
        //1.显示新添加的10条,正在热映,不应该是最受期待
        PageInfo pageInfo = new PageInfo();//自定义类
        pageInfo.setCurPageNo(1);
        pageInfo.setPageSize(10);
        int total = moviesService.queryAllCount(movieName);
        pageInfo.setTotalCount(total);
        //不应该是最受期待并且带有翻页功能并且id desc 的模糊查询
        List<Movies> list = moviesService.listMovieByDesc(pageInfo, movieName);
        modelAndView.addObject("moviesList", list);
        //右侧代码
        aside(modelAndView);
        modelAndView.setViewName("/front/index.jsp");
        return modelAndView;
    }

    /**
     * 注册用户退出
     */
    @RequestMapping("/userLogout")
    public ModelAndView userLogout(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        //清理注册用户的session
        request.getSession().removeAttribute(Consts.CURRENT_USER);
        return index(null);
    }

    /*电影详情*/
    @RequestMapping("/detail")
    public ModelAndView detail(String id) {
        ModelAndView modelAndView = new ModelAndView();
        //1.搜索电影详情,放入前端
        Movies movies = moviesService.getById(id);
        modelAndView.addObject("movies", movies);
        //2.搜索电影的电影票,放入前端
        List<Ticket> tickets = moviesService.getTicketByMovieId(id);
        modelAndView.addObject("tickets", tickets);
        //右侧代码
        aside(modelAndView);
        modelAndView.setViewName("/front/detail.jsp");
        return modelAndView;
    }

    /**
     * 购票的右侧公共代码部分
     * @param modelAndView
     */
    private void aside(ModelAndView modelAndView) {
        //3.最受期待
        modelAndView.addObject("zsqd", moviesService.queryListByType("zsqd"));
        //4.好评如潮,只查询两个，页面效果好
        modelAndView.addObject("hprc", moviesService.queryListByType("hprc"));
        //5.今日票房
        modelAndView.addObject("jrpf", moviesService.queryListByType("jrpf"));
        //6.最新的3条新闻
        modelAndView.addObject("newsList", newsService.latestListNews());
    }


    /**
     * 首页搜索功能,结果
     */
    /*注册用户登录到，index.jsp,set进去前端可以使用了*/
    @RequestMapping("/result")
    public ModelAndView result(String moviename) {
        ModelAndView modelAndView = new ModelAndView();
        //只查询最新的10条并且id desc 的模糊查询
        List<Movies> list = moviesService.queryMovies10(moviename);
        modelAndView.addObject("moviesList", list);
        //右侧代码
        aside(modelAndView);

        modelAndView.setViewName("/front/result.jsp");
        return modelAndView;
    }


    /**
     * 新闻详情
     * @param id 新闻id
     *
     */
    @RequestMapping("/detailNews")
    public ModelAndView detailNews(String id) {
        ModelAndView modelAndView = new ModelAndView();
        //1.搜索新闻详情,放入前端
        News news = newsService.getById(id);
        modelAndView.addObject("news", news);
        //右侧代码
        aside(modelAndView);
        modelAndView.setViewName("/front/detailNews.jsp");
        return modelAndView;
    }
}
