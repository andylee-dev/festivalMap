package com.oracle.s202350104.utils;

import java.io.File;
import java.util.UUID;

import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUploadDeleteUtil {

	// 파일 이름 관리 (중복 파일 이름 처리)
	UUID uuid = UUID.randomUUID();
	String pathDB = null;
	String fileName = null;
	String realPath = null;
	String realFileSize = null;
	File fileSaveAndDelete = null;
	String[] uploadResult = null;

	// 파일 업로드 처리
	public String[] uploadFile(MultipartFile file) throws FileUploadException {

		try {
			if (file != null && !file.isEmpty()) {
				fileName = uuid + "_" + file.getOriginalFilename();
				pathDB = "..\\photos\\";
				realPath = System.getProperty("user.dir") + "\\src\\main\\webapp\\photos";
				fileSaveAndDelete = new File(realPath, fileName);
				realFileSize = (file.getSize() / 1024) + "KB";

				// 업로드된 파일을 저장
				file.transferTo(fileSaveAndDelete);
			} else {
				// 파일이 없을 경우 처리
				fileName = ""; // 빈 문자열 또는 다른 기본값으로 설정
				pathDB = ""; // 빈 문자열 또는 다른 기본값으로 설정
				realPath = "";
				realFileSize = "";
			}
			// 파일이름, 용량, 경로를 반환
			uploadResult = new String[] { fileName, pathDB, realFileSize };

			log.info("uploadFile getSize : {}", realFileSize);
			log.info("uploadFile fileName : {}", fileName);
			log.info("uploadFile pathDB : {}", pathDB);
			log.info("uploadFile realPath : {}", realPath);
			log.info("uploadFile savaFile : {}", fileSaveAndDelete);
		} catch (Exception e) {
			throw new FileUploadException("파일 업로드 중 오류 발생", e);
		}
		return uploadResult;
	}

	// 파일 삭제 처리
	public void deleteFile(String fileName) throws FileUploadException {
		// 파일 유효성 검사 (파일 유형, 크기 등)
		try {
			// 실제 경로
			realPath = System.getProperty("user.dir") + "\\src\\main\\webapp\\photos";

			// 구현체 생성(실 경로 + 파일명)
			fileSaveAndDelete = new File(realPath, fileName);

			// 원본 File 삭제
			fileSaveAndDelete.delete();

			log.info("deleteFile getSize : {}", realFileSize);
			log.info("deleteFile fileName : {}", fileName);
			log.info("deleteFile realPath : {}", realPath);

		} catch (Exception e) {
			log.error("deleteFile errer : {}", e.getMessage());
		}
	}
}
