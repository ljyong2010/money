package org.manage.util;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Page;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017-7-28.
 */
public class Pager {
    private int pageIndex = 1;
    private int pageSize = 10;
    private int sEcho;

    public void setPageIndex(int num) {
        this.pageIndex = num;
    }

    public int getPageIndex() {
        return this.pageIndex;
    }

    public void setPageSize(int num) {
        this.pageSize = num;
    }

    public int getPageSize() {
        return this.pageSize;
    }

    public void setSEcho(int sEcho) {
        this.sEcho = sEcho;
    }

    public boolean IsNeedPaging() {
        return this.pageIndex >= 0 && this.pageSize > 0;
    }

    /* 获取分页映射表 */
    public <T> Map<String, Object> getMap(Page<T> list) {
        Map<String, Object> retMap = Maps.newHashMap();
        retMap.put("sEcho", this.sEcho);
        retMap.put("iTotalRecords", list.getTotalRow());
        retMap.put("iTotalDisplayRecords", list.getTotalRow());
        retMap.put("data", list.getList());
        return retMap;
    }

    /* 读取参数中的分页信息 */
    public static Pager Render(Map<String, String> params) {
        Pager pager = new Pager();
        if (!Strings.isNullOrEmpty(params.get("numbers"))) {
            pager.setPageIndex(Integer.parseInt(params.get("numbers")));
        } else if (!Strings.isNullOrEmpty(params.get("PageIndex"))) {
            pager.setPageIndex(Integer.parseInt(params.get("PageIndex")));
        }
        if (!Strings.isNullOrEmpty(params.get("iDisplayLength"))) {
            pager.setPageSize(Integer.parseInt(params.get("iDisplayLength")));
        } else if (!Strings.isNullOrEmpty(params.get("PageSize"))) {
            pager.setPageSize(Integer.parseInt(params.get("PageSize")));
        }
        if (!Strings.isNullOrEmpty(params.get("sEcho")))
            pager.setSEcho(Integer.parseInt(params.get("sEcho")));
        return pager;
    }

    /* 获取分页映射表 */
    public static <T> Map<String, Object> PageMap(Map<String, String> params, Page<T> list) {
        Map<String, Object> retMap = Maps.newHashMap();
        retMap.put("sEcho", Integer.parseInt(params.get("sEcho")));
        /*retMap.put("sEcho", params.get("sEcho"));*/
        retMap.put("iTotalRecords", list.getTotalRow());
        retMap.put("iTotalDisplayRecords", list.getTotalRow());
        retMap.put("data", list.getList());
        return retMap;
    }

    public static HashMap<String, Object> returnMsg(int code) {
        return returnMsg(code,"");
    }
    public static HashMap<String, Object> returnMsg(int code, String msg) {
        HashMap<String, Object> retMap = new HashMap<String, Object>();
        retMap.put("code", code);
        retMap.put("msg", msg);
        return retMap;
    }
}
