using DBCode.DataClass;
using Society;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataAccessLayer.MasterDA
{
    public class DA_Maintenence_Master
    {
        stored st = new stored();
        DataTable dt1 = new DataTable();
        public void fill_drop(DropDownList drp_down, string sqlstring, string text, string value)
        {
            st.fill_drop(drp_down, sqlstring, text, value);
        }


        public void fill_drop_1(DropDownList drp_down, string sqlstring, string text, string value)
        {
            st.fill_drop_1(drp_down, sqlstring, text, value);
        }
        public DataTable get_maintenance_details(maintenance Maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", Maintenance1.Sql_Operation));
            data_item.Add(st.create_array("society_id", Maintenance1.Society_Id));

            status1 = st.run_query(data_item, "Select", "sp_new_maintenance", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        public DataTable Get_Monthwise_Charges(maintenance_cal maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));
            data_item.Add(st.create_array("society_id", maintenance1.Society_Id));

            status1 = st.run_query(data_item, "Select", "sp_Society_Charges_monthwise", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        public maintenance Update_Maintenance_Details(maintenance Maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            int sdr = 0;
            string status1;
            int i = 1;
            dt1 = btn_add_click(Maintenance1);
            data_item.Add(st.create_array("operation", Maintenance1.Sql_Operation));
            if (Maintenance1.Sql_Operation == "Update")
            {
                foreach (DataRow row in dt1.Rows)
                {
                    data_item.Add(st.create_array("col" + i + "_name", string.IsNullOrWhiteSpace(row["ex_details"].ToString()) ? (object)DBNull.Value : row["ex_details"].ToString()));
                    data_item.Add(st.create_array("col" + i + "_amount", string.IsNullOrWhiteSpace((float.Parse(row["f_amount"].ToString()) / Maintenance1.Flat).ToString()) ? (object)DBNull.Value : (float.Parse(row["f_amount"].ToString()) / Maintenance1.Flat).ToString()));
                    i++;
                }

                data_item.Add(st.create_array("build_id", Maintenance1.build_id));
                data_item.Add(st.create_array("m_date", Maintenance1.M_Date));
                data_item.Add(st.create_array("wing_id", Maintenance1.wing_id));
                data_item.Add(st.create_array("society_id", Maintenance1.Society_Id));
                data_item.Add(st.create_array("m_total", Maintenance1.M_Total));

            }
            status1 = st.run_query_scalar(data_item, "Select", "sp_new_maintenance", ref sdr);
            if (status1 == "Done")
            {
                if (sdr != 0)

                    Maintenance1.n_m_id = sdr;
            }
            return Maintenance1;



        }

        public maintenance_cal Remaining_Due(maintenance_cal maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";
           

            data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));
            data_item.Add(st.create_array("society_id", maintenance1.Society_Id));
            status1 = st.run_query(data_item, "Select", "sp_Society_Charges_monthwise", ref sdr);

            if (status1 == "Done")
            {
                if (sdr.Read())
                {
                    maintenance1.Amount = Convert.ToDecimal(sdr["amount"].ToString());
                    maintenance1.Pending_Amount = Convert.ToDecimal(sdr["due"].ToString());

                }
                  
            }
            return maintenance1;
        }

        public maintenance_cal Delete_Monthwise_Charges(maintenance_cal maintenance1)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";

            data_item.Add(st.create_array("operation", "Delete"));
            data_item.Add(st.create_array("mon_charge_id", maintenance1.mon_charge_id));
            status1 = st.run_query(data_item, "Select", "sp_society_charges_monthwise", ref sdr);

            if (status1 == "Done")
            {
                maintenance1.Sql_Result = status1;
            }
            return maintenance1;
        }

        public maintenance_cal Update_monthwise_charges(maintenance_cal Maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;
            data_item.Add(st.create_array("operation", Maintenance1.Sql_Operation));
            data_item.Add(st.create_array("mon_charge_id", Maintenance1.mon_charge_id));
            if (Maintenance1.Sql_Operation == "Update")
            {
                data_item.Add(st.create_array("society_id", Maintenance1.Society_Id));
                
                
                data_item.Add(st.create_array("amount", Maintenance1.Amount));
            }
            status1 = st.run_query(data_item, "Select", "sp_Society_Charges_monthwise", ref sdr);
            if (status1 == "Done")
            {
                if (Maintenance1.Sql_Operation == "Select")
                {
                    while (sdr.Read())
                    {
                        Maintenance1.mon_charge_id = Convert.ToInt32(sdr["mon_charge_id"].ToString());
                        Maintenance1.Amount = Convert.ToDecimal(sdr["amount"].ToString());

                        Maintenance1.Date = Convert.ToDateTime(sdr["date"].ToString());
                    }
                }
            }
            return Maintenance1;
        }

        public DataTable Print_maintanance(maintenance Maintanance)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;

            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", Maintanance.Sql_Operation));
            data_item.Add(st.create_array("society_Id", Maintanance.Society_Id));
            data_item.Add(st.create_array("n_m_id", Maintanance.n_m_id));

            status1 = st.run_query(data_item, "Select", "sp_new_maintenance", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }
        public DataTable ownerwise_maintenance(maintenance getMaintenance)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("query", getMaintenance.Sql_Operation));
            
            status1 = st.run_query(data_item, "Select", "sp_search", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }
            

        public DataTable get_maintenance_report(maintenance getMaintenance)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;

            DataTable dt = new DataTable();
            data_item.Add(st.create_array("query", getMaintenance.Sql_Operation));

            status1 = st.run_query(data_item, "Select", "sp_search", ref sdr);
            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        public maintenance getflats(maintenance maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            int i = 1;
            
            string status1 = "";
            if (maintenance1.W_Name == "0")
            {
                data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));
                data_item.Add(st.create_array("build_id", maintenance1.build_id));
            }
            else


            {
                data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));
                data_item.Add(st.create_array("w_name", maintenance1.W_Name));
                data_item.Add(st.create_array("build_id", maintenance1.build_id));
            }

            status1 = st.run_query(data_item, "Select", "sp_flat_master", ref sdr);
            if (status1 == "Done")
                if (sdr.Read())

                    maintenance1.Flat = int.Parse(sdr["flat"].ToString());

            return maintenance1;
        }
        public maintenance Check_Already(maintenance maintenance1)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status;
            data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));

            data_item.Add(st.create_array("build_id", maintenance1.build_id));
            data_item.Add(st.create_array("m_date", maintenance1.M_Date));

            status = st.run_query(data_item, "Select", "sp_new_maintenance", ref sdr);
            if (status == "Done")
            {

                if (sdr.Read())
                {

               
                    maintenance1.n_m_id = Convert.ToInt32(sdr["n_m_id"].ToString());
                    maintenance1.Sql_Result = "Exist";
                }
            }


            return maintenance1;

        }



        public DataTable btn_add_click(maintenance Maintenance1)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            //int i = 1;
            //int total = 0;
            string status1;
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", "exfetch"));
            data_item.Add(st.create_array("build_id", Maintenance1.build_id));
            data_item.Add(st.create_array("date", Maintenance1.Date));
            status1 = st.run_query(data_item, "Select", "sp_society_expense", ref sdr);
            if (status1 == "Done")
            {
                if (sdr.HasRows == true)
                    dt.Load(sdr);
              

            }
            return dt;
        }

        public maintenance Maintenance_Delete(maintenance Maintenance1)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status = "";
            data_item.Add(st.create_array("operation", Maintenance1.Sql_Operation));
            data_item.Add(st.create_array("n_m_id", Maintenance1.n_m_id));

            status = st.run_query(data_item, "Delete", "sp_new_maintenance", ref sdr);
            if (status == "Done")
            {
                Maintenance1.Sql_Result = status;
            }
            return Maintenance1;


        }
        public maintenance Select_Maintenance_Details(maintenance maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;
            data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));
            data_item.Add(st.create_array("n_m_id", maintenance1.n_m_id));
            status1 = st.run_query(data_item, "Select", "sp_new_maintenance", ref sdr);
            if (status1 == "Done")
            {
                while (sdr.Read())
                {

                    maintenance1.build_id = Convert.ToInt32(sdr["build_id"].ToString());
                    maintenance1.M_Date = Convert.ToDateTime(sdr["m_date"].ToString());
                    // drp_flat_type.SelectedValue = sdr["facility_id"].ToString();

                    maintenance1.wing_id = Convert.ToInt32(sdr["wing_id"].ToString());
                    maintenance1.M_Total = Convert.ToDecimal(sdr["m_total"].ToString());
                    maintenance1.n_m_id = Convert.ToInt32(sdr["n_m_id"].ToString());
                    maintenance1.Status = Convert.ToInt32(sdr["status"].ToString());

                }
            }

            return maintenance1;
        }


        public maintenance Check_Date(maintenance maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status;
            data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));

            data_item.Add(st.create_array("build_id", maintenance1.build_id));
            data_item.Add(st.create_array("m_date", maintenance1.M_Date));
            status = st.run_query(data_item, "Select", "sp_new_maintenance", ref sdr);

            if (sdr.Read())
        { 
                maintenance1.Sql_Result = "Exist";
                maintenance1.n_m_id = Convert.ToInt32(sdr["n_m_id"].ToString());

        }

            return maintenance1;

        }

        public maintenance Bill_Exist(maintenance maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status;
            data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));

            data_item.Add(st.create_array("n_m_id", maintenance1.n_m_id));
            status = st.run_query(data_item, "Select", "sp_new_maintenance", ref sdr);

            if (sdr.Read())
            {
                maintenance1.Sql_Result = "Bill_Exist";

            }

            return maintenance1;

        }
        public object search_maintenance(maintenance maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";

            DataTable dt = new DataTable();
            data_item.Add(st.create_array("Operation", maintenance1.Sql_Operation));
            data_item.Add(st.create_array("search", maintenance1.Name));
            data_item.Add(st.create_array("society_id", maintenance1.Society_Id));

            status1 = st.run_query(data_item, "Select", "sp_new_maintenance", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }
        public maintenance Genrate_Bill(maintenance maintenance1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status;
            data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));

            data_item.Add(st.create_array("m_date", maintenance1.M_Date));
            data_item.Add(st.create_array("wing_id", maintenance1.wing_id));
            data_item.Add(st.create_array("n_m_id", maintenance1.n_m_id));
            data_item.Add(st.create_array("regular", maintenance1.RegularAmount));
            data_item.Add(st.create_array("additional", maintenance1.Add_OnAmount));
            status = st.run_query(data_item, "Select", "sp_new_maintenance", ref sdr);

            if (status == "Done")
            {
                maintenance1.Sql_Result = status;

            }

            return maintenance1;

        }


        public DataTable List_Fill(maintenance maintenance1)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status = "";
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", maintenance1.Sql_Operation));
            data_item.Add(st.create_array("society_id", maintenance1.Society_Id));
            data_item.Add(st.create_array("build_id", maintenance1.build_id));
            status = st.run_query(data_item, "Select", "sp_new_maintenance", ref sdr);
            if (status == "Done")
            {
                if (sdr.HasRows)
                {
                    
                        dt.Load(sdr);
                  
                   
                }

            }

            return dt;
        }

      
    }
}
