/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author Luu Bach
 */
public class Mail {

    Session newSession = null;
    MimeMessage mimeMessage = null;

    public static void main(String[] args) throws MessagingException {
        Mail mail = new Mail();
        mail.setupServerProperties();
        mail.draftEmail();
        mail.sendEmail();
    }

    private void setupServerProperties() {
        Properties properties = System.getProperties();
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        newSession = Session.getDefaultInstance(properties, null);

    }

    private MimeMessage draftEmail() throws AddressException, MessagingException {
        String[] emailRecipients = {"luubach.it@gmail.com"}; //Enter list of email recipients
        String emailSubject = "Reset Your Password";
        String link = "https://www.youtube.com/"; // Replace with your actual link
        String emailBody = "Here is your link: <a href=\"" + link + "\">Click Here To Set Your New Password</a>";
        mimeMessage = new MimeMessage(newSession);

        for (int i = 0; i < emailRecipients.length; i++) {
            mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(emailRecipients[i]));
        }
        mimeMessage.setSubject(emailSubject);

// CREATE MIMEMESSAGE
// CREATE MESSAGE BODY PARTS
// CREATE MESSAGE MULTIPART
// ADD MESSAGE BODY PARTS ----> MULTIPART
// FINALLY ADD MULTIPART TO MESSAGECONTENT i.e. mimeMessage object
        MimeBodyPart bodyPart = new MimeBodyPart();
        bodyPart.setContent(emailBody, "text/html");
        MimeMultipart multiPart = new MimeMultipart();
        multiPart.addBodyPart(bodyPart);
        mimeMessage.setContent(multiPart);
        return mimeMessage;
    }

    private void sendEmail() throws MessagingException {
        String fromUser = "BachLDHE176589@fpt.edu.vn"; //Enter sender email id
        String fromUserPassword = "ddxt mtwn ryzu scqf"; //Enter sender gmail password, this will be authenticated by gmail smtp server 
        String emailHost = "smtp.gmail.com";
        Transport transport = newSession.getTransport("smtp");
        transport.connect(emailHost, fromUser, fromUserPassword);
        transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
        transport.close();
        System.out.println("Email successfully sent!!!");
    }

}
