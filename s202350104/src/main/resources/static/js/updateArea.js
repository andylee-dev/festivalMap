function updateAreaOptions() {
	$.ajax({
		url: "/getAreas",
		method: "GET",
		success: function (areas) {
			// Area select 옵션 업데이트
			$(".area-dropdown").empty().append("<option value='0'>시도</option>");
			$(".sigungu-dropdown").empty().append("<option value='0'>시군구</option>");
			areas.forEach(function (area) {
				$(".area-dropdown").append("<option value='" + area.area + "'>" + area.content + "</option>");
			});
			console.log("updateAreaOptions")
		},
		error: function () {
			alert("Area 정보를 가져오지 못했습니다.");
		}
	});
}

function updateSigunguOptions(selectedArea) {
	$.ajax({
		url: "/getSigungu/" + selectedArea,
		method: "GET",
		success: function (sigungu) {
			// Sigungu select 옵션 업데이트
			$(".sigungu-dropdown").empty().append("<option value='0'>시군구</option>");
			sigungu.forEach(function (s) {
				$(".sigungu-dropdown").append("<option value='" + s.sigungu + "'>"+ s.content + "</option>");
			});
			console.log("updateSigunguOptions")
		},
		error: function () {
			alert("Sigungu 정보를 가져오지 못했습니다.");
		}
	});
}