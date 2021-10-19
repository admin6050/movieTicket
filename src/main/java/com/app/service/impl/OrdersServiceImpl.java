package com.app.service.impl;

import com.app.entity.Orders;
import com.app.entity.Ticket;
import com.app.mapper.OrdersMapper;
import com.app.mapper.TicketMapper;
import com.app.service.OrdersService;
import com.app.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * 订单
 */
@Service
public class OrdersServiceImpl implements OrdersService {
    @Autowired
    private OrdersMapper ordersMapper;
    @Autowired
    private TicketMapper ticketMapper;
    /**
     * 创建一个订单
     * id :电影票id
     */
    public void addOrder(String id){
        //1.先改变这个电影票的出票状态
        Ticket ticket =ticketMapper.queryById(Integer.parseInt(id));
        ticket.setOccupy("售出座位");
        ticketMapper.updateTicket(ticket);
        //2.在生成新的订单
        Orders orders = new Orders();
        orders.setCreatedate(new Date());
        orders.setMovieid(ticket.getMovieid());
        orders.setMoviename(ticket.getMoviename());
        orders.setSeat(ticket.getSeat());
        orders.setStatus("0");//只订票没有付钱
        ordersMapper.insertOrders(orders);

    }
    /**
     * 订单列表---按创建时间倒序排序
     */
    public List<Orders> listOrders(PageInfo pageInfo){

        int begin = (pageInfo.getCurPageNo()-1)*pageInfo.getPageSize();//limit参数
        int end=pageInfo.getPageSize();//limit参数
        return ordersMapper.queryByCreateDate(begin,end);
    }

    /**
     * 查询订单总记录数
     *
     */
    public int queryTotal(){
        return ordersMapper.queryTotal();
    }
}
