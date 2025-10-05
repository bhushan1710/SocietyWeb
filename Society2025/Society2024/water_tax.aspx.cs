using BusinessLogic.MasterBL;
using DBCode.DataClass.Master_Dataclass;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Society2024
{
    public partial class Water_tax : System.Web.UI.Page
    {
        private Village village = new Village();
        private BL_Village_Master bL_Village = new BL_Village_Master();
        protected void Page_Load(object sender, EventArgs e)
       
        {
            if (Session["village_id"] != null)
            {
                village_id.Value = Session["village_id"].ToString();
            }
          

            if (!IsPostBack)
            {
                fill_drop1();
                water_tax_Gridbind();
       
            }
        }

        public void fill_drop1()
        {
            String sql_query = "Select *  from connection_type";
            bL_Village.fill_drop(drp_connectiontype, sql_query, "connection_type", "con_type_id");
            String sql_query1 = "SELECT house_no,village_owner_id from house_owner";
            bL_Village.fill_drop(drp_house_no, sql_query1, "house_no", "village_owner_id");
        }

        public void water_tax_Gridbind()
        {
            DataTable dt = new DataTable();
            village.Sql_Operation = "Grid_Show";
            village.Village_Id = village_id.Value;
            dt = bL_Village.get_water_tax(village);

            GridView1.DataSource = dt;
            ViewState["dirState"] = dt;
            GridView1.DataBind();
        }

        public void runproc_save(String operation)
        {
            if (water_tax_id.Value != "")
                village.Water_Tax_Id = Convert.ToInt32(water_tax_id.Value);
            village.Sql_Operation = operation;
            village.House_No = Convert.ToInt32(drp_house_no.SelectedValue);
            village.From_Date = Convert.ToDateTime(Txt_fromdate.Text);
            village.To_Date = Convert.ToDateTime(Txt_todate.Text);
            village.Connection_Type = (drp_connectiontype.SelectedValue);
            village.Water_Connection_Size = Convert.ToInt32(txt_water_con.Text);
            village.Water_Tax_Amount = Convert.ToDecimal(Txt_watertaxamount.Text);
            village.Village_Id = village_id.Value;
            bL_Village.update_water_tax(village);

        }

        public void runproc(string operation)
        {
            if (water_tax_id.Value != "")
                village.Water_Tax_Id = Convert.ToInt32(water_tax_id.Value.ToString());
            village.Sql_Operation = operation;

            var result = bL_Village.update_water_tax(village);
            if (operation == "Select")
            {

                (water_tax_id.Value) = result.Water_Tax_Id.ToString();
                village_id.Value = result.Village_Id;
                drp_house_no.SelectedValue = result.House_No.ToString();
                Txt_fromdate.Text = result.From_Date.ToString("yyyy-MM-dd");
                Txt_todate.Text = result.To_Date.ToString("yyyy-MM-dd");
                drp_connectiontype.SelectedValue = result.Connection_Type;
                txt_water_con.Text = result.Water_Connection_Size.ToString();
                Txt_watertaxamount.Text = result.Water_Tax_Amount.ToString();
               // ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
            }
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

        protected void btn_save_Click(object sender, EventArgs e)
        {
            runproc_save("Update");
            Response.Redirect("water_tax.aspx");
            ClientScript.RegisterStartupScript(this.GetType(), "Pop", "SuccessEntry();", true);
        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            if (water_tax_id.Value != "")
                village.Water_Tax_Id = Convert.ToInt32(water_tax_id.Value);
            village.Sql_Operation = "Delete";
            bL_Village.delete_water_tax(village);
            Response.Redirect("water_tax.aspx");
        }

        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("water_tax.aspx");
        }

        protected void edit_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            water_tax_id.Value = id;
            runproc("Select");
            btn_delete.Visible = true;
            update.Update();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModalScript", "openModal();", true);
        }



        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
            System.Web.UI.WebControls.Label water_tax_id = (System.Web.UI.WebControls.Label)row.FindControl("water_tax_id");
            village.Sql_Operation = "Delete";

            village.Water_Tax_Id = Convert.ToInt32(water_tax_id.Text);
            bL_Village.delete_water_tax(village);


            water_tax_Gridbind();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            water_tax_Gridbind();
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("SELECT dbo.water_tax.water_tax_id, dbo.water_tax.house_no,FORMAT(dbo.water_tax.from_date, 'MMMM yyyy') AS from_date, dbo.water_tax.to_date, dbo.water_tax.water_connection_size, dbo.water_tax.water_tax_amount, dbo.water_tax.village_id,dbo.connection_type.con_type_id, dbo.connection_type.connection_type FROM  dbo.water_tax INNER JOIN dbo.connection_type ON dbo.water_tax.con_type_id = dbo.connection_type.con_type_id and active_status = 0 and village_id='" + village_id.Value + "'");
            if (txt_search.Text != "")
            {
            }
            village.Sql_Operation = sb.ToString();
            var result = bL_Village.search_sq_ft_rate(village);
            GridView1.DataSource = result;
            ViewState["dirState"] = result;
            GridView1.DataBind();
        }
    protected void btn_import_Click(object sender, EventArgs e)
    { }

    }
}