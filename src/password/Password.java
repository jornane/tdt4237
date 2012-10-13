package password;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import sun.misc.BASE64Encoder;



public class Password {
	
    private static final String ENCODING = "UTF-8";
    private static final String ENCRYPTION_ALGORITHM = "SHA-512";
    private static final int SALT_LENGTH = 10;
    private static final BASE64Encoder encoder = new BASE64Encoder();
	
	public static final String getSalt() throws UnsupportedEncodingException {
        SecureRandom random = new SecureRandom();
        byte bytes[] = new byte[SALT_LENGTH];
        random.nextBytes(bytes);
        String salt = encoder.encode(bytes);
        return salt;
    }
	
	
	public static final String hashWithSalt(String password, String salt) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        String result;
        	byte[] hash = null;
            byte[] MessageBytes = password.getBytes(ENCODING);
            byte[] saltBytes = salt.getBytes(ENCODING);
            MessageDigest md = MessageDigest.getInstance(ENCRYPTION_ALGORITHM);
            md.reset();
            md.update(saltBytes);
            md.update(MessageBytes);
            hash = md.digest();
            result = encoder.encode(hash);
        return result;
    }
	

}
