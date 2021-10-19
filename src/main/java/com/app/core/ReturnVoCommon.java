package com.app.core;


import top.jfunc.json.impl.JSONObject;

public class ReturnVoCommon {
	
	private int code = 0;//
	private String errMsg;//
	private JSONObject data;
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public JSONObject getData() {
		return data;
	}
	public void setData(JSONObject data) {
		this.data = data;
	}
	
	

}
