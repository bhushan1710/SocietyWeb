using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DBCode.DataClass
{
    public class Amc
    {
        private int amcid;
        private int amctype;
        private string amcname;
        private string address1;
        private string address2;
        private string contactno1;
        private string contactno2;
        private string email;
        private DateTime regdate;
        private DateTime validfrom;
        private DateTime validto;
        private DateTime contactstart;
        private DateTime contactend;
        private float charges;
        private string Operation;
        private string Result;
        public int Amc_Id
        {
            get { return amcid; }
            set { amcid = value; }
        }
        public int Amc_Type
        {
            get { return amctype; }
            set { amctype = value; }
        }

        public string Amc_Name
        {
            get { return amcname; }
            set { amcname = value; }
        }

        public string Address_1
        {
            get { return address1; }
            set { address1 = value; }
        }

        public string Address_2
        {
            get { return address2; }
            set { address2 = value; }
        }
        public string Contact_No_1
        {
            get { return contactno1; }
            set { contactno1 = value; }
        }
        public string Contact_No_2
        {
            get { return contactno2; }
            set { contactno2 = value; }
        }
        public string Email
        {
            get { return email; }
            set { email = value; }
        }
        public DateTime Reg_Date
        {
            get { return regdate; }
            set { regdate = value; }
        }
        public DateTime Valid_From
        {
            get { return validfrom; }
            set { validfrom = value; }
        }
        public DateTime Valid_To
        {
            get { return validto; }
            set { validto = value; }
        }
        public DateTime Contact_Start
        {
            get { return contactstart; }
            set { contactstart = value; }
        }
        public DateTime Contact_End
        {
            get { return contactend; }
            set { contactend = value; }
        }
        public float Charges
        {
            get { return charges; }
            set { charges = value; }
        }

        public string Sql_Operation
        {
            get { return Operation; }
            set { Operation = value; }
        }
        public string Sql_Result
        {
            get { return Result; }
            set { Result = value; }
        }

    }
}