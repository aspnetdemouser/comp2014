using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance.Model;

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


            
        }
    }
    #endregion
}