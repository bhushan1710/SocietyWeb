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
using DBCode.DataClass;
using BusinessLogic.MasterBL;
using DocumentFormat.OpenXml.Bibliography;
using BusinessLogic.BL;

//using CrystalDecisions.CrystalReports.Engine;
//using CrystalDecisions.Windows.Forms;

namespace Society
{
    public partial class maintenance_search : System.Web.UI.Page
    {
        BL_FillRepeater repeater = new BL_FillRepeater();
        maintenance Maintenance1 = new maintenance();
        BL_Maintenance_Master bL_Maintenance = new BL_Maintenance_Master();

        DataTable dt1 = new DataTable();
        public class BillCharge
        {
            public int SrNo { get; set; }
            public string ChargeName { get; set; }
            public decimal Amount { get; set; }
        }



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
                //runproc("Select");

                //filldrop();
                maintenance_Gridbind();


                Allbound();


                if (Request.QueryString["id"] != null)
                {
                    //cust_id.Value = Request.QueryString["id"].ToString();

                }


            }

        }
        protected void Allbound()
        {

            building_fill();
            wing_fill();
        }

        protected void CategoryRepeater_ItemCommand1(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectCategory")
            {
                building_id.Value = e.CommandArgument.ToString();
                wing_fill();

            }

        }

        protected void CategoryRepeater_ItemCommand2(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectCategory")
            {
                wing_id.Value = e.CommandArgument.ToString();

            }

        }

        public void maintenance_Gridbind()
        {
            DataTable dt = new DataTable();
            Maintenance1.Sql_Operation = "Grid_Show";
            Maintenance1.Society_Id = society_id.Value;
            dt = bL_Maintenance.getMaintenanceDetails(Maintenance1);
            GridView1.DataSource = dt;
            ViewState["dirState"] = dt;
            GridView1.DataBind();
            GridView3.DataSource = dt;
            GridView3.DataBind();
        }
        public void building_fill()
        {
            DataTable dt = new DataTable();
            Maintenance1.Sql_Operation = "FillBuild";
            Maintenance1.Society_Id = society_id.Value;
            dt = bL_Maintenance.list_Fill(Maintenance1);
            Repeater1.DataSource = dt;
            Repeater1.DataBind();

        }
        public void wing_fill()
        {
            DataTable dt = new DataTable();
            Maintenance1.Sql_Operation = "FillWing";
            Maintenance1.Society_Id = society_id.Value;
            Maintenance1.build_id = building_id.Value != "" ? Convert.ToInt32(building_id.Value) : 0;
            dt = bL_Maintenance.list_Fill(Maintenance1);
            DataRow newRow = dt.NewRow();
            newRow["Wing_id"] = 0;  // Your column name here
            newRow["W_Name"] = "ALL"; // Example default text

            // ✅ Insert row at top
            dt.Rows.InsertAt(newRow, 0);

            dt.AcceptChanges();// Set wing name for "All" option
                               // Add an empty row for "All" option
            Repeater2.DataSource = dt;
            Repeater2.DataBind();

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
            Response.Redirect("new_maintenance.aspx");
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        public string runproc_save(string operation)
        {

            Maintenance1.Sql_Operation = "exfetch";
            Maintenance1.build_id = Convert.ToInt32(building_id.Value);
            Maintenance1.Date = Convert.ToDateTime(txt_date.Text);
            bL_Maintenance.Add_Click(Maintenance1);


            Maintenance1.Sql_Operation = operation;
            Maintenance1.Society_Id = society_id.Value;
            Maintenance1.build_id = Convert.ToInt32(building_id.Value);
            Maintenance1.M_Date = Convert.ToDateTime(txt_date.Text);
            var flat = Label4.Text.Split(':');

            if (flat.Length > 1)
                Maintenance1.Flat = Convert.ToInt32(flat[1]);
            Maintenance1.wing_id = Convert.ToInt32(wing_id.Value);

            Maintenance1.M_Total = Convert.ToDecimal(txt_amount.Text);
            //Maintenance1.Total_Amount = decimal.Parse(txt_total_amt.Text);
            //Maintenance1.Amount_Per_Flat = decimal.Parse(txt_amt_per_ft.Text);
            //Maintenance1.Nature_Of_Charge = txt_nature_charge.Text;
            var result = bL_Maintenance.updateMaintenanceDetails(Maintenance1);
            n_m_id.Value = result.n_m_id.ToString();

            return result.Sql_Result;


        }


        public void runproc(String operation)
        {

            if (n_m_id.Value != "")
                Maintenance1.n_m_id = Convert.ToInt32(n_m_id.Value);
            Maintenance1.Sql_Operation = operation;
            var result = bL_Maintenance.select_maintenance_details(Maintenance1);

            n_m_id.Value = result.n_m_id.ToString();
            building_id.Value = result.build_id.ToString();
            txt_date.Text = result.M_Date.ToString("yyyy-MM-dd");

            wing_id.Value = result.wing_id.ToString();
            txt_amount.Text = result.M_Total.ToString();

            m_bill_status.Value = result.Status.ToString();

            if (result.Status == 1)
            {
                Panel1.Enabled = false;

            }
            else
                Panel1.Enabled = true;

            Allbound();


        }


        public void final_total()
        {


            int sum = Convert.ToInt32(dt1.Compute("SUM(f_amount)", string.Empty));
            txt_amount.Text = sum.ToString();

        }
        protected void edit_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            n_m_id.Value = id;
            Session["n_m_id"] = n_m_id.Value;
            runproc("Select");
            // if (drp_wing.Text != "ALL")
            drp_build_SelectedIndexChanged(sender, e);
            btnAdd_Click(sender, e);
            list_fill();



            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModalScript", "openModal();", true);

            //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "OpenModal()", "<script>$('#mymodal').modal('show');</script>", true);
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {

            if (txt_amount.Text != "0")
            {
                Maintenance1.Sql_Operation = "check_already";
                Maintenance1.build_id = Convert.ToInt32(building_id.Value);
                Maintenance1.M_Date = Convert.ToDateTime(txt_date.Text);
                var result = bL_Maintenance.check_already(Maintenance1);
                if (result.Sql_Result == "Exist")
                {


                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Maintenance Already Exist For This Month..!!!');", true);
                }

                else
                {

                    var str = runproc_save("Update");
                    if (str == "Done")
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Maintenance Bill Only Save Not Generate Maintenance Bill..!!!');", true);
                        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "SuccessEntry();", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "FailedEntry();", true);

                    }
                }

            }
            else
                Response.Redirect("maintenance_search.aspx");


        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            if (n_m_id.Value != "")
                Maintenance1.n_m_id = Convert.ToInt32(n_m_id.Value);
            Maintenance1.Sql_Operation = "Delete";
            bL_Maintenance.delete(Maintenance1);
            Response.Redirect("maintenance_search.aspx");

        }

        protected void btn_close_Click(object sender, EventArgs e)
        {
            dt1 = null;
        }


        protected void btn_print_Click(object sender, EventArgs e)
        {
            Maintenance1.Sql_Operation = "GetBills";  // 👉 Replace with your actual operation name
            Maintenance1.Society_Id = society_id.Value;
            Maintenance1.n_m_id = Convert.ToInt32(n_m_id.Value); // If you're filtering by n_m_id = 1

            DataTable dt = bL_Maintenance.get_maintanance(Maintenance1);

            ViewState["bill"] = dt;
            Repeater3.DataSource = dt;
            Repeater3.DataBind();
            ScriptManager.RegisterStartupScript(this, GetType(), "showPrintModal", "$('#printModal').modal('show');", true);
        }

        protected void btn_bill_Click(object sender, EventArgs e)
        {
            Maintenance1.Sql_Operation = "checkBill";
            Maintenance1.build_id = Convert.ToInt32(building_id.Value);
            Maintenance1.M_Date = Convert.ToDateTime(txt_date.Text);
            var result = bL_Maintenance.check_date(Maintenance1);
            n_m_id.Value = result.n_m_id.ToString();
            if (result.Sql_Result == "Exist")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Maintenance Already Exist For This Month..!!!');", true);

            }
            else
            {

                if (txt_amount.Text != "0")
                {
                    Maintenance1.Sql_Operation = "check_already";
                    Maintenance1.build_id = Convert.ToInt32(building_id.Value);
                    Maintenance1.M_Date = Convert.ToDateTime(txt_date.Text);
                    var data = bL_Maintenance.check_already(Maintenance1);
                    n_m_id.Value = data.n_m_id.ToString();
                    if (data.Sql_Result != "Exist")


                        runproc_save("Update");

                }



                Maintenance1.Sql_Operation = "generate";
                Maintenance1.M_Date = Convert.ToDateTime(txt_date.Text);
                Maintenance1.wing_id = Convert.ToInt32(wing_id.Value);
                Maintenance1.n_m_id = Convert.ToInt32(n_m_id.Value);
                dt1 = (DataTable)ViewState["expenseData"];
                bool doesNotExistRegular = dt1.AsEnumerable().Any(row => row.Field<string>("Type") == "Regular");
                bool doesNotExist = dt1.AsEnumerable().Any(row => row.Field<string>("Type") == "Add-On");

                if (doesNotExistRegular)
                    Maintenance1.RegularAmount = Convert.ToDecimal(dt1.Compute("SUM(amount)", "type = 'Regular'"));
               
                if (doesNotExist)
                    Maintenance1.Add_OnAmount = Convert.ToDecimal(dt1.Compute("SUM(amount)", "type = 'Add-On'"));

                var result3 = bL_Maintenance.genrate_bill(Maintenance1);

                if (result3.Sql_Result == "Done")
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Maintenance Bill Generated Successfully..!!!');", true);
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('" + result3.Sql_Result + "');", true);
                Response.Redirect("maintenance_search.aspx");
            }
            btnAdd_Click(sender, e);
        }

        public void list_fill()
        {

            Maintenance1.Sql_Operation = "owner_select";
            Maintenance1.build_id = Convert.ToInt32(building_id.Value);
            var result4 = bL_Maintenance.list_Fill(Maintenance1);


            CheckBoxList1.DataSource = result4;
            CheckBoxList1.DataTextField = "owner_name";
            CheckBoxList1.DataValueField = "owner_id";
            CheckBoxList1.DataBind();


        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
            Label n_m_id = (Label)row.FindControl("n_m_id");
            Maintenance1.Sql_Operation = "Delete";

            Maintenance1.n_m_id = Convert.ToInt32(n_m_id.Text);
            var result = bL_Maintenance.delete(Maintenance1);

            maintenance_Gridbind();

            if (result.Sql_Result == "Done")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "Delete()", true);
                Response.Write("<script>alert('building Entry Has Been Registered Successfully')");
                Response.Redirect("maintenance_search.aspx");
            }


        }


        protected void btn_search_Click(object sender, EventArgs e)
        {

            Maintenance1.Name = txt_search.Text.Trim();
            Maintenance1.Sql_Operation = "search";
            Maintenance1.Society_Id = society_id.Value;
            var result = bL_Maintenance.search_maintenance1(Maintenance1);
            GridView1.DataSource = result;
            GridView1.DataSource = result;
            ViewState["dirState"] = result;
            GridView1.DataBind();
            GridView3.DataSource = result;
            GridView3.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refocus", "refocusAfterPostback();", true);


        }

        protected void Print_Click(object sender, EventArgs e)
        {

            //showreport();
            Response.Redirect("printreport.aspx");
        }

        protected void CheckAll_CheckedChanged(object sender, EventArgs e)
        {
            foreach (ListItem item in CheckBoxList1.Items)
            {
                item.Selected = CheckAll.Checked;
            }
        }

        protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool isAllChecked = true;
            foreach (ListItem item in CheckBoxList1.Items)
            {
                if (!item.Selected)
                {
                    isAllChecked = false;
                    break;
                }
            }

            CheckAll.Checked = isAllChecked;
        }

        protected void search_field_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (search_field.SelectedValue == "year")
            //{
            //    string sql2 = "SELECT distinct year FROM maintainance ";
            //    bL_Maintenance.fill_drop(drop_build, sql2, "year", "year");

            //}
            //else if (search_field.SelectedValue == "month_name")
            //{
            //    string sql4 = "SELECT distinct month_name FROM maintainance ";
            //    bL_Maintenance.fill_drop(drop_build, sql4, "month_name", "month_name");


            //}
            //else if (search_field.SelectedValue == "build_name")
            //{
            //    string sql3 = "SELECT build_id, name FROM  dbo.building_master where society_id='" + society_id.Value + "' order by name";
            //    bL_Maintenance.fill_drop(drop_build, sql3, "name", "build_id");

            //}
        }

        protected void drp_wing_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (drp_wing.Text != "select")
            //{

            //    string sql1 = "Select distinct flat_no,facility_id from dbo.owner_search_vw where  society_id='" + society_id.Value + "' and  w_id='" + drp_wing.SelectedValue + "'";
            //    st.fill_drop(drp_flat_type, sql1, "flat_no", "facility_id");

            //}
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#edit_model').modal('show');", true);
        }

        protected void drp_build_SelectedIndexChanged(object sender, EventArgs e)
        {

            //if (building_id.Value != "")
            //{
            //    list_fill();
            //    string sql1 = "Select distinct wing_id,w_name from wing_master where society_id='" + society_id.Value + "' and  build_id='" + drp_build.SelectedValue + "'";
            //    bL_Maintenance.fill_drop_1(drp_wing, sql1, "w_name", "wing_id");
            //    // drp_wing_SelectedIndexChanged(sender, e);
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#edit_model').modal('show');", true);

            //}

        }

        protected void drp_flat_type_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAdd_Click(sender, e);
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            maintenance_Gridbind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {

            {
                BtnPanel.Visible = true;

                int i = 1;
                float total = 0;
                Maintenance1.Sql_Operation = "exfetch";
                Maintenance1.Society_Id = society_id.Value;
                Maintenance1.build_id = Convert.ToInt32(building_id.Value);
                Maintenance1.Date = Convert.ToDateTime(txt_date.Text);
                var result = bL_Maintenance.Add_Click(Maintenance1);
                if (result != null)
                {
                    if (result.Rows.Count > 0)
                    {
                        BtnPanel.Visible = true;
                    }
                    else
                    {
                        BtnPanel.Visible = false;
                        lblMsg.Text = "No maintanance Added!";
                    }
                    dt1 = result;
                    ViewState["expenseData"] = dt1;
                    if (TextBox6.Text == "ALL")
                    {
                        Maintenance1.Sql_Operation = "check_count";
                        Maintenance1.build_id = Convert.ToInt32(building_id.Value);
                        Maintenance1.W_Name = wing_id.Value.ToString();
                    }
                    else

                    {
                        Maintenance1.Sql_Operation = "check_wing";
                        Maintenance1.W_Name = wing_id.Value.ToString();
                        Maintenance1.build_id = Convert.ToInt32(building_id.Value);

                    }
                    var flat = bL_Maintenance.getflat(Maintenance1);
                    Label4.Text = "No of Flat :" + flat.Flat.ToString();
                    dt1.Columns.Add("amount", typeof(decimal));

                    foreach (DataRow row in dt1.Rows)
                    {
                        int count = flat.Flat == 0 ? 1 : flat.Flat;
                        row["amount"] = Convert.ToDecimal(row["f_amount"].ToString()) / count;


                    }



                    dt1.AcceptChanges();

                    txt_amount.Text = dt1.Compute("SUM(f_amount)", string.Empty).ToString();
                    expenseGrid.DataSource = dt1;
                    expenseGrid.DataBind();

                }
            }
        }


        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (building_id.Value != "")
                {
                    var link = (LinkButton)e.Item.FindControl("lnkCategory");
                    if (link.CommandArgument == building_id.Value)
                        TextBox5.Text = link.Text;
                }
            }
        }

        protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (wing_id.Value != "")
                {
                    var link = (LinkButton)e.Item.FindControl("lnkCategory");
                    if (link.CommandArgument == wing_id.Value)
                        TextBox6.Text = link.Text;
                }
            }
        }

        public static class NumberToWords
        {
            private static string[] units = { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine" };
            private static string[] teens = { "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
            private static string[] tens = { "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };

            public static string ConvertToWords(int number)
            {
                if (number == 0) return "Zero";
                if (number < 0) return "Minus " + ConvertToWords(Math.Abs(number));

                string words = "";

                if ((number / 1000) > 0)
                {
                    words += ConvertToWords(number / 1000) + " Thousand ";
                    number %= 1000;
                }

                if ((number / 100) > 0)
                {
                    words += ConvertToWords(number / 100) + " Hundred ";
                    number %= 100;
                }

                if (number > 0)
                {
                    if (words != "") words += "and ";
                    if (number < 10)
                        words += units[number];
                    else if (number < 20)
                        words += teens[number - 10];
                    else
                    {
                        words += tens[number / 10];
                        if ((number % 10) > 0)
                            words += " " + units[number % 10];
                    }
                }

                return words;
            }
        }
        [System.Web.Services.WebMethod]
        public static string GetBillHtml(string billId)
        {
            int id = Convert.ToInt32(billId);
            var bL_Maintenance = new BL_Maintenance_Master();
            var Maintenance1 = new maintenance
            {
                Sql_Operation = "Select",
                n_m_id = id
            };

            var result = bL_Maintenance.select_maintenance_details(Maintenance1);

            // Get Charges for this Bill
            Maintenance1.Sql_Operation = "exfetch";
            Maintenance1.build_id = result.build_id;
            Maintenance1.Date = result.M_Date;

            DataTable charges = bL_Maintenance.Add_Click(Maintenance1);

            // Build the HTML string
            decimal total = 0;
            string rows = "";

            for (int i = 0; i < charges.Rows.Count; i++)
            {
                decimal amount = Convert.ToDecimal(charges.Rows[i]["f_amount"]);
                total += amount;

                rows += $"<tr>" +
                        $"<td style='padding:5px'>{i + 1}</td>" +
                        $"<td style='padding:5px'>{charges.Rows[i]["ex_details"]}</td>" +
                        $"<td style='padding:5px'>₹ {amount}</td>" +
                        $"</tr>";
            }

            string totalInWords = NumberToWords.ConvertToWords((int)total);

            string html = $@"
        <div style='padding:20px; font-family:sans-serif;'>
        <h3 style='text-align:center;'>MAINTENANCE BILL</h3>
        <p><strong>Owner Name:</strong> {result.owner_name}</p>
        <p><strong>Flat No:</strong> {result.flat_no} | <strong>Wing:</strong> {result.wing_name}</p>
        <p><strong>Bill Date:</strong> {result.M_Date:dd MMM yyyy} | <strong>Due Date:</strong> {result.Due_Date:dd MMM yyyy}</p>
        
        <table border='1' width='100%' cellpadding='5' cellspacing='0' style='border-collapse: collapse;'>
            <thead>
                <tr>
                    <th>Sr. No</th>
                    <th>Nature of Charges</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                {rows}
                <tr>
                    <td colspan='2' style='text-align:right'><strong>Total</strong></td>
                    <td><strong>₹ {total}</strong></td>
                </tr>
            </tbody>
        </table>

        <p><strong>Amount in Words:</strong> {totalInWords} rupees</p>
        <p><em>Do follow rules and regulations.</em></p>
        <p style='text-align:right;'>For Gokuldham<br/><strong>HON-SECRETARY</strong></p>
    </div>";

            return html;
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

        }



        protected void Repeater3_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = (DataRowView)e.Item.DataItem;

                // Convert col1_name...col30_name into a new table
                DataTable chargesTable = new DataTable();
                chargesTable.Columns.Add("SrNO");
                chargesTable.Columns.Add("ChargeName");
                chargesTable.Columns.Add("Amount");

                for (int i = 1; i <= 30; i++)
                {

                    string nameCol = $"col{i}_name";
                    string amtCol = $"col{i}_amount";

                    string chargeName = row[nameCol]?.ToString();
                    string amount = row[amtCol]?.ToString();

                    if (!string.IsNullOrWhiteSpace(chargeName)) // Only add if name exists
                    {
                        chargesTable.Rows.Add(i, chargeName, amount);
                    }
                }

                // Bind nested Repeater
                Repeater rptCharges = (Repeater)e.Item.FindControl("billCharges");
                rptCharges.DataSource = chargesTable;
                rptCharges.DataBind();
            }
        }

        protected void btnViewBill_Command(object sender, CommandEventArgs e)
        {
            Maintenance1.n_m_id = Convert.ToInt32(e.CommandArgument.ToString());
            Maintenance1.Sql_Operation = "GetBills";  // 👉 Replace with your actual operation name
            Maintenance1.Society_Id = society_id.Value;
            // If you're filtering by n_m_id = 1

            DataTable dt = bL_Maintenance.get_maintanance(Maintenance1);
            ViewState["bill"] = dt;
            Repeater3.DataSource = dt;
            Repeater3.DataBind();
            //  bill.Update();
            ScriptManager.RegisterStartupScript(this, GetType(), "showPrintModal", "$('#printModal').modal('show');", true);
        }

        //protected void btnViewBill_Command(object sender, CommandEventArgs e)
        //{
        //    string billId = e.CommandArgument.ToString();

        //    // Example: Get data from DB (or just simulate for now)
        //    var billData = bL_Maintenance.select_maintenance_details(new maintenance
        //    {
        //        Sql_Operation = "Select",
        //        n_m_id = Convert.ToInt32(billId)
        //    });

        //    // Populate hidden fields or use JavaScript to set modal values
        //    // Example: Populate modal via JS
        //    string js = $@"
        //document.getElementById('modalDate').innerText = '{billData.M_Date:dd MMM yyyy}';
        //document.getElementById('modalAmount').innerText = '{billData.M_Total}';
        //document.getElementById('modalMode').innerText = 'Online';
        //document.getElementById('modalTxnRef').innerText = 'TXN12345';
        //document.getElementById('modalUpiId').innerText = 'owner@upi';
        //$('#receiptModal').modal('show');";

        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowReceiptModal", js, true);
        //}



    }
}




