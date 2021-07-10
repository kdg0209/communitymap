package com.kdg.community.app.Domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "mappercategoryconfig")
public class MapperCategoryConfig {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	@ManyToOne
	@JoinColumn(name = "code", insertable = false, updatable = false)
	private Mapper mapper;
	
	private String name;
	private String imgPath;
}
