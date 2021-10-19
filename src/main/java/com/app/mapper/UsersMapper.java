package com.app.mapper;



import com.app.entity.Users;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UsersMapper {


    /**
     * 查询出所有用户的条数
     */
    int queryTotalCount();
    /**
     * 可以没有参数,动态sql
     * 通过用户名和密码查询用户
     * @param users 用户名+密码+权限
     * @return 查询用户
     */
    List<Users> selectUser(@Param("start")int start , @Param("end")int end, @Param("users") Users users);

    /**
     * 插入用户
     * @param users
     * @return
     */
    int insertUser(Users users);

    /**
     * 通过id删除用户
     * @param id
     * @return
     */
    int deleteById(Integer id);
}