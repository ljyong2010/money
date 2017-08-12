package org.manage.util;

import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Model;

import java.util.*;

/**
 * Created by Administrator on 2017-7-28.
 */
@SuppressWarnings("unchecked")
public class SqlBuilder {
    public enum Condition{
        LIKE(" LIKE "),
        RLIKE(" LIKE"),
        EQ(" = "),
        GT(" > "),
        LT(" < "),
        GE(" >= "),
        LE(" <= "),
        NE(" != "),
        IN(" IN "),
        NI(" NOT IN "),
        ISNULL(" IS NULL "),
        NOTNULL(" IS NOT NULL ");
        private String value;
        Condition(String value){
            this.value = value;
        }
    }
    static public class Param{
        private String alias;
        private Condition condition;
        private Object value;
        public Param(String alias,Condition condition,Object value){
            this.alias=alias;
            this.condition=condition;
            this.value=value;
        }
    }
    protected Map<String,Param> conditions = new HashMap<>();//条件集合
    protected StringBuilder sql = new StringBuilder(" ");//AND语句
    public List params = new ArrayList<>();//参数集合
    private String alias; // 字段别名

    public SqlBuilder(Model model){
        this(model,null);
    }
    public SqlBuilder(Model model, String alias){
        if (model != null){
            Set<Map.Entry<String,Object>> entrySet = model._getAttrsEntrySet();
            for (Map.Entry<String,Object> entry:entrySet){
                String key = entry.getKey();
                Object value = entry.getValue();
                if (!value.equals("")&&value!=null){
                    addCondition(alias,key,value instanceof String ? Condition.LIKE : Condition.EQ,value);
                }

            }
        }
        this.alias=alias;
    }
    public SqlBuilder addCondition(String alias, String name, Condition condition, Object value){
        if (!Strings.isNullOrEmpty(value)){
            conditions.put(name,new Param(alias,condition,value));
        }
        return this;
    }
    public SqlBuilder addCondition(String name, Condition condition, Object value) {
        if (!Strings.isNullOrEmpty(value)){
            conditions.put(name,new Param(alias,condition,value));
        }
        return this;
    }
    public SqlBuilder addCondition(String name, Condition condition){
        conditions.put(name,new Param(alias,condition,conditions.get(name).value));
        return this;
    }
    public String build(){
        for (Map.Entry<String,Param> entry:conditions.entrySet()){
            Param param = entry.getValue();
            String key = StrKit.notBlank(param.alias)?param.alias+"."+entry.getKey():entry.getKey();
            sql.append("AND ").append(key).append(param.condition.value);
            if (Condition.IN.equals(param.condition) || Condition.NI.equals(param.condition)){
                List values = new ArrayList();
                if (param.value instanceof String){
                    String value = (String) param.value;
                    values = Arrays.asList(value.split(","));
                }
                if (param.value instanceof Object[]){
                    values = Arrays.asList((Object[]) param.value);
                }
                if (param.value instanceof List){
                    values = (List) param.value;
                }
                sql.append("(");
                for (int i = 0; i < values.size(); i++){
                    sql.append(i == 0 ? "?" : ",? ");
                }
                sql.append(")");
                params.addAll(values);
            } else if (Condition.LIKE.equals(param.condition)) {
                sql.append("? ");
                params.add("%" + param.value + "%");
            } else if (Condition.RLIKE.equals(param.condition)){
                sql.append(" ? ");
                params.add(param.value + "%");
            } else if (!Condition.ISNULL.equals(param.condition) && !Condition.NOTNULL.equals(param.condition)) {
                sql.append("? ");
                params.add(param.value);
            }
        }
        return sql.toString();
    }
    public Object[] paras(){
        return params.toArray();
    }
}
