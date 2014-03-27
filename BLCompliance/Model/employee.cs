using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLCompliance.Model
{
    public class employee
    {

        /// <summary>
        /// Unique Id for Employee
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// Employee Login Email
        /// </summary>
        public string EmailAddress { get; set; }

        public string Password { get; set; }

        public string Position { get; set; }

        public DateTime? DateOfHire { get; set; }

        public string Licence_Number { get; set; }

        public DateTime? Licence_Expiry { get; set; }

        public DateTime? DateLastExclusionCheck { get; set; }

        public bool IsActiveRecord { get; set; }

        public bool? IsDeleted { get; set; }
        /// <summary>
        /// 1 = Level1, 2= Level2 
        /// </summary>
        public int EmployeeType { get; set; }
        
        public string FacilityName { get; set; }

        public int FacilityId { get; set; }

        public DateTime? LastUpdateDate { get; set; }

        public DateTime? CreateDate { get; set; }

        public string ContactName { get; set; }

        public string EmployeeTypeText { get; set; }

        public int create_by { get; set; }

     

    }
}
