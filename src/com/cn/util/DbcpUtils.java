package com.cn.util;

import org.apache.commons.dbcp.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Properties;

public class DbcpUtils {
  public static  DataSource ds =null;

    static{

        Properties p =new Properties();

        try {
            p.load(DbcpUtils.class.getClassLoader().getResourceAsStream("dbcp.properties"));
            ds= BasicDataSourceFactory.createDataSource(p);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

}
