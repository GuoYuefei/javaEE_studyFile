package cn.becomegood.web.constomtld;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;
import javax.servlet.jsp.tagext.DynamicAttributes;

public class Dyn extends BodyTagSupport implements DynamicAttributes {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	//所有的动态参数
	private Map<String, Double> map = new HashMap<String, Double>();
	
	
	@Override
	public void setDynamicAttribute(String uri, String key, Object value)
			throws JspException {
		//把所有参数取出，循环过程交给服务器
		map.put(key, Double.parseDouble((String)value));
		
	}

	
	
	@Override
	public int doStartTag() throws JspException {

		return super.doStartTag();
	}



	@Override
	public int doAfterBody() throws JspException {
//		JspWriter out = pageContext.popBody();
		double min=Double.MAX_VALUE,max=0;			//min设置成double的最大值是为了后面的比较不出错
		
		for (double d : map.values()) {			//遍历Map中的所有数值
			min = Math.min(d, min);				//得到最小值
			
			max = Math.max(d, max);				//得到最大值
		}
		StringBuffer buffer = new StringBuffer();     //StringBuffer对象
		buffer.append("<table>");
		
		for (Entry<String, Double> enrty : map.entrySet()) {		//较常用
			
			buffer.append("<tr>");
			buffer.append("<td>"+enrty.getKey()+"</td>");		//显示公司
			buffer.append("<td><img src='images/error.jpg' height='10' width='");	//显示图片
			buffer.append((enrty.getValue()-min)/(max-min+1)*250+20);			//图片的长度动态显示
			buffer.append("'/>"+enrty.getValue()+"</td>");						//最后显示数值
			buffer.append("</tr>");
		}		
		buffer.append("</table>");
		
		try {
			JspWriter out = getBodyContent().getEnclosingWriter();
			out.write(buffer.toString());			//输出到客户端
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return EVAL_PAGE;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
