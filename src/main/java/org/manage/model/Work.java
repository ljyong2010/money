package org.manage.model;

import com.jfinal.plugin.activerecord.Page;
import org.manage.model.base.BaseWork;
import org.manage.util.Pager;
import org.manage.util.Pagination;
import org.manage.util.SqlBuilder;

import java.util.Map;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Work extends BaseWork<Work> {
	public static final Work dao = new Work().dao();

	public Map<String,Object> getWorkList(Map<String,String> params){
		String sqlFrom = "from work where delflag=0";
		SqlBuilder sqlBuilder = new SqlBuilder(null);
		sqlBuilder.addCondition("employee", SqlBuilder.Condition.EQ,params.get("employee"));
		sqlBuilder.addCondition("startDate", SqlBuilder.Condition.GE,params.get("startDate"));
		sqlBuilder.addCondition("endDate", SqlBuilder.Condition.LE,params.get("endDate"));
		String sql = sqlBuilder.build();
		Object[] paras = sqlBuilder.paras();
		sqlFrom+=sql;
		Page<Work> workPage = Pagination.JPaginate(params,Work.dao,"select * ",sqlFrom,paras);
		Map<String,Object> retMap = Pager.PageMap(params,workPage);
		return retMap;
	}
	public Work getEmplayInfo(String id){
		Work work = Work.dao.findFirst("select * from work where delflag = 0 and ID=?",id);
		return work;
	}
}
