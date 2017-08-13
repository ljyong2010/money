package org.manage.controller;

import com.jfinal.core.Controller;
import org.manage.model.APPUSER;

import java.util.List;

public class AssessorController extends Controller {

    public void index(){
        String index = this.getPara("pindex");
        render(index+".jsp");
    }

    public void userName(){
        List<APPUSER> list = APPUSER.dao.getLName();
        renderJson(list);
    }
}
