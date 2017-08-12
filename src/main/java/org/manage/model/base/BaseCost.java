package org.manage.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseCost<M extends BaseCost<M>> extends Model<M> implements IBean {

	public void setID(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public void setMoney(java.lang.Double money) {
		set("money", money);
	}

	public java.lang.Double getMoney() {
		return get("money");
	}

	public void setCostDetails(java.lang.String costDetails) {
		set("costDetails", costDetails);
	}

	public java.lang.String getCostDetails() {
		return get("costDetails");
	}

	public void setPerson(java.lang.String person) {
		set("person", person);
	}

	public java.lang.String getPerson() {
		return get("person");
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

	public void setDate(java.lang.String date) {
		set("date", date);
	}

	public java.lang.String getDate() {
		return get("date");
	}

}
