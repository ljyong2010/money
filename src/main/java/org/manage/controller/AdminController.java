package org.manage.controller;


import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;
import org.manage.model.*;
import org.manage.util.JsonUtil;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017-7-28.
 */
public class AdminController extends Controller {

    public void index(){
        String index = this.getPara("pindex");
        render(index+".jsp");
    }
    public void UserList(){
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = APPUSER.dao.getUserList(paramsHash);
        renderJson(retMap);

    }
    public void AppUserTypeList(){
        List<APPUSERTYPE> appusertypeList= APPUSERTYPE.dao.getList();
        setAttr("data",appusertypeList);
        renderJson();
    }
    public void UserDelete(){
        renderJson();
    }
    public void AppRoleList(){
        List<APPROLE> approleList= APPROLE.dao.getAppRoleList();
        setAttr("data",approleList);
        renderJson();
    }
    public void GetUserRole(){
        StringBuffer sb = new StringBuffer();
        Map<String,String> paramMap= JsonUtil.jToMap(this.getRequest());
        String userid=paramMap.get("USERID");
        List<AppuserRole> appuserRoleList=AppuserRole.dao.getAppuserRoleList(userid);
        boolean flag=false;
        for (AppuserRole appuserRole:appuserRoleList){
            if (flag){
                sb.append(",");
            }else {
                flag=true;
            }
            sb.append(appuserRole.getROLEID());
        }
        setAttr("data",sb.toString());
        renderJson();
    }
    public void UserRoleSave(){
        Map<String,String> map=new HashMap<String, String>();
        Map<String,Object> retMap=new HashMap<>();
        map=JsonUtil.jToMap(this.getRequest());
        String mapList=null;
        String userID=null;
        if (map.containsKey("MAP")){
            mapList=map.get("MAP");
        }
        if (map.containsKey("USERID")){
            userID=map.get("USERID");
        }
        retMap=AppuserRole.dao.updateRole(mapList,userID);
        renderJson(retMap);
    }
    public void UserSave(){

    }
    public void GetUser(){
        Map<String,String> paramMap=JsonUtil.jToMap(this.getRequest());
        String userID=paramMap.get("USERID");
        APPUSER appuser=APPUSER.dao.getUser(userID);
        renderJson(appuser);
    }
    public void APPUSERINFOList(){
        Map<String,String> paramsHash=JsonUtil.jsonNameToMap(this.getRequest());
        int uid = ((APPUSER)getSessionAttr("Appuser")).getUSERTYPEID();
        Map<String,Object> retMap = APPUSERINFO.dao.getList(paramsHash,uid);
        renderJson(retMap);
    }
    public void AppuserStopUse(){
        Map<String,String> paramMap=JsonUtil.jToMap(this.getRequest());
        String userid=paramMap.get("USERID");
        Map<String,Object> retMap=APPUSER.dao.stopUser(userid);
        renderJson(retMap);
    }
    public void APPUSERINFOSave_add(){
        Map<String,String> params=JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap=new HashMap();
        APPUSER appuser=getSessionAttr("Appuser");
        String loginName="";
        String passWord="";
        String userID="";
        Integer sex=null;
        String address="";
        String tel="";
        String email="";
        String name="";
        if (params.containsKey("LOGINNAME")){
            loginName=params.get("LOGINNAME");
        }
        if (params.containsKey("PASSWORD")){
            passWord=params.get("PASSWORD");
        }
        if (params.containsKey("USERID")){
            userID=params.get("USERID");
        }
        if (params.containsKey("SEX")){
            sex=Integer.parseInt(params.get("SEX"));
        }
        if (params.containsKey("ADDRESS")){
            address=params.get("ADDRESS");
        }
        if (params.containsKey("TEL")){
            tel=params.get("TEL");
        }
        if (params.containsKey("EMAIL")){
            email=params.get("EMAIL");
        }
        if (params.containsKey("NAME")){
            name=params.get("NAME");
        }
        retMap=APPUSER.dao.saveUserAndInfo_e(appuser,loginName,passWord,userID,sex,address,tel,email,name);
        renderJson(retMap);
    }
    public void loginCheck(){
        Map<String,String> paramMap=JsonUtil.jToMap(this.getRequest());
        String loginName=null;
        if (paramMap.containsKey("loginname")){
            loginName=paramMap.get("loginname");
        }
        int count=APPUSER.dao.loginCheck((APPUSER)getSessionAttr("Appuser"),loginName);
        renderJson(count);
    }
    public void GetAPPUSERINFO1(){
        Map<String,String> paramMap=JsonUtil.jToMap(this.getRequest());
        String userID=null;
        if (paramMap.containsKey("USERID")){
            userID=paramMap.get("USERID");
        }
        Record record=APPUSERINFO.dao.getAppUserInfo1(userID);
        renderJson(record);
    }
    public void APPUSERINFOList_e(){
        Map<String,String> paramsHash=JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = APPUSERINFO.dao.getList_e(paramsHash);
        renderJson(retMap);
    }
    public void resetPassword(){
        Map<String,String> paramsHash = JsonUtil.jToMap(this.getRequest());
        String userId = paramsHash.get("USERID");
        Map<String,Object> retMap =APPUSER.dao.resetPw(userId);
        renderJson(retMap);
    }
}
