package com.oracle.s202350104.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class CourseDaoImpl implements CourseDao {

	private final SqlSession session;

	@Override
	public int courseCount() {
		int courseCount = 0;
		log.info("CourseDaoImpl courseCount start...");
		try {
			courseCount = session.selectOne("courseCount");
			log.info("CourseDaoImpl courseCount courseCount ->" + courseCount);
		} catch (Exception e) {
			log.info("CourseDaoImpl courseCount e.getMessage() ->" + e.getMessage());
		}
		return courseCount;
	}

	
	@Override
	public List<Course> courseList(Course course) {
		List<Course> courseList = null;
		log.info("CourseDaoImpl courseList start...");
		try {
			courseList = session.selectList("courseListAll", course);
			log.info("CourseDaoImpl courseList courseList.size() ->" + courseList.size());
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseList e.getMessage() ->" + e.getMessage());
		}
		
		return courseList;
	}

	
	@Override
	public List<Course> courseDetail(int course_id) {
		log.info("course_id ->" + course_id);
		List<Course> courseDetailList = null;
		try {
			courseDetailList = session.selectList("noCourseDetailList", course_id);
			log.info("CourseDaoImpl courseDetail courseDetailList.size() ->" + courseDetailList.size());
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseDetail e.getMessage() ->" + e.getMessage());
		}
		return courseDetailList;
	}


	@Override
	public int courseInsert(Course course) {
		int result = 0;
		int newCourseId= 0;
		try {
			log.info("CourseDaoImpl courseInsert courseInsert id->" + course.getId());
			result = session.insert("noCourseInsert", course);
			newCourseId = course.getId();
			log.info("CourseDaoImpl courseInsert courseInsert ->" + result);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseInsert e.getMessage() ->" + e.getMessage());
		}
		return newCourseId;
	}


	@Override
	public int courseContentInsert(List<CourseContent> courseContentList) {
		int courseContentInsert = 0;
		try {
			log.info("CourseDaoImpl courseContentInsert courseContentList ->" + courseContentList);
			courseContentInsert = session.insert("noCourseContentInsert", courseContentList);
			log.info("CourseDaoImpl courseInsert courseContentInsert ->" + courseContentInsert);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseContentInsert e.getMessage() ->" + e.getMessage());
		}
		return courseContentInsert;
	}

	
	@Override
	public int courseContentDelete(int id) {
		int courseContentDelete = 0;
		try {
			log.info("CourseDaoImpl courseContentDelete id ->" + id);
			courseContentDelete = session.delete("noCourseContentDelete", id);
			log.info("CourseDaoImpl courseContentDelete courseDelete ->" + courseContentDelete);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseContentDelete e.getMessage() ->" + e.getMessage());
		}
		return courseContentDelete;
	}
	
	@Override
	public int courseDelete(int id) {
		int courseDelete = 0;
		try {
			log.info("CourseDaoImpl courseDelete id ->" + id);
			courseDelete = session.delete("noCourseDelete", id);
			log.info("CourseDaoImpl courseDelete courseDelete ->" + courseDelete);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseDelete e.getMessage() ->" + e.getMessage());
		}
		return courseDelete;
	}


	@Override
	public Course courseUpdateDetail(int id) {
		log.info("CourseDaoImpl courseContent start...");
		Course courseUpdateDetail = null;
		try {
			courseUpdateDetail = session.selectOne("noCourseContent", id);
			log.info("CourseDaoImpl courseContent courseUpdateDetail ->" + courseUpdateDetail);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseContent e.getMessage() ->" + e.getMessage());
		}
		return courseUpdateDetail;
	}


	@Override
	public int courseUpdate(Course course) {
		log.info("CourseDaoImpl courseUpdate start...");
		int courseUpdate = 0;
		log.info("CourseDaoImpl courseUpdate course ->" + course);
		try {
			courseUpdate = session.update("noCourseUpdate", course);
			log.info("CourseDaoImpl courseUpdate courseUpdate ->" + courseUpdate);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseUpdate e.getMessage() ->" + e.getMessage());
		}
		
		return courseUpdate;
	}


	@Override
	public List<CourseContent> courseContentList(int id) {
		log.info("CourseDaoImpl courseContentList start...");
		List<CourseContent> courseContentList = null;
		try {
			courseContentList = session.selectList("noCourseContentList", id);
			log.info("CourseDaoImpl courseContentList ->" + courseContentList);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseContentList e.getMessage() ->" + e.getMessage());
		}
		
		return courseContentList;
	}


//	@Override
//	public int deleteCourseContent(int contentId, int courseId) {
//		log.info("CourseDaoImpl deleteCourseContent content_id ->" + contentId, courseId);
//		int deleteCourseContent = 0;
//		try {
//			deleteCourseContent = session.delete("noDeleteCourseContent", contentId, contentId);
//			log.info("CourseDaoImpl deleteCourseContent ->" + deleteCourseContent);
//			
//		} catch (Exception e) {
//			log.info("CourseDaoImpl deleteCourseContent e.getMessage() ->" + e.getMessage());
//		}
//		
//		return deleteCourseContent;
//	}


	@Override
	public int deleteCourseContent(CourseContent courseContent) {
		log.info("CourseDaoImpl deleteCourseContent courseContent ->" + courseContent);
		int deleteCourseContent = 0;

		try {
			deleteCourseContent = session.delete("noDeleteCourseContent", courseContent);
			log.info("CourseDaoImpl deleteCourseContent ->" + deleteCourseContent);
			
		} catch (Exception e) {
			log.error("CourseDaoImpl deleteCourseContent e.getMessage() ->" + e.getMessage());
		}
		
		return deleteCourseContent;
	}


	@Override
	public int deleteToContent(List<CourseContent> deleteContent) {
		log.info("CourseDaoImpl deleteToContent delList ->" + deleteContent);
		int deleteToContent = 0;
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("course_id", deleteContent.get(0).getCourse_id());
			params.put("list", deleteContent);
			
			deleteToContent = session.delete("noDeleteToContent", params);
			log.info("CourseDaoImpl deleteToContent deleteToContent ->" + deleteToContent);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl deleteToContent e.getMessage() ->" + e.getMessage());
		}
		return deleteToContent;
	}


	@Override
	public int maxOrderNum(int id) {
		int maxOrderNum = 0;
		try {
			maxOrderNum = session.selectOne("noMaxOrderNum", id);
			log.info("CourseDaoImpl maxOrderNum maxOrderNum ->" + maxOrderNum);
		} catch (Exception e) {
			log.info("CourseDaoImpl maxOrderNum e.getMessage() ->" + e.getMessage());
		}
		
		return maxOrderNum;
	}

	
//	@Override
//	public Course courseDetailContent(int id) {
//		log.info("id ->" + id);
//		Course courseDetailContent = null;
//		try {
//			courseDetailContent = session.selectOne("noCourseDetailContent",id);
//			log.info("CourseDaoImpl courseDetailContent courseDetailContent ->" + courseDetailContent);
//			
//		} catch (Exception e) {
//			log.info("CourseDaoImpl courseDetailContent e.getMessage() ->" + e.getMessage());
//		}
//		return courseDetailContent;
//	}
}
