const isDuplicate = (user, callback) => {
    const {email, nickname} = user;
    console.log(email,nickname);

    $.ajax({
        method:"POST",
        url:"/admin/user/getTotalSearchUserAjax",
        contentType: "application/json", 
        data: JSON.stringify(user), 
        success: function(result) {
            console.log(result);

            // total user가 1 이상일 경우
            if (result >= 1) {
                callback(true); // 중복된 경우
            } else {
                callback(false); // 중복되지 않은 경우
            }
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
}   