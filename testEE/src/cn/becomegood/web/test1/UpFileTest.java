package cn.becomegood.web.test1;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;




public class UpFileTest extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public UpFileTest() {
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

		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		//以下syso代码仅做测试
		System.out.println("request.getServerName()= "+request.getServerName());
		System.out.println("request.getRequestURI()= "+request.getRequestURI());
		System.out.println("request.getRequestURL()= "+request.getRequestURL());
		Enumeration<String> enumeration = request.getHeaderNames();
		while (enumeration.hasMoreElements()) {
			System.out.println("request.getHeaderNames()= "+enumeration.nextElement());
		}
		System.out.println("request.getContextPath()= "+request.getContextPath());
		ServletContext servletContext = request.getServletContext();
		System.out.println("servletContext.getRealPath(request.getContextPath()): "+servletContext.getRealPath(request.getContextPath()));
		System.out.println(request.getServletPath());
		System.out.println(request.getServletContext());
		
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method<hr/><br/>");
		out.println("请以POST方式上传文件");
		out.println("");
		request.getRequestDispatcher("/upfile.html").forward(request, response);
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		/*
		 * 接收处理文件和信息
		 */
		File file1 = null;
		String instruction1=null,author=null;
		//用于读取二进制数据
		DiskFileItemFactory factory = new DiskFileItemFactory();
//		String path = request.getSession().getServletContext().getRealPath("/upload");
//		String repositoryPath = request.getSession().getServletContext().getRealPath("/upload/temp");
//		factory.setRepository(new File(repositoryPath));
//		factory.setSizeThreshold(1024*1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
//		DiskFileUpload upload = new DiskFileUpload();		//这个已经被抛弃了被上两行代替
		
		try {
			List<FileItem> list = upload.parseRequest(request);
			out.println("遍历所的 FileItem 。。。<br/>");
			for (FileItem fileItem : list) {
				if (fileItem.isFormField()) {	//如果时文本域
					if ("Instruction1".equals(fileItem.getFieldName())) {	//如果该文本的名字时Instruction1
						out.println("遍历到 Instruction1 ...<br/>");
						instruction1 = new String(fileItem.getString().getBytes(),"UTF-8");
					}
					if("author".equals(fileItem.getFieldName())){
						out.println("遍历到 author ...<br/>");
						author = new String(fileItem.getString().getBytes(),"UTF-8");
					}
				}else {		//不是文本域，那就时文件域了
					if ("file1".equals(fileItem.getFieldName())) {		//如果该文件域的名字是file1
						out.println("遍历到 file1 ...<br/>");
						//file由原来的文字加简介名称
						File client = new File(new String(fileItem.getName().getBytes(),"UTF-8"));
						file1 = new File(this.getServletContext().getRealPath("/upload"),
								instruction1+"_"+author+"_"+client.getName());
						if (!file1.getAbsoluteFile().exists()) {	//如果不存在绝对路径就创建目录
							file1.getAbsoluteFile().mkdirs();
						}
						if (file1.exists()) {					//如果已经存在了就删除文件或目录重建
							file1.delete();
						}
						file1.createNewFile();
						InputStream inputStream = fileItem.getInputStream();
						OutputStream outputStream = new FileOutputStream(file1);
						byte[] buffer = new byte[1024*1024];
						int len=0;
						while((len=inputStream.read(buffer))>-1){
							outputStream.write(buffer, 0, len);
						}
						inputStream.close();
						outputStream.flush();
						outputStream.close();
						out.println("已在服务器端保存文件："+"<a href="+"'file://"+file1.getParent()+"'>"
								+file1.getAbsolutePath()+"</a><br/>");
					}
				}
				
			}
			
			
			
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		out.println("<hr/><div> <fieldset><legend='接收文件'>"
				+ "<div>文件介绍："+instruction1
				+ "</div>");
		out.println("<div>文件作者："+author+"</div>");
		out.println("<div>文件："+file1+"</div></div>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		
		
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

}
