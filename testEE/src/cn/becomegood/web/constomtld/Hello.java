package cn.becomegood.web.constomtld;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 使用的TagSupport模板类，而非使用Tag的接口
 * 该类简单的实现了自定义标签接收参数数据
 * @author fly
 *
 */
public class Hello extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	@Override
	public int doEndTag() throws JspException {
		JspWriter out = pageContext.getOut();
		
		try {
			out.println("Hello,"+name);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
		
	}
	/*
	 * 必须
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
}
