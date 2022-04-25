package com.cn.util;

import com.cn.entity.User;

import java.util.List;

public class Pager {


     private  List<User> users; //所有的数据
     private Integer total ;//总条数
     private Integer  currentPage;// 当前页
    private   Integer pageCount ; //每页显示条数
     private Integer pageSize; //总页数

    private String searchUserName;
    private String searchUserGender;


    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }


    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getPageCount() {
        return pageCount;
    }

    public void setPageCount(Integer pageCount) {
        this.pageCount = pageCount;
    }

    public String getSearchUserName() {
        return searchUserName;
    }

    public void setSearchUserName(String searchUserName) {
        this.searchUserName = searchUserName;
    }

    public String getSearchUserGender() {
        return searchUserGender;
    }

    public void setSearchUserGender(String searchUserGender) {
        this.searchUserGender = searchUserGender;
    }
}



