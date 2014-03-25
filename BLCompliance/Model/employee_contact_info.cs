using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLCompliance.Model
{
    /// <summary>
    /// employee contact information
    /// </summary>
    public class employee_contact_info
    {
        public int ContactInfoId { get; set; }

        public int EmployeeId { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string AddressLine { get; set; }

        public string City { get; set; }

        public string State { get; set; }
        
        public string CountryName { get; set; }

        public string ZipCode { get; set; }

        public string TelePhone { get; set; }

        public string FaxNumber { get; set; }

        public bool IsActiveRecord { get; set; }

        public DateTime? Create_date { get; set; }

        public DateTime? Update_date { get; set; }

        public int create_by { get; set; } 
    }
}
