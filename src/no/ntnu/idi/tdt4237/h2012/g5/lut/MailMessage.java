package no.ntnu.idi.tdt4237.h2012.g5.lut;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.UnknownHostException;


public class MailMessage implements Runnable {

	private Socket socket;
	private InetAddress mailServer;
	private int lastCode;
	private String from;
	private String to;
	private String subject;
	private String content;
	private Exception terminateReason;

	public MailMessage(String from, String to, String subject, String content, InetAddress mailServer) throws IOException {
		socket = new Socket();
		// TODO: check if valid
		this.from = from;
		// TODO: check if valid
		this.to = to;
		// TODO: make subject conform rfc2047
		this.subject = subject.replaceAll("[\r\n]+", " ");
		this.content = content;
		this.mailServer = mailServer;
	}
	
	public void scheduleTimeout(final long timeOut) {
		new Thread(){public void run() {
			try {
				Thread.sleep(timeOut);
				interrupt();
			} catch (Exception e) {}
			}
		}.start();
	}
	
	public void interrupt() throws IOException {
		socket.close();
	}

	public void run() {
		try {
			socket.connect(new InetSocketAddress(mailServer, 25));
			BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			OutputStreamWriter out = new OutputStreamWriter(socket.getOutputStream());
			expectCode(in, 220);
			out.write("HELO "+InetAddress.getLocalHost().getHostName()+"\r\n");
			out.flush();
			expectCode(in, 250);
			out.write("MAIL FROM: "+from+"\r\n");
			out.flush();
			expectCode(in, 250);
			out.write("RCPT TO: "+to+"\r\n");
			out.flush();
			expectCode(in, 250);
			out.write("DATA"+"\r\n");
			out.flush();
			expectCode(in, 354);
			out.write("From: "+from+"\r\n");
			out.write("To: "+to+"\r\n");
			out.write("Subject: "+subject+"\r\n");
			out.write("MIME-Version: 1.0\r\n");
			out.write("Content-Type: text/plain; charset=ISO_8859-1\r\n");
			out.write("This is a MIME encoded message.\r\n\r\n");
			out.write(content+"\r\n\r\n");
			out.write(".\n");
			out.flush();
			expectCode(in, 250);
			out.write("QUIT");
			out.flush();
			interrupt();
		} catch (Exception e) {
			this.terminateReason = e;
		}
	}

	private void expectCode(BufferedReader in, int expected) throws IOException {
		if (nextCode(in) != expected)
			throw new UnsupportedOperationException("Invalid code: "+lastCode+", expected "+expected);
	}
	private int nextCode(BufferedReader in) throws IOException {
		String line = in.readLine();
		System.out.println(line);
		if (line.charAt(3) != ' ')
			return -1;
		return lastCode = Integer.parseInt(line.substring(0, 3));
	}
	
	public Exception getTerminateReason() {
		return terminateReason;
	}

}
