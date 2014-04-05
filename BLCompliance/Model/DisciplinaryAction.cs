using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLCompliance.Model
{
    /// <summary>
    /// model class for Disciplinary Action
    /// </summary>
    public class DisciplinaryAction
    {
        /// <summary>
        /// Unique Id for DisciplinaryAction
        /// </summary>
        public int Id { get; set; }
        /// <summary>

        public int EmployeeId { get; set; }

        public string EmployeeName { get; set; }

        public string Infraction { get; set; }
        public string Infraction_ShortText { get; set; }

        public DateTime DateOfAction { get; set; }

        public string ActionDescription { get; set; }
        public string ActionDescription_ShortText { get; set; }

        public int CreatedBy { get; set; }

        public DateTime CreatedDate { get; set; }

    }
}
