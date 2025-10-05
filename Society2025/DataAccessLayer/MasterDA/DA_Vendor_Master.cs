using DBCode.DataClass.Master_Dataclass;
using Society;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DataAccessLayer.MasterDA
{
    public class DA_Vendor_Master
    {
        stored st = new stored();
        public DataTable Get_Vendor_Details(Vendor vendor)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", vendor.Sql_Operation));
            data_item.Add(st.create_array("society_id", vendor.Society_Id));

            status1 = st.run_query(data_item, "Select", "sp_vendor_master", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }
        public Vendor updateVendorDetails(Vendor vendor)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";
            data_item.Add(st.create_array("operation", vendor.Sql_Operation));
            data_item.Add(st.create_array("vendor_id", vendor.vendor_id));
            if (vendor.Sql_Operation == "Update")
            {
                data_item.Add(st.create_array("society_id", vendor.Society_Id));
                data_item.Add(st.create_array("v_name", vendor.V_Name));
                data_item.Add(st.create_array("org_name", vendor.Org_Name));
                data_item.Add(st.create_array("address1", vendor.Address1));
                data_item.Add(st.create_array("address2", vendor.Address2));
                data_item.Add(st.create_array("mobile_no", vendor.Mobile_No));
                data_item.Add(st.create_array("org_tel_no", vendor.Org_Tel_No));
                data_item.Add(st.create_array("email", vendor.Email));
            }
            status1 = st.run_query(data_item, "Select", "sp_vendor_master", ref sdr);
            vendor.Sql_Result = status1;

            if (status1 == "Done")
            {
                if (vendor.Sql_Operation == "Select")
                {
                    while (sdr.Read())
                    {
                        //  facility_id.Value = sdr["facility_id"].ToString();
                        vendor.Society_Id = sdr["society_id"].ToString();
                        vendor.V_Name = sdr["v_name"].ToString();
                        vendor.Org_Name = sdr["org_name"].ToString();
                        vendor.Address1 = sdr["address1"].ToString();
                        vendor.Address2 = sdr["address2"].ToString();
                        vendor.Mobile_No = sdr["mobile_no"].ToString();
                        vendor.Org_Tel_No = sdr["org_tel_no"].ToString();
                        vendor.Email = sdr["email"].ToString();
                    }
                }
                else
                {
                    vendor.Sql_Result = status1;
                }
            }
            return vendor;





            //ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            //SqlDataReader sdr = null;
            //string status1 = "";
            //data_item.Add(st.create_array("operation", operation));
            //data_item.Add(st.create_array("v_id", v_id.Value == null ? (object)DBNull.Value : v_id.Value));
            //if (operation == "Update")
            //{
            //    data_item.Add(st.create_array("society_id", society_id.Value == null ? (object)DBNull.Value : society_id.Value));
            //    data_item.Add(st.create_array("v_name", string.IsNullOrWhiteSpace(txt_name.Text) ? (object)DBNull.Value : txt_name.Text));
            //    data_item.Add(st.create_array("org_name", string.IsNullOrWhiteSpace(txt_org_name.Text) ? (object)DBNull.Value : txt_org_name.Text));
            //    data_item.Add(st.create_array("address1", string.IsNullOrWhiteSpace(txt_add1.Text) ? (object)DBNull.Value : txt_add1.Text));
            //    data_item.Add(st.create_array("address2", string.IsNullOrWhiteSpace(txt_add2.Text) ? (object)DBNull.Value : txt_add2.Text));
            //    data_item.Add(st.create_array("mobile_no", string.IsNullOrWhiteSpace(txt_mob.Text) ? (object)DBNull.Value : txt_mob.Text));
            //    data_item.Add(st.create_array("org_tel_no", string.IsNullOrWhiteSpace(txt_org_mob.Text) ? (object)DBNull.Value : txt_org_mob.Text));
            //    data_item.Add(st.create_array("email", string.IsNullOrWhiteSpace(txt_mail.Text) ? (object)DBNull.Value : txt_mail.Text));

            //}
            //status1 = st.run_query(data_item, operation, "sp_vendor_master", ref sdr);

            //if (status1 == "Done")
            //{
            //    if (operation == "Select")
            //    {
            //        while (sdr.Read())
            //        {
            //            txt_name.Text = sdr["v_name"].ToString();
            //            txt_org_name.Text = sdr["org_name"].ToString();
            //            txt_add1.Text = sdr["address1"].ToString();
            //            txt_add2.Text = sdr["address2"].ToString();
            //            txt_mob.Text = sdr["mobile_no"].ToString();
            //            txt_org_mob.Text = sdr["org_tel_no"].ToString();
            //            txt_mail.Text = sdr["email"].ToString();
            //        }
            //    }

            //}
            //return status1;

        }

        public object vendor_serach(Vendor vendor)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";

            DataTable dt = new DataTable();
            data_item.Add(st.create_array("Operation", vendor.Sql_Operation));
            data_item.Add(st.create_array("search", vendor.Name));
            data_item.Add(st.create_array("society_id", vendor.Society_Id));

            status1 = st.run_query(data_item, "Select", "sp_vendor_master", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        public Vendor Delete_Vendor(Vendor vendor)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status = "";
            data_item.Add(st.create_array("operation", vendor.Sql_Operation));
            data_item.Add(st.create_array("vendor_id", vendor.vendor_id));

            status = st.run_query(data_item, "Delete", "sp_vendor_master", ref sdr);
            if (status == "Done")
            {
                vendor.Sql_Result = status;
            }
            return vendor;
        }
        public Vendor Org_Name_TextChanged(Vendor vendor)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;

            string status1 = "";

            data_item.Add(st.create_array("operation", vendor.Sql_Operation));
            data_item.Add(st.create_array("vendor_id", vendor.vendor_id));
            data_item.Add(st.create_array("v_name", vendor.V_Name));
            data_item.Add(st.create_array("org_name", vendor.Org_Name));
            status1 = st.run_query(data_item, "Select", "sp_vendor_master", ref sdr);

            if (status1 == "Done")
                if (sdr.Read())
                    vendor.Sql_Result = "Already exist";
                else
                    vendor.Sql_Result = "";
            return vendor;
        }
        public Vendor Mobile_No_TextChanged(Vendor vendor)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;

            string status1 = "";

            data_item.Add(st.create_array("operation", vendor.Sql_Operation));
            data_item.Add(st.create_array("vendor_id", vendor.vendor_id));
            data_item.Add(st.create_array("mobile_no", vendor.Mobile_No));
            status1 = st.run_query(data_item, "Select", "sp_vendor_master", ref sdr);

            if (status1 == "Done")
                if (sdr.Read())
                    vendor.Sql_Result = "Already exist";
                else
                    vendor.Sql_Result = "";
            return vendor;
        }

        public Vendor Email_TextChanged(Vendor vendor)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;

            string status1 = "";

            data_item.Add(st.create_array("operation", vendor.Sql_Operation));
            data_item.Add(st.create_array("vendor_id", vendor.vendor_id));
            data_item.Add(st.create_array("email", vendor.Email));
            status1 = st.run_query(data_item, "Select", "sp_vendor_master", ref sdr);

            if (status1 == "Done")
                if (sdr.Read())
                    vendor.Sql_Result = "Already exist";
                else
                    vendor.Sql_Result = "";
            return vendor;
        }
    }
}