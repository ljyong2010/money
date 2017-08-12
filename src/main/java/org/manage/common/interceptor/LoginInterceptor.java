package org.manage.common.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

/**
 * Created by Administrator on 2017-7-25.
 */
public class LoginInterceptor implements Interceptor {
    @Override
    public void intercept(Invocation inv) {
        Controller controller = inv.getController();
        //判断登录条件是否成立(除了登录功能不拦截之外，其他都拦截)
        if(controller.getSessionAttr("Appuser") == null){
            controller.redirect("/tlogin");
        }else{
            inv.invoke();
        }
    }
}
