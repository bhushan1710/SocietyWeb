using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DBCode.DataClass
{
    public class Inventory
    {
        private int inid;
        private string inname;
        private float qty;
        private int slot;
        private float charges;
        private string societyid;
        private string Operation;
        private string Result;
        private string name;

        public int inventory_id
        {
            get { return inid; }
            set { inid = value; }
        }
        public string In_Name
        {
            get { return inname; }
            set { inname = value; }
        }
        public float Qty
        {
            get { return qty; }
            set { qty = value; }
        }
        public int Slot
        {
            get { return slot; }
            set { slot = value; }
        }
        public float Charges
        {
            get { return charges; }
            set { charges = value; }
        }
        public string Society_Id
        {
            get { return societyid ; }
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