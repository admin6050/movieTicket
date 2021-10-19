package com.app.mapper;


import com.app.entity.Orders;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrdersMapper {
    int insertOrders(Orders orders);

    /**
     * 订单列表---按创建时间倒序排序
     */
    List<Orders> queryByCreateDate(@Param("begin") int begin,@Param("end") int end);

    /**
     * 查询订单总记录数
     *
     */
    int queryTotal();
}