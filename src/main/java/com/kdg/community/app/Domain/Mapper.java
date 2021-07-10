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

@Data
@Entity
@Table(name = "mapper")
public class Mapper {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	private char status;
	private String name;
	private String contents;
	private int memberCode;
	private int categoryCode;
	private int editAuth;
	private String editPassword;
	private String writeDate;
	private String writeIp;
	
	@ManyToOne
	@JoinColumn(name = "code", insertable = false, updatable = false)
	private Member member;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "mapper")
	private List<MapperNameConfig> mapperNameConfigList = new ArrayList<MapperNameConfig>();
	
	public void addMapperNameConfigList(MapperNameConfig mapperNameConfig) {
		mapperNameConfigList.add(mapperNameConfig);
		mapperNameConfig.setMapper(this);
	}
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "mapper")
	private List<MapperCategoryConfig> mapperCategoryConfigList = new ArrayList<MapperCategoryConfig>();
	
	public void addMapperCategoryConfigList(MapperCategoryConfig mapperCategoryConfig) {
		mapperCategoryConfigList.add(mapperCategoryConfig);
		mapperCategoryConfig.setMapper(this);
	}
}
