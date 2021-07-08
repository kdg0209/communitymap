package com.kdg.community.app.Domain;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "emailverification")
public class EmailVerification {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	private String memberEmail;
	private String value;
	private String write_date;
}
