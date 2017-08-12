package org.manage.controller;

import com.jfinal.core.Controller;
import org.manage.model.APPUSER;
import org.manage.model.Customerinfo;
import org.manage.util.JsonUtil;

import java.util.Map;


public class CustomerController extends Controller {
    public void index(){
        String index = this.getPara("pindex");
        render(index+".jsp");
    }

    public void delete(){

    }
    public void customList(){
        APPUSER appuser = getSessionAttr("Appuser");
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.getCustomList(paramsHash,appuser);
        renderJson(retMap);
    }
    public void yqcustomList(){
        APPUSER appuser = getSessionAttr("Appuser");
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.getYqCustomList(paramsHash,appuser);
        renderJson(retMap);
    }
    public void saveCustomInfo(){

    }
}
