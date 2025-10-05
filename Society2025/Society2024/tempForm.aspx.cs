//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web.UI;
//using System.Web.UI.WebControls;

//namespace Society2024
//{
//    public partial class tempForm : System.Web.UI.Page
//    {
//        public class PollOption
//        {
//            public string OptionText { get; set; }
//            public int VoteCount { get; set; }
//        }

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                BindPoll();
//            }
//        }

//        private void BindPoll()
//        {
//            // Bind title & question from backend
//            lblTitle.Text = "Ghanashyam Milk Man";
//            lblQuestion.Text = "What are you looking for?";

//            // Bind poll options with existing votes from DB (here static for example)
//            List<PollOption> options = new List<PollOption>()
//        {
//            new PollOption { OptionText = "Healthy food 🥗", VoteCount = 9 },
//            new PollOption { OptionText = "Healthy drinks 🥤", VoteCount = 5 },
//            new PollOption { OptionText = "Both ➡️", VoteCount = 7 },
//            new PollOption { OptionText = "Not looking for anything 🤷‍♂️", VoteCount = 2 }
//        };

//            rptOptions.DataSource = options;
//            rptOptions.DataBind();

//            // Bind total votes
//            lblTotalVotes.Text = options.Sum(o => o.VoteCount) + " votes";
//        }
//    }
//}



using BusinessLogic.BL;
using DataAccessLayer.DA;
using DBCode.DataClass;
using Google.Api.Gax;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading.Tasks;
using BusinessLogic;

namespace Society2024
{
    public partial class tempForm : System.Web.UI.Page
    {
        private readonly IEmailService _emailService = new SendGridEmailService();

        protected async void btnSend_Click(object sender, EventArgs e)
        {
            lblStatus.Text = "";
            try
            {
                string toEmail = txtToEmail.Text.Trim();
                string toName = txtToName.Text.Trim();
                string subject = txtSubject.Text.Trim();
                string htmlBody = txtBody.Text.Trim();
                string plainBody = System.Text.RegularExpressions.Regex
                    .Replace(htmlBody, "<.*?>", string.Empty);

                //await _emailService.SendEmailAsync(
                //    toEmail, toName, subject, plainBody, htmlBody);

                lblStatus.ForeColor = System.Drawing.Color.Green;
                lblStatus.Text = "Email sent successfully!";
            }
            catch (Exception ex)
            {
                lblStatus.ForeColor = System.Drawing.Color.Red;
                lblStatus.Text = "Send failed: " + ex.Message;
                // Log ex via your logging framework
            }
        }

    }
}
