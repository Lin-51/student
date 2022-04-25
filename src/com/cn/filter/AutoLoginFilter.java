package com.cn.filter;

import com.cn.entity.User;
import com.cn.service.UserService;
import com.cn.service.impl.UserServiceImpl;
import com.cn.util.CookieUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "AutoLoginFilter",urlPatterns = {"/html/*"})

public class AutoLoginFilter implements Filter {

    UserService userService =new UserServiceImpl();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request=(HttpServletRequest) servletRequest;
        HttpServletResponse response=(HttpServletResponse) servletResponse;

        Object loginUser = request.getSession().getAttribute("loginUser");

        if(loginUser!=null){
            filterChain.doFilter(request,response);
        }else{

            Cookie[] cookies = request.getCookies();
            Cookie cookie = CookieUtil.findCookie(cookies, "autoLogin");

            if(cookie!=null){
                String userName = cookie.getValue().split("#")[0];
                String userPass = cookie.getValue().split("#")[1];

                User login = userService.login(userName, userPass);

                if(login!=null){
                    request.getSession().setAttribute("loginUser",login);

                    filterChain.doFilter(request,response);
                }else{

                    response.sendRedirect("/index.jsp");
                }

            }else{
                response.sendRedirect("/index.jsp");
            }

        }


    }

    @Override
    public void destroy() {

    }
}
