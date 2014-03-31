using System;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BLCompliance.Model;

public partial class AssignTraining : System.Web.UI.Page
{
    private ArrayList arraylist1 = new ArrayList();
    private ArrayList arraylist2 = new ArrayList();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetCources();
        }
    }

    /// <summary>
    /// Method for get cource list.
    /// </summary>
    private void GetCources()
    {
        List<TrainingCourse> courses;
        BLCompliance.BLTrainingCourses.GetAllActiveTrainingCourses(out courses);
        ListBox1.DataSource = courses;
        ListBox1.DataTextField = "course_title";
        ListBox1.DataValueField = "course_id";
        ListBox1.DataBind();

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

    }
}