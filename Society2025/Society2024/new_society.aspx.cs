using BusinessLogic.BL;
using Society;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utility.DataClass;

namespace Society2024
{
    public partial class society1 : System.Web.UI.Page
    {
      
        Login_Details Details = new Login_Details();
        BL_New_Registration new_Registration = new BL_New_Registration();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["society_id"].ToString() == "")
            {
                 Response.Redirect("login1.aspx");
            }else
                society_id.Value = Session["society_id"].ToString();
            if (!IsPostBack)
            {
                fill_drop1();
                //gvbind1();
                txt_es_date.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");

            }

        }
        public void fill_drop1()
        {
            String sql_query = "Select *  from state";
            new_Registration.fill_drop(ddl_state, sql_query, "state", "state_id");

            String sql_query1 = "Select *  from district";
            new_Registration.fill_drop(ddl_district, sql_query1, "district", "district_id");
            String sql_query2 = "Select *  from division";
            new_Registration.fill_drop(ddl_division, sql_query2, "division", "division_id");
        }

       
        
        public void runproc_save(String operation)
        {

            if (society_master_id.Value != "")
                Details.society_master_id = Convert.ToInt32(society_master_id.Value.ToString());
            Details.Sql_Operation = "Update";
            Details.Society_Id = society_id.Value;
            Details.Name = txt_name.Text;
            Details.Establish_Date = Convert.ToDateTime(txt_es_date.Text);
            Details.Registration_No = txt_registration.Text;
            Details.Off_Address1 = txt_off_address1.Text;
            Details.Off_Address2 = txt_off_address2.Text;
            Details.Contact_No1 = txt_contact_no1.Text;
            Details.Email = txt_email.Text;
            Details.City = txt_city.Text;
            Details.State_Id = 1;// Convert.ToInt32(ddl_state.SelectedValue);
            Details.Pincode = txt_pincode.Text;
          //  Details.Home_No = Convert.ToInt32(txt_street.Text);
            Details.Division = ddl_division.SelectedValue;
            Details.District_Id = Convert.ToInt32(ddl_district.SelectedValue);
            new_Registration.Update_Society(Details);
      
        }




        public void runproc(String operation)
        {
            if (society_master_id.Value != "")
                Details.society_master_id = Convert.ToInt32(society_master_id.Value);
            Details.Sql_Operation = "Select";
            var result = new_Registration.select_society(Details);

            society_id.Value = result.Society_Id;
            txt_name.Text = result.Name;
            txt_es_date.Text = result.Establish_Date.ToString("yyyy-MM-dd");
            txt_registration.Text = result.Registration_No;
            txt_off_address1.Text = result.Off_Address1;
            txt_off_address2.Text = result.Off_Address2;
            txt_contact_no1.Text = result.Contact_No1;
            txt_email.Text = result.Email;
            txt_city.Text = result.City;
            ddl_state.SelectedValue = result.State_Id.ToString();
            txt_pincode.Text = result.Pincode.ToString();
            txt_street.Text = result.Home_No.ToString();
            ddl_division.SelectedValue = result.Division.ToString();
            ddl_district.SelectedValue = result.District_Id.ToString();
            Session["society_id"] = society_id.Value;
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
             

            if (Label22.Text == "")
            {
                runproc_save("Update");
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "SuccessEntry();", true);
            }
            else
            {
                
                Response.Redirect("new_society.aspx");
            }



        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            if (society_master_id.Value != "")
                Details.society_master_id = Convert.ToInt32(society_master_id.Value);
            Details.Sql_Operation = "Delete";
            new_Registration.delete(Details);
            Response.Redirect("new_society.aspx");

        }

        protected void edit_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            society_master_id.Value = id;
            runproc("Select");
            btn_delete.Visible = true;
            ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
            //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "OpenModal()", "<script>$('#mymodal').modal('show');</script>", true);
        }

       

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("society_search.aspx");
        }

        protected void txt_registration_TextChanged(object sender, EventArgs e)
        {
            if (txt_registration.Text.Trim() != "")
            {
                if (society_master_id.Value != "")
                    Details.society_master_id = Convert.ToInt32(society_master_id.Value);
                Details.Sql_Operation = "check_no";
                Details.Name = txt_name.Text;
                Details.Registration_No = txt_registration.Text;
                var result = new_Registration.Reg_Textchanged(Details);
                Label22.Text = result.Sql_Result;
            }
        }

        protected void ddl_state_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl_state.Text != "select")
            {

                string sql1 = "select * from dbo.district Where state_id="  + ddl_state.SelectedValue;
                new_Registration.fill_drop(ddl_district, sql1, "district", "district_id");

            }
        }

        protected void ddl_district_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl_district.Text != "select")
            {

                string sql2 = "select * from dbo.division Where district_id=" + ddl_district.SelectedValue;
                new_Registration.fill_drop(ddl_division, sql2, "division", "division_id");

            }
        }
    }
}
