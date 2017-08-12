package org.manage.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BasePayhist<M extends BasePayhist<M>> extends Model<M> implements IBean {

	public void setID(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getID() {
		return get("ID");
	}

	public void setUserId(java.lang.String userId) {
		set("userId", userId);
	}

	public java.lang.String getUserId() {
		return get("userId");
	}

	public void setCustomName(java.lang.String customName) {
		set("customName", customName);
	}

	public java.lang.String getCustomName() {
		return get("customName");
	}

	public void setActualdate(java.lang.String actualdate) {
		set("actualdate", actualdate);
	}

	public java.lang.String getActualdate() {
		return get("actualdate");
	}

	public void setAcualmoney(java.lang.Double acualmoney) {
		set("acualmoney", acualmoney);
	}

	public java.lang.Double getAcualmoney() {
		return get("acualmoney");
	}

	public void setDeflag(java.lang.String deflag) {
		set("deflag", deflag);
	}

	public java.lang.String getDeflag() {
		return get("deflag");
	}

	public void setPayId(java.lang.Integer payId) {
		set("payId", payId);
	}

	public java.lang.Integer getPayId() {
		return get("payId");
	}

}
