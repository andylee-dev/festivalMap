<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		function updateAreaOptions() {
			$.ajax({
				url: "/getAreas",
				method: "GET",
				success: function (areas) {
					// Area select 옵션 업데이트
					$("#area").empty().append("<option value='999'>전체</option>");
					areas.forEach(function (area) {
						$("#area").append(
							"<option value='" + area.area + "'>" + area.content
							+ "</option>");
					});
				},
				error: function () {
					alert("Area 정보를 가져오지 못했습니다.");
				}
			});
		}
		
		function updateSigunguOptions(selectedArea) {
			$
				.ajax({
					url: "/getSigungu/" + selectedArea,
					method: "GET",
					success: function (sigungu) {
						// Sigungu select 옵션 업데이트
						$("#sigungu").empty().append(
							"<option value='999'>전체</option>");
						sigungu.forEach(function (s) {
							$("#sigungu").append(
								"<option value='" + s.sigungu + "'>"
								+ s.content + "</option>");
						});
					},
					error: function () {
						alert("Sigungu 정보를 가져오지 못했습니다.");
					}
				});
		}
		document.addEventListener("DOMContentLoaded", function() {
			updateAreaOptions();
		$("#area").change(function() {
				const selectedArea = $(this).val();
		if (selectedArea) {
			updateSigunguOptions(selectedArea);
				} else {
			$("#sigungu").empty().append("<option value=''>---</option>");
				}
			});
		});
	</script>