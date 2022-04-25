package com.cn.service;

import com.cn.entity.User;
import com.cn.util.Pager;
import com.cn.util.Result;

public interface UserService {
    Integer preRegister(String userName);

    Integer register(User user);

    User login(String userName, String userPass);

    Result updateUserPass(String userId, String oldUserPass, String newUserPass);

    User updateUserPicture(Integer userId, String fileName);

    Pager queryByPage(Integer page, Integer pageCount,String UserName,String userGender);

    void deleteUserByUserId(int userId);

    Integer update(User user);

    User queryByUserId(int parseInt);
}
