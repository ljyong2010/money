package org.manage.controller;

import com.jfinal.core.Controller;
import org.manage.model.APPUSER;
import org.manage.model.Work;
import org.manage.util.JsonUtil;
import org.manage.util.Strings;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class WorkController extends Controller {
    public void index(){
        String index = this.getPara("pindex");
        render(index+".jsp");
    }
    public void workList(){
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Work.dao.getWorkList(paramsHash);
        renderJson(retMap);
    }
    public void getEmplay(){
        Map<String,String> paramsHash = JsonUtil.jToMap(this.getRequest());
        String id = paramsHash.get("ID");
        Work work = Work.dao.getEmplayInfo(id);
        renderJson(work);
    }
    public void emplaySave(){
        Map<String,Object> retMap = new HashMap<>();
        Work work = JsonUtil.JToJavaBean(this.getRequest(),Work.class);
        if (Strings.isNullOrEmpty(work.getID())){
            APPUSER appuser = getSessionAttr("Appuser");
            work.setID(UUID.randomUUID().toString().replaceAll("-",""));
            work.setUserId(appuser.getUSERID());
            if (work.save()){
                retMap.put("code",1);
                retMap.put("msg","");
            }else {
                retMap.put("code",-1);
                retMap.put("msg","fail");
            }
        }else {
            if (work.update()){
                retMap.put("code",1);
                retMap.put("msg","");
            }else {
                retMap.put("code",-1);
                retMap.put("msg","fail");
            }
        }
        renderJson(retMap);
    }
    public void delete(){
        Map<String,Object> retMap = new HashMap<>();
        Map<String,String> paramsHash = JsonUtil.jToMap(this.getRequest());
        String id = paramsHash.get("id");
        if (Work.dao.deleteById(id)){
            retMap.put("code",1);
            retMap.put("msg","");
        }else {
            retMap.put("code",-1);
            retMap.put("msg","fail");
        }
        renderJson(retMap);
    }
}
