package cn.becomegood.web.constomtld;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;


/**
 * 该类继承了BodyTagSupprot，默认是按主线流程下来
 * 该类实现了对标签体内的字符全部转换成小写
 * @author fly
 *
 */
public class ToLow extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public int doEndTag() throws JspException {
		
		String content = this.getBodyContent().getString();			//获取标签内代码
		
		try {
			this.pageContext.getOut().print(content.toLowerCase());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return EVAL_PAGE;
	}
	
	
	
	
	
}
