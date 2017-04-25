package cn.becomegood.web.test2;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5的简单类
 * @author fly
 *
 */
public final class SafeUtil {
	private static String KEY="cookie:becomegood.cn";
	//工具类构造函数私有化
	private SafeUtil(){
		
	}

	/**
	 * 自定义的md5加密函数
	 * @param ss	要加密的字符串
	 * @return
	 */
	public static String calcMD5(String ss) {
		String s = (ss==null ? "" : ss);		//若未空返回空字符串
		try {
			//创建字典
			char[] hexDigits = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
			byte[] strTemp = s.getBytes();		//获取对应字节
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");	//获取md5加密方式
			mdTemp.update(strTemp);				//更新数据
			byte[] md = mdTemp.digest();		//加密
			int j = md.length;					//加密后字节数组的长度
			char[] result = new char[2*j];		//创建字符串数组
			int k = 0;							//用于计数
			for (byte b : md) {
				result[k++]=hexDigits[b >>> 4 & 0xf];		//把前面大4位，转换成对应的16以下的数字
				result[k++]=hexDigits[b & 0xf];				//把后面小4位，转换成对应的16以下的数字
			}
			return new String(result);			//反回字符串
		} catch (NoSuchAlgorithmException e) {
			return null;						//出错反回null
		}
	}
	
	
	public static String getKEY() {
		return KEY;
	}
	
	public static void setKEY(String kEY) {
		KEY = kEY;
	}
	
	
	
	
}
