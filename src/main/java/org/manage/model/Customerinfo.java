package org.manage.model;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import org.manage.model.base.BaseCustomerinfo;
import org.manage.util.DateUtil;
import org.manage.util.Pager;
import org.manage.util.Pagination;
import org.manage.util.SqlBuilder;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Customerinfo extends BaseCustomerinfo<Customerinfo> {
	public static final Customerinfo dao = new Customerinfo().dao();

	public Map<String,Object> getCustomList(Map<String,String> params,APPUSER appuser){
		Map<String,Object> retMap = new HashMap<>();
		String sqlForm = "from customerinfo where flag = 0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		sqlBuilder.addCondition("assessorId", SqlBuilder.Condition.EQ,appuser.getUSERID());
		sqlBuilder.addCondition("customName", SqlBuilder.Condition.RLIKE,params.get("customName"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> recordPage = Pagination.JPaginate(params,"select *",sqlForm,pars);
		retMap = Pager.PageMap(params,recordPage);
		return retMap;
	}
	public Map<String,Object> getYqCustomList(Map<String,String> params,APPUSER appuser){
		String sqlForm = "from customerinfo where flag = 0 ";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		sqlBuilder.addCondition("replydate", SqlBuilder.Condition.LT,DateUtil.getDateTimeFormat(new Date()));
		sqlBuilder.addCondition("assessorId", SqlBuilder.Condition.EQ,appuser.getUSERID());
		sqlBuilder.addCondition("customName", SqlBuilder.Condition.RLIKE,params.get("customName"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> recordPage = Pagination.JPaginate(params,"select *",sqlForm,pars);
		Map<String,Object> retMap = Pager.PageMap(params,recordPage);
		return retMap;
	}
}
