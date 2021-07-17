package com.kdg.community.app.Domain;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "mapping")
public class Mapping {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	private String md_type;
	private String md_id;
	private char status;
	private Timestamp timestamp;
	private String address;
	private Long categoryCode;
	private String markerImg;
	private double latitude;
	private double longitude;
	private String writeDate;
	private String writeIp; 
	
	@ManyToOne
	@JoinColumn(name = "mapperCode")
	private Mapper mapper;
	
	public void setMapper(Mapper mapper) {
		this.mapper = mapper;
		
		if(mapper != null) {
			mapper.getMappingList().add(this);
		}
	}
}
