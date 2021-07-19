package com.kdg.community.app.Controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kdg.community.app.Common.GetUserIp;
import com.kdg.community.app.Domain.MappingFiles;
import com.kdg.community.app.Service.MappingFilesService;

@Controller
public class MappingFilesController {

	private final MappingFilesService mappingFilesService;
	private static final String UPLOAD_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mappingFiles\\"; //파일 경로
	
	
	public MappingFilesController(MappingFilesService mappingFilesService) {
		this.mappingFilesService = mappingFilesService;
	}


	@PostMapping(value = "/app/mappingfiles/do_upload")
	@ResponseBody
	public Long do_upload(MultipartFile files, Long timestamp) {
		 String fileName		 = saveFile(files);
		 GetUserIp getUserIp 	 = new GetUserIp();
		 SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		 Date time 				 = new Date();
		 
		 MappingFiles mappingFiles = new MappingFiles();
		 mappingFiles.setTimestamp(timestamp);
		 mappingFiles.setFileName(fileName);
		 mappingFiles.setWriteDate(format.format(time));
		 mappingFiles.setWriteIp(getUserIp.returnIP());

		 mappingFilesService.insert(mappingFiles);
		 return mappingFiles.getCode();
	}
	
	@PostMapping("/app/mappingfiles/do_delete")
    @ResponseBody
    public void do_delete(Long code) {
		MappingFiles mappingFiles = mappingFilesService.getView(code);
        
        File file = new File(UPLOAD_PATH +""+ mappingFiles.getFileName());
        
        if(file.exists()){ 
            file.delete(); //파일 삭제
        }
        
        mappingFilesService.delete(mappingFiles.getCode());
    }
		
	private String saveFile(MultipartFile file){
        
        UUID uuid = UUID.randomUUID();
        String saveName = uuid + "_" + file.getOriginalFilename();
        
        // 저장할 File 객체를 생성(껍데기 파일)
        File saveFile = new File(UPLOAD_PATH,saveName); // 저장할 폴더 이름, 저장할 파일 이름
 
        try {
            file.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
 
        return saveName;
    } 
}
