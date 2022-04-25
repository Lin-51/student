package com.cn.util;

import com.cn.entity.User;

public class Result {

    private String message;

    private Integer status;





    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Result(String message, Integer status) {
        this.message = message;
        this.status = status;
    }
    public Result(String message) {
        this.message = message;
    }

    public Result(Integer status) {
        this.status = status;
    }
    public Result() {

    }
}
