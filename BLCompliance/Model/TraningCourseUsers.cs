using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLCompliance.Model
{
    public class TraningCourseUsers
    {
        /// <summary>
        /// unique record id of traing assignment
        /// </summary>
        public int TrainingAssignmentId { get; set; }
        public int EmployeeId { get; set; }
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public int FacilityId { get; set; }
        public string EmployeeName { get; set; }
        public string EmailAddress { get; set; }
        public int EmpType { get; set; }
        public DateTime? DateAssigned { get; set; }
        public DateTime? DueDate { get; set; }
        /// <summary>
        /// 1 Not completed , 2 Completed
        /// </summary>
        public int CompletionStatus { get; set; }

        

    }
}
