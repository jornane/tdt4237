package no.ntnu.idi.tdt4237.h2012.g5.lut;

import javax.servlet.http.HttpServletRequest;

final public class ProxyService {

	private ProxyService() {/* don't use it*/}

	private static final String HEADER_X_FORWARDED_FOR =
			"X-FORWARDED-FOR";

	public static String remoteAddr(HttpServletRequest request, boolean trustChain) {
		try {
			String remoteAddr = request.getRemoteAddr();
			String x;
			if ((x = request.getHeader(HEADER_X_FORWARDED_FOR)) != null)
				return remoteAddr(x, trustChain);
			return remoteAddr;
		} catch (Exception e) {
			return request.getRemoteAddr();
		}
	}
	public static String remoteAddr(String headerValue, boolean trustChain) {
		int idx = headerValue.indexOf(',');
		if (idx > -1)
			if (trustChain)
				return headerValue = headerValue.substring(0, idx);
			else
				return headerValue = headerValue.substring(idx+1).trim();
		return headerValue;
	}

}
