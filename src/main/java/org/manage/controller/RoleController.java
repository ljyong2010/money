package org.manage.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import org.manage.model.APPMENU;
import org.manage.model.APPROLE;
import org.manage.model.ApproleMenu;
import org.manage.util.JsonUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017-7-28.
 */
public class RoleController extends Controller {
    public void index(){
        String index = this.getPara("pindex");
        render(index+".jsp");
    }

    public void APPROLEList(){
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        Map<String,Object> retMap = APPROLE.dao.getListPage(paramsHash);
        renderJson(retMap);
    }
    public void AppRoleDelete(){
        Map<String,String> paramMap=JsonUtil.jsonToMap(this.getRequest());
        String roleID=paramMap.get("ROLEID");
        Map<String,Object> retMap=APPROLE.dao.roleDelete(roleID);
        renderJson(retMap);
    }
    public void AppRoleSave(){
        Map<String,Object> retMap=new HashMap<String, Object>();
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        String roleID=paramsHash.get("ROLEID");
        String roleName=paramsHash.get("ROlENAME");
        retMap=APPROLE.dao.roleSave(roleID,roleName);
        renderJson(retMap);
    }
    public void GetAPPROLE(){
        Map<String,String> paramMap=JsonUtil.jToMap(this.getRequest());
        String roleID=paramMap.get("ROLEID");
        APPROLE approle=APPROLE.dao.getRole(roleID);
        renderJson(approle);
    }
    public void APPMENUList(){
        List<HashMap<String,Object>> list=new ArrayList<HashMap<String, Object>>();
        List<APPMENU> appmenuList=APPMENU.dao.getListTree();
        for (int i=0;i<appmenuList.size();i++){
            HashMap<String,Object> hm = new HashMap<String, Object>();
            hm.put("MENUID",appmenuList.get(i).getMENUID().toString());
            hm.put("PARENTID",appmenuList.get(i).getPARENTID().toString());
            hm.put("MENUNAME",appmenuList.get(i).getMENUNAME());
            list.add(hm);
        }
        setAttr("data",list);
        renderJson();
    }
    public void AppRoleMenuList(){
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        String roleID="";
        if (paramsHash.containsKey("ROLEID")){
            roleID=paramsHash.get("ROLEID");
        }
        List<ApproleMenu> approleMenus=ApproleMenu.dao.getRoleList(roleID);
        List<BigDecimal> integerList=new ArrayList<BigDecimal>();
        for(ApproleMenu approleMenu:approleMenus){
            integerList.add(approleMenu.getMENUID());
        }
        renderJson(integerList);
    }
    public void AppRoleMenuSave(){
        Map<String,String> paramsHash= JsonUtil.jsonNameToMap(this.getRequest());
        String roleID=paramsHash.get("ROLEID");
        String menuID=paramsHash.get("MENUID");
        Map<String,Object> retMap=ApproleMenu.dao.roleSave(roleID,menuID);
        renderJson(retMap);
    }
}
