package com.app.controller;

import com.app.core.ReturnVoCommon;
import com.app.entity.Movies;
import com.app.entity.Orders;
import com.app.entity.Ticket;
import com.app.service.MoviesService;
import com.app.service.OrdersService;
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
 * 用户controller
 */
@RequestMapping("/movies")
@Controller
public class MoviesController {
    @Autowired
    private MoviesService moviesService;
    @Autowired
    private OrdersService ordersService;


    /**
     * 电影列表带翻页功能
     * page: 当前第几页
     * rows:每页大小
     *
     */
    @RequestMapping("/list")
    @ResponseBody
    public Map<String,Object> list(String movieName,Integer page,Integer rows) {
        Map<String,Object> map = new HashMap<String,Object>();
        PageInfo pageInfo = new PageInfo();//自定义类
        //前端已经判断过了,一定会传.所以用这个
        pageInfo.setCurPageNo(page);
        pageInfo.setPageSize(rows);
        /*if (StringUtilsEx.isEmpty(page)){//如果前端没有传page
            page=1;
            pageInfo.setCurPageNo(page);
        }
        if (StringUtilsEx.isEmpty(rows)){
            rows=5;
            pageInfo.setPageSize(rows);
        }*/
        //PageHelper.startPage(page,rows);//翻页功能,配合mybatis逆向工程
        //查询电影总条数
        int total = moviesService.queryAllCount(movieName);
        pageInfo.setTotalCount(total);
        List<Movies> list = moviesService.listMovie(pageInfo,movieName);
        map.put("rows",list);
        map.put("total",pageInfo.getTotalCount());//总行数
        return map;
    }

    /**
     * 根据主键查询一个电影
     */
     @RequestMapping("/getById")
     @ResponseBody
     public Movies getById(String id){
        return moviesService.getById(id);
     }

    /**
     * 增加或修改一个电影
     */
    @RequestMapping("/add")
    @ResponseBody
    public ReturnVoCommon add(Movies movie) {
        ReturnVoCommon returnVoCommon = new ReturnVoCommon();

        try{
            if (movie.getId()==0){//为空时是增加StringUtilsEx.isEmpty(movie.getId())
                moviesService.add(movie);
            }else {//id不为空就是修改
                moviesService.update(movie);
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
            moviesService.delete(id);
        }catch (Exception e){
            returnVoCommon.setCode(-1);
            returnVoCommon.setErrMsg("删除失败!");
        }
        return returnVoCommon;
    }


    /**
     * 设置一个电影属性
     *      * 是否最受期待
     *      * 是否好评入潮
     *      * 是否今日票房
     */
    @RequestMapping("/update")
    @ResponseBody
    public ReturnVoCommon update(String id,String column) {
        ReturnVoCommon returnVoCommon = new ReturnVoCommon();
        try{
            moviesService.update(id,column);
        }catch (Exception e){
            returnVoCommon.setCode(-1);
            returnVoCommon.setErrMsg("设置失败!");
        }
        return returnVoCommon;
    }

    /**
     *创建某个电影电影票
     */
    @RequestMapping("/createTickets")
    @ResponseBody
    public ReturnVoCommon createTickets(String movieid) {
        ReturnVoCommon returnVoCommon = new ReturnVoCommon();
        //先检查这个电影的电影票是否已经生成
        List<Ticket> list  = moviesService.getTicketByMovieId(movieid);
        if (list!=null&&list.size()>0){
            returnVoCommon.setCode(2);
            return returnVoCommon;
        }
        try{
            moviesService.createTickets(movieid);
        }catch (Exception e){
            e.printStackTrace();
            returnVoCommon.setCode(-1);
            returnVoCommon.setErrMsg("生成失败!");
            return returnVoCommon;
        }
        return returnVoCommon;
    }

    /**
     * 根据电影票id生成订单
     * id:电影票id
     */
    @RequestMapping("/addOrder")
    @ResponseBody
    public ReturnVoCommon addOrder(String id) {
        ReturnVoCommon returnVoCommon = new ReturnVoCommon();
        try {
            ordersService.addOrder(id);
        }catch (Exception e){
            e.printStackTrace();
            returnVoCommon.setCode(-1);
            returnVoCommon.setErrMsg("生成失败");
            return returnVoCommon;
        }

        return returnVoCommon;
    }

    /**
     *订单列表
     */
    @RequestMapping("/listOrders")
    @ResponseBody
    public Map<String,Object> listOrders(Integer page,Integer rows) {
        Map<String,Object> map = new HashMap<String,Object>();
        PageInfo pageInfo = new PageInfo();//自定义类
        //前端已经判断过了,一定会传.所以用这个
        pageInfo.setCurPageNo(page);
        pageInfo.setPageSize(rows);
        //查询电影总条数
        int total = ordersService.queryTotal();
        pageInfo.setTotalCount(total);
        List<Orders> list = ordersService.listOrders(pageInfo);
        map.put("rows",list);
        map.put("total",pageInfo.getTotalCount());//总行数
        return map;
    }
}
