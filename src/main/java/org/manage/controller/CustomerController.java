package org.manage.controller;

import com.jfinal.core.Controller;
import org.manage.model.APPUSER;
import org.manage.model.Customerinfo;
import org.manage.util.JsonUtil;
import org.manage.util.Strings;

import java.util.HashMap;
import java.util.Map;


public class CustomerController extends Controller {
    public void index(){
        String index = this.getPara("pindex");
        render(index+".jsp");
    }

    public void delete(){
        Map<String,String> paramMap=JsonUtil.jToMap(this.getRequest());
        String ID = null;
        if (paramMap.containsKey("ID")){
            ID=paramMap.get("ID");
        }
        Map<String,Object> retMap = Customerinfo.dao.deleteInfo(ID);
        renderJson(retMap);
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
        Map<String,String> params = JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = new HashMap<>();
        APPUSER appuser = getSessionAttr("Appuser");
        Customerinfo customerinfo = JsonUtil.mapToBean(params,Customerinfo.class);
        if (Strings.isNullOrEmpty(customerinfo.getID())){
            customerinfo.setID(JsonUtil.getUUID());
            customerinfo.setAssessorId(appuser.getUSERID());
            customerinfo.setAcualmoney(0.0);
            if (customerinfo.save()){
                retMap.put("code",1);
                retMap.put("msg","");
            }else {
                retMap.put("code",-1);
                retMap.put("msg","save fail");
            }
        }else {
            customerinfo.setAcualmoney(0.0);
            if (customerinfo.update()){
                retMap.put("code",1);
                retMap.put("msg","");
            }else {
                retMap.put("code",-1);
                retMap.put("msg","save fail");
            }
        }
        renderJson(retMap);
    }
    public void payMoneyInfo(){
        Map<String,String> params = JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = new HashMap<>();
        Customerinfo customerinfo = JsonUtil.mapToBean(params,Customerinfo.class);
        if (!Strings.isNullOrEmpty(customerinfo.getID())){
            if (customerinfo.update()){
                retMap.put("code",1);
                retMap.put("msg","");
            }else {
                retMap.put("code",-1);
                retMap.put("msg","save fail");
            }
        }
        renderJson(retMap);
    }
    public void paymentMoney(){
        Map<String,String> paramMap=JsonUtil.jToMap(this.getRequest());
        String ID = null;
        if (paramMap.containsKey("ID")){
            ID=paramMap.get("ID");
        }
        Map<String,Object> retMap = Customerinfo.dao.payFull(ID);
        renderJson(retMap);
    }
    public void GetCustomerInfo(){
        Map<String,String> paramMap=JsonUtil.jToMap(this.getRequest());
        String ID = null;
        if (paramMap.containsKey("ID")){
            ID=paramMap.get("ID");
        }
        Customerinfo customerinfo = Customerinfo.dao.getCustomerInfo(ID);
        renderJson(customerinfo);
    }
    public void customListHis(){
        APPUSER appuser = getSessionAttr("Appuser");
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.getHisCust(paramsHash,appuser);
        renderJson(retMap);
    }
    public void checkUserCard(){
        Map<String,String> paramMap=JsonUtil.jToMap(this.getRequest());
        String cart = paramMap.get("card");
        Map<String,Object> retMap = Customerinfo.dao.checkCart(cart);
        renderJson(retMap);
    }
}
