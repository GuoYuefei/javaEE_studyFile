package cn.becomegood.web.constomtld;

import java.io.IOException;
import java.util.ResourceBundle;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

public class Copyright implements Tag {
	private Tag parent;				//父标签，本例中没有用到
	private PageContext pageContext;		//jsp内容
	
	@Override
	public int doEndTag() throws JspException {			//标签结束时执行
		JspWriter out = pageContext.getOut();			//得到输出的out对象
		
		try {
			out.println("<div align=center style='line-height:22px;font-size:12px;'>");
			//从配置文件中得到版权信息
			out.println(ResourceBundle.getBundle("properties/copyright").		//包名
					getString("right"));
			out.print("</div>");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	@Override
	public int doStartTag() throws JspException {
		// TODO Auto-generated method stub
		return 0;				//跳过执行
	}

	@Override
	public Tag getParent() {
		// TODO Auto-generated method stub
		return this.parent;
	}

	@Override
	public void release() {
		// TODO Auto-generated method stub

	}

	@Override
	public void setPageContext(PageContext pageContext) {

		this.pageContext=pageContext;
	}

	@Override
	public void setParent(Tag arg0) {
		this.parent = arg0;
	}

}
