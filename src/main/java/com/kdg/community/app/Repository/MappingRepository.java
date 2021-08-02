package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.Mapping;

public interface MappingRepository extends CrudRepository<Mapping, Long>{

	@Query(value = "SELECT m FROM Mapping m INNER JOIN m.mapper WHERE m.mapper.code = :mapperCode")
	Page<Mapping> mappingListByMapper(@Param("mapperCode") Long mapperCode, Pageable pageable);
	
	@Query(value = "SELECT mapping.*, mappercategoryconfig.name AS categoryName, hasName.fieldValues AS fieldValues FROM mapping " +
			" JOIN mappercategoryconfig ON mapping.categoryCode = mappercategoryconfig.code" +  
			" JOIN mappinghasnames AS hasName ON hasName.code = " +   
			" (SELECT mappinghasnames.code FROM mappinghasnames WHERE mapping.code = mappinghasnames.mappingCode LIMIT 1) " +   
			" WHERE mapping.mapperCode = :mapperCode " +
			" AND mapping.longitude >= :south_west_lng " +
			" AND mapping.longitude <= :north_east_lng " +
			" AND mapping.latitude >= :south_west_lat " +
			" AND mapping.latitude <= :north_east_lat ", nativeQuery = true)
	List<Object[]> mappingListByAllMap(@Param("mapperCode") Long mapperCode, 
									   @Param("south_west_lng") Double south_west_lng, 
									   @Param("north_east_lng") Double north_east_lng, 
									   @Param("south_west_lat") Double south_west_lat, 
									   @Param("north_east_lat") Double north_east_lat);
	
	@Query(value = "SELECT mapping.*, mappercategoryconfig.name AS categoryName, hasName.fieldValues AS fieldValues FROM mapping " +
			" JOIN mappercategoryconfig ON mapping.categoryCode = mappercategoryconfig.code" +  
			" JOIN mappinghasnames AS hasName ON hasName.code = " +   
			" (SELECT mappinghasnames.code FROM mappinghasnames WHERE mapping.code = mappinghasnames.mappingCode LIMIT 1) " +   
			" WHERE mapping.mapperCode = :mapperCode " +
			" AND mapping.longitude >= :south_west_lng " +
			" AND mapping.longitude <= :north_east_lng " +
			" AND mapping.latitude >= :south_west_lat " +
			" AND mapping.latitude <= :north_east_lat " +
			" AND categoryCode IN :categoryCode ", nativeQuery = true)
	List<Object[]> mappingCategoryListByAllMap(@Param("mapperCode") Long mapperCode, 
									   @Param("south_west_lng") Double south_west_lng, 
									   @Param("north_east_lng") Double north_east_lng, 
									   @Param("south_west_lat") Double south_west_lat, 
									   @Param("north_east_lat") Double north_east_lat,
									   @Param("categoryCode") List<Long> categoryCode);
	
	@Query(value = "SELECT code, markerImg, latitude, longitude FROM mapping WHERE mapperCode = :mapperCode " +
			" AND longitude >= :south_west_lng " +
			" AND longitude <= :north_east_lng " +
			" AND latitude >= :south_west_lat " +
			" AND latitude <= :north_east_lat ", nativeQuery = true)
	List<Object[]> mappingMarkerListData(@Param("mapperCode") Long mapperCode, 
									   @Param("south_west_lng") Double south_west_lng, 
									   @Param("north_east_lng") Double north_east_lng, 
									   @Param("south_west_lat") Double south_west_lat, 
									   @Param("north_east_lat") Double north_east_lat);
	
	@Query(value = "SELECT code, markerImg, latitude, longitude FROM mapping WHERE mapperCode = :mapperCode " +
			" AND longitude >= :south_west_lng " +
			" AND longitude <= :north_east_lng " +
			" AND latitude >= :south_west_lat " +
			" AND latitude <= :north_east_lat " + 
			" AND categoryCode IN :categoryCode ", nativeQuery = true)
	List<Object[]> mappingMarkerCategoryListData(@Param("mapperCode") Long mapperCode, 
									   @Param("south_west_lng") Double south_west_lng, 
									   @Param("north_east_lng") Double north_east_lng, 
									   @Param("south_west_lat") Double south_west_lat, 
									   @Param("north_east_lat") Double north_east_lat,
									   @Param("categoryCode") List<Long> categoryCode);
	
	@Query(value = "SELECT mapping.*, mappercategoryconfig.name AS categoryName, hasName.fieldValues AS fieldValues FROM mapping " +
			" JOIN mappercategoryconfig ON mapping.categoryCode = mappercategoryconfig.code" +  
			" JOIN mappinghasnames AS hasName ON hasName.code = " +   
			" (SELECT mappinghasnames.code FROM mappinghasnames WHERE mapping.code = mappinghasnames.mappingCode LIMIT 1) " +   
			" WHERE mapping.code = :code ", nativeQuery = true)
	List<Object[]> mappingSelectOneMarker(@Param("code") Long code);
	
//	@Query(value = "SELECT m FROM Mapping m JOIN FETCH m.mapper WHERE m.mapper.code = :mapperCode")
//	List<Mapping> mappingList(@Param("mapperCode") Long mapperCode);
	
	@Query(value = "SELECT * FROM Mapping WHERE mapperCode = :mapperCode", nativeQuery = true)
	List<Mapping> mappingList(@Param("mapperCode") Long mapperCode);
	
	@Query(value = "SELECT m FROM Mapping m JOIN FETCH m.mapperCategoryConfig WHERE m.mapperCategoryConfig.code = :categoryCode")
	List<Mapping> findCategoryCodeList(@Param("categoryCode") Long categoryCode);
	
	@Query(value = "SELECT m FROM Mapping m JOIN FETCH m.mapper WHERE m.code = :code AND m.mapper.code = :mapperCode")
	public Mapping view(@Param("code") Long code, @Param("mapperCode") Long mapperCode);

	@Modifying
	@Transactional
	@Query(value = "DELETE FROM Mapping WHERE code = :code")
	public void delete(@Param("code") Long code);
	
	

}
