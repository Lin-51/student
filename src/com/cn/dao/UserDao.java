package com.cn.dao;

import com.cn.entity.User;

import java.util.List;

public interface UserDao {


    Integer preRegister(String userName);

    Integer register(User user);

    User login(String userName, String userPass);

    Integer updateUserPass(String userId, String newUserPass);

    Integer checkUserPass(String userId, String oldUserPass);

    void updateUserPicture(Integer userId, String fileName);

    User queryByUserId(Integer userId);

    Integer queryUserCount(String sql,List params);

    List<User> queryByPage(String sql,List params);

    void deleteUserByUserId(int userId);

    Integer updateUser(User user);
}
