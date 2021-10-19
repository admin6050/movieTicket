package com.app.controller;
import com.app.core.ReturnVoCommon;
import com.app.entity.Users;
import com.app.mapper.UsersMapper;
import com.app.util.Consts;
import com.app.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户controller
 */
@RequestMapping("/users")
@Controller
public class UsersController {
    @Autowired
    private UsersMapper usersMapper;
    /**
     * 登录
     *
     */
    @RequestMapping("/login")
    @ResponseBody
    public ReturnVoCommon login(Users user, HttpServletRequest request){
        //因为查询出来只会有一条记录所以，设置分页为0,1
        List<Users> usersList = usersMapper.selectUser(0,1,user);
        ReturnVoCommon vo=new ReturnVoCommon();
        if (usersList==null||usersList.size()==0){
            vo.setCode(-1);
            vo.setErrMsg("用户名或者密码错误");
            return vo;
        }
        if (user.getAuth().equals("注册用户")){
            vo.setCode(1);
            request.getSession().setAttribute(Consts.CURRENT_USER,usersList.get(0));
        }else {//管理员
            vo.setCode(2);
            request.getSession().setAttribute(Consts.ADMIN_USER,usersList.get(0));
        }
        return vo;
    }

    /**
     * 注册  ,管理员不允许注册
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/reg")
    @ResponseBody
    public ReturnVoCommon reg(Users user, HttpServletRequest request) {
        ReturnVoCommon vo = new ReturnVoCommon();
        //另外new一个user存放姓名，为了符合动态sql
        Users user1 = new Users();
        user1.setName(user.getName());
        //1.在数据库查询是否已经存在用户
        List<Users> usersList = usersMapper.selectUser(0,1,user1);//根据用户名查询用户
        if (usersList.size()>0&&usersList!=null){
            vo.setCode(-1);
            vo.setErrMsg("用户名已经存在");
            return vo;
        }
        user.setAuth("注册用户");
        //2.保存到数据库
        usersMapper.insertUser(user);
        return vo;
    }

    /**
     * 管理员退出
     */
    @RequestMapping("/logout")
    public ModelAndView reg(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        //清理管理员的session
        request.getSession().removeAttribute(Consts.ADMIN_USER);
        modelAndView.setViewName("/front/login.jsp");
        return modelAndView;
    }

    /**
     * 注册用户列表带翻页功能
     * page: 当前第几页
     * rows:每页大小
     */
    @RequestMapping("/list")
    @ResponseBody
    public Map<String,Object> list(Integer page,Integer rows) {
        Map<String,Object> map = new HashMap<String,Object>();
        PageInfo pageInfo = new com.app.util.PageInfo();//自定义类
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
        int total = usersMapper.queryTotalCount();
        pageInfo.setTotalCount(total);
        int begin = (pageInfo.getCurPageNo()-1)*pageInfo.getPageSize();//limit参数
        int end=pageInfo.getPageSize();//limit参数
        List<Users> list = usersMapper.selectUser(begin,end,new Users());
        map.put("rows",list);
        map.put("total",pageInfo.getTotalCount());//总行数
        return map;
    }

    /*后台管理员，用户管理删除按钮*/
    @RequestMapping("/delete")
    @ResponseBody
    public ReturnVoCommon reg(String id) {
        ReturnVoCommon vo = new ReturnVoCommon();
        try {
            usersMapper.deleteById(Integer.parseInt(id));
        }catch (Exception e){
            vo.setCode(-1);
            vo.setErrMsg("删除失败！");
            return vo;
        }
        return vo;
    }
}
