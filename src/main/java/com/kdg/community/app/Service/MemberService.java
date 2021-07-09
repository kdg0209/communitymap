package com.kdg.community.app.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.Member;
import com.kdg.community.app.Repository.MemberRepository;

@Service
@Transactional
public class MemberService {

	private final MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
	
	public Member findById (String id) {
		return memberRepository.findById(id);
	}
	
	public Member login (String id, String password) {
		return memberRepository.findByIdAndPassword(id, password);
	}
}
