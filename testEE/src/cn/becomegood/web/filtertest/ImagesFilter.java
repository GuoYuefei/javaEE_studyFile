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
/**
 * 该过滤器用于图片的防盗
 * @author fly
 * @version 1.0
 */
public class ImagesFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		// 强转成HttpServletRequest
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		
		String referer = request.getHeader("referer");		//链接来源的地址
		
		if (referer==null || !referer.contains(request.getServerName())) {
			//显示错误照片
			request.getRequestDispatcher("/images/error.jpg").forward(request, response);
		} else {
			chain.doFilter(request, response);			//正常显示照片
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
