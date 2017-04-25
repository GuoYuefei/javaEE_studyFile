package cn.becomegood.web.filtertest;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;



import cn.becomegood.web.filtertest.wrapper.HttpChatacterResponseWrapper;

/**
 * 这是用于过滤错误、非法、敏感的词汇的过滤器
 * @author fly
 *
 */
public class OutputReplaceFilter implements Filter {

	
	private Properties replaceConfig = new Properties();
	//非法词、敏感词，配置在初始化参数中
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		String file = config.getInitParameter("file");		//从xml配置文件中读取另一个配置文件的位子
		String realPath = config.getServletContext().getRealPath(file);
		try {
			replaceConfig.load(new FileInputStream(realPath));
			//加载非法词汇
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*
	 * 这是通过一个自定义的response伪装起来窗体给下面的filter，但是最后输出已经用原来的
	 * 用自定义的目的是为了得到文本，然后把替换的文本在输出
	 * (non-Javadoc)
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		HttpChatacterResponseWrapper response = 			//自定义的response
				new HttpChatacterResponseWrapper((HttpServletResponse)arg1);
		arg2.doFilter(arg0, response);			//doFilter,使用自定义的response
		
		String output = response.getCharArrayWriter().toString();
		//得到response的输出内容
		for (Object obj : replaceConfig.keySet()) {			//遍历所有敏感词汇
			String key = (String)obj;				//把取出的键强转为String
			output = output.replace(key, replaceConfig.getProperty(key));
			//把所有含有敏感、非法、错误的词汇替换  也就是我们说的和谐咯，哈哈哈
		}
		PrintWriter out	= arg1.getWriter();
		//通过原来的response的getWrite方法输出
		out.write(output);
		out.println("<!-- Generated at "+ new java.util.Date() + "-->");
		//记录发生该事件的时间
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

}
