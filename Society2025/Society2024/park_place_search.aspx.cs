using System;
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
    public partial class park_place_search : System.Web.UI.Page
    {
        Parking_1 parking = new Parking_1();
        BL_Parking_Master bL_Parking = new BL_Parking_Master();



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
                runproc("Select");

                Parking_Gridbind();


                if (Request.QueryString["id"] != null)
                {
                    //cust_id.Value = Request.QueryString["id"].ToString();

                }

            }

        }

        public void Parking_Gridbind()
        {
            DataTable dt = new DataTable();
            parking.Sql_Operation = "Grid_Show";
            parking.Society_Id = society_id.Value;
            dt = bL_Parking.getParkingDetails(parking);
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


        protected void btn_new_Click(object sender, EventArgs e)
        {
            Response.Redirect("park_place_search.aspx");
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            parking.Name = txt_search.Text.Trim();
            parking.Sql_Operation = "search";
            parking.Society_Id = society_id.Value;
            var result = bL_Parking.search_park_place(parking);
            GridView1.DataSource = result;
            ViewState["dirState"] = result;
            GridView1.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refocus", "refocusAfterPostback();", true);
        }

        public void runproc(String operation)
        {
            if (place_id.Value != "")
                parking.place_id = Convert.ToInt32(place_id.Value.ToString());
            parking.Sql_Operation = operation;
            parking.Society_Id = society_id.Value;
            parking.Parking_No = txt_number.Text;
            parking.Park_For = ddl_park_for.SelectedValue;
            bL_Parking.updateParkingDetails(parking);

        }
        public void runproc1(String operation)
        {
            if (place_id.Value != "")
                parking.place_id = Convert.ToInt32(place_id.Value);
            parking.Sql_Operation = operation;
            var result = bL_Parking.updateParkingDetails(parking);

            (place_id.Value) = result.place_id.ToString();
            society_id.Value = result.Society_Id;
            txt_number.Text = result.Parking_No;
            ddl_park_for.SelectedItem.Text = result.Park_For;

        }



        protected void btn_save_Click(object sender, EventArgs e)
        {

            if (Label3.Text == "")
            {
                runproc("Update");
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "SuccessEntry();", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);

            }

        }

        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("park_place_search.aspx");
        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {

            if (place_id.Value != "")
                parking.place_id = Convert.ToInt32(place_id.Value);
            parking.Sql_Operation = "Delete";
            bL_Parking.delete(parking);
            //park_drop();

            Response.Redirect("park_place_search.aspx");
        }



        protected void edit_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            place_id.Value = id;
            runproc1("Select");
            btn_delete.Visible = true;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModalScript", "openModal();", true);
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
            System.Web.UI.WebControls.Label place_id = (System.Web.UI.WebControls.Label)row.FindControl("place_id");
            parking.Sql_Operation = "Delete";

            parking.place_id = Convert.ToInt32(place_id.Text);
            bL_Parking.delete(parking);

            Parking_Gridbind();

        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void txt_number_TextChanged(object sender, EventArgs e)
        {
            if (txt_number.Text.Trim() != "")
            {
                if (place_id.Value != "")
                    parking.place_id = Convert.ToInt32(place_id.Value);
                parking.Sql_Operation = "check_exist";
                parking.Society_Id = society_id.Value;
                parking.Parking_No = txt_number.Text;

                var result = bL_Parking.numbertextchanged(parking);

                Label3.Text = result.Sql_Result;
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Parking_Gridbind();
        }
    }
}

