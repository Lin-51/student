package com.cn.util;

import com.cn.entity.User;

import java.util.List;

public class EasyUIResult {

    private Integer total;

    private List<User> rows;

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<User> getRows() {
        return rows;
    }

    public void setRows(List<User> rows) {
        this.rows = rows;
    }
}
