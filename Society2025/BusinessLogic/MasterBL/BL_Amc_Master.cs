using DataAccessLayer.MasterDA;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace BusinessLogic.MasterBL
{
    public class BL_Amc_Master
    {
        public DataTable getAmcDetails(int amc_id, string society_id)
        {
            DA_Amc_Master dA_Amc = new DA_Amc_Master();
            DataTable amc_data = dA_Amc.geAmcDetails(amc_id, society_id);
            return amc_data;
        }
        public void updateAmcDetails(DataTable amcmaster)
        {
            DA_Amc_Master dA_Amc = new DA_Amc_Master();
           dA_Amc.updateAmcDetails(amcmaster);


        }
    }
}