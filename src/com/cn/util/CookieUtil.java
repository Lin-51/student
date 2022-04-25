package com.cn.util;

import javax.servlet.http.Cookie;

public class CookieUtil {


    public static Cookie findCookie(Cookie[] cookies,String cookieName){

        if(cookies==null){

            return null;
        }

        for (Cookie cookie : cookies) {

            if(cookieName.equals(cookie.getName())){

                return cookie;

            }

        }

        return null;
    }


}
