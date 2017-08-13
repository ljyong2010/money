package org.manage.controller;

import com.jfinal.core.Controller;

public class AssessorController extends Controller {
    public void index(){
        String index = getPara("pindex");
        render(index+".jsp");
    }

}
