using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance.Model;
using BLCompliance;
using System.Text;
using System.Globalization;

public partial class employeeprofile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] == null)
        {
            Response.Redirect("login.aspx");

        }
        if (!IsPostBack)
        {
            bool isLevel2 = false;
            employee loginEmp = null;
            if (Session["emp2014br2"] != null)
            {
                loginEmp = Session["emp2014br2"] as employee;
                if (loginEmp.EmployeeType == 2)
                    isLevel2 = true;
            }

            if (GetSelectedEmployeeId() > 0)
            {
                LoadData(GetSelectedEmployeeId(), isLevel2);
                btnEmpUpdateInformation.Visible = true;
                btnEmpCreatInformation.Visible = false;
                divAddNewEmployeeTitle.Visible = false;
                divOfficerInfo.Visible = true;
            }
            else
            {
                btnEmpUpdateInformation.Visible = false;
                btnEmpCreatInformation.Visible = true;
                divAddNewEmployeeTitle.Visible = true;
                divOfficerInfo.Visible = false;
                if (isLevel2)
                {
                    txtconfpassword.TextMode = txtpassword.TextMode = TextBoxMode.SingleLine;
                }
            }
        }
    }

    protected void LoadData(int EmpId, bool isLevel2)
    {
        BLCompliance.Model.employee employee;
        BLCompliance.Model.employee_contact_info contactInfo;

        BLCompliance.Result result = BLCompliance.BLManageFacility.GetEmployeeById(EmpId, out employee);


        if (employee != null && result.ResultCode == 1)
        {
            txtemailaddress.Text = employee.EmailAddress;

            if (isLevel2)
            {
                txtpassword.TextMode = TextBoxMode.SingleLine;
                txtconfpassword.TextMode = TextBoxMode.SingleLine;
                txtemailaddress.ReadOnly = true;
            }
            txtpassword.Text = employee.Password;
            txtconfpassword.Text = employee.Password;
            txtposition.Text = employee.Position;
            lblCurrentPosition.Text = employee.Position;
            lblCurrentEmail.Text = employee.EmailAddress;

            if (employee.DateOfHire.HasValue)
            {
                try
                {
                    txtDATEHIRE.Text = Convert.ToDateTime(employee.DateOfHire).ToString("MM/dd/yyyy");
                }
                catch (Exception ex)
                {
                    txtDATEHIRE.Text = Convert.ToString(employee.DateOfHire);
                }

            }


            txtLICENCE.Text = employee.Licence_Number;

            if (employee.Licence_Expiry.HasValue)
            {
                try
                {
                    txtLICENSE_EXP.Text = Convert.ToDateTime(employee.Licence_Expiry).ToString("MM/dd/yyyy");
                }
                catch (Exception ex)
                {
                    txtLICENSE_EXP.Text = Convert.ToString(employee.Licence_Expiry);
                }
            }

            if (employee.DateLastExclusionCheck.HasValue)
            {

                try
                {
                    txtEXCLUSSION.Text = Convert.ToDateTime(employee.DateLastExclusionCheck).ToString("MM/dd/yyyy");
                }
                catch (Exception ex)
                {
                    txtEXCLUSSION.Text = Convert.ToString(employee.DateLastExclusionCheck);
                }
            }
        }

        BLCompliance.Result resultContInfo = BLCompliance.BLContactInfo.GetEmployeeContactInfo(txtemailaddress.Text.Trim(), out contactInfo);

        if (contactInfo != null && resultContInfo.ResultCode == 1)
        {
            ViewState["ContactInfoId"] = contactInfo.ContactInfoId;
            txtFNAME.Text = contactInfo.FirstName;
            txtLNAME.Text = contactInfo.LastName;
            lblCurrentFullName.Text = contactInfo.FirstName + " " + contactInfo.LastName;
            txtADDR1.Text = contactInfo.AddressLine1;
            txtADDR2.Text = contactInfo.AddressLine2;
            lblCurrentAddress.Text = contactInfo.AddressLine1 + " " + contactInfo.AddressLine2;
            txtCITY.Text = contactInfo.City;
            ddlState.SelectedValue = contactInfo.State;
            lblCurrentStateCity.Text = contactInfo.City + " " + contactInfo.State;
            txtZIPCODE.Text = contactInfo.ZipCode;
            txtPHONE.Text = contactInfo.TelePhone;
            lblCurrentPhone.Text = contactInfo.TelePhone;
            lblCurrentFax.Text = contactInfo.FaxNumber;
            txtFAX.Text = contactInfo.FaxNumber;
        }


    }
    protected int GetSelectedEmployeeId()
    {
        int employeeId = 0;
        //EmployeeId = string.IsNullOrEmpty(Convert.ToString(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_EDIT_EMPLOYEE_ID])) ? 0 : Convert.ToInt32(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_EDIT_EMPLOYEE_ID]);

        if (Request.QueryString["enc"] != null)
        {
            byte[] data = Convert.FromBase64String(Request.QueryString["enc"].ToString());
            string decodedString = Encoding.UTF8.GetString(data);
            int.TryParse(decodedString, out employeeId);
        }

        return employeeId;
    }
    protected void btnEmpUpdateInformation_Click(object sender, EventArgs e)
    {
        Validate("emploeeprofile");

        if (Page.IsValid)
        {
            try
            {
                employee ObjSessionEmp = null;
                if (Session["emp2014br2"] != null)
                {
                    ObjSessionEmp = Session["emp2014br2"] as employee;

                }

                if (txtpassword.Text.Equals(txtconfpassword.Text) == false)
                {
                    lblErr.Text = "Passwords don't match !";
                    return;
                }

                BLCompliance.Model.employee objEmployee = new BLCompliance.Model.employee();
                BLCompliance.Model.employee_contact_info objcont = new BLCompliance.Model.employee_contact_info();
                objEmployee.Id = GetSelectedEmployeeId();
                objEmployee.EmailAddress = txtemailaddress.Text.Trim();
                objEmployee.Password = txtpassword.Text;
                objEmployee.EmployeeType = 1;
                objEmployee.Position = txtposition.Text;
                objEmployee.Licence_Number = txtLICENCE.Text;
                objEmployee.IsDeleted = false;
                objEmployee.IsActiveRecord = true;

                if (!string.IsNullOrEmpty(txtLICENSE_EXP.Text.ToString()))
                {
                    DateTime tempDate;
                    if (DateTime.TryParseExact(txtLICENSE_EXP.Text.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.Licence_Expiry = tempDate;
                    }
                    else if (DateTime.TryParseExact(txtLICENSE_EXP.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.Licence_Expiry = tempDate;
                    }

                }
                if (!string.IsNullOrEmpty(txtDATEHIRE.Text.ToString()))
                {
                    DateTime tempDate;

                    if (DateTime.TryParseExact(txtDATEHIRE.Text.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.DateOfHire = tempDate;
                    }
                    else if (DateTime.TryParseExact(txtDATEHIRE.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.DateOfHire = tempDate;
                    }



                }

                if (!string.IsNullOrEmpty(txtEXCLUSSION.Text.ToString()))
                {
                    DateTime tempDate;
                    if (DateTime.TryParseExact(txtEXCLUSSION.Text.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.DateLastExclusionCheck = tempDate;
                    }
                    else if (DateTime.TryParseExact(txtEXCLUSSION.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.DateLastExclusionCheck = tempDate;
                    }
                }

                //objemp.FacilityId = string.IsNullOrEmpty(Convert.ToString(Session[CommonConstants.CONST_SESSION_KEY_FACILITY_ID])) ? 0 : Convert.ToInt32(Session[CommonConstants.CONST_SESSION_KEY_FACILITY_ID]);
                //objemp.create_by = string.IsNullOrEmpty(Convert.ToString(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_ID])) ? 0 : Convert.ToInt32(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_ID]);
                objEmployee.FacilityId = ObjSessionEmp.FacilityId;
                objEmployee.create_by = ObjSessionEmp.create_by;

                BLCompliance.Model.employee Objemployee;

                BLCompliance.Result resultEmpInfo = BLCompliance.BLManageFacility.UpdateEmployeeInfo(objEmployee, out Objemployee);
                objcont.ContactInfoId = string.IsNullOrEmpty(Convert.ToString(ViewState["ContactInfoId"])) ? 0 : Convert.ToInt32(ViewState["ContactInfoId"]);
                objcont.EmployeeId = GetSelectedEmployeeId();
                objcont.LastName = txtLNAME.Text;
                objcont.FirstName = txtFNAME.Text;
                objcont.FaxNumber = txtFAX.Text;
                objcont.AddressLine1 = txtADDR1.Text;
                objcont.AddressLine2 = txtADDR2.Text;
                objcont.City = txtCITY.Text;
                objcont.State = ddlState.SelectedValue;
                objcont.ZipCode = txtZIPCODE.Text;
                objcont.IsActiveRecord = true;
                objcont.TelePhone = txtPHONE.Text;
                objcont.create_by = ObjSessionEmp.create_by;

                if (Objemployee != null && resultEmpInfo.ResultCode == 1)
                {
                    BLCompliance.Model.employee_contact_info Objcontactinfo;
                    BLCompliance.Result resultContactInfo = BLCompliance.BLContactInfo.UpdateContactInfo(objcont, out Objcontactinfo);
                    if (Objcontactinfo != null && resultContactInfo.ResultCode == 1)
                    {
                        lblErr.Text = "Information updated.";
                        lblErr.ForeColor = System.Drawing.Color.WhiteSmoke;
                    }
                    else
                    {

                    }
                }
                else if (resultEmpInfo.ResultCode == -1)
                {

                }
                else
                {
                }


            }
            catch (Exception ex)
            {
                throw new Exception("Error raised in InsertAndUpdateEmployeeInfo::ERR:" + ex.Message + ":" + ex.StackTrace, ex);
            }
        }
        else
        {
            #region validate css apply
            for (int i = 0; i <= Page.Validators.Count - 1; i++)
            {
                if (Page.Validators[i] is RequiredFieldValidator)
                {
                    RequiredFieldValidator validatorObject = Page.Validators[i] as RequiredFieldValidator;
                    ContentPlaceHolder cph = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
                    if (validatorObject.IsValid == false)
                    {
                        if (cph.FindControl(validatorObject.ControlToValidate) != null)
                        {
                            
                            TextBox txt = cph.FindControl(validatorObject.ControlToValidate) as TextBox;
                            if (txt.ID.Contains("txtemailaddress"))
                            {
                                txt.CssClass = "mandatory_selected validateemail";
                            }
                            else if (txt.ID.Contains("txtpassword") || txt.ID.Contains("txtconfpassword"))
                            {
                                if (txt.ID.Contains("txtpassword"))
                                    txt.CssClass = "mandatory_selected PASSWORD1";
                                else
                                    txt.CssClass = "mandatory_selected PASSWORD2";
                            }
                            else
                            {
                                txt.CssClass = "mandatory_selected";
                            }
                            
                        }
                    }
                    else
                    {
                        if (cph.FindControl(validatorObject.ControlToValidate) != null)
                        {
                            TextBox txt = cph.FindControl(validatorObject.ControlToValidate) as TextBox;
                            if (txt.ID.Contains("txtpassword") || txt.ID.Contains("txtconfpassword"))
                            {
                                if (txt.ID.Contains("txtpassword"))
                                    txt.CssClass = "mandatory PASSWORD1";
                                else
                                    txt.CssClass = "mandatory PASSWORD2";
                            }
                            else if (txt.ID.Contains("txtemailaddress"))
                            {
                                txt.CssClass = "mandatory validateemail";
                            }
                            else
                            {
                                txt.CssClass = "mandatory";
                            }
                        }
                    }
                }
            }
            #endregion
        }
    }
    protected void btnEmpCreatInformation_Click(object sender, EventArgs e)
    {
        Validate("emploeeprofile");

        if (Page.IsValid)
        {
            try
            {

                employee ObjSessionEmp = null;
                if (Session["emp2014br2"] != null)
                {
                    ObjSessionEmp = Session["emp2014br2"] as employee;

                }

                if (txtpassword.Text.Equals(txtconfpassword.Text) == false)
                {
                    lblErr.Text = "Passwords don't match !";
                    return;
                }

                BLCompliance.Model.employee objEmployee = new BLCompliance.Model.employee();
                BLCompliance.Model.employee_contact_info objContactInfo = new BLCompliance.Model.employee_contact_info();
                objEmployee.EmailAddress = txtemailaddress.Text.Trim();
                objEmployee.Password = txtpassword.Text;
                objEmployee.EmployeeType = 1;
                objEmployee.Position = txtposition.Text;
                objEmployee.Licence_Number = txtLICENCE.Text;

                if (!string.IsNullOrEmpty(txtLICENSE_EXP.Text.ToString()))
                {
                    DateTime tempDate;
                    if (DateTime.TryParseExact(txtLICENSE_EXP.Text.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.Licence_Expiry = tempDate;
                    }
                    else if (DateTime.TryParseExact(txtLICENSE_EXP.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.Licence_Expiry = tempDate;
                    }

                }
                if (!string.IsNullOrEmpty(txtDATEHIRE.Text.ToString()))
                {
                    DateTime tempDate;
                    if (DateTime.TryParseExact(txtDATEHIRE.Text.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.DateOfHire = tempDate;
                    }
                    else if (DateTime.TryParseExact(txtDATEHIRE.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.DateOfHire = tempDate;
                    }



                }

                if (!string.IsNullOrEmpty(txtEXCLUSSION.Text.ToString()))
                {
                    DateTime tempDate;
                    if (DateTime.TryParseExact(txtEXCLUSSION.Text.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.DateLastExclusionCheck = tempDate;
                    }
                    else if (DateTime.TryParseExact(txtEXCLUSSION.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                    {
                        objEmployee.DateLastExclusionCheck = tempDate;
                    }
                }

                objEmployee.IsDeleted = false;
                objEmployee.IsActiveRecord = true;
                lblErr.Text = "";
                //objemp.FacilityId = string.IsNullOrEmpty(Convert.ToString(Session[CommonConstants.CONST_SESSION_KEY_FACILITY_ID])) ? 0 : Convert.ToInt32(Session[CommonConstants.CONST_SESSION_KEY_FACILITY_ID]);
                //objemp.create_by = string.IsNullOrEmpty(Convert.ToString(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_ID])) ? 0 : Convert.ToInt32(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_ID]);
                objEmployee.FacilityId = ObjSessionEmp.FacilityId;
                objEmployee.create_by = ObjSessionEmp.create_by;
                BLCompliance.Model.employee Objemployee;
                BLCompliance.Result resultEmpInfo = BLCompliance.BLManageFacility.InsertEmployeeInfo(objEmployee, out Objemployee);

                if (resultEmpInfo.ResultCode != 1 || Objemployee == null)
                {
                    lblErr.Text = resultEmpInfo.ResultMessage;
                    return;
                }

                objContactInfo.EmployeeId = Objemployee.Id;
                objContactInfo.LastName = txtLNAME.Text;
                objContactInfo.FirstName = txtFNAME.Text;
                objContactInfo.FaxNumber = txtFAX.Text;                
                objContactInfo.AddressLine1 = txtADDR1.Text;
                objContactInfo.AddressLine2 = txtADDR2.Text;
                objContactInfo.City = txtCITY.Text;
                objContactInfo.State = ddlState.SelectedValue;
                objContactInfo.ZipCode = txtZIPCODE.Text;
                objContactInfo.IsActiveRecord = true;
                objContactInfo.TelePhone = txtPHONE.Text;
                objContactInfo.create_by = ObjSessionEmp.create_by;
                // objcont.create_by = string.IsNullOrEmpty(Convert.ToString(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_ID])) ? 0 : Convert.ToInt32(Session[CommonConstants.CONST_SESSION_KEY_EMPLOYEE_ID]);

                if (Objemployee != null && resultEmpInfo.ResultCode == 1)
                {
                    BLCompliance.Model.employee_contact_info Objcontactinfo;
                    BLCompliance.Result resultContactInfo = BLCompliance.BLContactInfo.InsertContactInfo(objContactInfo, out Objcontactinfo);
                    if (Objcontactinfo != null && resultContactInfo.ResultCode == 1)
                    {
                        Response.Redirect("manage_facility_employees.aspx");
                    }
                    else
                    {

                    }
                }
                else if (resultEmpInfo.ResultCode == -1)
                {
                    lblErr.Text = resultEmpInfo.ResultMessage;
                }
                else
                {
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Thread") == false)
                {
                    throw new Exception("Error raised in InsertAndUpdateEmployeeInfo::ERR:" + ex.Message + ":" + ex.StackTrace, ex);
                }
            }
        }
        else
        {
            #region validate css apply
            for (int i = 0; i <= Page.Validators.Count - 1; i++)
            {
                if (Page.Validators[i] is RequiredFieldValidator)
                {
                    RequiredFieldValidator validatorObject = Page.Validators[i] as RequiredFieldValidator;
                    ContentPlaceHolder cph = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
                    if (validatorObject.IsValid == false)
                    {
                        if (cph.FindControl(validatorObject.ControlToValidate) != null)
                        {
                            TextBox txt = cph.FindControl(validatorObject.ControlToValidate) as TextBox;
                            if (txt.ID.Contains("txtpassword") || txt.ID.Contains("txtconfpassword"))
                            {
                                if(txt.ID.Contains("txtpassword"))
                                    txt.CssClass = "mandatory_selected PASSWORD1";
                                else
                                    txt.CssClass = "mandatory_selected PASSWORD2";
                            }
                            else if (txt.ID.Contains("txtemailaddress"))
                            {
                                txt.CssClass = "mandatory_selected validateemail";
                            }
                            else
                            {
                                txt.CssClass = "mandatory_selected";
                            }
                        }
                    }
                    else
                    {
                        if (cph.FindControl(validatorObject.ControlToValidate) != null)
                        {
                            TextBox txt = cph.FindControl(validatorObject.ControlToValidate) as TextBox;
                            if (txt.ID.Contains("txtpassword") || txt.ID.Contains("txtconfpassword"))
                            {
                                if (txt.ID.Contains("txtpassword"))
                                    txt.CssClass = "mandatory PASSWORD1";
                                else
                                    txt.CssClass = "mandatory PASSWORD2";
                            }
                            else if (txt.ID.Contains("txtemailaddress"))
                            {
                                txt.CssClass = "mandatory validateemail";
                            }
                            else
                            {
                                txt.CssClass = "mandatory";
                            }
                        }
                    }
                }
            }
            #endregion
        }
    }
}