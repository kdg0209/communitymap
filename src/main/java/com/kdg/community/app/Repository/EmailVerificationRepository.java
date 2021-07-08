package com.kdg.community.app.Repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.kdg.community.app.Domain.EmailVerification;

public interface EmailVerificationRepository extends CrudRepository<EmailVerification, Long>{

	@Query(value = "SELECT * FROM emailverification WHERE memberEmail = :value ORDER BY write_date DESC LIMIT 1 OFFSET 0", nativeQuery = true)
	EmailVerification writeDateValidation(@Param("value") String value);
}
