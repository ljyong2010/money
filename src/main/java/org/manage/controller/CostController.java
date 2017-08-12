package org.manage.controller;

import com.jfinal.core.Controller;
import org.manage.model.APPUSER;
import org.manage.model.Cost;
import org.manage.util.JsonUtil;
import org.manage.util.Strings;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class CostController extends Controller {
    public void index(){
        String index = this.getPara("pindex");
        render(index+".jsp");
    }

    public void costList(){
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Cost.dao.getCostList(paramsHash);
        renderJson(retMap);
    }
    public void delete(){

    }
    public void getCost(){
        Map<String,String> paramsHash = JsonUtil.jToMap(this.getRequest());
        String id = paramsHash.get("ID");
        Cost cost = Cost.dao.getCostInfo(id);
        renderJson(cost);
    }
    public void costSave(){
        Map<String,Object> retMap = new HashMap<>();
        Cost cost = JsonUtil.JToJavaBean(this.getRequest(),Cost.class);
        if (Strings.isNullOrEmpty(cost.getID())){
            APPUSER appuser = getSessionAttr("Appuser");
            cost.setID(UUID.randomUUID().toString().replaceAll("-",""));
            cost.setUserId(appuser.getUSERID());
            if (cost.save()){
                retMap.put("code",1);
                retMap.put("msg","");
            }else {
                retMap.put("code",-1);
                retMap.put("msg","fail");
            }
        }else {
            if (cost.update()){
                retMap.put("code",1);
                retMap.put("msg","");
            }else {
                retMap.put("code",-1);
                retMap.put("msg","fail");
            }
        }
        renderJson(retMap);
    }
}
