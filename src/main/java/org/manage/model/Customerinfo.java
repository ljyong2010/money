package org.manage.model;

import com.jfinal.plugin.activerecord.Db;
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

	public Map<String,Object> checkCart(String cart){
		Map<String,Object> retMap = new HashMap<>();
		if (Db.queryInt("select count(1) from customerinfo where card=?",cart)>0){
			retMap.put("code",1);
		}else {
			retMap.put("code",-1);
		}
		return retMap;
	}

	public Map<String,Object> getCustomList(Map<String,String> params,APPUSER appuser){
		Map<String,Object> retMap = new HashMap<>();
		int uid = appuser.getUSERTYPEID();
		String sqlForm = "from customerinfo a left join appuser b on a.assessorId = b.userid where a.flag = 0 and a.payId = 0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		if (uid != 2){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,appuser.getUSERID());
		}
		if (params.containsKey("assessorId")){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,params.get("assessorId"));
		}
		sqlBuilder.addCondition("a","replydate", SqlBuilder.Condition.GE,DateUtil.getDateTimeFormat(new Date()));
		sqlBuilder.addCondition("a","customName", SqlBuilder.Condition.RLIKE,params.get("customName"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> recordPage = Pagination.JPaginate(params,"select a.*,b.LOGINNAME,"+uid+" as UID",sqlForm+" order by a.borrowdate desc",pars);
		retMap = Pager.PageMap(params,recordPage);
		return retMap;
	}
	public Map<String,Object> getYqCustomList(Map<String,String> params,APPUSER appuser){
		String sqlForm = "from customerinfo a left join appuser b on a.assessorId=b.userid where a.flag = 0 and a.payId = 0 ";
		int uid = appuser.getUSERTYPEID();
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		sqlBuilder.addCondition("a","replydate", SqlBuilder.Condition.LT,DateUtil.getDateTimeFormat(new Date()));
		if (uid !=2){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,appuser.getUSERID());
		}else {
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,params.get("assessorId"));
		}
		sqlBuilder.addCondition("a","customName", SqlBuilder.Condition.RLIKE,params.get("customName"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> recordPage = Pagination.JPaginate(params,"select a.*,b.LOGINNAME,"+uid+" as UID",sqlForm+" order by a.borrowdate desc",pars);
		Map<String,Object> retMap = Pager.PageMap(params,recordPage);
		return retMap;
	}
	public Customerinfo getCustomerInfo(String id){
		Customerinfo customerinfo = dao.findFirst("select * from customerinfo where ID=? AND flag=0",id);
		return customerinfo;
	}
	public Map<String,Object> payFull(String id){
		Map<String,Object> retMap = new HashMap<>();
		if (Db.update("update customerinfo set payId=? where ID=?",1,id) > 0){
			retMap.put("code",1);
			retMap.put("msg","");
		}else {
			retMap.put("code",-1);
			retMap.put("msg","pay money fail");
		}
		return retMap;
	}
	public Map<String,Object> deleteInfo(String id){
		Map<String,Object> retMap = new HashMap<>();
		if (Db.update("delete from customerinfo where ID=?",id) > 0){
			retMap.put("code",1);
			retMap.put("msg","");
		}else {
			retMap.put("code",-1);
			retMap.put("msg","pay money fail");
		}
		return retMap;
	}
	public Map<String,Object> getAssload(Map<String,String> params,APPUSER appuser){
		int uid = appuser.getUSERTYPEID();
		String sqlForm = "from customerinfo a left join appuser b on a.assessorId=b.userid where flag = 0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.GE,params.get("startDate"));
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.LE,params.get("endDate"));
		if (uid==2){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,params.get("USERID"));
		}else {
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,appuser.getUSERID());
		}

		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> page = Pagination.JPaginate(params,"select sum(a.borrowbalan) as LOANS,sum(a.acualmoney) as RECEMENOY,LOGINNAME",sqlForm+" group by b.loginname",pars);
		Map<String,Object> retMap = Pager.PageMap(params,page);
		return retMap;
	}

	/**
	 * 明天查看 overduemenoy
	 * @param params
	 * @param appuser
	 * @return
	 */
	public Map<String,Object> getOverdue(Map<String,String> params,APPUSER appuser){
		int uid = appuser.getUSERTYPEID();
		String sqlForm = "from customerinfo a left join appuser b on a.assessorId=b.userid where flag = 0 and payId=0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.GE,params.get("startDate"));
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.LE,params.get("endDate"));
		if (uid==2){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,params.get("USERID"));
		}else {
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,appuser.getUSERID());
		}
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> page = Pagination.JPaginate(params,"select a.assessorId,sum(a.replymoney) as GIVEMENOY,sum(a.acualmoney) as ACTMENOY,LOGINNAME",sqlForm+" group by b.loginname,a.assessorId",pars);
		Map<String,Object> retMap = Pager.PageMap(params,page);
		return retMap;
	}

	/**
	 * showwoverdue
	 * @param params
	 * @return
	 */
	public Map<String,Object> getOverShow(Map<String,String> params){
		String sqlForm = "from customerinfo a left join appuser b on a.assessorId=b.userid where flag = 0 and payId=0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.GE,params.get("sdate"));
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.LE,params.get("edate"));
		sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,params.get("USERID"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> page = Pagination.JPaginate(params,"select a.replymoney,a.acualmoney,LOGINNAME",sqlForm,pars);
		Map<String,Object> retMap = Pager.PageMap(params,page);
		return retMap;
	}
	public Map<String,Object> getHisCust(Map<String,String> params,APPUSER appuser){
		int uid = appuser.getUSERTYPEID();
		String sqlForm = "from customerinfo a left join appuser b on a.assessorId = b.userid where flag=0 and payId = 1";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		if (uid != 2){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,appuser.getUSERID());
		}
		if (params.containsKey("assessorId")){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,params.get("assessorId"));
		}
		sqlBuilder.addCondition("a","customName", SqlBuilder.Condition.RLIKE,params.get("customName"));
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.GE,params.get("startDate"));
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.LE,params.get("endDate"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> page = Pagination.JPaginate(params,"select a.*,b.LOGINNAME",sqlForm+" order by a.borrowdate desc",pars);
		Map<String,Object> retMap = Pager.PageMap(params,page);
		return retMap;
	}
	public Map<String,Object> getSalary(Map<String,String> params,APPUSER appuser){
		int uid = appuser.getUSERTYPEID();
		String sqlForm = "from customerinfo a left join appuser b on a.assessorId = b.userid where a.flag=0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		if (uid != 2){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,appuser.getUSERID());
		}
		if (params.containsKey("assessorId")){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,params.get("assessorId"));
		}
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.GE,params.get("startDate"));
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.LE,params.get("endDate"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> page = Pagination.JPaginate(params,"select a.assessorId,sum(a.borrowbalan) as bor,sum(a.acualmoney) as acu,sum(a.revfee) as rev,b.LOGINNAME",sqlForm+" group by b.LOGINNAME,a.assessorId",pars);
		Map<String,Object> retMap = Pager.PageMap(params,page);
		return retMap;
	}
	public Map<String,Object> salaryShow(Map<String,String> params){
		String sqlForm = "from customerinfo a left join appuser b on a.assessorId = b.userid where flag=0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.GE,params.get("startDate"));
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.LE,params.get("endDate"));
		sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,params.get("USERID"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm+=sql;
		Page<Record> page = Pagination.JPaginate(params,"select a.borrowbalan,a.borrowdate,a.acualmoney,a.actualdate,a.revfee,b.LOGINNAME",sqlForm,pars);
		Map<String,Object> retMap = Pager.PageMap(params,page);
		return retMap;
	}
	public Map<String,Object> gettotal(Map<String,String> params,APPUSER appuser){
		int uid = appuser.getUSERTYPEID();
		String sqlForm = "from customerinfo a left join appuser b on a.assessorId = b.userid where a.flag=0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		if (uid == 2){
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,params.get("assessorId"));
		}else {
			sqlBuilder.addCondition("a","assessorId", SqlBuilder.Condition.EQ,appuser.getUSERID());
		}
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.GE,params.get("startDate"));
		sqlBuilder.addCondition("a","borrowdate", SqlBuilder.Condition.LE,params.get("endDate"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm += sql;
		String strsel = "select a.assessorId,sum(a.borrowbalan) as BOR,sum(a.acualmoney) as ACU,sum(a.replymoney) as REP,sum(a.revfee) as REV,b.LOGINNAME";
		Page<Record> page = Pagination.JPaginate(params,strsel,sqlForm+" group by b.LOGINNAME,a.assessorId",pars);
		Map<String,Object> retMap = Pager.PageMap(params,page);
		return retMap;
	}
	public Map<String,Object> zTotal(Map<String,String> params){
		String sqlForm = "from customerinfo where flag=0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		sqlBuilder.addCondition("borrowdate", SqlBuilder.Condition.GE,params.get("startDate"));
		sqlBuilder.addCondition("borrowdate", SqlBuilder.Condition.LE,params.get("endDate"));
		String sql = sqlBuilder.build();
		Object[] pars = sqlBuilder.paras();
		sqlForm += sql;
		String strsel = "select sum(borrowbalan) as ZBOR,sum(acualmoney) as ZACU,sum(replymoney) as ZREP,sum(revfee) as ZREV";
		Page<Record> page = Pagination.JPaginate(params,strsel,sqlForm,pars);
		Map<String,Object> retMap = Pager.PageMap(params,page);
		return retMap;
	}
}
