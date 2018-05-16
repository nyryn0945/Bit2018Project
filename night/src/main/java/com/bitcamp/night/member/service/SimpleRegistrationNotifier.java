package com.bitcamp.night.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.bitcamp.night.member.model.Member;

@Service("SimpleRegistrationNotifier")
public class SimpleRegistrationNotifier
{
	@Autowired
	private JavaMailSender mailSender;

	public void sendMail(Member member)
	{
		SimpleMailMessage message = new SimpleMailMessage();
		message.setSubject("[공지] 회원 가입을 축하합니다.");
		message.setFrom("isincorp@gmail.com");
		message.setText("회원 가입을 환영합니다.");
		message.setTo(member.getEmail());

		try {
			mailSender.send(message);
		}
		catch (MailException ex) {
			ex.printStackTrace();
		}
	}
}