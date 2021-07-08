package com.kdg.community.app.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.EmailVerification;
import com.kdg.community.app.Repository.EmailVerificationRepository;

@Service
@Transactional
public class EmailVerificationService {

	private final EmailVerificationRepository emailVerificationRepository;

	public EmailVerificationService(EmailVerificationRepository emailVerificationRepository) {
		this.emailVerificationRepository = emailVerificationRepository;
	}
	
	public EmailVerification writeDateValidation(String value) {
		return emailVerificationRepository.writeDateValidation(value);
	}
	
	public EmailVerification insert(EmailVerification emailVerification) {
		return emailVerificationRepository.save(emailVerification);
	}
}
