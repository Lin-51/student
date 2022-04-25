package com.cn.servlet;

import com.cn.entity.User;
import com.cn.service.UserService;
import com.cn.service.impl.UserServiceImpl;
import com.cn.util.Pager;
import com.cn.util.Result;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.UUID;

@WebServlet(name="userServlet",urlPatterns = {"/UserServlet"})
public class UserServlet extends BaseServlet{

    private UserService userService=new UserServiceImpl();



    public String queryByPage(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        String currentPage = request.getParameter("currentPage");
        Integer page=1;
        if(currentPage!=null){
            page=Integer.parseInt(currentPage);
        }


        String pc = request.getParameter("pageCount");
        Integer pageCount=10;
        if(pc!=null){
            pageCount=Integer.parseInt(pc);
        }
        String userName = request.getParameter("userName");
        String userGender = request.getParameter("userGender");

        Pager pager=userService.queryByPage(page,pageCount,userName,userGender);

        session.setAttribute("pager",pager);
        return "/html/userList.jsp";
    }




    public String deleteUserByUserId(HttpServletRequest request, HttpServletResponse response){
        String uid = request.getParameter("userId");
        int userId = Integer.parseInt(uid);
        userService.deleteUserByUserId(userId);
        return "/UserServlet?m=queryByPage";
    }


    public Result preRegister(HttpServletRequest request, HttpServletResponse response){

        String userName = request.getParameter("userName");

        Integer result=userService.preRegister(userName);
        if(result>0){
            return new Result("用户名已存在",0);
        }else{
            return new Result(1); //{message:"",status:200}
        }
    }

    public Result register(HttpServletRequest request, HttpServletResponse response){

        String userName = request.getParameter("userName");
        String userPass = request.getParameter("userPass");
        String userGender = request.getParameter("userGender");
        String userAge = request.getParameter("userAge");
        String userPhone = request.getParameter("userPhone");
        String userAddress = request.getParameter("userAddress");

        User user=new User(userName,userPass,userGender,userAge,userPhone,userAddress,null,null);
        Integer result =userService.register(user);

        if(result>0){
            return new Result(1); //{message:"",status:200}
        }else{
            return new Result(0); //{message:"",status:200}
        }
    }

    public String saveOrUpdate(HttpServletRequest request, HttpServletResponse response){
        String userId = request.getParameter("userId");
        String userName = request.getParameter("userName");
        String userPass = request.getParameter("userPass");
        String userGender = request.getParameter("userGender");
        String userAge = request.getParameter("userAge");
        String userPhone = request.getParameter("userPhone");
        String userAddress = request.getParameter("userAddress");
        System.out.println("userId"+userId);
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

        return "UserServlet?m=queryByPage";

    }


    public User queryByUserId(HttpServletRequest request, HttpServletResponse response){
        String userId = request.getParameter("userId");
        User user=userService.queryByUserId(Integer.parseInt(userId));
        return user;
    }



    public Result login(HttpServletRequest request, HttpServletResponse response){

        String userName = request.getParameter("userName");
        String userPass = request.getParameter("userPass");
        User user =userService.login(userName,userPass);

        if(user!=null){
            String autoLogin = request.getParameter("autoLogin");
            if("on".equals(autoLogin)){
                Cookie cookie =new Cookie("autoLogin",userName+"#"+userPass);
                cookie.setMaxAge(60*60*24*7);
                response.addCookie(cookie);
            }

            request.getSession().setAttribute("loginUser",user);
            return new Result(userName+",欢迎你！",1); //{message:"",status:200}

        }else{
            return new Result("当前未登录",0); //{message:"",status:200}
        }
    }

    public String loginOut(HttpServletRequest request, HttpServletResponse response){

            //清除session
            request.getSession().invalidate();

        return "/index.jsp";

    }


    public Result updateUserPass(HttpServletRequest request, HttpServletResponse response){
        String userId = request.getParameter("userId");
        String oldUserPass = request.getParameter("oldUserPass");
        String newUserPass = request.getParameter("newUserPass");
        Result result=userService.updateUserPass(userId,oldUserPass,newUserPass);
        return result;

    }

    public String updateUserPicture(HttpServletRequest request, HttpServletResponse response){

        String realPath = request.getServletContext().getRealPath("");
        System.out.println(realPath);
        File file =new File(realPath);
        String parent = file.getParent();
        System.out.println(parent);

        File uploadPath=new File(parent+File.separator+"upload");

        if(!uploadPath.exists()){
            uploadPath.mkdirs(); 
        }


        DiskFileItemFactory disk=new DiskFileItemFactory();

        ServletFileUpload replace =new ServletFileUpload(disk);
        Integer userId=null;
        String fileName=null;
        try {
            List<FileItem> items = replace.parseRequest(request);

            for (FileItem item:items) {

                if(item.isFormField()){
                        String uid = item.getString();
                        System.out.println(uid);
                     userId = Integer.parseInt(uid);
                }else{
                    String suff = item.getName().substring(item.getName().lastIndexOf("."));
                     fileName = UUID.randomUUID().toString() + suff;
                    String url=uploadPath+File.separator+fileName;
                    item.write(new File(url));
                }
                
            }

        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        User user=userService.updateUserPicture(userId,fileName);

        request.getSession().setAttribute("loginUser",user);

        return "/html/userList.jsp";

    }


}
