using BusinessLogic.BL;
using DBCode.DataClass;
using Microsoft.Reporting.Map.WebForms.BingMaps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Society2024
{
    /// <summary>
    /// Summary description for VoteService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    //[System.Web.Script.Services.ScriptService]
    public class VoteService : System.Web.Services.WebService
    {

        Polls polls = new Polls();
        BL_poll bL_Poll = new BL_poll();
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string SaveVote(int OneVotePerUnit, int AllowMultipleVotes, int userId, int pollId, int optionId, String SocietyID, String userType)
        {
            try
            {
                polls.UserId = userId;
                polls.Poll_id = pollId;
                polls.OptionId = optionId;
                polls.society_id = SocietyID;
                polls.user_type = userType;
                polls.AllowMultiple = AllowMultipleVotes;
                polls.VotePerUnit = OneVotePerUnit;
                bL_Poll.vote(polls);

                return "Vote saved successfully";
               
            }
            catch (Exception ex)
            {
                // Log error
                return "Error saving vote: " + ex.Message;
            }
        }

    }
}
