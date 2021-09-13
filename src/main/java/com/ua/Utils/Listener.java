package com.ua.Utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class Listener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        if (sce.getServletContext().getRequestCharacterEncoding()==null) {
            sce.getServletContext().setRequestCharacterEncoding("UTF-8");
        }
    }
}
