  // 페이지 로드 후 실행되는 JavaScript 코드
  $(document).ready(function(){
    // pagination의 각 페이지 버튼에 대한 클릭 이벤트 처리
    $('.pagination .page-item a').on('click', function(e){
      e.preventDefault(); // 기본 동작 방지

      // 모든 페이지 버튼에서 active 클래스 제거
      $('.pagination .page-item').removeClass('active');

      // 클릭한 페이지 버튼에 active 클래스 추가
      $(this).parent().addClass('active');
    });
  });