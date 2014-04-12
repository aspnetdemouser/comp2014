using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance;
using BLCompliance.Model;
using System.Text;
using System.Web.Services;
using System.Runtime.Serialization.Json;
using System.Collections;
using System.Reflection;
using System.Globalization;


public partial class reporting : System.Web.UI.Page
{
    #region Page Load
    
    static int TrackinID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] == null)
        {
            Response.Redirect("login.aspx");
        }

        if (!IsPostBack)
        {
            BindDepartmentreportList();
            employee ObjSessionEmp = null;
            ObjSessionEmp = HttpContext.Current.Session["emp2014br2"] as employee;


            if (GetSelectedInboxId() > 0)
            {
                TrackinID = GetSelectedInboxId();
                List<reportinginfo> ReportingList = new List<reportinginfo>();
                BLReportinginfo.ReportingList(GetSelectedInboxId(), ObjSessionEmp.create_by, "","", out ReportingList);
                plsTracking.Visible = true;

                foreach (reportinginfo ObjReport in ReportingList)
                {
                    REPORT_DATE.Text = Convert.ToDateTime(ObjReport.Date).ToString("MM/dd/yyyy");
                    drpDepartment.SelectedValue = Convert.ToString(ObjReport.DepartmentId);
                    FLNAME.Text = ObjReport.PersonInvolved;
                    MESSAGE.Text = ObjReport.IncidentDescription;
                    if (Convert.ToBoolean(ObjReport.IsAonymously) == true)
                    {
                        Submitanonymously.Checked = true;
                        txtSubmittedby.Text = "";
                    }
                    else
                    {
                        txtSubmittedby.Text = ObjReport.From.Split(' ')[0];

                    }
                }



            }
        }
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        employee loginEmp = null;
        if (Session["emp2014br2"] != null)
        {
            loginEmp = Session["emp2014br2"] as employee;
        }
        if (null != loginEmp && loginEmp.EmployeeType == 1)
        {
            this.Page.MasterPageFile = "~/Firstlevel.master";
        }
        else
        {
            this.Page.MasterPageFile = "~/main.master";
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (Request.QueryString["enc"] == null)
        {
            //
            Label lblEmpName = (Label)Master.FindControl("lblEmpName");

            txtSubmittedby.Text = lblEmpName.Text;
            hdnSubmittedby.Text = lblEmpName.Text;
        }
    }
    protected int GetSelectedInboxId()
    {
        int InboxId = 0;
        //EmployeeId = string.IsNullOrEmpty(Convert.ToString(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_EDIT_EMPLOYEE_ID])) ? 0 : Convert.ToInt32(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_EDIT_EMPLOYEE_ID]);

        if (Request.QueryString["enc"] != null)
        {
            byte[] data = Convert.FromBase64String(Request.QueryString["enc"].ToString());
            string decodedString = Encoding.UTF8.GetString(data);
            int.TryParse(decodedString, out InboxId);
        }

        return InboxId;
    }
    #endregion

    #region Binding Control
    private void BindDepartmentreportList()
    {
        List<reportinginfo> DepartmentreportList = new List<reportinginfo>();
        BLReportinginfo.DepartmentreportList(out DepartmentreportList);
        drpDepartment.DataSource = DepartmentreportList;
        drpDepartment.DataTextField = "DepartmentName";
        drpDepartment.DataValueField = "DepartmentId";
        drpDepartment.DataBind();
        drpDepartment.Items.Insert(0, new ListItem("", ""));
    }
    #endregion

    #region Web Method
    [WebMethod(true)]
    public static string SaveReporting(object Objreportinginfo)
    {
        string result = "success";
        try
        {
            employee ObjSessionEmp = null;
            if (HttpContext.Current.Session["emp2014br2"] != null)
            {
                ObjSessionEmp = HttpContext.Current.Session["emp2014br2"] as employee;
            }

            reportinginfo objincident = new reportinginfo();
            Dictionary<string, object> objreportinginfoData = (Dictionary<string, object>)Objreportinginfo;

            if (TrackinID > 0)
            {


                reportinginfo objTrackingIncident = new reportinginfo();
                
                //objTrackingIncident.IncidentDateClosed = Convert.ToDateTime(Convert.ToString(objreportinginfoData["IncidentDateClosed"]));

                if (objreportinginfoData.ContainsKey("IncidentDateClosed") && objreportinginfoData["IncidentDateClosed"] != null)
                {
                    string dateIncidentClosed = objreportinginfoData["IncidentDateClosed"].ToString();

                    if (!string.IsNullOrEmpty(dateIncidentClosed))
                    {
                        DateTime tempDate;
                        if (DateTime.TryParseExact(dateIncidentClosed, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                        {
                            objTrackingIncident.IncidentDateClosed = tempDate;
                        }
                    }
                }

                if (objreportinginfoData.ContainsKey("Resolution"))
                {
                    objTrackingIncident.Resolution = Convert.ToString(objreportinginfoData["Resolution"]);
                }

                if (objreportinginfoData.ContainsKey("Status"))
                {
                    objTrackingIncident.Status = Convert.ToString(objreportinginfoData["Status"]);
                }

                objTrackingIncident.IncidentId = TrackinID;
                BLCompliance.Result resultIncidentTrackInfo = BLReportinginfo.UpdateTrackingIncidentInfo(objTrackingIncident, out objTrackingIncident);
                if (objTrackingIncident != null && resultIncidentTrackInfo.ResultCode == 1)
                {
                    result = resultIncidentTrackInfo.ResultMessage;
                    return result;
                }
                else
                {
                    result = resultIncidentTrackInfo.ResultMessage;
                    return result;
                }
            }



            //objincident.IncidentReportedDate = Convert.ToDateTime(Convert.ToString(objreportinginfoData["IncidentReportedDate"]));

            if (objreportinginfoData["IncidentReportedDate"] != null)
            {
                string incidentReportDate = objreportinginfoData["IncidentReportedDate"].ToString();

                if (!string.IsNullOrEmpty(incidentReportDate))
                {
                    DateTime tempDate;
                    if (DateTime.TryParseExact(incidentReportDate, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objincident.IncidentReportedDate = tempDate;
                    }
                }

            }

            objincident.IsAonymously = Convert.ToBoolean(objreportinginfoData["IsAonymously"]);
            objincident.IsActiveRecord = true;
            objincident.IncidentOccuredDate = DateTime.Now;
            objincident.IncidentDescription = Convert.ToString(objreportinginfoData["IncidentDescription"]);
            objincident.PersonInvolved = Convert.ToString(objreportinginfoData["PersonInvolved"]);
            objincident.DepartmentId = Convert.ToInt32(objreportinginfoData["DepartmentId"]);
            objincident.create_by = ObjSessionEmp.Id;
            objincident.ReportType = CommonConstants.CONST_TYPE_REPORT;
            BLCompliance.Result resultIncidentInfo = BLReportinginfo.InsertIncidentInfo(objincident, out objincident);
            if (objincident != null && resultIncidentInfo.ResultCode == 1)
            {
                result = resultIncidentInfo.ResultMessage;
                return result;
            }
            else
            {
                result = resultIncidentInfo.ResultMessage;
                return result;
            }

            //IEnumerable DepartmentList = Departmentreport as IEnumerable;
            //if (DepartmentList != null)
            //{
            //    foreach (object element in DepartmentList)
            //    {
            //        reportinginfo objDepartment = new reportinginfo();
            //        Dictionary<string, object> objDepartmentreport = (Dictionary<string, object>)element;
            //        objDepartment.DepartmentId = Convert.ToInt32(objDepartmentreport["DepartmentId"]);
            //        objDepartment.IsActiveRecord = true;
            //        objDepartment.create_by = ObjSessionEmp.create_by;
            //        objDepartment.IncidentId = objincident.IncidentId;
            //        BLCompliance.Result resultDepartmentInfo = BLReportinginfo.InsertDepartmentInfo(objDepartment, out objDepartment);
            //    }
            //}

            //IEnumerable IncidentPersonList = IncidentPerson as IEnumerable;
            //if (IncidentPersonList != null)
            //{
            //    foreach (object element in IncidentPersonList)
            //    {
            //        reportinginfo objIncidentPerson = new reportinginfo();

            //        Dictionary<string, object> objIncidentPersonData = (Dictionary<string, object>)element;
            //        objIncidentPerson.PersonFirstName = Convert.ToString(objIncidentPersonData["PersonFirstName"]);
            //        objIncidentPerson.PersonLastName = Convert.ToString(objIncidentPersonData["PersonLastName"]);
            //        objIncidentPerson.IsActiveRecord = true;
            //        objIncidentPerson.create_by = ObjSessionEmp.create_by;
            //        objIncidentPerson.IncidentId = objincident.IncidentId;
            //        BLCompliance.Result resultDepartmentInfo = BLReportinginfo.InsertPersonInfo(objIncidentPerson, out objIncidentPerson);
            //    }
            //}
        }
        catch (Exception ex)
        {
            result = "Error raised in Reporting.aspx.cs - SaveReporting() :ERR::" + ex.Message;
        }
        finally
        {

        }
        return result;
    }

    #endregion
}