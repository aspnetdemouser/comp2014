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

public partial class reporting : System.Web.UI.Page
{
    #region Page Load
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] == null)
        {
            Response.Redirect("login.aspx");

        }

        if (!IsPostBack)
        {
            BindDepartmentreportList();
        }
    } 
    #endregion

    #region Binding Control
    private void BindDepartmentreportList()
    {
        List<reportinginfo> DepartmentreportList = new List<reportinginfo>();
        BLReportinginfo.DepartmentreportList(out DepartmentreportList);
        rptDepartmentInvolved.DataSource = DepartmentreportList;
        rptDepartmentInvolved.DataBind();
    } 
    #endregion

    #region Web Method
    [WebMethod(true)]
    public static string SaveReporting(object IncidentPerson, object Departmentreport, object Objreportinginfo)
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

            objincident.IncidentReportedDate = Convert.ToDateTime(Convert.ToString(objreportinginfoData["IncidentReportedDate"]));
            objincident.IsAonymously = Convert.ToBoolean(objreportinginfoData["IsAonymously"]);
            objincident.IsActiveRecord = true;
            objincident.IncidentOccuredDate = DateTime.Now;
            objincident.IncidentDescription = Convert.ToString(objreportinginfoData["IncidentDescription"]);
            objincident.create_by = null != ObjSessionEmp ? ObjSessionEmp.create_by : 0;

            BLCompliance.Result resultIncidentInfo = BLReportinginfo.InsertIncidentInfo(objincident, out objincident);
            if (objincident != null && resultIncidentInfo.ResultCode == 1)
            {
                //lblErr.Text = "Information updated.";
                //lblErr.ForeColor = System.Drawing.Color.WhiteSmoke;
            }
            else
            {
                result = resultIncidentInfo.ResultMessage;
                return result;
            }

            IEnumerable DepartmentList = Departmentreport as IEnumerable;
            if (DepartmentList != null)
            {
                foreach (object element in DepartmentList)
                {
                    reportinginfo objDepartment = new reportinginfo();
                    Dictionary<string, object> objDepartmentreport = (Dictionary<string, object>)element;
                    objDepartment.DepartmentId = Convert.ToInt32(objDepartmentreport["DepartmentId"]);
                    objDepartment.IsActiveRecord = true;
                    objDepartment.create_by = ObjSessionEmp.create_by;
                    objDepartment.IncidentId = objincident.IncidentId;
                    BLCompliance.Result resultDepartmentInfo = BLReportinginfo.InsertDepartmentInfo(objDepartment, out objDepartment);
                }
            }

            IEnumerable IncidentPersonList = IncidentPerson as IEnumerable;
            if (IncidentPersonList != null)
            {
                foreach (object element in IncidentPersonList)
                {
                    reportinginfo objIncidentPerson = new reportinginfo();

                    Dictionary<string, object> objIncidentPersonData = (Dictionary<string, object>)element;
                    objIncidentPerson.PersonFirstName = Convert.ToString(objIncidentPersonData["PersonFirstName"]);
                    objIncidentPerson.PersonLastName = Convert.ToString(objIncidentPersonData["PersonLastName"]);
                    objIncidentPerson.IsActiveRecord = true;
                    objIncidentPerson.create_by = ObjSessionEmp.create_by;
                    objIncidentPerson.IncidentId = objincident.IncidentId;
                    BLCompliance.Result resultDepartmentInfo = BLReportinginfo.InsertPersonInfo(objIncidentPerson, out objIncidentPerson);
                }
            }
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