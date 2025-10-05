using Society;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI.WebControls;
using Utility.DataClass;

namespace DataAccessLayer.DA
{
    public class DA_Receipt
    {
        stored st = new stored();
        public void fill_drop(DropDownList drp_down, string sqlstring, string text, string value)
        {
            st.fill_drop(drp_down, sqlstring, text, value);
        }
        public DataTable getreceipt(receipt Receipt)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", Receipt.Sql_Operation));
            data_item.Add(st.create_array("society_id", Receipt.Society_Id));

            status1 = st.run_query(data_item, "Select", "sp_receipt", ref sdr);

            if (status1 == "Done")
                if(sdr.HasRows)
                dt.Load(sdr);

            return dt;
        }

        public receipt updatereceipt(receipt Receipt)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;
            data_item.Add(st.create_array("operation", Receipt.Sql_Operation));
            data_item.Add(st.create_array("receipt_id", Receipt.receipt_id));
            
            if (Receipt.Sql_Operation == "Update")
            {
                data_item.Add(st.create_array("society_id", Receipt.Society_Id));
                data_item.Add(st.create_array("receipt_no", Receipt.Receipt_No));
                data_item.Add(st.create_array("pay_mode", Receipt.Pay_Mode));
                data_item.Add(st.create_array("date", Receipt.Date));
                data_item.Add(st.create_array("owner_id", Receipt.Owner_Id));
                data_item.Add(st.create_array("wing_id", Receipt.Wing_Id));
                data_item.Add(st.create_array("recivable_amt", Receipt.Recivable_Amt));
                data_item.Add(st.create_array("pay_for", Receipt.PayFor));
                data_item.Add(st.create_array("build_id", Receipt.build_id));
                data_item.Add(st.create_array("owner_name", Receipt.Owner_Name));
                //data_item.Add(st.create_array("bill_no", Receipt.Bill_No));
                if (Receipt.Pay_Mode == 2 || Receipt.Pay_Mode == 3)
                {
                    data_item.Add(st.create_array("chqno", Receipt.Chqno));
                    data_item.Add(st.create_array("chqdate", Receipt.Chqdate));
                }
                data_item.Add(st.create_array("remarks", Receipt.Remarks));
                if(Receipt.PayFor == 1 || Receipt.PayFor == 3)
                {
                    data_item.Add(st.create_array("received_amt", Receipt.Received_Amount));

                }
                else
                {
                    data_item.Add(st.create_array("addon_amt", Receipt.Received_Amount));

                }
              

            }
            status1 = st.run_query(data_item, "Select", "sp_receipt", ref sdr);
            Receipt.Sql_Result = status1;

            if (status1 == "Done")
            {
                if (Receipt.Sql_Operation == "Select")
                {
                    while (sdr.Read())
                    {

                        Receipt.Society_Id = sdr["society_id"].ToString();
                        Receipt.Receipt_No = sdr["receipt_no"].ToString();
                        Receipt.Pay_Mode = Convert.ToInt32(sdr["pay_mode"]);
                        Receipt.Date = Convert.ToDateTime(sdr["date"].ToString());
                        Receipt.Recivable_Amt = float.Parse(sdr["recivable_amt"].ToString());
                        
                        Receipt.build_id = Convert.ToInt32(sdr["build_id"]);
                        Receipt.Owner_Id = Convert.ToInt32(sdr["owner_id"].ToString());
                        Receipt.Wing_Id = Convert.ToInt32(sdr["wing_id"]);
                        //Receipt.Bill_No = sdr["bill_no"].ToString();
                        Receipt.Chqno = sdr["chqno"].ToString();
                        if (sdr["chqdate"].ToString() != "")
                        {
                            Receipt.Chqdate = Convert.ToDateTime(sdr["chqdate"]);
                        }
                        Receipt.Remarks = sdr["remarks"].ToString();
                        Receipt.Received_Amount = float.Parse(sdr["recevied_amt"].ToString());
                       

                    }
                }
                else
                {
                    Receipt.Sql_Result = status1;
                }
            }
            return Receipt;
        }

        public DataTable fill_list(string operation, string society, string build_id, string wing_id)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1 = "";
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", operation));

            data_item.Add(st.create_array("society_id", society));

            data_item.Add(st.create_array("wing_id", wing_id));

            data_item.Add(st.create_array("build_id", build_id)); 

            status1 = st.run_query(data_item, "Select", "sp_receipt", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        //public receipt Email_Send(receipt receipt)
        //{
        //    ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
        //    SqlDataReader sdr = null;
        //    string status;
        //    data_item.Add(st.create_array("operation", receipt.Sql_Operation));
        //    data_item.Add(st.create_array("receipt_id", receipt.receipt_id));
        //    data_item.Add(st.create_array("owner_id", receipt.Owner_Id));

        //    status = st.run_query(data_item, "Delete", "sp_receipt", ref sdr);
        //    if (status == "Done")
        //    {
        //        receipt.Sql_Result = status;
        //    }
        //    return receipt;
        //}



        public object Print_Receipt(receipt getReceipt)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;

            DataTable dt = new DataTable();
            data_item.Add(st.create_array("query", getReceipt.Sql_Operation));

            status1 = st.run_query(data_item, "Select", "sp_search", ref sdr);
            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;

        }

        public DataTable get_cashbook(Cashbook cash)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;
            DataTable dt = new DataTable();
            data_item.Add(st.create_array("operation", cash.Sql_Operation));
            data_item.Add(st.create_array("build_id", cash.build_id));
            data_item.Add(st.create_array("type", cash.Type));
            data_item.Add(st.create_array("society_id", cash.Society_Id));
            if (cash.Date1 != DateTime.MinValue && cash.Date2 != DateTime.MinValue)
            {
                data_item.Add(st.create_array("date1", cash.Date1));
                data_item.Add(st.create_array("date2", cash.Date2));
            }
            status1 = st.run_query(data_item, "Select", "sp_cashbook", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        public receipt receipt_exfetch(receipt Receipt)
        {
            
            string status = "", str = "";
            int val = 0;
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            data_item.Add(st.create_array("operation", Receipt.Sql_Operation));
            data_item.Add(st.create_array("society_id", Receipt.Society_Id));
            status = st.run_query(data_item, "Select", "sp_receipt", ref sdr);
            if (status == "Done")
            {
                if (sdr.Read())
                {
                    str = sdr["receipt_no"].ToString();
                    val = int.Parse(Regex.Match(str, @"\d+").ToString()) + 1;
                    Receipt.Receipt_No = str.Replace((val - 1).ToString(), (val).ToString());
                }
                else
                {
                    Receipt.Receipt_No = "RPT0001";
                }
            }
            return Receipt;
        }

        public DataTable Get_Paid_Amount(receipt getReceipt)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;

            DataTable dt = new DataTable();
            data_item.Add(st.create_array("query", getReceipt.Sql_Operation));

            status1 = st.run_query(data_item, "Select", "sp_search", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        public DataTable receipt_search(receipt receipt1)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status1;

            DataTable dt = new DataTable();
            data_item.Add(st.create_array("search", receipt1.Owner_Name));
            data_item.Add(st.create_array("operation", "search"));
            data_item.Add(st.create_array("society_id", receipt1.Society_Id));

            status1 = st.run_query(data_item, "Select", "sp_receipt", ref sdr);

            if (status1 == "Done")
                if (sdr.HasRows)
                    dt.Load(sdr);
            return dt;
        }

        public receipt ownerpendingbalance(receipt Receipt)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status;
            data_item.Add(st.create_array("operation", Receipt.Sql_Operation));
            data_item.Add(st.create_array("owner_id", Receipt.Owner_Id));
            status = st.run_query(data_item, "Select", "sp_receipt", ref sdr);
            if (status == "Done")
            {
                if (sdr.Read())
                {
                    if (Receipt.PayFor == 1)
                        Receipt.Balance = (Convert.ToDecimal(sdr["balanceRegular"]) - Convert.ToDecimal(sdr["advance_regular"])).ToString();
                    else if (Receipt.PayFor == 2)
                        Receipt.Balance = (Convert.ToDecimal(sdr["balanceAddon"]) - Convert.ToDecimal(sdr["advanceAddon"])).ToString();
                    else if (Receipt.PayFor == 3)
                        Receipt.Balance = ((Convert.ToDecimal(sdr["balanceRegular"]) + Convert.ToDecimal(sdr["balanceAddon"])) - (Convert.ToDecimal(sdr["advance_regular"]) + Convert.ToDecimal(sdr["advanceAddon"]))).ToString();


                }
            }

            return Receipt;
        }

        public receipt pending_receipt(receipt Receipt)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            //string status;
            data_item.Add(st.create_array("operation", Receipt.Sql_Operation));
            data_item.Add(st.create_array("owner_id", Receipt.Owner_Id));
            data_item.Add(st.create_array("balance", Receipt.Balance));
            data_item.Add(st.create_array("pay_for", Receipt.PayFor));
            data_item.Add(st.create_array("received_amt", Receipt.Received_Amount));
            string status = st.run_query(data_item, "Select", "sp_receipt", ref sdr);
            return Receipt;
        }

        public receipt advance_pay_settlement(receipt Receipt)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status;
            int bal = 0;
            data_item.Add(st.create_array("operation", Receipt.Sql_Operation));
            data_item.Add(st.create_array("owner_id", Receipt.Owner_Id));

            status = st.run_query(data_item, "Select", "sp_receipt", ref sdr);
            if (status == "Done")
            {
                while (sdr.Read())
                {
                   bal += Convert.ToInt32(sdr["che_amount"].ToString());

                }
                Receipt.Balance = bal.ToString();
            }

            return Receipt;

        }

        public receipt delete(receipt Receipt)
        {
            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status;
            data_item.Add(st.create_array("operation", Receipt.Sql_Operation));
            data_item.Add(st.create_array("receipt_id", Receipt.receipt_id));

            status = st.run_query(data_item, "Delete", "sp_receipt", ref sdr);
            if (status == "Done")
            {
                Receipt.Sql_Result = status;
            }
            return Receipt;
        }

        public receipt Select_Cheque(receipt Receipt)
        {

            ICollection<System.Collections.ArrayList> data_item = new List<System.Collections.ArrayList>();
            SqlDataReader sdr = null;
            string status;

            data_item.Add(st.create_array("operation", Receipt.Sql_Operation));
            data_item.Add(st.create_array("chqno", Receipt.Chqno));
            data_item.Add(st.create_array("owner_id", Receipt.Owner_Id));
            status = st.run_query(data_item, "Select", "sp_receipt", ref sdr);
            if (status == "Done")
            {
                if (sdr.Read())
                {
                    Receipt.Chqdate = Convert.ToDateTime(sdr["che_date"].ToString());
                    Receipt.Che_Amount = Convert.ToInt32(sdr["che_amount"].ToString());
                }
            }
            return Receipt;
        }
    
    }
}