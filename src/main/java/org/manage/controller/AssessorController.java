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
        renderJson(list);
    }
    public void assessorList(){
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = Customerinfo.dao.getAssload(paramsHash);
        renderJson(retMap);
    }
}
