package org.manage.controller;

import com.jfinal.core.Controller;
import org.manage.model.APPUSER;
import org.manage.model.Customerinfo;
import org.manage.util.JsonUtil;

import java.util.List;
import java.util.Map;

public class AssessorController extends Controller {

    public void index(){
        String index = this.getPara("pindex");
        render(index+".jsp");
    }

    public void userName(){
        List<APPUSER> list = APPUSER.dao.getLName();
        setAttr("data",list);
        renderJson();
    }
    public void assessorList(){
        APPUSER appuser = getSessionAttr("Appuser");
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.getAssload(paramsHash,appuser);
        renderJson(retMap);
    }
    public void overdueMenoy(){
        APPUSER appuser = getSessionAttr("Appuser");
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.getOverdue(paramsHash,appuser);
        renderJson(retMap);
    }
    public void overShowMenoy(){
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.getOverShow(paramsHash);
        renderJson(retMap);
    }
    public void salaryInfo(){
        APPUSER appuser = getSessionAttr("Appuser");
        Map<String,String> paramsHash = JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.getSalary(paramsHash,appuser);
        renderJson(retMap);
    }
    public void salaryShowMenoy(){
        Map<String,String> paramsHash = JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.salaryShow(paramsHash);
        renderJson(retMap);
    }
    public void totalInfo(){
        APPUSER appuser = getSessionAttr("Appuser");
        Map<String,String> paramsHash = JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.gettotal(paramsHash,appuser);
        renderJson(retMap);
    }
    public void total(){
        APPUSER appuser = getSessionAttr("Appuser");
        Map<String,String> paramsHash = JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.zTotal(paramsHash,appuser);
        renderJson(retMap);
    }
}
