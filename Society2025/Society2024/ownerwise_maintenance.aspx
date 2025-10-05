<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ownerwise_maintenance.aspx.cs" Inherits="Society.ownerwise_maintenance" MasterPageFile="~/Site.Master" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="box box-primary">
        <div class="box-header with-border">

            <div class="box-body">
                <table width="100%">
                    <tr>
                        <th width="100%" class="">
                            <h1 class=" tex0 font-weight-bold " style="color: #012970;">Ownerwise Maintenance Bill Reports
                            </h1>
                        </th>
                    </tr>
                </table>
                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                <asp:HiddenField ID="society_id" runat="Server"></asp:HiddenField>

                        <asp:HiddenField runat="server" ID="build_id" />
                        <asp:HiddenField runat="server" ID="owner_id" />

                        <div class="form-group">
                            <div class="row ">
                                <div class="col-sm-1">
                                    <asp:Label ID="Label1" runat="server" Text="Building Name :"></asp:Label>

                                </div>
                                <div class="col-sm-2">
                                    <div class="dropdown-container">
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="input-box form-control"
                                            placeholder="Select" autocomplete="off" required="required" />
                                        <div id="RepeaterContainer1" style="width: 100%;" class="suggestion-list">
                                            <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="CategoryRepeater_ItemCommand1">
                                                <ItemTemplate>
                                                    <asp:LinkButton
                                                        ID="lnkCategory"
                                                        runat="server"
                                                        CssClass="suggestion-item link-button category-link"
                                                        Text='<%# Eval("name") %>'
                                                        CommandArgument='<%# Eval("build_id") %>'
                                                        CommandName="SelectCategory"
                                                        OnClientClick="setTextBox1(this.innerText);" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Literal ID="litNoItem" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>'
                                                        Text="No items found." />
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-1">
                                    <asp:Label ID="Label2" runat="server" Text="Owner Name :"></asp:Label>

                                </div>
                                <div class="col-sm-2">
                                    <div class="dropdown-container">
                                        <asp:TextBox ID="TextBox2" runat="server" CssClass="input-box form-control"
                                            placeholder="Select" autocomplete="off" required="required" />
                                        <div id="RepeaterContainer2" style="width: 100%;" class="suggestion-list">
                                            <asp:Repeater ID="Repeater2" runat="server" OnItemCommand="CategoryRepeater_ItemCommand2">
                                                <ItemTemplate>
                                                    <asp:LinkButton
                                                        ID="lnkCategory"
                                                        runat="server"
                                                        CssClass="suggestion-item link-button category-link"
                                                        Text='<%# Eval("name") %>'
                                                        CommandArgument='<%# Eval("owner_id") %>'
                                                        CommandName="SelectCategory"
                                                        OnClientClick="setTextBox2(this.innerText);" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Literal ID="litNoItem" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>'
                                                        Text="No items found." />
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-1">
                                    <asp:Label ID="lbl_date" runat="server" Text="From Date:"></asp:Label>

                                </div>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="txt_from" TextMode="Date" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-sm-1">
                                    <asp:Label ID="Label12" runat="server" Text="To Date:"></asp:Label>

                                </div>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="txt_to" TextMode="Date" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                           &nbsp;&nbsp;&nbsp;&nbsp;

                        <center>
                            <asp:Button ID="btn_search" runat="server" class="btn btn-primary" OnClick="btn_search_Click" Width="70px" Text="Search" UseSubmitBehavior="False" ValidationGroup="g1" />
                                   
                                        <asp:Button ID="btn_print" runat="server" class="btn btn-primary" OnClick="btn_print_Click" Text="Print" Width="70px" UseSubmitBehavior="False" ValidationGroup="g1" />
                                        <asp:Button ID="Button1" runat="server" class="btn btn-danger" OnClick="btn_print_Click" Text="Download reports" Width="150px" UseSubmitBehavior="False" ValidationGroup="g1" />


                        </center>


                        <br />
                        <asp:Panel ID="Panel1" runat="server" Visible="false">

                            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="887px"></rsweb:ReportViewer>
                        </asp:Panel>

                        <div class="form-group">
                            <div class="row ">
                                <div class="col-sm-12">
                                    <div style="width: 100%; overflow: auto;">
                                        <asp:GridView PageSize="15" AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging" ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" AllowSorting="true" HeaderStyle-BackColor="lightblue" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" OnSorting="GridView1_Sorting" OnRowUpdating="GridView1_RowUpdating">

                                            <%--                                            <asp:GridView ID="grid_cust" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped table-dark">--%>
                                            <Columns>
                                                <%-- <asp:TemplateField HeaderText="No" ItemStyle-Width="100">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Date" ItemStyle-Width="200" SortExpression="M_Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="receipt_no" runat="server" Text='<%# Bind("Date")%>'></asp:Label>

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Particular" ItemStyle-Width="450" SortExpression="Particular">
                                                    <ItemTemplate>
                                                        <asp:Label ID="b_id" runat="server" Text='<%# Bind("Particular")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Payment" ItemStyle-Width="300" SortExpression="Payment">
                                                    <ItemTemplate>
                                                        <asp:Label ID="name" runat="server" Text='<%# Bind("Payment")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Maintenance" ItemStyle-Width="150" SortExpression="Maintenance">
                                                    <ItemTemplate>
                                                        <asp:Label ID="name1" runat="server" Text='<%# Bind("Maintenance")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>


                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:label runat="server" ID="lbl_owner_id" Visible="false"></asp:label>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
        </div>
    </div>






    <script>
 
function initDropdownEvents() {

    const textBox1 = document.getElementById("<%= TextBox1.ClientID %>");

    const repeaterContainer1 = document.getElementById("RepeaterContainer1");
 
    textBox1.addEventListener("focus", function () {

        repeaterContainer1.style.display = "block";

    });
 
    textBox1.addEventListener("input", function () {

        const input = textBox1.value.toLowerCase();

        filterSuggestions("category-link", input);

    });

    const textBox2 = document.getElementById("<%= TextBox2.ClientID %>");

    const repeaterContainer2 = document.getElementById("RepeaterContainer2");

    textBox2.addEventListener("focus", function () {

        repeaterContainer2.style.display = "block";

    });

    textBox2.addEventListener("input", function () {

        const input = textBox2.value.toLowerCase();

        filterSuggestions("category-link", input);

    });

}
 
 
 
 
function filterSuggestions(className, value) {

    const items = document.querySelectorAll("." + className);

    let matchFound = false;
 
    items.forEach(item => {

        if (item.innerText.toLowerCase().includes(value.toLowerCase())) {

            item.style.display = "block";

            matchFound = true;

        } else {

            item.style.display = "none";

        }

    });
 
    let noMatchMessage = document.getElementById("no-match-message");
 
    if (!matchFound) {

        if (!noMatchMessage) {

            noMatchMessage = document.createElement("div");

            noMatchMessage.id = "no-match-message";
 
            noMatchMessage.innerText = "No matching suggestions.";

            items[0]?.parentNode?.appendChild(noMatchMessage);

        }

        noMatchMessage.style.display = "block";

    } else {

        if (noMatchMessage) {

            noMatchMessage.style.display = "none";

        }

    }

}
 
function setTextBox1(value) {

    document.getElementById("<%= TextBox1.ClientID %>").value = value;

    document.getElementById("RepeaterContainer1").style.display = "none";

}


        function setTextBox2(value) {

            document.getElementById("<%= TextBox2.ClientID %>").value = value;

    document.getElementById("RepeaterContainer2").style.display = "none";

}
 
 
Sys.Application.add_load(initDropdownEvents);
 
 
    </script>
 
</asp:Content>
