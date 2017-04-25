package cn.becomegood.web.filtertest;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CharacterEncodingFilter implements Filter {
	private String characterEncoding;
	private boolean enabled;
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		//获取配置文件的数据，trim（），string的函数用于除去前后空格
		characterEncoding = config.getInitParameter("characterEncoding").trim();
		enabled = "true".equalsIgnoreCase(config.getInitParameter("enabled").trim());
	}

	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		// 当enabled设置开启,且characterEncoding不为空或者“”时执行编码统一
		HttpServletRequest request=(HttpServletRequest)req;
		HttpServletResponse response=(HttpServletResponse)res;
		
		if (enabled && characterEncoding != null && !characterEncoding.equals("")) {
			//设置request和response的编码
			request.setCharacterEncoding(characterEncoding);
//			HttpServletRequestWrapper replaceQuest2 = new HttpServletRequestWrapper(request){
//			
//			};
			response.setCharacterEncoding(characterEncoding);
		}
		chain.doFilter(request, response);			//执行下一个filter或者servlet
	}


	@Override
	public void destroy() {
		characterEncoding = null;			//销毁时清空资源
	}
}
