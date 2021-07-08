package com.kdg.community.app.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.Member;
import com.kdg.community.app.Repository.JoinRepository;

@Service
@Transactional
public class JoinService {

	private final JoinRepository joinRepository;

	public JoinService(JoinRepository joinRepository) {
		this.joinRepository = joinRepository;
	}
	
	public int idValidation(String value) {
		return joinRepository.idValidation(value);
	}
	
	public int nicknameValidation(String value) {
		return joinRepository.nicknameValidation(value);
	}
	
	public int phoneverification(String value) {
		return joinRepository.phoneverification(value);
	}
	
	public int emailverification(String value) {
		return joinRepository.emailverification(value);
	}
	
	public Member insert(Member member) {
		return joinRepository.save(member);
	}
}
