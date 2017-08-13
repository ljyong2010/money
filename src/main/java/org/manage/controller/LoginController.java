package org.manage.controller;

import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import org.manage.common.interceptor.LoginInterceptor;
import org.manage.model.APPUSER;
import org.manage.model.AppuserRole;

import java.util.HashMap;

/**
 * Created by Administrator on 2017-7-25.
 */
public class LoginController extends Controller {
    private static final String FORM_ITEM_CODE = "CheckCode";
    @Clear(LoginInterceptor.class)
    public void index(){
        if (getSessionAttr("Appuser")!=null){
            redirect("/index");
        }else {
            render("login.jsp");
        }
    }
    @Clear(LoginInterceptor.class)
    public void login(){
        HashMap<String,Object> retMap=new HashMap<String, Object>();
        String homepage=null;
        try {
            String username=getPara("LOGINNAME");
            String password=getPara("PASSWORD");
            homepage = "index.jsp";
            APPUSER appuser=APPUSER.dao.checkLogin(username,password);
            if (appuser==null){
                throw new Exception("用户名或密码不正确，请重新登录");
            }else {
                AppuserRole role=AppuserRole.dao.checkRole(appuser.getUSERID());
                setSessionAttr("Appuser",appuser);
                setSessionAttr("Role",role);
                retMap.put("code",1);
                retMap.put("msg",homepage);
            }
        }catch (Exception e){
            retMap.put("code",0);
            retMap.put("msg",e.getMessage());
        }
        renderJson(retMap);
    }
    @Clear(LoginInterceptor.class)
    public void code(){
        renderCaptcha();
    }
    public void logout(){
        removeSessionAttr("Appuser");
        removeSessionAttr("Role");
        redirect("/tlogin");
    }
    public void personInfo(){

    }
    public void changePassword(){

    }
}
