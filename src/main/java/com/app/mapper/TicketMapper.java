package com.app.mapper;


import com.app.entity.Ticket;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TicketMapper {
    /**
     * 根据电影id查询某个电影所有票
     */
    List<Ticket> queryTicketByMovieId(int id);

    /**
     * 插入电影票
     */
    int insertTicket(Ticket ticket);

    /**
     * 根据电影票id查询出对应的票
     */
    Ticket queryById(int id);

    /**
     * 动态sql
     * 改变occupy为售出座位
     *
     */
    int updateTicket(Ticket ticket);
}
