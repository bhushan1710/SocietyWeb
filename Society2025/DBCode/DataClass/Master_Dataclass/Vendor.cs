using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DBCode.DataClass.Master_Dataclass
{
    public class Vendor
    {
        private int vid;
        private string vname;
        private string orgname;
        private string address1;
        private string address2;
        private string orgtelno;
        private string mobileno;
        private string email;
        private int status;
        private string societyid;
        private string Operation;
        private string Result;
        private string name;



        public int vendor_id
        {
            get { return vid; }
            set { vid = value; }
        }
        public string V_Name
        {
            get { return vname; }
            set { vname = value; }
        }
        public string Org_Name
        {
            get { return orgname; }
            set { orgname = value; }
        }
        public string Address1
        {
            get { return address1; }
            set { address1 = value; }
        }
        public string Address2
        {
            get { return address2; }
            set { address2 = value; }
        }
        public string Org_Tel_No
        {
            get { return orgtelno; }
            set { orgtelno = value; }
        }
        public string Mobile_No
        {
            get { return mobileno; }
            set { mobileno = value; }
        }
        public string Email
        {
            get { return email; }
            set { email = value; }
        }
        public int Status
        {
            get { return status; }
            set { status = value; }
        }
        public string Society_Id
        {
            get { return societyid; }
            set { societyid = value; }
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
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
    }
}