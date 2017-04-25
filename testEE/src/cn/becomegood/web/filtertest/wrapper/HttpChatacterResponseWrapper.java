package cn.becomegood.web.filtertest.wrapper;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

/**
 * 用于内容替换过滤器，
 * 因为该过滤器要求输出有缓存
 * @author fly
 *
 */
public class HttpChatacterResponseWrapper extends HttpServletResponseWrapper {

	public HttpChatacterResponseWrapper(HttpServletResponse response) {
		super(response);
		// TODO Auto-generated constructor stub
	}

	private CharArrayWriter charArrayWriter = new CharArrayWriter();	//已数组为目标的输出流

	@Override
	public PrintWriter getWriter() throws IOException {
		// TODO Auto-generated method stub
		return new PrintWriter(charArrayWriter);
		// 返回字符数组Writer，缓存内容
	}

	public CharArrayWriter getCharArrayWriter() {
		return charArrayWriter;
	}//get方法
}