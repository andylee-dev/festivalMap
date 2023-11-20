package com.oracle.s202350104.utils;

import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadUtil {
    public static String uploadFile(MultipartFile file, String uploadDirectory) throws FileUploadException {
        // 파일 유효성 검사 (파일 유형, 크기 등)
        // 파일 이름 관리 (중복 파일 이름 처리)

        try {
            // 파일 업로드 처리 (예: Apache Commons FileUpload 사용)
            // 업로드된 파일을 저장
            // 파일 경로를 반환
        } catch (Exception e) {
            throw new FileUploadException("파일 업로드 중 오류 발생", e);
        }
        return null;
    }
}
