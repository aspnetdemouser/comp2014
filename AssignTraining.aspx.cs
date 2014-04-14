using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using BLCompliance;
using BLCompliance.Model;
using System.Web.UI;
using System.Globalization;
using System.Text;


public partial class AssignTraining : System.Web.UI.Page
{
    private ArrayList arraylist1 = new ArrayList();
    private ArrayList arraylist2 = new ArrayList();
    protected void Page_PreInit(object sender, EventArgs e)
    {
        employee loginEmp = null;
        if (Session["emp2014br2"] != null)
        {
            loginEmp = Session["emp2014br2"] as employee;
        }
        if (Request.QueryString["edit"] != null && null != loginEmp && loginEmp.EmployeeType == 1)
        {
            this.Page.MasterPageFile = "~/Firstlevel.master";
        }
        else
        {
            this.Page.MasterPageFile = "~/main.master";
        }


        Control ht = this.Master.FindControl("hdnTS");
        if (ht != null)
        {
            if (ht is HiddenField)
            {
                HiddenField ht1 = ht as HiddenField;
                ht1.Value = "sel";
            }
        }

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            // GetAllActiveTraining();

            if (Session["emp2014br2"] != null)
            {
                employee employee = Session["emp2014br2"] as employee;

                if (employee.EmployeeType == 2)
                {
                    btnEditStatusCancel.Visible = btnEditStatus.Visible = false;
                    chkCompleted.Visible = false;
                    if (Request.QueryString["edit"] != null)
                    {
                        int idToFind = GetRecordId();
                        if (idToFind > 0)
                        {
                            EditRecord(idToFind);
                        }
                    }
                    else
                    {
                        //add mode
                        GetEmployeesForCourse(0);
                        txtCourseName.Focus();
                    }

                    SetFacilityInfo(employee);
                }
                else if (employee.EmployeeType == 1)
                {
                    //edit completetion status by level 1 user
                    int idToFind = GetRecordId();
                    if (idToFind > 0)
                    {
                        EditRecord(idToFind);
                    }
                }
                else
                {
                    Response.Redirect("login.aspx");
                }

            }
        }
    }

    /// <summary>
    /// Method for get active cource list.
    /// </summary>
    private void GetAllActiveCourses(out List<TrainingCourse> courses)
    {
        courses = new List<TrainingCourse>();
        BLCompliance.BLTrainingCourses.GetAllActiveTrainingCourses(out courses);
        //dlstTraining.DataSource = courses;
        //dlstTraining.DataTextField = "course_title";
        //dlstTraining.DataValueField = "course_id";
        //dlstTraining.DataBind();
        //dlstTraining.Items.Insert(0, new ListItem("-- Select --", "0"));
    }

    /// <summary>
    /// btn1_Click event is used to move single or multiple items from Listbox1 to Listbox2
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn1_Click(object sender, EventArgs e)
    {
        lbltxt.Visible = false;
        if (ListBox1.SelectedIndex >= 0)
        {
            for (var i = 0; i < ListBox1.Items.Count; i++)
            {
                if (!ListBox1.Items[i].Selected) continue;
                if (!arraylist1.Contains(ListBox1.Items[i]))
                {
                    arraylist1.Add(ListBox1.Items[i]);
                }
            }
            foreach (var itm in arraylist1)
            {
                if (!ListBox2.Items.Contains(((ListItem)itm)))
                {
                    ListBox2.Items.Add(((ListItem)itm));
                }
                ListBox1.Items.Remove(((ListItem)itm));
            }
            ListBox2.SelectedIndex = -1;
        }
        else
        {
            lbltxt.Visible = true;
            lbltxt.Text = "Please choose employee to move";
        }
    }

    /// <summary>
    /// btn2_Click event is used to move all items from Listbox1 to Listbox2
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn2_Click(object sender, EventArgs e)
    {
        lbltxt.Visible = false;
        while (ListBox1.Items.Count != 0)
        {
            for (var i = 0; i < ListBox1.Items.Count; i++)
            {
                ListBox2.Items.Add(ListBox1.Items[i]);
                ListBox1.Items.Remove(ListBox1.Items[i]);
            }
        }
    }

    /// <summary>
    /// btn3_Click event is used to move single or multiple items from Listbox2 to Listbox1
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn3_Click(object sender, EventArgs e)
    {
        lbltxt.Visible = false;
        if (ListBox2.SelectedIndex >= 0)
        {
            for (var i = 0; i < ListBox2.Items.Count; i++)
            {
                if (!ListBox2.Items[i].Selected) continue;
                if (!arraylist2.Contains(ListBox2.Items[i]))
                {
                    arraylist2.Add(ListBox2.Items[i]);
                }
            }
            foreach (var itm in arraylist2)
            {
                if (!ListBox1.Items.Contains(((ListItem)itm)))
                {
                    ListBox1.Items.Add(((ListItem)itm));
                }
                ListBox2.Items.Remove(((ListItem)itm));
            }
            ListBox1.SelectedIndex = -1;
        }
        else
        {
            lbltxt.Visible = true;
            lbltxt.Text = "Please select employee to remove.";
        }
    }

    /// <summary>
    /// btn4_Click event is used to move all items form Listbox2 to Listbox1
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn4_Click(object sender, EventArgs e)
    {
        lbltxt.Visible = false;
        while (ListBox2.Items.Count != 0)
        {
            for (var i = 0; i < ListBox2.Items.Count; i++)
            {
                ListBox1.Items.Add(ListBox2.Items[i]);
                ListBox2.Items.Remove(ListBox2.Items[i]);
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        // var courseId = Convert.ToInt32(dlstTraining.SelectedValue);

        if (HttpContext.Current.Session["emp2014br2"] == null)
        {
            Response.Redirect("login.aspx");
        }
        string strCourse = txtCourseName.Text;
        if (!string.IsNullOrEmpty(strCourse))
        {

            if (txtDueDate.Text.Trim() == "")
            {
                lbltxt.Visible = true;
                lbltxt.Text = "Please select due date.";
                return;
            }

            bool isMsgShow = false;

            DateTime dueDate = DateTime.MinValue;
            if (!string.IsNullOrEmpty(txtDueDate.Text.ToString()))
            {
                DateTime tempDate;

                if (DateTime.TryParseExact(txtDueDate.Text.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                {
                    dueDate = tempDate;
                }
                else if (DateTime.TryParseExact(txtDueDate.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                {
                    dueDate = tempDate;
                }
            }

            var empLoggedIn = HttpContext.Current.Session["emp2014br2"] as employee;
            int courseId = BLTrainingCourses.AddCourse(txtCourseName.Text.Trim(), empLoggedIn.Id);

            foreach (ListItem itm2 in ListBox2.Items)
            {

                BLTrainingCourses.AssignUserToCourse(courseId, Convert.ToInt32(itm2.Value), empLoggedIn.Id, dueDate);
                lbltxt.Text = "Training assigned successfully";
                lbltxt.Visible = true;
                isMsgShow = true;
            }

            //foreach (ListItem itm1 in ListBox1.Items)
            //{
            //    BLTrainingCourses.UnAssignUserToCourse(courseId, Convert.ToInt32(itm1.Value), empLoggedIn.Id);
            //    if (isMsgShow == false)
            //    {
            //        lbltxt.Visible = true;
            //        lbltxt.Text = "Employee unassigned from course.";
            //    }
            //}

            // ListBox1.Items.Clear();
            // ListBox2.Items.Clear();
            //dlstTraining.SelectedIndex = 0;
        }
        else
        {
            lbltxt.Visible = true;
            lbltxt.Text = "Please enter course.";
            txtCourseName.Focus();
        }
    }
    protected void dlstTraining_SelectedIndexChanged(object sender, EventArgs e)
    {
        lbltxt.Text = "";
        GetEmployeesForCourse(0);
        GetEmployeesUnderCourse();
    }

    private void GetEmployeesForCourse(int courseId)
    {

        //var selectedId = Convert.ToInt32(dlstTraining.SelectedValue);
        int selectedId = 0; //selected course id
        if (courseId > 0)
        {
            List<TraningCourseUsers> users;
            BLCompliance.BLTrainingCourses.GetUnAssingedUserList(selectedId, out users);
            ListBox1.DataSource = users;
            ListBox1.DataTextField = "EmployeeName";
            ListBox1.DataValueField = "EmployeeId";
            ListBox1.DataBind();
        }
        else
        {
            ListBox1.Items.Clear();
            List<employee> employeeList = new List<employee>();
            BLCompliance.BLManageFacility.GetEmployees(0, "", true, out employeeList);
            ListBox1.DataSource = employeeList;
            ListBox1.DataTextField = "ContactName";
            ListBox1.DataValueField = "Id";
            ListBox1.DataBind();
        }
    }

    private void GetEmployeesUnderCourse()
    {
        txtDueDate.Text = "";
        //var selectedId = Convert.ToInt32(dlstTraining.SelectedValue);
        var selectedId = 0; //selected course id
        if (selectedId > 0)
        {
            List<TraningCourseUsers> users;
            BLCompliance.BLTrainingCourses.GetEmployeesUnderCourse(selectedId, out users);

            ListBox2.DataSource = users;
            ListBox2.DataTextField = "EmployeeName";
            ListBox2.DataValueField = "EmployeeId";
            ListBox2.DataBind();
            if (users.Count > 0)
            {
                if (users[0].DueDate.HasValue)
                {
                    txtDueDate.Text = users[0].DueDate.Value.ToString("MM/dd/yyyy");
                }
            }
        }
        else
        {
            ListBox2.Items.Clear();
        }
    }

    private void SetFacilityInfo(BLCompliance.Model.employee employee)
    {
        lblFacilityName.Text = employee.FacilityName;

        employee_contact_info contactInfo = null;
        Result result = BLContactInfo.GetEmployeeContactInfo(employee.EmailAddress, out contactInfo);
        if (result.ResultCode == 1 && contactInfo != null)
        {

            //if (!string.IsNullOrEmpty(contactInfo.State))
            //{
            //    lblInfo1.Text = string.Format("{0} - {1}, {2}", employee.FacilityName, contactInfo.City, contactInfo.State);
            //}
            //else
            //{
            //    lblInfo1.Text = string.Format("{0} - {1}", "", employee.FacilityName, contactInfo.City);
            //}

            lblCityStateZip.Text = string.Format("{0}, {1}, {2}", contactInfo.City, contactInfo.State, contactInfo.ZipCode);
            lblCountry.Text = contactInfo.CountryName;
        }


    }
    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["edit"] != null)
        {
            //var bytes = Encoding.UTF8.GetBytes(ddlEmpName.SelectedValue.ToString());
            //var base64 = Convert.ToBase64String(bytes);
            //Response.Redirect("ManageDisciplinaryAction.aspx?enc=" + base64);

        }
        else
        {

            Response.Redirect("ManageTraining.aspx");
        }

    }

    protected int GetRecordId()
    {
        int recordId = 0;
        if (Request.QueryString["edit"] != null)
        {
            byte[] data = Convert.FromBase64String(Request.QueryString["edit"].ToString());
            string decodedString = Encoding.UTF8.GetString(data);
            int.TryParse(decodedString, out recordId);
        }
        return recordId;
    }

    private void EditRecord(int id)
    {
        formEdit.Visible = false;
        formEdit1.Visible = false;

        btnEditStatusCancel.Visible = true;
        lblInfo1.Text = "Edit Training Status";

        int empType = 0;
        employee loginEmp = null;
        if (Session["emp2014br2"] != null)
        {
            loginEmp = Session["emp2014br2"] as employee;

            empType = loginEmp.EmployeeType;
        }

        BLCompliance.Model.TraningCourseUsers recordToEdit = null;
        Result result = BLTrainingCourses.GetTrainingCourseToEdit(id, out recordToEdit);
        if (result.ResultCode == 1 && recordToEdit != null)
        {
            hdnRecordId.Value = recordToEdit.TrainingAssignmentId.ToString();
            btnEditStatus.Visible = true;
            formReadOnly0.Visible = formReadOnly4.Visible = formReadOnly2.Visible = formReadOnly3.Visible = formReadOnly1.Visible = true;
            if (empType == 1)
            {
                txtReadonly1_CourseTitle.Visible = txtReadOnly2_DateAssigned.Visible = txtReadOnly3_DateDue.Visible = false;

            }
            else if (empType == 2)
            {
                txtReadonly1_CourseTitle.Text = recordToEdit.CourseName;
                lblReadonly2_DateAssigned.Visible = lblReadOnly1_CourseTitle.Visible = lblReadOnly3_DueDate.Visible = false;
                 txtReadonly1_CourseTitle.Visible = txtReadOnly2_DateAssigned.Visible = txtReadOnly3_DateDue.Visible = true;

            }


            lblReadOnly1_CourseTitle.Text = recordToEdit.CourseName;
            if (recordToEdit.DueDate.HasValue)
            {
                lblReadOnly3_DueDate.Text = recordToEdit.DueDate.Value.ToString("MM/dd/yyyy");
                txtReadOnly3_DateDue.Text = recordToEdit.DueDate.Value.ToString("MM/dd/yyyy");
            }
            if (recordToEdit.DateAssigned.HasValue)
            {
                lblReadonly2_DateAssigned.Text = recordToEdit.DateAssigned.Value.ToString("MM/dd/yyyy");
                txtReadOnly2_DateAssigned.Text = recordToEdit.DateAssigned.Value.ToString("MM/dd/yyyy");
            }

            if (recordToEdit.CompletionStatus == 2)
            {
                chkIsCompleted.Checked = true;
            }
            lblReadOnly0_EmpName.Text = recordToEdit.EmployeeName;


        }
    }


    protected void btnEditStatusCancel_Click(object sender, EventArgs e)
    {
         employee loginEmp = null;
         if (Session["emp2014br2"] != null)
         {
             loginEmp = Session["emp2014br2"] as employee;

             if (loginEmp.EmployeeType == 1)
             {
                 Response.Redirect("training.aspx");
             }
             else
             {
                 Response.Redirect("ManageTraining.aspx");
             }
         }
        
    }
    protected void btnEditStatus_Click(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] != null)
        {
            //update completion stauts
            if (!string.IsNullOrEmpty(hdnRecordId.Value))
            {
                if (Request.QueryString["edit"] != null)
                {
                    employee loginEmp = null;
                    if (Session["emp2014br2"] != null)
                    {
                        loginEmp = Session["emp2014br2"] as employee;
                        int recordId = 0;
                        int.TryParse(hdnRecordId.Value, out recordId);

                        int completionStatus = 1; //not completed
                        if (chkIsCompleted.Checked)
                        {
                            completionStatus = 2;
                        }
                        if (loginEmp.EmployeeType == 1)
                        {
                            BLCompliance.BLTrainingCourses.UpdateTrainingAssignedStatus(recordId, completionStatus, loginEmp.Id);
                            lbltxt.Text = "Training status updated successfully.";
                        }

                        if (loginEmp.EmployeeType == 2)
                        {
                            if (txtReadonly1_CourseTitle.Text.Trim() == "")
                            {
                                lbltxt.Text = "Please enter course.";
                                return;
                            }
                            if (txtReadOnly2_DateAssigned.Text.Trim() == "")
                            {
                                lbltxt.Text = "Please enter date assigned.";
                                return;
                            }
                            if (txtReadOnly3_DateDue.Text.Trim() == "")
                            {
                                lbltxt.Text = "Please enter due date.";
                                return;
                            }
                            

                            DateTime dueDate = DateTime.MinValue;
                            if (!string.IsNullOrEmpty(txtReadOnly3_DateDue.Text.ToString()))
                            {
                                DateTime tempDate;

                                if (DateTime.TryParseExact(txtReadOnly3_DateDue.Text.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                                {
                                    dueDate = tempDate;
                                }
                            }

                            DateTime assignedDate = DateTime.MinValue;
                            if (!string.IsNullOrEmpty(txtReadOnly2_DateAssigned.Text.ToString()))
                            {
                                DateTime tempDate;

                                if (DateTime.TryParseExact(txtReadOnly2_DateAssigned.Text.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                                {
                                    assignedDate = tempDate;
                                }
                            }

                            if (assignedDate != DateTime.MinValue && dueDate != DateTime.MinValue)
                            {
                                if (assignedDate > dueDate)
                                {

                                    lbltxt.Text = "Assign date cannot be more than due date.";
                                    return;
                                }

                            }

                            int courseId = BLTrainingCourses.AddCourse(txtReadonly1_CourseTitle.Text.Trim(), loginEmp.Id);

                            BLCompliance.BLTrainingCourses.UpdateTrainingAssignmentById(recordId, completionStatus, loginEmp.Id, assignedDate, dueDate, courseId);
                            
                            lbltxt.Text = "Training status updated successfully.";
                        }
                    }
                }
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
}