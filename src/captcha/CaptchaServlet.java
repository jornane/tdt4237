package captcha;

import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.*;
import java.math.BigInteger;
import java.net.*;

import java.util.Random;
import java.security.*;
import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.http.*;

public class CaptchaServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, 
                                HttpServletResponse response) 
                 throws ServletException, IOException {

    int width = 150;
    int height = 50;

    StringBuilder s = new StringBuilder();


    BufferedImage bufferedImage = new BufferedImage(width, height, 
                  BufferedImage.TYPE_INT_RGB);

    Graphics2D g2d = bufferedImage.createGraphics();

    Font font = new Font("Georgia", Font.BOLD, 18);
    g2d.setFont(font);

    RenderingHints rh = new RenderingHints(
           RenderingHints.KEY_ANTIALIASING,
           RenderingHints.VALUE_ANTIALIAS_ON);

    rh.put(RenderingHints.KEY_RENDERING, 
           RenderingHints.VALUE_RENDER_QUALITY);

    g2d.setRenderingHints(rh);

    GradientPaint gp = new GradientPaint(0, 0, 
    Color.red, 0, height/2, Color.black, true);

    g2d.setPaint(gp);
    g2d.fillRect(0, 0, width, height);

    g2d.setColor(new Color(255, 153, 0));

    Random r = new Random();
    int index = Math.abs(r.nextInt()) % 2;
    
    for( int i=0; i<index+5; i++ )
    	s.append((char)(Math.abs(r.nextInt())%26+'a'));

    String captcha = s.toString();
    String md5 = getMD5Hash(captcha);
    
    request.getSession().setAttribute("captcha", md5 );

    int x = 0; 
    int y = 0;

    for (int i=0; i<captcha.length(); i++) {
        x += 10 + (Math.abs(r.nextInt()) % 15);
        y = 20 + Math.abs(r.nextInt()) % 20;
        g2d.drawChars(captcha.toCharArray(), i, 1, x, y);
    }

    g2d.dispose();

    response.setContentType("image/png");
    OutputStream os = response.getOutputStream();
    ImageIO.write(bufferedImage, "png", os);
    os.close();
  } 
  
  public static String getMD5Hash( String s )
  {
	  	String md5 = null;
		try	{
		    MessageDigest mdEnc = MessageDigest.getInstance("MD5"); // Encryption algorithm
		    mdEnc.update(s.getBytes(), 0, s.length());
		    md5 = new BigInteger(1, mdEnc.digest()).toString(16); // Encrypted string
		} catch ( Exception e )	{
			e.printStackTrace();
		}	
		
		return md5;	   
  }

  protected void doGet(HttpServletRequest request, 
                       HttpServletResponse response)
                           throws ServletException, IOException {
      processRequest(request, response);
  } 


  protected void doPost(HttpServletRequest request, 
                        HttpServletResponse response)
                            throws ServletException, IOException {
      processRequest(request, response);
  }
}
