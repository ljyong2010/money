package org.manage.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import org.manage.model.APPMENU;
import org.manage.util.JsonUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017-7-28.
 */
public class MenuController extends Controller {
    public void index(){
        String index = this.getPara("pindex");
        render(index+".jsp");
    }

    public void APPMENUDelete(){
        Map<String,Object> retMap=new HashMap<String, Object>();
        APPMENU appmenu=JsonUtil.JToJavaBean(this.getRequest(),APPMENU.class);
        if (appmenu.getMENUID()!=null){
            boolean flag=APPMENU.dao.deleteById(appmenu.getMENUID());
            if (flag){
                retMap.put("code",1);
            }else {
                retMap.put("code",-1);
                retMap.put("msg","delete fail");
            }
        }
        renderJson(retMap);
    }
    public void AppMenuSave(){
        HashMap<String,Object> retMap=new HashMap<String, Object>();
        APPMENU appmenu=JsonUtil.JToJavaBean(this.getRequest(),APPMENU.class);

        if (appmenu.getMENUID()==null){
            appmenu.remove("MENUID");
            if (appmenu.save()){
                retMap.put("code",1);
            }else{
                retMap.put("code",-1);
                retMap.put("msg","save fail");
            }
        }else {
            if (appmenu.update()){
                retMap.put("code",1);
            }else{
                retMap.put("code",-1);
                retMap.put("msg","update fail");
            }
        }
        renderJson(retMap);
    }
    public void GetMenuList(){
        List<HashMap<String,Object>> list=new ArrayList<HashMap<String, Object>>();

        Map<String,Object> requestParams= JsonUtil.paramsToMap(this.getRequest());
        String parentID=null;
        String menuID=null;
        if (requestParams.containsKey("id")){
            parentID=requestParams.get("id").toString();
        }
        if (requestParams.containsKey("rootid")){
            menuID=requestParams.get("rootid").toString();
        }
        List<APPMENU> appmenuList=APPMENU.dao.getList(parentID,menuID);
        for (int i=0;i<appmenuList.size();i++){
            HashMap<String,Object> hm = new HashMap<String, Object>();
            hm.put("halfCheck",false);
            hm.put("id",appmenuList.get(i).getMENUID().toString());
//            hm.put("isParent",Integer.parseInt(appmenuList.get(i).getPARENTID().toString())==0);
            hm.put("isParent",isParent(appmenuList.get(i).getMENUID().toString(),appmenuList.get(i).getPARENTID().toString()));
            hm.put("name",appmenuList.get(i).getMENUNAME());
            hm.put("pId",appmenuList.get(i).getPARENTID().toString());
            hm.put("sid",null);
            list.add(hm);
        }

        renderJson(list);
    }
    private boolean isParent(String id, String parentId) {
        if(Integer.valueOf(parentId)==0)
            return true;
        int count= Db.queryInt("select count(1) from dbo.APPMENU where parentid=?",id);
        if(count>0){
            return true;
        }
        return false;
    }
    public void GetAPPMENU(){
        Map<String,String> params=JsonUtil.jToMap(this.getRequest());
        APPMENU appmenu=APPMENU.dao.getMenu(params.get("MENUID"));
        renderJson(appmenu);
    }
}
