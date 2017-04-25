package cn.becomegood.web.test1;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class Code extends HttpServlet {
	public static final Character[] CHARS={'2','3','4','5','6','7','8','9',
		'Q','W','E','R','T','Y','U','P','A','S','D','F','G','H','J','K','L','Z','X',
		'C','V','B','N','M'
	};
	public static Random random = new Random();
	
	/**
	 * 获取随机字符串
	 * @return
	 */
	public static String getRandomString() {
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
	public static Color getRandomColor(){
		return new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255));
	}
	/**
	 * 取参数的反色 reverse 译为 反转
	 * @param color
	 * @return
	 */
	public static Color getReverseColor(Color color){
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
//		response.setContentType("image/jpeg");			//设置输出类型
		ServletOutputStream imageout = response.getOutputStream();
		String randomString = getRandomString();		//得到随机字符串
		request.getSession(true).setAttribute("randomString", randomString);
		int width = 100;
		int height = 30;
		Color color = getRandomColor();
		Color reverse = getReverseColor(color);
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
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
