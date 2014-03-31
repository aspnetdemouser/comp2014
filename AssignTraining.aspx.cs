using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using BLCompliance;
using BLCompliance.Model;

public partial class AssignTraining : System.Web.UI.Page
{
    private ArrayList arraylist1 = new ArrayList();
    private ArrayList arraylist2 = new ArrayList();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetAllActiveTraining();
        }
    }

    /// <summary>
    /// Method for get cource list.
    /// </summary>
    private void GetAllActiveTraining()
    {
        List<TrainingCourse> courses;
        BLCompliance.BLTrainingCourses.GetAllActiveTrainingCourses(out courses);
        dlstTraining.DataSource = courses;
        dlstTraining.DataTextField = "course_title";
        dlstTraining.DataValueField = "course_id";
        dlstTraining.DataBind();
        dlstTraining.Items.Insert(0, new ListItem("-- Select --", "0"));
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
            lbltxt.Text = "Please select atleast one in Listbox1 to move";
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
            lbltxt.Text = "Please select atleast one in Listbox2 to move";
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
        var courseId = Convert.ToInt32(dlstTraining.SelectedValue);



        if (courseId > 0)
        {
            foreach (ListItem itm2 in ListBox2.Items)
            {
                var empLoggedIn = HttpContext.Current.Session["emp2014br2"] as employee;
                BLTrainingCourses.AssignUserToCourse(courseId, Convert.ToInt32(itm2.Value), empLoggedIn.Id);
            }

            foreach (ListItem itm1 in ListBox1.Items)
            {
                var empLoggedIn = HttpContext.Current.Session["emp2014br2"] as employee;
                BLTrainingCourses.UnAssignUserToCourse(courseId, Convert.ToInt32(itm1.Value), empLoggedIn.Id);
            }

            ListBox1.Items.Clear();
            ListBox2.Items.Clear();
            dlstTraining.SelectedIndex = 0;
        }
        else
        {
            lbltxt.Visible = true;
            lbltxt.Text = "Please select atleast one training and user.";
        }
    }
    protected void dlstTraining_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetUsersForAssignTraining();
        GetEmployeesUnderCourse();
    }

    private void GetUsersForAssignTraining()
    {
        var selectedId = Convert.ToInt32(dlstTraining.SelectedValue);
        if (selectedId > 0)
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
        }
    }

    private void GetEmployeesUnderCourse()
    {
        var selectedId = Convert.ToInt32(dlstTraining.SelectedValue);
        if (selectedId > 0)
        {
            List<TraningCourseUsers> users;
            BLCompliance.BLTrainingCourses.GetEmployeesUnderCourse(selectedId, out users);
            ListBox2.DataSource = users;
            ListBox2.DataTextField = "EmployeeName";
            ListBox2.DataValueField = "EmployeeId";
            ListBox2.DataBind();
        }
        else
        {
            ListBox2.Items.Clear();
        }
    }
}