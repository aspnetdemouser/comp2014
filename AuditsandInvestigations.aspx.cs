using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using BLCompliance.Model;
using BLCompliance;
using System.Web.Services;

public partial class tracking : System.Web.UI.Page
{
    #region Page Load
    protected void Page_PreInit(object sender, EventArgs e)
    {
        employee loginEmp = null;
        if (Session["emp2014br2"] != null)
        {
            loginEmp = Session["emp2014br2"] as employee;
        }
        if (Request.QueryString["enc"] != null && null != loginEmp && loginEmp.EmployeeType == 1)
        {
            this.Page.MasterPageFile = "~/Firstlevel.master";
        }
        else
        {
            this.Page.MasterPageFile = "~/main.master";
        }
    }
    employee ObjSessionEmp = null;
    static int createby = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] == null)
        {
            Response.Redirect("login.aspx");
        }
        else if (HttpContext.Current.Session["emp2014br2"] != null)
        {
            ObjSessionEmp = Session["emp2014br2"] as employee;
            createby = ObjSessionEmp.create_by;
        }

        if (!IsPostBack)
        {

           
            BindInboxList();
        }
    }
    #endregion
    #region Binding Control
    protected void BindInboxList()
    {
        List<reportinginfo> ReportingList = new List<reportinginfo>();
        int? id = 0;
        BLReportinginfo.ReportingList(id, ObjSessionEmp.create_by, "","", out ReportingList);
        rptInbox.DataSource = ReportingList;
        rptInbox.DataBind();
    }
    #endregion
    #region Web Method
    [WebMethod]
    public static reportinginfo[] GetReportingDetails(int id)
    {
        List<reportinginfo> ReportingList = new List<reportinginfo>();
        BLReportinginfo.ReportingList(id, createby, "","", out ReportingList);
        return ReportingList.ToArray();
    }
    #endregion
    protected void EditTrackCommand(object sender, CommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument);
     
        var bytes = Encoding.UTF8.GetBytes(id.ToString());
        var base64 = Convert.ToBase64String(bytes);
        Response.Redirect("reporting.aspx?enc=" + base64);
    }
   
    protected void btnSearchSubmit_Click(object sender, EventArgs e)
    {
        if (txtSearch.Text != "Enter your search criteria here")
        {
            List<reportinginfo> ReportingList = new List<reportinginfo>();
            BLReportinginfo.ReportingList(0, ObjSessionEmp.create_by, txtSearch.Text.Trim(),"", out ReportingList);
            rptInbox.DataSource = ReportingList;
            rptInbox.DataBind();
        }
        else
        {
            BindInboxList();
        }
    }
    protected void btnResetSearch_Click(object sender, ImageClickEventArgs e)
    {
        ClearControls();
        BindInboxList();
    }

    private void ClearControls()
    {
        foreach (Control container in Page.Controls)
        {
            foreach (Control c in container.Controls)
            {
                foreach (Control ctrl in c.Controls)
                {
                    if (ctrl is TextBox)
                    {
                        ((TextBox)ctrl).Text = string.Empty;
                    }
                }
            }
        }
    }  
}