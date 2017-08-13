package org.manage.common;

import com.jfinal.config.Routes;
import org.manage.controller.*;

/**
 * Created by Administrator on 2017-7-26.
 */
public class AdminRoutes extends Routes{
    @Override
    public void config() {
        setBaseViewPath("/jsps");
        add("/tuser", AdminController.class,"/admin");
        add("/tmenu", MenuController.class,"/admin");
        add("/trole", RoleController.class,"/admin");
        add("/tcust", CustomerController.class,"/cust");
        add("/twork", WorkController.class,"/work");
        add("/tcost",CostController.class,"/cost");
        add("/assessor",AssessorController.class,"/assessor");
    }
}
