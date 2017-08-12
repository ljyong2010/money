package org.manage.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import org.manage.model.APPUSER;

import java.util.List;

/**
 * Created by Administrator on 2017-7-25.
 */
public class IndexController extends Controller {
    public void index(){
        APPUSER appuser = getSessionAttr("Appuser");
        setAttr("appuser", appuser);
        List<Record> rId = Db.find("select * from APPMENU C where C.PARENTID=0 AND C.ISHIDE=0 AND C.DELFLAG=0 AND C.MENUID IN (SELECT A.MENUID FROM APPROLE_MENU A  WHERE A.ROLEID IN (select B.ROLEID from APPUSER_ROLE B where B.USERID=?)) order by C.MENUSORT", appuser.getUSERID());
        StringBuffer sbPage = new StringBuffer();
        for (Record rc : rId) {
            List<Record> clId = Db.find("select * from APPMENU C where C.PARENTID=? AND C.ISHIDE=0 AND C.DELFLAG=0 AND C.MENUID IN (SELECT A.MENUID FROM APPROLE_MENU A  WHERE A.ROLEID IN (select B.ROLEID from APPUSER_ROLE B where B.USERID=?)) order by C.MENUSORT", rc.get("MENUID"), appuser.getUSERID());
            String murl = rc.get("MENUURL");
            if (murl.equals("javascript:void(0);"))
                murl = "#";
            if (clId.size() == 0) {
                sbPage.append("<li id=\"menu-" + rc.get("MENUID") + "\">" + "<a href=\"" + murl + "\">" + "<i class=\"");
                String icon = null;
                if (rc.get("MENUICON").toString().trim() == null || rc.get("MENUICON").toString().trim().equals("")) {
                    icon = "";
                } else {
                    icon = rc.get("MENUICON").toString();
                }
                sbPage.append(icon + "\"></i>" + rc.get("MENUNAME") + "</a>");
                sbPage.append("\n");
            } else {
                sbPage.append("<li id=\"menu-" + rc.get("MENUID") + "\">");
                sbPage.append("\n");
                sbPage.append("<a href=\"" + murl + "\"><i class=\"");
                String icon = null;
                if (rc.get("MENUICON").toString().trim() == null || rc.get("MENUICON").toString().trim().equals("")) {
                    icon = "";
                } else {
                    icon = rc.get("MENUICON").toString();
                }
                sbPage.append(icon + "\"></i>" + rc.get("MENUNAME") + "</a>");
                sbPage.append("\n");
                sbPage.append("<ul class=\"tagx\">");
                sbPage.append("\n");
                for (Record crc : clId) {
                    List<Record> clIdT = Db.find("select * from APPMENU C where C.PARENTID=? AND C.ISHIDE=0 AND C.DELFLAG=0 AND C.MENUID IN (SELECT A.MENUID FROM APPROLE_MENU A WHERE A.ROLEID IN (select B.ROLEID from APPUSER_ROLE B where B.USERID=?)) order by C.MENUSORT", crc.get("MENUID"), appuser.getUSERID());
                    String murlT = crc.get("MENUURL");
                    if (murlT.equals("javascript:void(0);"))
                        murlT = "#";
                    if (clIdT.size() == 0) {
                        sbPage.append("<li id=\"menu-" + crc.get("MENUID") + "\"><a href=\"" + crc.get("MENUURL") + "\"><i class=\"");
                        sbPage.append("\"></i>" + crc.get("MENUNAME") + "</a></li>");
                        sbPage.append("\n");
                    } else {
                        sbPage.append("<li id=\"menu-" + crc.get("MENUID") + "\">");
                        sbPage.append("\n");
                        sbPage.append("<a href=\"" + murlT + "\"><i class=\"");
                        sbPage.append("\"></i>" + crc.get("MENUNAME") + "</a>");
                        sbPage.append("\n");
                        sbPage.append("<ul class=\"tagx\">");
                        sbPage.append("\n");
                        for(Record crcT:clIdT){
                            sbPage.append("<li id=\"menu-" + crcT.get("MENUID") + "\"><a href=\"" + crcT.get("MENUURL") + "\"><i class=\"");
                            sbPage.append("\"></i>" + crcT.get("MENUNAME") + "</a></li>");
                            sbPage.append("\n");
                        }
                        sbPage.append("</ul>");
                        sbPage.append("\n");
                        sbPage.append("</li>");
                    }
                }
                sbPage.append("</ul>");
                sbPage.append("\n");
                sbPage.append("</li>");
            }
            setAttr("sbPage", sbPage.toString());
            render("index.jsp");
        }
    }

    public void consoleShow() {
        render("Console.jsp");
    }
}
