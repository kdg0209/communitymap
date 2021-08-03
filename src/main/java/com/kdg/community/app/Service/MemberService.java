package com.kdg.community.app.Service;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
	
	public Page<Member> memberList(Pageable pageable){
		return memberRepository.memberList(pageable);
	}

	public Page<Object[]> mapperCountOfmemberList(Pageable pageable){
		return memberRepository.mapperCountOfmemberList(pageable);
	}
	
	public Member findByCode (Long code) {
		return memberRepository.findByCode(code);
	}
	
	public Member findById (String id) {
		return memberRepository.findById(id);
	}
	
	public Member login (String id, String password) {
		return memberRepository.findByIdAndPassword(id, password);
	}
	
	public boolean update (Member member) {
		Member updateMember = memberRepository.findByCode(member.getCode());
		try {
			
			updateMember.setIsAdmin(member.getIsAdmin());
			updateMember.setIsDenie(member.getIsDenie());
			updateMember.setPhone(member.getPhone());
			
			if(member.getPassword() != "") {
				updateMember.setPassword(member.getPassword());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	public void delete (Long code) {
		memberRepository.delete(code);
	}
}
