package org.manage.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseAPPUSERINFO<M extends BaseAPPUSERINFO<M>> extends Model<M> implements IBean {

	public void setUSERID(java.lang.String USERID) {
		set("USERID", USERID);
	}

	public java.lang.String getUSERID() {
		return get("USERID");
	}

	public void setNAME(java.lang.String NAME) {
		set("NAME", NAME);
	}

	public java.lang.String getNAME() {
		return get("NAME");
	}

	public void setSEX(java.lang.Integer SEX) {
		set("SEX", SEX);
	}

	public java.lang.Integer getSEX() {
		return get("SEX");
	}

	public void setADDRESS(java.lang.String ADDRESS) {
		set("ADDRESS", ADDRESS);
	}

	public java.lang.String getADDRESS() {
		return get("ADDRESS");
	}

	public void setTEL(java.lang.String TEL) {
		set("TEL", TEL);
	}

	public java.lang.String getTEL() {
		return get("TEL");
	}

	public void setEMAIL(java.lang.String EMAIL) {
		set("EMAIL", EMAIL);
	}

	public java.lang.String getEMAIL() {
		return get("EMAIL");
	}

	public void setINUSERID(java.lang.String INUSERID) {
		set("INUSERID", INUSERID);
	}

	public java.lang.String getINUSERID() {
		return get("INUSERID");
	}

	public void setINDATE(java.util.Date INDATE) {
		set("INDATE", INDATE);
	}

	public java.util.Date getINDATE() {
		return get("INDATE");
	}

	public void setDELFLAG(java.lang.Integer DELFLAG) {
		set("DELFLAG", DELFLAG);
	}

	public java.lang.Integer getDELFLAG() {
		return get("DELFLAG");
	}

	public void setENTITYID(java.lang.Integer ENTITYID) {
		set("ENTITYID", ENTITYID);
	}

	public java.lang.Integer getENTITYID() {
		return get("ENTITYID");
	}

}