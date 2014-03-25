using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLCompliance.Model
{
    public class TraningCourseUsers
    {
        public int EmployeeId { get; set; }
        public int CourseId { get; set; }
        public int FacilityId { get; set; }
        public string EmployeeName { get; set; }
        public string CourseName { get; set; }
        public string EmailAddress { get; set; }
    }
}
