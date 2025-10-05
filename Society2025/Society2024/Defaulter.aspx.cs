using BusinessLogic;
using BusinessLogic.MasterBL;
using DBCode.DataClass.Master_Dataclass;
using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.Office2016.Drawing.ChartDrawing;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utility.DataClass;

namespace Society
{
    public partial class Defaulter : System.Web.UI.Page
    {
        BL_User_Login BL_Login = new BL_User_Login();
        Login_Details details = new Login_Details();
        private readonly IEmailService _emailService = new SendGridEmailService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] == null)
            {
                Response.Redirect("login1.aspx");
            }
            else
                society_id.Value = Session["society_id"].ToString();

            if (!IsPostBack)
            {
                due_fill(sender, e);
                btn_search_Click(sender, e);
            }
        }


        protected async void btn_send_email_Click(object sender, EventArgs e)
        {
            //Button btn = sender as Button; //GridViewRow Row = (GridViewRow)btn.NamingContainer;
            //string rowindex = GridView8.Rows[Row.RowIndex].Cells[1].Text;
            //int abc = Row.RowIndex;

            // List to store both email and name
            List<(string Email, string Name)> recipients = new List<(string Email, string Name)>();

            foreach (GridViewRow row in GridView8.Rows)
            {
                CheckBox chkBx = (CheckBox)row.FindControl("CheckBox1");
                if (chkBx != null && chkBx.Checked)
                {
                    Label emailLabel = (Label)row.FindControl("email");
                    Label nameLabel = (Label)row.FindControl("owner_name"); // Assuming you have a Label with ID "name"

                    if (emailLabel != null && nameLabel != null)
                    {
                        recipients.Add((emailLabel.Text.Trim(), nameLabel.Text.Trim()));
                    }
                }
            }

            try
            {

                string subject = Session["society_name"] + " Maintenance Due reminder!";
                string htmlBody = messageContent.Text;
                string plainBody = System.Text.RegularExpressions.Regex
                    .Replace(htmlBody, "<.*?>", string.Empty);

                await _emailService.SendEmailAsync(
                    recipients, subject, plainBody, htmlBody);

            }
            catch (Exception ex)
            {

                // Log ex via your logging framework
            }

        }

        protected void btn_send_sms_Click(object sender, EventArgs e)
        {
            List<String> list = new List<string>();
            foreach (GridViewRow row in GridView8.Rows)
            {

                CheckBox chkBx = (CheckBox)row.FindControl("CheckBox1");
                if (chkBx.Checked == true)
                {

                    Label contact_no = (Label)row.FindControl("mobile_no");
                    list.Add(contact_no.Text);

                }
            }
            messageContent.Text = string.Join(",", list);
        }


        protected void select_all_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox select_all = sender as CheckBox;
            foreach (GridViewRow row in GridView8.Rows)
            {
                CheckBox chkBx = (CheckBox)row.FindControl("CheckBox1");
                if (select_all.Checked == true)
                    chkBx.Checked = true;
                else
                    chkBx.Checked = false;
            }


            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refocus", "updateRecipientCount();", true);

        }

        //protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
        //{

        //    if (RadioButton1.Checked == true)
        //    {
        //        btn_send_email.Visible = true;
        //        btn_send_sms.Visible = false;
        //    }
        //    else
        //    {
        //        btn_send_email.Visible = false;
        //        btn_send_sms.Visible = true;
        //    }
        //}

        //protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (RadioButton2.Checked == true)
        //    {
        //        btn_send_email.Visible = false;
        //        btn_send_sms.Visible = true;
        //    }
        //    else
        //    {
        //        btn_send_email.Visible = true;
        //        btn_send_sms.Visible = false;
        //    }
        //}

        protected void btn_search_Click(object sender, EventArgs e)
        {

            details.Name = txt_search.Text.Trim();
            details.Sql_Operation = "defaulter_show";
            details.society_id = Session["society_id"].ToString();
            var result = BL_Login.search_defaulter(details);
            if (result != null && result.Rows.Count > 0)
            {
                ViewState["dirState"] = result;
                ViewState["sortdr"] = "Asc";
                result.Compute("Sum(due)", string.Empty).ToString();
            }

            GridView8.DataSource = result;
            GridView8.DataBind();
            GridView3.DataSource = result;
            GridView3.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refocus", "refocusAfterPostback();", true);

        }

        protected void due_fill(object sender, EventArgs e)
        {
            lbl_due.Text = "0";
            details.Name = "";
            details.Sql_Operation = "defaulter_show";
            details.society_id = Session["society_id"].ToString();
            var result = BL_Login.search_defaulter(details);
            if (result != null && result.Rows.Count > 0)
            {
                //ViewState["dirState"] = result;
                //ViewState["sortdr"] = "Asc";
                lbl_due.Text = result.Compute("Sum(due)", string.Empty).ToString();
            }


        }
        protected void GridView8_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dtrslt = (DataTable)ViewState["dirState"];
            if (dtrslt != null && dtrslt.Rows.Count > 0)
            {
                if (Convert.ToString(ViewState["sortdr"]) == "Asc")
                {
                    dtrslt.DefaultView.Sort = e.SortExpression + " Desc";
                    ViewState["sortdr"] = "Desc";
                }
                else
                {
                    dtrslt.DefaultView.Sort = e.SortExpression + " Asc";
                    ViewState["sortdr"] = "Asc";
                }
                GridView8.DataSource = dtrslt;
                GridView8.DataBind();


            }
        }

        protected void GridView8_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView8.PageIndex = e.NewPageIndex;
            btn_search_Click(sender, e);
        }
    }
}