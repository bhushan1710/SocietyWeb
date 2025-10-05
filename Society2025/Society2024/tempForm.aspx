<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tempForm.aspx.cs" MasterPageFile="~/Site.Master" Inherits="Society2024.tempForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <title>Dynamic Poll</title>
<style>

        .poll-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            width: 350px;
            box-shadow: 0 0 10px rgba(0,0,0,0.4);
        }
        .poll-title {
            font-size: 14px;
            color: #38bdf8;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .poll-question {
            font-size: 16px;
            margin-bottom: 15px;
        }
        .option {
            background: #dcdcdc;
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 15px;
            cursor: pointer;
        }
        .option:hover {
            background: #919191;
        }
        .result-row {
            display: none;
            align-items: center;
            margin-top: 8px;
            gap: 8px;
        }
        .bar-container {
            flex: 1;
            background: #c8c8c8;
            height: 6px;
            border-radius: 3px;
            overflow: hidden;
        }
        .bar {
            height: 100%;
            background: #38bdf8;
            width: 0%;
            transition: width 1s ease;
        }
        .percentage {
            min-width: 35px;
            font-size: 14px;
            text-align: right;
        }
        .total-votes {
            font-size: 12px;
            color: gray;
            margin-top: 10px;
        }
    </style>

<body>

        <div class="poll-card">
            <div class="poll-title" id="poll-title"><asp:Label ID="lblTitle" runat="server" /></div>
            <div class="poll-question" id="poll-question"><asp:Label ID="lblQuestion" runat="server" /></div>

            <div id="poll-options">
                <asp:Repeater ID="rptOptions" runat="server">
                    <ItemTemplate>
                        <div class="option" data-index='<%# Container.ItemIndex %>' data-votes='<%# Eval("VoteCount") %>' onclick="vote(<%# Container.ItemIndex %>)">
                            <div><%# Eval("OptionText") %></div>
                            <div class="result-row">
                                <div class="bar-container"><div class="bar"></div></div>
                                <div class="percentage">0%</div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="total-votes" id="total-votes"><asp:Label ID="lblTotalVotes" runat="server" Text="0 votes" /></div>
        </div>


    <script>
        let votes = [];
        let voted = false;

        // Load votes from backend
        window.onload = function () {
            document.querySelectorAll(".option").forEach(opt => {
                votes.push(parseInt(opt.getAttribute("data-votes")));
            });
        }

        function vote(index) {
            if (voted) return;
            voted = true;

            votes[index] += 1;
            const total = votes.reduce((a, b) => a + b, 0);

            document.getElementById('total-votes').innerText = total + " votes";

            document.querySelectorAll('.option').forEach((opt, i) => {
                const percent = ((votes[i] / total) * 100).toFixed(0);
                const resultRow = opt.querySelector('.result-row');
                const percentageText = opt.querySelector('.percentage');
                const bar = opt.querySelector('.bar');

                resultRow.style.display = "flex";
                percentageText.innerText = percent + "%";

                setTimeout(() => {
                    bar.style.width = percent + "%";
                }, 100);
            });
        }
    </script>
</body>

</asp:Content>--%>




<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="tempForm.aspx.cs" MasterPageFile="~/Site.Master" Inherits="Society2024.tempForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">


<asp:TextBox ID="txtToEmail" runat="server" Placeholder="Recipient Email" Width="300px" />
<asp:TextBox ID="txtToName" runat="server" Placeholder="Recipient Name" Width="200px" />
<asp:TextBox ID="txtSubject" runat="server" Placeholder="Subject" Width="400px" />
<asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine"
                     Rows="6" Width="500px" Placeholder="Message body (HTML OK)" />
<asp:Button ID="btnSend" runat="server" Text="Send Email" OnClick="btnSend_Click" />
<asp:Label ID="lblStatus" runat="server" />

</asp:Content>
