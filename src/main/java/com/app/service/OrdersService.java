package com.app.service;


import com.app.entity.Orders;
import com.app.util.PageInfo;

import java.util.List;

public interface OrdersService {
    void addOrder(String id);

    List<Orders> listOrders(PageInfo pageInfo);

    /**
     * 查询订单总记录数
     *
     */
    int queryTotal();
}
