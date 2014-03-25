$(document).ready(function () {

    

    $(function () {
        /*  submit button common */
        $(".testcall").bind("click", function (e) {
            e.preventDefault();
            alert("test call..");
            GetListOfUsersToAssign(1);
            return false;

        });

        
    });
      

    init_course_assign();

    $(".close").click(function (e) {
        e.preventDefault();
        $("#assign_course_popup").hide();
    });

   
});


//function GetListOfUsersToAssign(courseId) {
//    $.ajax({
//        type: "POST",
//        url: "ManageTraining.aspx/GetUserListForCourse",
//        data: '{courseId: "' + courseId + '" }',
//        contentType: "application/json; charset=utf-8",
//        dataType: "json",
//        success: OnGetListOfUsersToAssignSuccess,
//        failure: function (response) {
//            alert("failed in get user list to assign to course.");
//        }
//    });
//}
//function OnGetListOfUsersToAssignSuccess(response) {
//    $(response).each(function (idx) {
//        $popupInner.append('<a href="#" class="jsLink user-link" accid="' + this.ID + '">' + this.DISPLAY_NAME + '</a>');
//    });
//}

function BindUserLinkEvents(courseId) {

    $(".user-link").bind('click', function (e) {
        e.preventDefault();
        var empId = $(this).attr("accid");
        var empName = $(this).text();
        $.ajax({
            type: "POST",
            url: "ManageTraining.aspx/AssignCourseToUser",
            data: '{empId: "' + empId + '" ,"courseId":"' + courseId + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $('.message-inner').html('User <b>' + empName + '</b> assign to the course.');
                $('.message').fadeIn(500);
                $('.message-inner').fadeIn(500);
                $(this).remove();
            },
            failure: function (response) {
                alert("failed in get user list to assign to course.");
            }
        });


        return false;
    });

}
function init_course_assign() {
    var $courseCatsWrapper = $('.cats_articles div.links');
    var $courseCats = $courseCatsWrapper.find('div.l_0');
    var $popup = $('#assign_course_popup');
    var $popupInner = $popup.find('.popup-inner');
    var $messageBox = $popup.find('.message');

    
    var currentCourseCat = null;

    $courseCats.find('a.assign-course').click(function (e) {
        $("#assign_course_popup").show();
        $popupInner.html('');
        $messageBox.hide();
        currentCourseCat = $(this).attr('course_id');
        $.ajax({
            type: "POST",
            url: "ManageTraining.aspx/GetUserListForCourse",
            data: '{cId: "' + currentCourseCat + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var employees = response.d;
                $.each(employees, function (index, employee) {
                    $popupInner.append('<a href="#" class="jsLink user-link"  courseId  accid="' + employee.EmployeeId + '">' + employee.EmployeeName + '</a>');
                });
                BindUserLinkEvents(currentCourseCat);
            },
            failure: function (response) {
                alert("failed in get user list to assign to course.");
            }
        });
    });

   

}