﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Web.Configuration;
using DBCode.DataClass.Master_Dataclass;
using BusinessLogic.MasterBL;
using System.Windows.Forms;

namespace Society
{
    partial class vendor_search : System.Web.UI.Page
    {
        Vendor vendor = new Vendor();
        BL_Vendor_Master bL_Vendor = new BL_Vendor_Master();
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (Session["name"] == null)
            {
                Response.Redirect("login1.aspx");
            }else
                society_id.Value = Session["society_id"].ToString();
            if (!IsPostBack)
            {
                Vendor_GridBind();
                
            }

        }

        public void Vendor_GridBind()
        {
            DataTable dt = new DataTable();
            vendor.Sql_Operation = "Grid_Show";
            vendor.Society_Id = society_id.Value;
            dt = bL_Vendor.getvendorDetails(vendor);

            GridView1.DataSource = dt;
            ViewState["dirState"] = dt;
            GridView1.DataBind();

        }
        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dtrslt = (DataTable)ViewState["dirState"];
            if (dtrslt.Rows.Count > 0)
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
                GridView1.DataSource = dtrslt;
                GridView1.DataBind();


            }

        }

        protected void btn_search_Click(object sender, EventArgs e)
        {

            vendor.Name = txt_search.Text.Trim();
            vendor.Sql_Operation = "search";
            vendor.Society_Id = society_id.Value;
            var result = bL_Vendor.search_vendor(vendor);
            GridView1.DataSource = result;
            ViewState["dirState"] = result;
            GridView1.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refocus", "refocusAfterPostback();", true);
        }
        public string runproc_save(String operation)
        {
            if (vendor_id.Value != "")
                vendor.vendor_id = Convert.ToInt32(vendor_id.Value.ToString());
            vendor.Sql_Operation = operation;
            vendor.Society_Id = society_id.Value;
            vendor.V_Name = txt_name.Text;
            vendor.Org_Name = txt_org_name.Text;
            vendor.Address1 = txt_add1.Text;
            vendor.Address2 = txt_add2.Text;
            vendor.Mobile_No = txt_mob.Text;
            vendor.Org_Tel_No = txt_org_mob.Text;
            vendor.Email = txt_mail.Text;
            var result = bL_Vendor.updatevendorDetails(vendor);
            return result.Sql_Result;

        }
        public void runproc(String operation)
        {
            if (vendor_id.Value != "")
                vendor.vendor_id = Convert.ToInt32(vendor_id.Value);
            vendor.Sql_Operation = operation;
            var result = bL_Vendor.updatevendorDetails(vendor);

            vendor_id.Value = result.vendor_id.ToString();
            society_id.Value = result.Society_Id;
            txt_name.Text = result.V_Name;
            txt_org_name.Text = result.Org_Name;
            txt_add1.Text = result.Address1;
            txt_add2.Text = result.Address2;
            txt_mob.Text = result.Mobile_No;
            txt_org_mob.Text = result.Org_Tel_No;
            txt_mail.Text = result.Email;
        }


            protected void edit_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            vendor_id.Value = id;
            runproc("Select");
            btn_delete.Visible = true;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModalScript", "openModal();", true);
        }
        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (Label10.Text == "" && Label12.Text=="" )
            {
                string str = runproc_save("Update");

                if (str == "Done")
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "SuccessEntry();", true);
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "FailedEntry();", true);

                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);

            }

        }

        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("vendor_search.aspx");
        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            //MessageBoxButtons buttons = MessageBoxButtons.YesNo;
            //DialogResult result = MessageBox.Show("Are you sure want to delete", "delete", buttons);
       
                if (vendor_id.Value != "")
                    vendor.vendor_id = Convert.ToInt32(vendor_id.Value);
                vendor.Sql_Operation = "Delete";
                bL_Vendor.delete(vendor);
            
            Response.Redirect("vendor_search.aspx");
        }


        protected void txt_name_TextChanged(object sender, EventArgs e)
        {
            //    if (vendor_id.Value != "")
            //        vendor.V_Id = Convert.ToInt32(vendor_id.Value);
            //    vendor.Sql_Operation = "check_name";
            //    var result = bL_Vendor.org_name_textchanged(vendor);
            //    Label10.Text = result.Sql_Result;

        }


        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            MessageBoxButtons buttons = MessageBoxButtons.YesNo;
            DialogResult result = MessageBox.Show("Are you sure want to delete", "delete", buttons);
            if (result == DialogResult.Yes)
            {
                GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
                System.Web.UI.WebControls.Label vendor_id = (System.Web.UI.WebControls.Label)row.FindControl("vendor_id");
                vendor.Sql_Operation = "Delete";

                vendor.vendor_id = Convert.ToInt32(vendor_id.Text);
                bL_Vendor.delete(vendor);
                //ClientScript.RegisterStartupScript(this.GetType(), "Pop", "alert('" + result.Sql_Result + "')", true);
            }
            Vendor_GridBind();

        }

        protected void txt_mob_TextChanged(object sender, EventArgs e)
        {

            if (vendor_id.Value != "")
                vendor.vendor_id = Convert.ToInt32(vendor_id.Value);
            vendor.Sql_Operation = "check_no";
            vendor.Mobile_No = txt_mob.Text;
            var result = bL_Vendor.mobile_no_textchanged(vendor);
            Label12.Text = result.Sql_Result;
            if (Label12.Text != "")
                btn_save.Enabled = false;
            else
                btn_save.Enabled = true;

        }

        protected void txt_mail_TextChanged(object sender, EventArgs e)
        {
            if (vendor_id.Value != "")
                vendor.vendor_id = Convert.ToInt32(vendor_id.Value);
            vendor.Sql_Operation = "check_mail";
            vendor.Email = txt_mail.Text;
            var result = bL_Vendor.email_textchanged(vendor);
            Label13.Text = result.Sql_Result;

            if (Label13.Text != "")
                btn_save.Enabled = false;
            else
                btn_save.Enabled = true;
        }

        protected void txt_org_name_TextChanged(object sender, EventArgs e)
        {

            if (vendor_id.Value != "")
                vendor.vendor_id = Convert.ToInt32(vendor_id.Value);
            vendor.Sql_Operation = "check_name";
            vendor.V_Name = txt_name.Text;
            vendor.Org_Name = txt_org_name.Text;
            var result = bL_Vendor.org_name_textchanged(vendor);
            Label8.Text = result.Sql_Result;

            if (Label8.Text != "")
                btn_save.Enabled = false;
            else
                btn_save.Enabled = true;

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;

            Vendor_GridBind();
        }
    }
}

    

