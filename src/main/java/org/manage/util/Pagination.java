package org.manage.util;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import java.util.Map;

/**
 * Created by Administrator on 2017-7-28.
 */
public class Pagination<M extends Model> {
    /**
     *
     * @param paramMap
     * @param model
     * @param select
     * @param sqlExceptSelect
     * @param paras
     * @param <M>
     * @return
     */
    public static <M> Page<M> JPaginate(Map<String,String> paramMap, Model model, String select, String sqlExceptSelect, Object... paras){

        int pagesize=Integer.parseInt(paramMap.get("iDisplayLength"));
        int iNumber = Integer.parseInt(paramMap.get("iDisplayStart"));
        int num=iNumber/pagesize+1;
        return model.paginate(num,pagesize,select,sqlExceptSelect,paras);
    }

    public static <M> Page<M> JPaginate(Map<String,String> paramMap, Model model, String select, String sqlExceptSelect){
        int pagesize=Integer.parseInt(paramMap.get("iDisplayLength"));
        int iNumber = Integer.parseInt(paramMap.get("iDisplayStart"));
        int num=iNumber/pagesize+1;
        return model.paginate(num,pagesize,select,sqlExceptSelect);
    }
    /**
     * 指定分页 sql 最外层以是否含有 group by 语句
     * <pre>
     * 举例：
     * paginate(1, 10, true, "select *", "from user where id>? group by age", 123);
     * </pre>
     */
    public static <M> Page<M> JPaginate(Map<String,String> paramMap, Model model, boolean isGroupBySql, String select, String sqlExceptSelect, Object... paras){
        int pagesize=Integer.parseInt(paramMap.get("iDisplayLength"));
        int iNumber = Integer.parseInt(paramMap.get("iDisplayStart"));
        int num=iNumber/pagesize+1;
        return model.paginate(num,pagesize,isGroupBySql,select,sqlExceptSelect,paras);
    }

    public static Page<Record> JPaginate(Map<String,String> paramMap, String select, String sqlExceptSelect, Object... paras){
        int pagesize=Integer.parseInt(paramMap.get("iDisplayLength"));
        int iNumber = Integer.parseInt(paramMap.get("iDisplayStart"));
        int num=iNumber/pagesize+1;
        return Db.paginate(num,pagesize,select,sqlExceptSelect,paras);
    }
}
