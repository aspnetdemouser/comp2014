using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLCompliance.Model
{
   public class reportinginfo
    {
        /// <summary>
        /// Unique IncidentId for Incident
        /// </summary>
        public int IncidentId { get; set; }

        public int DepartmentId { get; set; }

        public string DepartmentName { get; set; }

        public string PersonFirstName { get; set; }

        public string PersonLastName { get; set; }

        public string PersonInvolved { get; set; }

        public string Status { get; set; }

        public string Resolution { get; set; }

        public DateTime? IncidentDateClosed { get; set; }
      
        public string IncidentDescription { get; set; }

        public DateTime? IncidentOccuredDate { get; set; }

        public DateTime? IncidentReportedDate { get; set; }

        public bool IsAonymously { get; set; }

        public bool? IsActiveRecord { get; set; }

        public DateTime? LastUpdateDate { get; set; }

        public DateTime? CreateDate { get; set; }

        public int create_by { get; set; }

        public int update_by { get; set; }

        public string CSVIncidentDepartment { get; set; }
        public string CSVIncidentPerson { get; set; }
       
       
        #region Inbox Property

        public int InboxId { get; set; }

        public string Subject { get; set; }

        public string Type { get; set; }

        public string Date { get; set; }

        public string From { get; set; }

        public string ReportType { get; set; }

        public string IncidentTypeCount { get; set; }
       
        #endregion
    }
}
