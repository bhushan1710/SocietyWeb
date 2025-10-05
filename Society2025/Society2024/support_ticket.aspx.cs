using BusinessLogic.BL;
using BusinessLogic.MasterBL;
using DBCode.DataClass.Master_Dataclass;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data; // Needed for DataTable

namespace Society
{
    public partial class support_ticket : Page
    {
        Search_Society support = new Search_Society();
        BL_Society_Master bl_support = new BL_Society_Master();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] == null)
            {
                Response.Redirect("login1.aspx");
            }
            else
            {
                society_id.Value = Session["society_id"].ToString();
            }

            if (!IsPostBack)
            {
                getTicket();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowComments")
            {
                int helpdeskId = Convert.ToInt32(e.CommandArgument);

                // Fetch and bind comments
                BindComments(helpdeskId);

                // Show modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#commentsModal').modal('show');", true);

            }
        }

        private void BindComments(int helpdeskId)
        {
            DataTable dt = bl_support.get_comment(helpdeskId);

            lblNoComments.Visible = dt.Rows.Count == 0;

            hfHelpdeskId.Value = helpdeskId.ToString();

            // Set name/unit only once from first row
            if (dt.Rows.Count > 0)
            {
                string name = dt.Rows[0]["name"].ToString();
                string unit = dt.Rows[0]["unit"].ToString();
                //lblUserNameUnit.Text = $"{name} - {unit}";
            }

            rptComments.DataSource = dt;
            rptComments.DataBind();
            temp.Update();
        }


        protected void btnReply_Click(object sender, EventArgs e)
        {
            string replyText = txtReply.Text.Trim();
            int helpdeskId = int.Parse(hfHelpdeskId.Value);

            if (!string.IsNullOrEmpty(replyText))
            {
                // Store reply via your BLL method
                support.Sql_Operation = "InsertComments";
                support.helpdeskId = helpdeskId;
                support.Comment = replyText;
                support.ownerId = Convert.ToInt32( Session["OwnerId"].ToString()); // Or user_id
                support.Society_Id = society_id.Value;
                support.Type = Session["user_role"].ToString();

                bl_support.post_comment(support); // You must implement this

                // Rebind updated comments and clear reply
                txtReply.Text = "";
               

                BindComments(helpdeskId);
            }
      
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Find the DropDownList in the current row
                DropDownList ddlStatus = (DropDownList)e.Row.FindControl("ddlStatus");

                if (ddlStatus != null)
                {
                    // Get the value from your data source
                    // Assume your data item has a property "Status" that corresponds to the selected value (e.g., "1", "2", etc.)
                    string statusValue = DataBinder.Eval(e.Row.DataItem, "Status").ToString();

                    // Set the selected value
                    if (ddlStatus.Items.FindByText(statusValue) != null)
                    {
                        ddlStatus.SelectedItem.Text = statusValue;
                    }
                }
            }
        }


        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddl.NamingContainer;

            Label hfHelpdeskId = (Label)row.FindControl("lblHelpdeskId");
            string helpdeskId = hfHelpdeskId.Text;
            string newStatus = ddl.SelectedValue;

            // Update in database
            support.Sql_Operation = "UpdateStatus";
            support.helpdeskId = Convert.ToInt32(helpdeskId);
            support.Status = Convert.ToInt32(newStatus);
            support.Society_Id = society_id.Value;

            bl_support.update_status(support);  // ➜ This is your method to write in BLL

            // Optional: Rebind the GridView if needed
            getTicket();

            // Show comment modal if you want
            BindComments(Convert.ToInt32(helpdeskId));

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#commentsModal').modal('show');", true);
        }


        // TODO: Update the status in DB or take desired action
        // Example:
        //UpdateHelpdeskStatus(helpdeskId, newStatus);

        // Rebind GridView or show message or load details
        //LoadHelpdeskData(); // Your method to rebind data


        protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Reply")
            {
                int helpdeskId = Convert.ToInt32(e.CommandArgument);
                TextBox txtReply = (TextBox)e.Item.FindControl("txtReply");
                string replyText = txtReply.Text.Trim();

                if (!string.IsNullOrEmpty(replyText))
                {
                    // Save the reply to DB (you need to have this method in BLL)
                    support.Sql_Operation = "AddReply";
                    //support.Helpdesk_id = helpdeskId;
                    //support.Description = replyText;
                    //support.Created_By = Session["name"].ToString(); // Or user_id
                    support.Society_Id = society_id.Value;

                 /*   bl_support.add_reply(support);*/ // You must have this BLL method

                    // Re-bind updated comments
                    BindComments(helpdeskId);
                }
            }
        }



        protected void btn_search_Click(object sender, EventArgs e)
        {
            getTicket();
        }

        protected void getTicket()
        {
            support.Sql_Operation = "SupportTicket";
            support.Society_Id = society_id.Value;
            var dt = bl_support.support_ticket(support);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getTicket();
        }

      

    }


}
