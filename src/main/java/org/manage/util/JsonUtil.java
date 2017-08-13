package org.manage.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

/**
 * Created by Administrator on 2017-7-28.
 */
public class JsonUtil {
 /* public static Map<String,String> paramHashfunc(String json){
        Map<String,String> map=new HashMap<String, String>();
        map= (Map<String, String>) JSON.parse(json.toString());
        return map;
    }*/

    /*public static<T> T JsonToJavaBean(String str, Class<T> clazz){
        Map<String,String> map=new HashMap<String, String>();
        try {

            T javaBean=JSONObject.parseObject(str,clazz);
            return javaBean;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
     public static void main(String args[]){
         String json="{JURISTIC:\"5\",UNIT_NAME:\"4\",jgDM:\"3\"}";
         BTUnit btUnit=(BTUnit)JsonToJavaBean(json,BTUnit.class);
         System.out.println(btUnit);
     }*/
    public static<T> T JsonToJavaBean(HttpServletRequest request, Class<T> clazz){
        Map<String,String> map=new HashMap<String, String>();
        try {
            StringBuilder json=new StringBuilder();
            BufferedReader reader=request.getReader();
            String line =null;
            while ((line=reader.readLine())!=null){
                json.append(line);
            }
            String str = json.toString();
            T javaBean= JSONObject.parseObject(json.toString(),clazz);
            return javaBean;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public static<T> T JToJavaBean(HttpServletRequest request,Class<T> clazz){
        Map<String,String> map=new HashMap<String, String>();
        try {
            StringBuilder json=new StringBuilder();
            BufferedReader reader=request.getReader();
            String line =null;
            while ((line=reader.readLine())!=null){
                json.append(line);
            }
            JSONArray array=JSONArray.parseArray(json.toString());
            Iterator<Object> it = array.iterator();

            while (it.hasNext()) {
                JSONObject ob = (JSONObject) it.next();
                map.put(ob.getString("name"),ob.getString("value"));
            }
            reader.close();
            String jsonString=JSONObject.toJSONString(map);
            T javaBean=JSONObject.parseObject(jsonString,clazz);
            return javaBean;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public static<T> T jsonArrayToJ(HttpServletRequest request,Class<T> clazz){
        Map<String,String> map=new HashMap<String, String>();
        StringBuilder json=new StringBuilder();
        try {
            BufferedReader reader=request.getReader();
            String line =null;
            while ((line=reader.readLine())!=null){
                json.append(line);
            }
            JSONArray array= JSONArray.parseArray(json.toString());
            Iterator<Object> it = array.iterator();

            while (it.hasNext()) {
                JSONObject ob = (JSONObject) it.next();
                if (!Strings.isNullOrEmpty(map.get(ob.getString("name"))))
                    map.put(ob.getString("name"), map.get(ob.getString("name")) + "," + ob.getString("value"));
                else
                    map.put(ob.getString("name"), ob.getString("value"));
            }
            reader.close();
            String jsonString= JSONObject.toJSONString(map);
            T javaBean= JSONObject.parseObject(jsonString,clazz);
            return javaBean;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public static Map<String,String> jToMap(HttpServletRequest request){
        Map<String,String> map=new HashMap<String, String>();
        try {
            StringBuilder json=new StringBuilder();
            BufferedReader reader=request.getReader();
            String line =null;
            while ((line=reader.readLine())!=null){
                json.append(line);
            }
            map= (Map<String, String>) JSON.parse(json.toString());
            reader.close();

        }catch (Exception e){
            //e.printStackTrace();
        }
        return map;
    }
    public static Map<String,String> jsonNameToMap(HttpServletRequest request){
        Map<String,String> map=new HashMap<String, String>();
        StringBuilder json=new StringBuilder();
        try {
            BufferedReader reader=request.getReader();
            String line =null;
            while ((line=reader.readLine())!=null){
                json.append(line);
            }
            JSONArray array=JSONArray.parseArray(json.toString());
            Iterator<Object> it = array.iterator();

            while (it.hasNext()) {
                JSONObject ob = (JSONObject) it.next();
                if (!Strings.isNullOrEmpty(map.get(ob.getString("name"))))
                    map.put(ob.getString("name"), map.get(ob.getString("name")) + "," + ob.getString("value"));
                else
                    map.put(ob.getString("name"), ob.getString("value"));
            }
            reader.close();
        }catch (Exception e){
            e.printStackTrace();

        }
        return map;
    }
    public static Map<String,String> paramHashfunc(HttpServletRequest request){
        Map<String,String> map=new HashMap<String, String>();
        StringBuilder json=new StringBuilder();
        try {
            BufferedReader reader=request.getReader();
            String line =null;
            while ((line=reader.readLine())!=null){
                json.append(line);
            }
            JSONArray array=JSONArray.parseArray(json.toString());
            Iterator<Object> it = array.iterator();

            while (it.hasNext()) {
                JSONObject jsonObject = (JSONObject) it.next();
                if (!Strings.isNullOrEmpty(map.get(jsonObject.getString("name"))))
                    map.put(jsonObject.getString("name"), map.get(jsonObject.getString("name")) + "," + jsonObject.getString("value"));
                else
                    map.put(jsonObject.getString("name"), jsonObject.getString("value"));
            }
            reader.close();
            map= (Map<String, String>) JSON.parse(json.toString());
        }catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
    public static Map<String,String> jsonToMap(HttpServletRequest request){
        Map<String,String> map=new HashMap<>();
        Map<String,String> jsonMap = new HashMap<>();
        StringBuilder json=new StringBuilder();
        try {
            BufferedReader reader=request.getReader();
            String line =null;
            while ((line=reader.readLine())!=null){
                json.append(line);
            }
            JSONArray array= JSONArray.parseArray(json.toString());
            Iterator<Object> it = array.iterator();
            int i = 0;
            while (it.hasNext()) {
                if (i < array.size() - 1) {
                    JSONObject ob = (JSONObject) it.next();
                    if (!Strings.isNullOrEmpty(map.get(ob.getString("name"))))
                        map.put(ob.getString("name"), map.get(ob.getString("name")) + "," + ob.getString("value"));
                    else
                        map.put(ob.getString("name"), ob.getString("value"));
                    i++;
                }else {
                    JSONObject ob = (JSONObject) it.next();
                    jsonMap = JSON.parseObject(ob.toString(),new TypeReference<Map<String,String>>(){});
                    i++;
                }
            }
            reader.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        map.putAll(jsonMap);
        return map;
    }
    public static<T> T mapToBean(Map<String,String> map,Class<T> clazz){
        String json = JSON.toJSONString(map);
        T javaBean= JSONObject.parseObject(json,clazz);
        return javaBean;
    }
    public static Map<String,Object> paramsToMap(HttpServletRequest request){
        Map<String,Object> map = new HashMap<String,Object>();
        try {
            StringBuffer buffer = new StringBuffer();
            BufferedReader reader=request.getReader();
            String line=null;
            while ((line=reader.readLine())!=null){
                buffer.append(line);
            }
            String[] spls=buffer.toString().split("&");
            for (String s:spls){
                String[] ar=s.split("=");
                if ("null".equals(ar[1]))
                    map.put(ar[0],"");
                else
                    map.put(ar[0],ar[1]);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }
    public static String getUUID(){
        return UUID.randomUUID().toString().replaceAll("-","");
    }
    public static void main(String[] args){
        String json = "[{\"name\":\"UNIT_NAME\",\"value\":\"aa\"},{\"name\":\"JGDM\",\"value\":\"aa\"},{\"sEcho\":1,\"iColumns\":7,\"iDisplayStart\":0,\"iDisplayLength\":10}]";
        Map<String,Object> map=new HashMap<>();
        Map<String,Object> jsonMap = new HashMap<>();
        JSONArray array= JSONArray.parseArray(json);
        Iterator<Object> it = array.iterator();
        int i = 0;
        while (it.hasNext()) {
            if (i < array.size() - 1) {
                JSONObject ob = (JSONObject) it.next();
                String a=ob.getString("name");
                System.out.println((String)map.get(ob.getString("name")));
                if (!Strings.isNullOrEmpty(map.get(ob.getString("name"))))
                    map.put(ob.getString("name"), map.get(ob.getString("name")) + "," + ob.get("value"));
                else
                    map.put(ob.getString("name"), ob.get("value"));
                i++;
            }else {
                JSONObject ob = (JSONObject) it.next();
                //jsonMap = JSONObject.toJavaObject(ob,Map.class);
                jsonMap = JSON.parseObject(ob.toString(),new TypeReference<Map<String,Object>>(){});
                i++;
            }
        }
        map.putAll(jsonMap);
        int a =(int)map.get("sEcho");
        //String jsonM = JSON.toJSONString(map);
        System.out.println("aaa");
    }
}
