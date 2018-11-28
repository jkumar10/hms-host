package com.jndi;

import java.util.Properties;
import java.util.Random;

import javax.mail.*;
import javax.mail.internet.*;
//import javax.activation.*;
//import javax.servlet.http.*;
//import javax.servlet.*;
//import javax.net.*;

public class SendEmail {

	private String from = "hmsatiu@gmail.com";
	private String host = "smtp.gmail.com";
	private String pwd = "vetpetsys";
	private String port = "465";
	private boolean sessionDebug = true;
	// to be changed
	private String to; // recipient email
	private String subject;
	private String content;

	private String otp = "";
	private String tempPwd = "";

	// send email confirmation after registration
	public void setConfirmation() {
		this.subject = "Hello from VetPet";
		this.content = "Hello there! Thank you for registrating with VetPet! \n"; // email content
		this.content += "\nYours,\nVetPet";
	}

	// send one time password (otp)
	public void setOtp() {
		Random rand = new Random();
		for (int i = 0; i < 6; i++) {
			int r = rand.nextInt(10);
			this.otp += r;
		}

		this.subject = "Your One-Time Password for VetPet";
		this.content = "Hello! Your one-time password for vetpet is: " + otp + "\n";
		this.content += "Enjoy using VetPet System!\n\n\n";
		this.content += "Yours,\nVetPet";
	}

	public String getOtp() {
		return this.otp;
	}

	// send temporary password
	public void setTempPwd() {
		Random rand = new Random();
		String temp = "";

		for (int i = 0; i < 16; i++) {
			temp += Character.toString((char) (rand.nextInt(94) + 33));
		}

		this.tempPwd = temp;

		this.subject = "Your Temporary Password for VetPet";
		this.content = "Hello! This is your temporary password: \n" + tempPwd + "\n";
		this.content += "Please reset your password after logging in with this temporary password.\n\n\n";
		this.content += "Yours,\nVetPet";
	}

	public String getTempPwd() {
		return this.tempPwd;
	}

	public boolean sendApptConfim(String to, String time, String date, String lname, String addr)
			throws AddressException, MessagingException {
		this.subject = "Appointment Confirmation from VetPet";
		this.content = "Hello! Thank you for choosing VetPet. You have an appointment at " + time + " on " + date;
		this.content += " with Dr. " + lname + ". The appointment will take place at " + addr + ".\n";
		this.content += "We are looking forward to seeing you!\n\n\n";
		this.content += "Yours,\nVetPet";

		// Get system properties
		Properties props = System.getProperties();
		props.put("mail.host", host);
		props.put("mail.transport.protocol.", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.socketFactory.fallback", "true"); // was false, now set it true to test
		props.put("mail.smtp.ssl.enable", "true");

		// mail session
		Session mailSession = Session.getDefaultInstance(props, null);
		mailSession.setDebug(sessionDebug);
		Message msg = new MimeMessage(mailSession);
		msg.setFrom(new InternetAddress(from));
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
		msg.setSubject(subject);
		msg.setContent(content, "text/plain;charset=utf-8");

		// set transport properties
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(host, 465, from, pwd);

		try {
			// Transport.send(msg);
			transport.sendMessage(msg, msg.getAllRecipients());
			System.out.println("sent");
		} catch (Exception err) {
			System.out.println("Error" + err.getMessage());
			transport.close();
			return false;
		}
		transport.close();

		return true;
	}

	public boolean sendPlanConfirm(String to, String providerName, String planName, String petName)
			throws AddressException, MessagingException {
		this.subject = "Insurance Plan Confirmation from VetPet";
		this.content = "Hello! Thank you for choosing VetPet. You have successfully chosen the insurance plan "
				+ planName;
		this.content += " from " + providerName + " for " + petName + ". \n\n\n";
		this.content += "Yours,\nVetPet";

		// Get system properties
		Properties props = System.getProperties();
		props.put("mail.host", host);
		props.put("mail.transport.protocol.", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.socketFactory.fallback", "true"); // was false, now set it true to test
		props.put("mail.smtp.ssl.enable", "true");

		// mail session
		Session mailSession = Session.getDefaultInstance(props, null);
		mailSession.setDebug(sessionDebug);
		Message msg = new MimeMessage(mailSession);
		msg.setFrom(new InternetAddress(from));
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
		msg.setSubject(subject);
		msg.setContent(content, "text/plain;charset=utf-8");

		// set transport properties
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(host, 465, from, pwd);

		try {
			// Transport.send(msg);
			transport.sendMessage(msg, msg.getAllRecipients());
			System.out.println("sent");
		} catch (Exception err) {
			System.out.println("Error" + err.getMessage());
			transport.close();
			return false;
		}
		transport.close();

		return true;
	}

	public boolean sendEmail(int type, String to) throws AddressException, MessagingException {
		// type 0 - email confirmation
		// type 1 - otp
		// type 2 - temp pwd
		this.to = to;
		if (type == 0) {
			this.setConfirmation();
		} else if (type == 1) {
			this.setOtp();
		} else if (type == 2) {
			this.setTempPwd();
		} else {
			System.out.println("Cannot send email: email type out of range");
			return false;
		}

		// Get system properties
		Properties props = System.getProperties();
		props.put("mail.host", host);
		props.put("mail.transport.protocol.", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.socketFactory.fallback", "true"); // was false, now set it true to test
		props.put("mail.smtp.ssl.enable", "true");

		// mail session
		Session mailSession = Session.getDefaultInstance(props, null);
		mailSession.setDebug(sessionDebug);
		Message msg = new MimeMessage(mailSession);
		msg.setFrom(new InternetAddress(from));
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
		msg.setSubject(subject);
		msg.setContent(content, "text/plain;charset=utf-8");

		// set transport properties
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(host, 465, from, pwd);

		try {
			// Transport.send(msg);
			transport.sendMessage(msg, msg.getAllRecipients());
			System.out.println("sent");
		} catch (Exception err) {
			System.out.println("Error" + err.getMessage());
			transport.close();
			return false;
		}
		transport.close();

		return true;
	}

}
