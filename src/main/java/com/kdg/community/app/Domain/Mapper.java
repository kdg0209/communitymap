package com.kdg.community.app.Domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


import lombok.Data;
import lombok.ToString;

@Data
@ToString(exclude = {"member", "mapperNameConfigList", "mapperCategoryConfigList"})
@Entity
@Table(name = "mapper")
public class Mapper {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	private char status;
	private String fileName;
	private String name;
	private String contents;
	private int categoryCode;
	private int editAuth;
	private String editPassword;
	private String writeDate;
	private String writeIp;
	
	@ManyToOne
	@JoinColumn(name = "memberCode")
	private Member member;
	
	public void setDept(Member member) {
		this.member = member;
		
		if(member != null) {
			member.getMapperList().add(this);
		}
	}
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "mapper")
	private List<MapperNameConfig> mapperNameConfigList = new ArrayList<MapperNameConfig>();
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "mapper")
	private List<MapperCategoryConfig> mapperCategoryConfigList = new ArrayList<MapperCategoryConfig>();
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "mapper")
	private List<Mapping> mappingList = new ArrayList<Mapping>();

}
