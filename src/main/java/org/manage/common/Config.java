package org.manage.common;

import com.jfinal.config.*;
import com.jfinal.core.Const;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.dialect.SqlServerDialect;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;
import com.jfinal.template.Engine;
import org.manage.common.interceptor.LoginInterceptor;
import org.manage.controller.IndexController;
import org.manage.controller.LoginController;
import org.manage.model._MappingKit;

/**
 * Created by Administrator on 2017-7-25.
 */
public class Config extends JFinalConfig {

    @Override
    public void configConstant(Constants constants) {
        PropKit.use("jdbc.properties");
        constants.setDevMode(PropKit.getBoolean("devMode", false));
        constants.setViewType(ViewType.JSP);
        constants.setMaxPostSize(1* Const.DEFAULT_MAX_POST_SIZE);
    }

    @Override
    public void configRoute(Routes me) {
        me.setBaseViewPath("jsps");
        me.add("/", IndexController.class);
        me.add("/tlogin", LoginController.class,"/login");
        me.add(new AdminRoutes());
    }

    @Override
    public void configEngine(Engine me) {

    }

    public static C3p0Plugin createC3p0Plugin() {
        return new C3p0Plugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password").trim(),PropKit.get("jdbcDriver").trim());
    }
    @Override
    public void configPlugin(Plugins me) {
        C3p0Plugin c3p0Plugin=createC3p0Plugin();
        me.add(c3p0Plugin);

        ActiveRecordPlugin activeRecordPlugin = new ActiveRecordPlugin(c3p0Plugin);
        activeRecordPlugin.setDialect(new SqlServerDialect());
        me.add(activeRecordPlugin);
        activeRecordPlugin.setShowSql(true);
        _MappingKit.mapping(activeRecordPlugin);
    }

    @Override
    public void configInterceptor(Interceptors me) {
        me.add(new LoginInterceptor());
        me.addGlobalServiceInterceptor(new Tx());
    }

    @Override
    public void configHandler(Handlers me) {
        me.add(new ContextPathHandler("ctx"));
    }
}
