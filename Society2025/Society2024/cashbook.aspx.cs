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
//using System.Windows.Controls;
//using Azure;
using System.Drawing.Drawing2D;
using Page = System.Web.UI.Page;
using Microsoft.Reporting.WebForms;
using Utility.DataClass;
using BusinessLogic.BL;
using Microsoft.Ajax.Utilities;
//using System.IdentityModel.Metadata


namespace Society
{
    public partial class cashbook : System.Web.UI.Page
    {
        BL_FillRepeater repeater = new BL_FillRepeater();
        Cashbook cash = new Cashbook();
        BL_Receipt bL_Receipt = new BL_Receipt();

        int dropValue = -1;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["name"] == null)
            {
                Response.Redirect("login1.aspx");
            }
            else
                society_id.Value = Session["society_id"].ToString();
            //if (Session["name"] == null)
            //{
            //    Response.Redirect("login1.aspx");
            //}


            if (!IsPostBack)
            {
                fill_dropdowns();


                txt_from.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txt_to.Text = DateTime.Now.ToString("yyyy-MM-dd");

            }

        }

        protected void CategoryRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectCategory")
            {
                building_id.Value = e.CommandArgument.ToString();

            }
        }
        public void fill_dropdowns()
        {

            //var data = new List<dynamic>
            //{
            //    new { credit = "1", debit = "2" }
            //};

            //Repeater1.DataSource = data;
            //Repeater1.DataBind();
        }

        protected void Cashbook_GridBind()
        {

            cash.Sql_Operation = "cashbook";
            if (dropValue != -1)
            {

                cash.Type = dropValue;
            }
            if (txt_from.Text != "" && txt_to.Text != "")
            {
                cash.Date1 = Convert.ToDateTime(txt_from.Text.ToString());
                cash.Date2 = Convert.ToDateTime(txt_to.Text.ToString());
            }
            var dt = bL_Receipt.Get_CashBook(cash);
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
            Response.Redirect("receipt_search_form.aspx");
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Cashbook_GridBind();
            Panel1.Visible = false;
            GridView1.Visible = true;
            int count = 1;


        }



        protected void btn_close_Click(object sender, System.EventArgs e)
        {
            Response.Redirect("receipt_search_form.aspx");
            //Response.Redirect("owner_detailsDataSet.aspx?view_id=" + Request.QueryString["view_id"]);

        }





        protected void edit_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();




            //btn_delete.Visible = true;
            ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
            //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "OpenModal()", "<script>$('#mymodal').modal('show');</script>", true);
        }



        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        protected void btn_print_Click(object sender, EventArgs e)
        {


            Panel1.Visible = true;
            GridView1.Visible = false;
            Cashbook_GridBind();
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource rds = new ReportDataSource("cashbook", (DataTable)ViewState["dirState"]);
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("Cashbook.rdlc");
            //  ReportParameter parameter = new ReportParameter("@receipt_id",receipt_id.Value);
            // ReportViewer1.LocalReport.SetParameters(parameter);
            ReportViewer1.LocalReport.DataSources.Add(rds);
            ReportViewer1.LocalReport.Refresh();


        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Cashbook_GridBind();
        }

        protected void ddlTransactionType_SelectedIndexChanged(object sender, EventArgs e)
        {
            dropValue = Convert.ToInt32(ddlTransactionType.SelectedValue);   // Gets the value
            string selectedText = ddlTransactionType.SelectedItem.Text;
        }
    }
}





