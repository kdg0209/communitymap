package com.kdg.community.app.Domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "member")
@Data
public class Member {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	private char is_certification;
	private String id;
	private String password;
	private String name;
	private String nickname;
	private String phone;
	private String email;
	private String write_date;
	private String write_ip;
	
	@OneToMany( mappedBy = "member", fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
	private List<Mapper> mapperList = new ArrayList<Mapper>();
	
}
