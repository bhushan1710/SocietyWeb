using BusinessLogic.MasterBL;
using DBCode.DataClass.Master_Dataclass;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utility.DataClass;

namespace Society
{
    public partial class recent_activity : System.Web.UI.Page
    {

        BL_User_Login BL_Login = new BL_User_Login();
        Login_Details details = new Login_Details();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["name"] == null)
            {
                Response.Redirect("login1.aspx");
            }

            if (!IsPostBack)
            {
                gridBind();
            }
        }


        protected void btn_search_Click(object sender, EventArgs e)
        {

            gridBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refocus", "refocusAfterPostback();", true);

        }

        protected void gridBind()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            int count = 1;
            sb.Append("Select *  from recent_activity_vw where society_id='" + Session["Society_id"].ToString() + "'");


            if (!string.IsNullOrWhiteSpace(txt_search.Text))
            {
                sb.Append(" AND (");
                sb.Append(" particular LIKE '" + txt_search.Text + "%'");
                sb.Append(" OR CAST(received_amt AS VARCHAR) LIKE '" + txt_search.Text + "%'");
                sb.Append(" OR type LIKE '" + txt_search.Text + "%'");
                sb.Append(" OR CAST(m_date AS VARCHAR) LIKE '" + txt_search.Text + "%'");
                sb.Append(" )");
                count++;
            }

            if (activityType.SelectedItem.Text != "All")
            {
                if (count > 0)
                {
                    sb.Append(" AND ");
                }
                sb.Append(" type = '" + activityType.SelectedItem.Text + "'");
                count++;
            }

            if (dateFrom.Value != "" && dateTo.Value != "")
            {
                if (count > 0)
                {
                    sb.Append(" AND ");
                }
                sb.Append(" m_date between cast(  '" + dateFrom.Value + "' as date) and cast('" + dateTo.Value + "' as date)");
                count++;
            }
            if (selectedMinPriceHidden.Value != "" && selectedMaxPriceHidden.Value != "")
            {
                if (count > 0)
                {
                    sb.Append(" AND ");
                }
                sb.Append(" received_amt between cast( '" + selectedMinPriceHidden.Value + "' as decimal) and cast ('" + selectedMaxPriceHidden.Value + "' as decimal)");
                count++;
            }
            sb.Append("order by date desc");
            details.Sql_Operation = "RecentActivity";
            details.Name = sb.ToString();


            var result = BL_Login.get_recent_Search(details);
            if (result.Rows.Count > 0)
            {
                maxPriceHidden.Value = result.AsEnumerable().Max(row => row.Field<decimal>("received_amt")).ToString();
                minPriceHidden.Value = result.AsEnumerable().Min(row => row.Field<decimal>("received_amt")).ToString();

            }

            GridView1.DataSource = result;
            ViewState["dirState"] = result;
            GridView1.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refocus", "refocusAfterPostback();", true);
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {

            gridBind();


            string chipsHtml = "";

            if (!string.IsNullOrEmpty(dateFrom.Value) || !string.IsNullOrEmpty(dateTo.Value))
            {
                chipsHtml += $"<span class='filter-chip' id='chip-date'>📅 {dateFrom.Value} – {dateTo.Value} <button onclick=\"removeFilter('date')\">×</button></span>";
            }

            if (activityType.SelectedItem.Text != "All")
            {
                chipsHtml += $"<span class='filter-chip' id='chip-type'>🛠️ Type: {activityType.SelectedItem.Text} <button onclick=\"removeFilter('type')\">×</button></span>";
            }

            if (!string.IsNullOrEmpty(selectedMinPriceHidden.Value) || !string.IsNullOrEmpty(selectedMaxPriceHidden.Value))
            {
                chipsHtml += $"<span class='filter-chip' id='chip-price'>💰 ₹{selectedMinPriceHidden.Value} – ₹{selectedMaxPriceHidden.Value} <button onclick=\"removeFilter('price')\">×</button></span>";
            }

            // Assign HTML to filterChips div
            filterChips.InnerHtml = chipsHtml;

            // Close the filter sidebar after applying filters
            ScriptManager.RegisterStartupScript(this, GetType(), "hideSidebar", "document.getElementById('filterSidebar').classList.remove('show');", true);

        }

    }
}