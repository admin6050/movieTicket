package com.app.util;

/**
 * describe
 * 应该在util包下建立一个PageInfo类
 * PageInfo 在实际开发不会让我们写，大家会复制即可，不需要浪费时间
 * 主要把 CURD全部搞清楚了
 * 总页数
 * 每页显示多少条数据
 * 记录总数
 * 当前页
 *
 */
public class PageInfo {


    private  int totalPageCount;// 总页数
    private  int pageSize=5;//每页显示多少条数据  默认显示3条，可以修改
    private  int totalCount;// 记录总数
    private  int curPageNo=1; //当前页 默认设置为1



    public int getTotalPageCount() {
        return totalPageCount;
    }

    public void setTotalPageCount(int totalPageCount) {
        this.totalPageCount = totalPageCount;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalCount() {
        return totalCount;
    }


    /**
     *
     * @param totalCount 记录总数
     */
    public void setTotalCount(int totalCount) {
        //设置总页数
        if(totalCount>0){
            this.totalCount = totalCount;
            //totalCount总条数   pageSize每页显示多条少条
            if(totalCount%pageSize==0){
               // totalPageCount;// 总页数
                totalPageCount=totalCount/pageSize;
            }else {
                totalPageCount=totalCount/pageSize+1;
            }
        }


    }

    public int getCurPageNo() {
        return curPageNo;
    }

    public void setCurPageNo(int curPageNo) {
        this.curPageNo = curPageNo;
    }
}
