using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLCompliance.Model
{
    public class TrainingCourse
    {
        public int course_id { get; set; }
        public string course_title { get; set; }
        public int create_by { get; set; }
        public int update_by { get; set; }
        public DateTime create_date { get; set; }
        public DateTime update_date { get; set; }
        public bool is_deleted { get; set; }
        public bool is_active_record { get; set; }
    }
}
