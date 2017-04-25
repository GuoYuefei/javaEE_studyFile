package cn.becomegood.web.constomtld;


import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 作为Dyn的父标签使用，仅做试验
 * @author fly
 *
 */
public class Title extends TagSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name; 
//	JspWriter out = pageContext.getOut();
//	JspWriter out = getBodyContent().getEnclosingWriter();		//获取out输出,需要每次刷新bodycontent的值
	@Override
	public int doStartTag() throws JspException {
		if (this.getParent() instanceof Dyn) {
			Dyn dyn = (Dyn) this.getParent();			//得到父标签
			this.name = dyn.getName();								//将自己的属性set进父标签
		}else {
			throw new JspException("没有在Dyn标签中");
		}
		return super.doStartTag();
	}
	
	
	
	@Override
	public int doEndTag() throws JspException {
		JspWriter out = pageContext.popBody();			//发现子标签自能用这个才能正常输出，不明所以
		try {
			out.append("<h1 align='center'>"+name+"</h1>");
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return EVAL_PAGE;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
}
