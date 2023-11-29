<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalRecommed</title>
<script type="text/javascript">
	//json데이터 불러오기
	let mbtiSet = {};
	
	// 버튼 클릭 시 json 데이터 불러오기
	document.addEventListener("DOMContentLoaded", function () {
		fetch('/data/mbtiTest.json')
			.then(response => response.json())
			.then(data => {
				mbtiSet = data;
				startTest();
		});
	});
	
	let currentQuestionIndex = 0;
	const mbtiResult = {"E":0,"I":0,"N":0,"S":0,"T":0,"F":0,"J":0,"S":0};
	
	function startTest() {
	  showQuestion();
	}
	
	function showQuestion() {
		  const questionData = mbtiSet.question_set[currentQuestionIndex];
		  document.getElementById('question').innerHTML = questionData.question;
/* 		  document.getElementById('questionImage').src = questionData.img;
 */
		  const optionBtns = document.querySelectorAll('.optionBtn');
		  
		  optionBtns.forEach((btn, i) => {
		    const option = questionData.options[i];
		    btn.innerHTML = option.content;

		    // 이벤트 핸들러에서 현재 선택지 정보를 참조할 수 있도록 data 속성에 저장
		    btn.dataset.optionKey = option.key;
		    btn.dataset.optionVal = option.val;
		  });
		}
	
	function selectOption(event) {
	  const option = {
			    key: event.target.dataset.optionKey,
			    val: parseInt(event.target.dataset.optionVal)
			  };	  
	  const { key, val } = option;
	  if (mbtiResult[key]) {
	    mbtiResult[key] += val;
	  } else {
	    mbtiResult[key] = val;
	  }
	  
	  currentQuestionIndex++;
	  
	  if (currentQuestionIndex < mbtiSet.question_set.length) {
	    showQuestion();
	    updateProgressBar();
	  } else {
	    showResult();
	  }
	}
	
	function updateProgressBar() {
	  const progress = ((currentQuestionIndex ) / mbtiSet.question_set.length) * 100;
	  document.querySelector('.progress-bar').style.width = progress+"%";
	  document.querySelector('.progress-bar').innerHTML = (currentQuestionIndex ) +"/"+( mbtiSet.question_set.length);
	}
	
	function showResult() {
	  const mbtiResultValue = calculateMBTI();
	  alert('당신의 MBTI 유형은' + mbtiResultValue+'입니다.');
	}
	
	function calculateMBTI() {
	  let result = "";
	  result += mbtiResult.E > mbtiResult.I ? "E" : "I";
	  result += mbtiResult.S > mbtiResult.N ? "S" : "N";
	  result += mbtiResult.T > mbtiResult.F ? "T" : "F";
	  result += mbtiResult.J > mbtiResult.P ? "J" : "P";
	  
	  return result;
	}
	
</script>

</head>
<body>
	<div class="container-fluid" >
		<div class="container">
			<h1 class="title fs-5">나에게 맞는 축제</h1>
		</div>
		<div class="card text-bg-dark">

			<div class="progress" role="progressbar" aria-label="Warning example"
				aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
				<div class="progress-bar text-bg-warning" style="width: ${1/12}%"></div>
			</div>

			<h5 class="card-title" id="question">문제</h5>
			<img
				src="https://images.unsplash.com/photo-1468234560893-89c00b6385c8?q=80&w=1936&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
				id="questionImage" class="card-img" alt="...">
			<div class="card-img-overlay">
				<!-- 카드 안에 내용을 넣고 싶을때, -->
			</div>
			<div class="flex justify-content-center"></div>
		</div>
				<button type="button" class="optionBtn btn" onclick="selectOption(event)">선택1</button>
				<button type="button" class="optionBtn btn" onclick="selectOption(event)">선택2</button>
		</div>


</body>
</html>

