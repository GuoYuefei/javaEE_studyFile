package cn.becomegood.web.constomtld;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import org.apache.catalina.valves.rewrite.Substitution.StaticElement;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

//通过web注释可以免配置
/**
 * 该类继承了HttpServlet的类，可以实现了servlet
 * 但是这里是服务于自定义标签的接口的
 * 继承的类和接口之间无联系，只为写入同一个文件，方便管理，因为要实现逻辑上的联系
 * 
 * 
 * 该类用于实现验证码功能，继承了自定标签的接口Tag
 * 该标签不需要任何的标签体就能在指定位置生成验证码
 * 这里的var变量比较特殊，逻辑上Servlet和Tag是不会共用的，但是看起来是共用的，
 * 实际上也通过某些方法实现了相等
 * 
 * 可扩展方面：
 * 1、以后可以增加不同种类的验证码，可以增加type属性，通过该属性实现不同种类的验证码呈现
 * 2、思考中。。。
 * 
 * 
 * @author fly
 * @version 1.0	
 * 
 */
@WebServlet(name="code",urlPatterns="/code")
public class Code extends HttpServlet implements Tag{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*//用静态属性所有对象都共享其值，但是也会导致线程不安全，并发高时须该
	private static String var;	*/	
	private String var;		//该属性用于记录对外发送验证码蕴含字符串的变量名,服务于继承的接口
	public static final Character[] CHARS={'2','3','4','5','6','7','8','9',
		'Q','W','E','R','T','Y','U','P','A','S','D','F','G','H','J','K','L','Z','X',
		'C','V','B','N','M'
	};
	private Random random = new Random();
	
	/**
	 * 获取随机字符串
	 * @return
	 */
	public String getRandomString() {
		StringBuffer stringBuffer = new StringBuffer(7);
		for(int i=0;i<6;i++){
			stringBuffer.append(CHARS[random.nextInt(CHARS.length)]);
		}
		return stringBuffer.toString();
	}
	/**
	 * 获取随机颜色
	 * @return
	 */
	public Color getRandomColor(){
		return new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255));
	}
	/**
	 * 取参数的反色 reverse 译为 反转
	 * @param color
	 * @return
	 */
	public Color getReverseColor(Color color){
		return new Color(255-color.getRed(), 255-color.getGreen(), 255-color.getBlue());
	}
	
	/**
	 * Constructor of the object.
	 */
	public Code() {
		super();
	}


	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*
		 * 生成验证吗
		 */
		var=request.getParameter("var");				//得到蕴含在param中的var值
		response.setContentType("image/jpeg");			//设置输出类型
		ServletOutputStream imageout = response.getOutputStream();
		int width = 100;
		int height = 30;
		Color color = getRandomColor();
		Color reverse = getReverseColor(color);
		String randomString = getRandomString();		//得到随机字符串
		//记录到以var所代表的字符串名的属性中，有效范围是session
		request.getSession().removeAttribute(var);;		//把之前的session清空
		request.getSession().setAttribute(var, randomString);	//将变量放入session
		request.getSession().setMaxInactiveInterval(60);		//有效时间是一分钟
		//创建一张彩色图片
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = image.createGraphics();
		g.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 23));
		g.setColor(color);
		g.fillRect(0, 0, width, height);						//背景充色
		g.setColor(reverse);									//取反色
		g.drawString(randomString, random.nextInt(23), 22);		//将String画进去
		for(int i=0,n=random.nextInt(200);i<n;i++){				//随机画取小点
			g.drawOval(random.nextInt(width), random.nextInt(height),
					random.nextInt(3), random.nextInt(3));
		}
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(imageout);
		encoder.encode(image);
		imageout.flush();
		imageout.close();
		
//		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
//		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
//		out.println("<HTML>");
//		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
//		out.println("  <BODY>");
//		out.print("    This is ");
//		out.print(this.getClass().toString());
//		out.println(", using the GET method");
//		out.println("<img src=\"servlet/Code\"/>");
//		out.println("  </BODY>");
//		out.println("</HTML>");
//		
//
//		out.flush();
//		out.close();
	}


	

	/**
	 * 
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	/**
	 * 这是接口部分编程,其中var写在上面了
	 */
	private Tag parent;
	private PageContext pageContext;
	@Override
	public int doEndTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		JspWriter out = pageContext.getOut();
		String context = request.getContextPath();
		try {
			out.print("<img alt='验证码' src='"+context+"/code?var="+var+"'>");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return 0;
	}
	@Override
	public int doStartTag() throws JspException {
		return 0;
	}
	@Override
	public Tag getParent() {
		return this.parent;
	}
	@Override
	public void release() {
		
	}
	@Override
	public void setPageContext(PageContext pageContext) {
		this.pageContext = pageContext;
	}
	@Override
	public void setParent(Tag parent) {
		this.parent=parent;
	}

	public String getVar() {
		return var;
	}
	public void setVar(String var) {
		this.var = var;
	}
}
