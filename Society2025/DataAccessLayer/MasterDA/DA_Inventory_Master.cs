using DBCode.DataClass;
using Society;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DataAccessLayer.MasterDA
{
    public class DA_Inventory_Master
    {
        stored st = new stored();
        public DataTable getInventoryDetils(Inventory inventory)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", inventory.Sql_Operation));
            data_item.Add(st.create_array("society_id", inventory.Society_Id));

            status1 = st.run_query(data_item, "Select", "sp_Inventory_master", ref sdr);
            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        public object inventory_search(Inventory inventory)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";

            DataTable dt = new DataTable();
            data_item.Add(st.create_array("Operation", inventory.Sql_Operation));
            data_item.Add(st.create_array("search", inventory.Name));
            data_item.Add(st.create_array("society_id", inventory.Society_Id));

            status1 = st.run_query(data_item, "Select", "sp_Inventory_master", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        public Inventory updateInventoryDetails(Inventory inventory)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";
            data_item.Add(st.create_array("operation", inventory.Sql_Operation));
            data_item.Add(st.create_array("inventory_id", inventory.inventory_id));
            if (inventory.Sql_Operation == "Update")
            {
                data_item.Add(st.create_array("society_id", inventory.Society_Id));
                data_item.Add(st.create_array("in_name", inventory.In_Name));
                data_item.Add(st.create_array("qty", inventory.Qty));
                data_item.Add(st.create_array("slot", inventory.Slot));
                data_item.Add(st.create_array("charges", inventory.Charges));

            }
            status1 = st.run_query(data_item, "Select", "sp_inventory_master", ref sdr);
            inventory.Sql_Result = status1;

            if (status1 == "Done")
            {
                if (inventory.Sql_Operation == "Select")
                {
                    while (sdr.Read())
                    {
                        inventory.Society_Id = sdr["society_id"].ToString();
                        inventory.In_Name = sdr["in_name"].ToString();
                        inventory.Qty = float.Parse(sdr["qty"].ToString());
                        inventory.Slot = Convert.ToInt32(sdr["slot"].ToString());
                        inventory.Charges = float.Parse(sdr["charges"].ToString());
                    }
                }
                else
                {
                    inventory.Sql_Result = status1;
                }
            }
            return inventory;
        }
        public Inventory Delete_Inventory(Inventory inventory)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status = "";
            data_item.Add(st.create_array("operation", inventory.Sql_Operation));
            data_item.Add(st.create_array("inventory_id", inventory.inventory_id));

            status = st.run_query(data_item, "Delete", "sp_inventory_master", ref sdr);
            if (status == "Done")
            {
                inventory.Sql_Result = status;
            }
            return inventory;
        }
    }
}