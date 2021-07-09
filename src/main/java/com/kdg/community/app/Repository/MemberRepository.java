package com.kdg.community.app.Repository;

import org.springframework.data.repository.CrudRepository;

import com.kdg.community.app.Domain.Member;

public interface MemberRepository extends CrudRepository<Member, Long>{

	Member findById(String id);
	
	Member findByIdAndPassword(String id, String password);
}
