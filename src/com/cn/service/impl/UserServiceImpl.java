package com.cn.service.impl;

import com.cn.dao.UserDao;
import com.cn.dao.impl.UserDaoImpl;
import com.cn.entity.User;
import com.cn.service.UserService;
import com.cn.util.Pager;
import com.cn.util.Result;
import org.apache.commons.codec.digest.DigestUtils;

import java.util.ArrayList;
import java.util.List;

public class UserServiceImpl implements UserService {

    private UserDao userDao =new UserDaoImpl();

    @Override
    public Integer preRegister(String userName) {
        Integer count=  this.userDao.preRegister(userName);
        return count;
    }

    @Override
    public Integer register(User user) {

        user.setUserPass((DigestUtils.md5Hex(user.getUserPass())));
        user.setUserPicture("defaultImg.jpg");
        user.setUserType(0);
        return userDao.register(user);
    }

    @Override
    public User login(String userName, String userPass) {
        userPass= DigestUtils.md5Hex(userPass);
        User user =userDao.login(userName,userPass);

        return user;
    }

    @Override
    public Result updateUserPass(String userId, String oldUserPass, String newUserPass) {
        oldUserPass= DigestUtils.md5Hex(oldUserPass);
        newUserPass= DigestUtils.md5Hex(newUserPass);
         Integer count=userDao.checkUserPass(userId,oldUserPass);
         if(count>0){
             Integer result=userDao.updateUserPass(userId,newUserPass);
             if(result>0){
                 return new Result("修改密码成功",1);
             }else{
                 return new Result("修改密码失败",2);
             }
         }else{
             return new Result("原密码不正确",0);
         }


    }

    @Override
    public User updateUserPicture(Integer userId, String fileName) {
        //修改头像
         userDao.updateUserPicture(userId,fileName);

         //根据id查询用户

         User user =userDao.queryByUserId(userId);

        return user;
    }

    @Override
    public Pager queryByPage(Integer page, Integer pageCount,String userName,String userGender) {
        Pager pager=new Pager();

        String sql="select * from user where 1=1";
        String queryCountsql ="select count(1) from user where 1=1";
        List params=new ArrayList<Object>();

        List queryCountparams=new ArrayList<Object>();
        if(userName!=null&&!userName.equals("")){
            sql=sql+" and userName like ?";
            queryCountsql=queryCountsql+" and userName like ?";
            params.add("%"+userName+"%");
            queryCountparams.add("%"+userName+"%");
        }

        if(!"".equals(userGender)&&userGender!=null){
            sql=sql+" and userGender=?";
            queryCountsql=queryCountsql+" and userGender=?";
            params.add(userGender);
            queryCountparams.add(userGender);

        }


        //获取总条数
        Integer total=userDao.queryUserCount(queryCountsql,queryCountparams);
        //每页显示的条数 pageCount;
        // 16   5    4
        // 15   5    3
       Integer pageSize=total%pageCount==0?(total/pageCount):(total/pageCount)+1;

       //设置当前页
        pager.setCurrentPage(page);

        //设置总页数
        pager.setPageSize(pageSize);

        //设置总条数
        pager.setTotal(total);

        pager.setPageCount(pageCount);

        //数据集合

        // 第1页 select * from user limit 5 offset 0;
        // (1-1)* 5
        // 第2页 select * from user limit 5 offset 5;
        // (2-1)* 5
        // 第3页 select * from user limit 5 offset 10;
        //(3-1)* 5



        sql=sql+" limit ? offset ?";
        params.add(pageCount);
        params.add((page-1)*pageCount);

        List<User> users=userDao.queryByPage( sql, params);

        pager.setUsers(users);

        if(userName==null){
            pager.setSearchUserName("");
        }else{
            pager.setSearchUserName(userName);
        }
        if(userGender==null||"".equals(userGender)){
            pager.setSearchUserGender("");
        }else{
            pager.setSearchUserGender(userGender);
        }

        return pager;
    }

    @Override
    public void deleteUserByUserId(int userId) {
        userDao.deleteUserByUserId(userId);
    }

    @Override
    public Integer update(User user) {
        //id,userName,userGender,userAge,userPhone,userAddress



        return userDao.updateUser(user);
    }

    @Override
    public User queryByUserId(int userId) {
        return userDao.queryByUserId(userId);
    }


}
