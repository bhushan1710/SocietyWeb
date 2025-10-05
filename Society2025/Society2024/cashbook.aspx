<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cashbook.aspx.cs" Inherits="Society.cashbook" MasterPageFile="~/Site.Master" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function SuccessEntry() {
            Swal.fire(
                'SUCCESS!',
                'Quotation Entry Successfully Registered!',
                'success'
            )
        }
        function Fail() {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'You Missed Something Empty!',
            })
        }
        function openModal() {
            $('#edit_model').modal('show');
        }

    </script>

    <div class="box box-primary">
        <div class="box-header with-border">

            <div class="box-body">

                <table width="100%">
                    <tr>
                        <th width="100%" class="">
                            <h1 class=" tex0 font-weight-bold " style="color: #012970;">Financial Report
                            </h1>
                        </th>
                    </tr>
                </table>
                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <ContentTemplate>


                        <asp:HiddenField ID="society_id" runat="Server"></asp:HiddenField>
                        <asp:HiddenField ID="build_id" runat="server" />


                        <asp:HiddenField ID="shop_maint_id" runat="server" />
                        <asp:HiddenField ID="wing_id" runat="server" />
                        <asp:HiddenField ID="owner_id" runat="server" />

                        <asp:HiddenField ID="building_id" runat="server" />

                        <div class="form-group">
                            <div class="row ">

                                                                <div class="col-sm-1">
                                     <asp:Label runat="server" Text="Type"></asp:Label>

                                </div>
                             
                                <div class="col-sm-2">
                                  
                                    <asp:DropDownList ID="ddlTransactionType" runat="server" OnSelectedIndexChanged="ddlTransactionType_SelectedIndexChanged" class='w-75'>
    <asp:ListItem Text="Select" Value="-1" />
    <asp:ListItem Text="Credit" Value="0" />
    <asp:ListItem Text="Debit" Value="1" />
</asp:DropDownList>

                      <%--              <div class="dropdown-container">
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="input-box form-control"
                                            placeholder="Select" autocomplete="off" required="required" ValidationGroup="valid" />
                                        <div id="RepeaterContainer1" style="width: 100%;" class="suggestion-list">
                                            <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="CategoryRepeater_ItemCommand">
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
                                    </div>--%>
                                        
                                </div>
                                <div class="col-sm-1">
                                    <asp:Label ID="lbl_date" runat="server" Text="From Date"></asp:Label>

                                </div>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="txt_from" TextMode="Date" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-sm-1">
                                    <asp:Label ID="Label12" runat="server" Text="To Date :"></asp:Label>

                                </div>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="txt_to" TextMode="Date" runat="server"></asp:TextBox>
                                </div>


                                <div class="row mt-3">
                                    <div class="col-12 text-center">
                                        <asp:Button ID="btn_search" runat="server" class="btn btn-primary mx-2"
                                            OnClick="btn_search_Click" ValidationGroup="valid" Text="Search" />

                                        <asp:Button ID="btn_print" runat="server" class="btn btn-primary mx-2"
                                            OnClick="btn_print_Click" Text="Print" ValidationGroup="valid" />

                                        <%--<asp:Button ID="Button1" runat="server" class="btn btn-danger mx-2"
                                            OnClick="btn_print_Click" Text="Download report" ValidationGroup="valid" />--%>
                                    </div>
                                </div>
                            </div>



                        </div>

                        <asp:Panel ID="Panel1" runat="server" Visible="false">
                            <div align="center">
                                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="59%"></rsweb:ReportViewer>
                            </div>
                        </asp:Panel>

                        <div class="form-group">
                            <div class="row ">
                                <div class="col-sm-12">
                                    <div style="width: 100%; overflow: auto;">
                                        <asp:GridView AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="15" ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" AllowSorting="true" HeaderStyle-BackColor="lightblue" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" OnSorting="GridView1_Sorting" OnRowUpdating="GridView1_RowUpdating">

                                            <%-- <asp:GridView ID="grid_cust" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped table-dark">--%>
                                            <Columns>
                                                <asp:TemplateField HeaderText="No" ItemStyle-Width="100">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Date" ItemStyle-Width="200" SortExpression="date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="receipt_no" runat="server" Text='<%# Bind("date","{0: dd-MMM-yyyy}")%>'></asp:Label>

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Particular" ItemStyle-Width="450" SortExpression="Particular">
                                                    <ItemTemplate>
                                                        <asp:Label ID="b_id" runat="server" Text='<%# Bind("Particular")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Debit" ItemStyle-Width="300" SortExpression="Debit">
                                                    <ItemTemplate>
                                                        <asp:Label ID="name" runat="server" Text='<%# Bind("Debit")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Credit" ItemStyle-Width="150" SortExpression="Credit">
                                                    <ItemTemplate>
                                                        <asp:Label ID="name1" runat="server" Text='<%# Bind("Credit")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>


                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

    </div>




  <%--  <script>

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


        Sys.Application.add_load(initDropdownEvents);


    </script>--%>

</asp:Content>
