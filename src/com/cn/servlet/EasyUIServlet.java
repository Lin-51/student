package com.cn.servlet;

import com.cn.entity.User;
import com.cn.service.UserService;
import com.cn.service.impl.UserServiceImpl;
import com.cn.util.EasyUIResult;
import com.cn.util.Pager;
import com.cn.util.Result;
import com.sun.media.sound.EmergencySoundbank;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/easyui")
public class EasyUIServlet extends BaseServlet {

    UserService userService =new UserServiceImpl();

    public EasyUIResult queryByPage(HttpServletRequest request, HttpServletResponse response){


        //需要接收前台传递的当前页和显示条数
        String p = request.getParameter("page");
        String r = request.getParameter("rows");
        Integer page= Integer.parseInt(p);
        Integer rows= Integer.parseInt(r);

        System.out.println(page);
        System.out.println(rows);

        String userName = request.getParameter("userName");
        String userGender = request.getParameter("userGender");

        Pager pager=userService.queryByPage(page,rows,userName,userGender);

        EasyUIResult easyUIResult =new EasyUIResult();
        easyUIResult.setTotal(pager.getTotal());
        easyUIResult.setRows(pager.getUsers());

        return easyUIResult;
    }

    public Result deleteByUserId(HttpServletRequest request, HttpServletResponse response){


        //需要接收前台传递的当前页和显示条数
        String id = request.getParameter("userId");
        Integer userId= Integer.parseInt(id);

        userService.deleteUserByUserId(userId);

        Result result =new Result();
        result.setStatus(1);

        return result;
    }

    public User queryUserById(HttpServletRequest request, HttpServletResponse response){


        //需要接收前台传递的当前页和显示条数
        String id = request.getParameter("userId");
        Integer userId= Integer.parseInt(id);

        User user = userService.queryByUserId(userId);

        return user;
    }

    public Result saveOrUpdate(HttpServletRequest request, HttpServletResponse response){
        String userId = request.getParameter("userId");
        String userName = request.getParameter("userName");
        String userPass = request.getParameter("userPass");
        String userGender = request.getParameter("userGender");
        String userAge = request.getParameter("userAge");
        String userPhone = request.getParameter("userPhone");
        String userAddress = request.getParameter("userAddress");
        System.out.println("userId"+userId);
        System.out.println("userName"+userName);

        if(userId==null||"".equals(userId)){
            //做保存
            User user=new User(userName,userPass,userGender,userAge,userPhone,userAddress,null,null);
            Integer result =userService.register(user);

            System.out.println("保存"+user);
        }else{
            //更新
            Integer id=Integer.parseInt(userId);
            //做保存
            User user=new User(id,userName,userGender,userAge,userPhone,userAddress);
            System.out.println(user);
            Integer result =userService.update(user);
        }

        return new Result(1);

    }

}
