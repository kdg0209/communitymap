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
@ToString(exclude = {"mappingHasNamesList"})
@Entity
@Table(name = "mapping")
public class Mapping {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	private String md_type;
	private String md_id;
	private char status;
	private Long timestamp;
	private Long categoryCode;
	private String markerImg;
	private String fileName;
	private String address;
	private double latitude;
	private double longitude;
	private String writeDate;
	private String writeIp; 
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "mapperCode")
	private Mapper mapper;
	
	public void setMapper(Mapper mapper) {
		this.mapper = mapper;
		
		if(mapper != null) {
			mapper.getMappingList().add(this);
		}
	}
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "mapping")
	private List<MappingHasNames> mappingHasNamesList = new ArrayList<MappingHasNames>();
}
