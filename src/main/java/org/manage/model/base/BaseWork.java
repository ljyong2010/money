package org.manage.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseWork<M extends BaseWork<M>> extends Model<M> implements IBean {

	public void setID(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public void setEmployee(java.lang.String employee) {
		set("employee", employee);
	}

	public java.lang.String getEmployee() {
		return get("employee");
	}

	public void setSalary(java.lang.Double salary) {
		set("salary", salary);
	}

	public java.lang.Double getSalary() {
		return get("salary");
	}

	public void setStartDate(java.lang.String startDate) {
		set("startDate", startDate);
	}

	public java.lang.String getStartDate() {
		return get("startDate");
	}

	public void setEndDate(java.lang.String endDate) {
		set("endDate", endDate);
	}

	public java.lang.String getEndDate() {
		return get("endDate");
	}

	public void setUserId(java.lang.String userId) {
		set("userId", userId);
	}

	public java.lang.String getUserId() {
		return get("userId");
	}

	public void setDelflag(java.lang.Integer delflag) {
		set("delflag", delflag);
	}

	public java.lang.Integer getDelflag() {
		return get("delflag");
	}

}