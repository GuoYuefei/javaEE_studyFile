package cn.becomegood.web.test1;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "MyServlet1",urlPatterns = {"/logins/my","/WEB-INF/logins/my"})
public class MyServlet1 implements Servlet {
	//transient译为短暂的，继承Serializable接口的类都可被序列化，而用了这个关键字的就不会被序列化，也就是说只会
	//在内存里短暂存在。这样做是安全的。
	private transient ServletConfig servletConfig;			//容器初始化Servlet时被传递给init（。。。）函数

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		System.out.println("destroy");
	}

	@Override
	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		System.out.println("getServletConfig()");
		return servletConfig;
	}

	@Override
	public String getServletInfo() {
		// TODO Auto-generated method stub
		System.out.println("getServletInfo()");
		return "My Servlet";
	}

	@Override
	public void init(ServletConfig servletConfig) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("init");
		this.servletConfig = servletConfig;
	}

	@Override
	public void service(ServletRequest request, ServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("service");
		String servletName = servletConfig.getServletName();
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		writer.print("<html><head></head>"
				+ "<body>Hello from " + servletName
				+ "<br/><hr>" + "Welcome "+request.getParameter("username")
				+ "测试中文"+"</body></html>");
		

	}

}
