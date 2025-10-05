<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="maintenance_search.aspx.cs" Inherits="Society.maintenance_search" MasterPageFile="~/Site.Master" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />
    <style>
        @media(max-width: 630px) {
            .top-row {
                flex-direction: column;
            }

            .w-90 {
                width: 90%;
            }
        }

        .resized-model {
            width: 100%;
            max-width: 900px;
            height: auto;
            margin: auto;
        }

        .suggestion-list {
            position: absolute;
            z-index: 1000;
            background: white;
            border: 1px solid #ccc;
            max-height: 200px;
            overflow-y: auto;
            width: 100%;
        }

        .suggestion-item {
            padding: 8px;
            cursor: pointer;
        }

        e
        .suggestion-item:hover {
            background: #f0f0f0;
        }

        .pdf-page-break {
            page-break-after: always;
            padding: 20px;
        }

            .pdf-page-break:last-child {
                page-break-after: auto;
            }

        @media print {
            .page-break {
                page-break-after: always;
            }

            .no-print {
                display: none !important;
            }
        }

        @media (max-width: 576px) {
            .resized-model {
                max-width: 100%;
                margin: 0.5rem;
            }

            .modal-dialog {
                margin: 0.5rem;
            }
            /*            .search-container {
                width: 100%;
            }*/
            /*            .input-buttons {
                display: flex;
                justify-content: flex-end;
            }*/
            .suggestion-list {
                width: 100% !important;
            }

            .form-control {
                width: 100% !important;
            }

            .calendar-icon {
                width: 24px;
                height: 24px;
            }

            .btn {
                width: 100%;
                /*                margin-top: 0.5rem;*/
            }
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        function openModal() {
            $('#edit_model').modal('show');
        }
        function FailedEntry() {
            Swal.fire({
                title: '❌ Failed!',
                text: 'Something went wrong. Please try again.',
                icon: 'error',
                showConfirmButton: true,
                confirmButtonColor: '#d33',
                confirmButtonText: 'Retry',
                timer: 3000,
                timerProgressBar: true,
                didOpen: () => {
                    Swal.showLoading()
                }
            });
        }
        function SuccessEntry() {
            Swal.fire({
                title: '✅ Success!',
                text: 'Saved Successfully',
                icon: 'success',
                showConfirmButton: true,
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'OK',
                timer: 1400,
                timerProgressBar: true,
                didOpen: () => {
                    Swal.showLoading()
                },
                willClose: () => {
                    window.location.href = 'maintenance_search.aspx';
                }
            });
        }
        function disableSaveButtonIfValid() {
            var btn = document.getElementById('<%= btn_save.ClientID %>');
            var modal = document.getElementById('edit_model');
            var inputs = modal.querySelectorAll('input[required], select[required]');
            var allValid = true;
            inputs.forEach(function (input) {
                if (!input.checkValidity()) {
                    allValid = false;
                }
            });
            if (allValid && btn) {
                btn.disabled = true;
                btn.value = "Saving...";
                __doPostBack('<%= btn_save.UniqueID %>', '');
                return false;
            }
            return false;
        }
    </script>
    <div class="box box-primary">
        <div class="box-header with-border">
            <div class="box-body">
                <table class="w-100">
                    <tr>
                        <th>
                            <h1 class="font-weight-bold" style="color: #012970;">Society Maintenance Bills</h1>
                        </th>
                    </tr>
                </table>
                <asp:UpdatePanel ID="bill" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:HiddenField ID="society_id" runat="Server"></asp:HiddenField>
                        <asp:HiddenField ID="m_bill_status" runat="Server"></asp:HiddenField>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-12">
                                    <div class="top-row d-flex align-items-center flex-wrap">
                                        <div class="search-container flex-grow-1">
                                            <asp:TextBox
                                                ID="txt_search"
                                                CssClass="aspNetTextBox form-control"
                                                placeHolder="Search here"
                                                runat="server"
                                                TextMode="Search"
                                                AutoPostBack="true"
                                                OnTextChanged="btn_search_Click"
                                                onkeyup="removeFocusAfterTyping()" />
                                            <ajaxToolkit:CalendarExtender
                                                ID="CalendarExtender1"
                                                runat="server"
                                                TargetControlID="txt_search"
                                                PopupButtonID="btn_calendar"
                                                Format="yyyy-MM-dd" />
                                            <div class="input-buttons">
                                                <img
                                                    id="btn_calendar"
                                                    src="img/calendar.png"
                                                    alt="Pick Date"
                                                    class="calendar-icon"
                                                    style="cursor: pointer; width: 24px; height: 24px;" />
                                                <button
                                                    id="btn_search"
                                                    type="submit"
                                                    class="search-button2"
                                                    runat="server"
                                                    onserverclick="btn_search_Click">
                                                    <span class="material-symbols-outlined">search</span>
                                                </button>
                                            </div>
                                        </div>
                                        &nbsp;&nbsp;
                                        <button type="button" class="btn btn-primary mt-sm-0" data-toggle="modal" data-target="#edit_model">Add</button>
                                        &nbsp;&nbsp;
                                        <button type="button" class="btn btn-primary mt-sm-0" onclick="printmaintenanceDetails()">Print</button>
                                        &nbsp;&nbsp;
                                        <button type="button" class="btn btn-success mt-sm-0" onclick="downloadReceipt()">
                                            <i class="fas fa-download me-1"></i>Download Report
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-12">
                                    <div class="table-responsive">
                                        <asp:GridView ID="GridView1" runat="server" AllowPaging="true" PageSize="10" OnPageIndexChanging="GridView1_PageIndexChanging" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" OnRowUpdating="GridView1_RowUpdating" AllowSorting="true" HeaderStyle-BackColor="lightblue" OnSorting="GridView1_Sorting" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" OnRowDeleting="GridView1_RowDeleting">
                                            <Columns>
                                                <asp:TemplateField HeaderText="No" ItemStyle-Width="80">
                                                    <ItemTemplate>
                                                        <asp:Label ID="No" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="n_m_id" runat="server" Text='<%# Bind("n_m_id")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Month" ItemStyle-Width="100" SortExpression="month_name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="month" runat="server" Text='<%#Bind("month_name")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Year" ItemStyle-Width="100" SortExpression="year">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Year" runat="server" Text='<%# Bind("year")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Building" ItemStyle-Width="200" SortExpression="building_name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="building_name" runat="server" Text='<%# Bind("build_name")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Wing" ItemStyle-Width="150" SortExpression="wings">
                                                    <ItemTemplate>
                                                        <asp:Label ID="w_name" runat="server" Text='<%# Bind("wings")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Bill Date" ItemStyle-Width="150" SortExpression="m_date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="m_date" runat="server" Text='<%# Bind("m_date", "{0:dd-MM-yyyy}")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Due Date" ItemStyle-Width="150" SortExpression="due_date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="due_date" runat="server" Text='<%# Bind("due_date", "{0:dd-MM-yyyy}")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Amount" ItemStyle-Width="120" SortExpression="m_total">
                                                    <ItemTemplate>
                                                        <asp:Label ID="m_total" runat="server" Text='<%# Bind("m_total")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status" ItemStyle-Width="150" SortExpression="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="gsg" runat="server" Text='<%# Bind("Status")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-Width="80" HeaderText="Edit">
                                                    <ItemTemplate>
                                                        <asp:LinkButton runat="server" ID="edit" OnCommand="edit_Command" CommandName="Update" CommandArgument='<%# Bind("n_m_id")%>' OnClientClick="openModal();">
                                                            <img src="Images/123.png" />
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField ItemStyle-Width="100" HeaderText="View">
                                                    <ItemTemplate>
                                                        <asp:Button
                                                            ID="btnViewBill"
                                                            runat="server"
                                                            Text="View Bill"
                                                            CssClass="btn btn-primary btn-sm"
                                                            CommandName="ViewBill"
                                                            CommandArgument='<%# Eval("n_m_id") %>' OnCommand="btnViewBill_Command" />
                                                        <!-- ✅ Add this -->
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                                <asp:TemplateField ItemStyle-Width="50" HeaderText="Delete" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton runat="server" ID="edit551" CommandName="Delete" OnClientClick="return confirm('Are you sure want to delete?');"><img src="Images/delete_10781634.png" height="25" width="25" /></asp:LinkButton>
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
                <div class="modal fade" id="edit_model" role="form" aria-labelledby="myLargeModalLabel" data-backdrop="static">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content resized-model">
                            <div class="modal-header">
                                <h4 class="modal-title"><strong>New Maintenance</strong></h4>
                            </div>
                            <div class="modal-body" id="printPreviewBody">
                                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:HiddenField ID="building_id" runat="Server"></asp:HiddenField>
                                        <asp:HiddenField ID="wing_id" runat="Server"></asp:HiddenField>
                                        <asp:HiddenField ID="n_m_id" runat="Server"></asp:HiddenField>
                                        <asp:HiddenField ID="society_name" runat="server" />
                                        <asp:Panel ID="Panel1" runat="server">
                                            <div class="form-group">
                                                <div class="row align-items-center mb-3">
                                                    <div class="col-12 col-sm-3">
                                                        <asp:Label ID="Label41" runat="server" Font-Bold="True" Font-Size="Medium" Text="Building Name"></asp:Label>
                                                        <asp:Label ID="Label40" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-12 col-sm-3">
                                                        <div class="dropdown-container">
                                                            <asp:TextBox ID="TextBox5" runat="server" CssClass="input-box form-control" placeholder="Select" autocomplete="off" required="required" />
                                                            <div id="RepeaterContainer1" class="suggestion-list">
                                                                <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound" OnItemCommand="CategoryRepeater_ItemCommand1">
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
                                                    <div class="col-12 col-sm-3">
                                                        <asp:Label ID="Label42" runat="server" Font-Bold="True" Font-Size="Medium" Text="Date"></asp:Label>
                                                        <asp:Label ID="Label44" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-12 col-sm-3">
                                                        <asp:TextBox ID="txt_date" CssClass="form-control" runat="server" placeholder="Enter Date" required TextMode="Date"></asp:TextBox>
                                                        <div class="invalid-feedback">
                                                            Please Enter Date
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row align-items-center mb-3">
                                                    <div class="col-12 col-sm-3">
                                                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium" Text="Wing"></asp:Label>
                                                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-12 col-sm-3">
                                                        <div class="dropdown-container">
                                                            <asp:TextBox ID="TextBox6" runat="server" CssClass="input-box form-control" placeholder="Select" autocomplete="off" required="required" />
                                                            <div id="RepeaterContainer2" class="suggestion-list">
                                                                <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound" OnItemCommand="CategoryRepeater_ItemCommand2">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton
                                                                            ID="lnkCategory"
                                                                            runat="server"
                                                                            CssClass="suggestion-item link-button category-link"
                                                                            Text='<%# Eval("w_name") %>'
                                                                            CommandArgument='<%# Eval("wing_id") %>'
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
                                                    <div class="col-12 col-sm-6">
                                                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="table-responsive">
                                                            <asp:GridView ID="expenseGrid" runat="server" PageSize="30" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" HeaderStyle-BackColor="lightblue" ShowHeaderWhenEmpty="true" EmptyDataText="No Expense for this Month">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Nature of Charges" ItemStyle-Width="33%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="month" runat="server" Text='<%#Bind("ex_details")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Amount" ItemStyle-Width="33%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="Year" runat="server" Text='<%# Bind("f_amount")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Amount Per Flat" ItemStyle-Width="33%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="building_name" runat="server" Text='<%# Bind("amount")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-12 text-center">
                                                        <asp:Button ID="btnAdd" runat="server" Text="Add New" UseSubmitBehavior="true" ValidationGroup="g1" OnClick="btnAdd_Click" class="btn btn-primary" />
                                                        <asp:Label runat="server" ID="lblMsg"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row align-items-center mb-3">
                                                    <div class="col-12 col-sm-3">
                                                        <asp:Label ID="TextBox1" runat="server" Text="Total Amount" Font-Bold="True"></asp:Label>
                                                    </div>
                                                    <div class="col-12 col-sm-3">
                                                        <asp:TextBox ID="txt_amount" runat="server" placeholder="Amount" Enabled="false" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                                        <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="modal-footer">
                                        <div class="row">
                                            <div class="col-12 text-center">
                                                <asp:Panel runat="server" ID="BtnPanel" CssClass="d-flex justify-content-center" Visible="false">
                                                    <asp:Button ID="btn_save" OnClientClick="disableSaveButtonIfValid();" runat="server" Text="Save" class="btn btn-primary mr-2" ValidationGroup="g1" OnClick="btn_save_Click" />
                                                    <asp:Button ID="btn_bill" runat="server" Text="Generate Bill" class="btn btn-primary mr-2" OnClick="btn_bill_Click" />
                                                    <asp:Button ID="btn_delete" runat="server" Text="Delete" class="btn btn-primary mr-2" OnClientClick="return confirm('Are you sure want to delete?');" OnClick="btn_delete_Click" Visible="False" />
                                                    <button type="button" class="btn btn-primary mr-2" data-toggle="modal" data-target="#emailmodal">Email</button>
                                                    <asp:Button ID="btn_print" runat="server" Text="Print" class="btn btn-primary mr-2" OnClick="btn_print_Click" />
                                                </asp:Panel>
                                                <asp:Button ID="btn_close" runat="server" Text="Close" class="btn btn-primary" UseSubmitBehavior="False" OnClientClick="resetForm(); return false;" data-dismiss="modal" />
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="emailmodal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content resized-model">
                        <div class="modal-header">
                            <h4 class="modal-title" id="gridSystemModalLabel1"><strong>Select Customer</strong></h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">
                            <asp:UpdatePanel ID="assd" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12">
                                                <label>Select all</label>
                                                <asp:CheckBox ID="CheckAll" runat="server" AutoPostBack="true" OnCheckedChanged="CheckAll_CheckedChanged"></asp:CheckBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-12">
                                                <asp:Panel ID="Panel21" runat="server" ScrollBars="Auto" Height="400px">
                                                    <asp:CheckBoxList ID="CheckBoxList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged" Font-Bold="true"></asp:CheckBoxList>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <div class="modal-footer">
                            <div class="row">
                                <div class="col-12 d-flex justify-content-between">
                                    <asp:Button ID="Button1" runat="server" Text="Close" class="btn btn-default" data-dismiss="modal" />
                                    <asp:Button ID="btn_email_send" runat="server" Text="Email" class="btn btn-primary" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="printModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content p-4 resized-model" style="font-family: Arial, sans-serif;">
                        <div class="model-temp p-4">
                            <div class="modal-header border-bottom-0"></div>
                            <asp:UpdatePanel runat="server">

                                <ContentTemplate>
                                    <div class="modal-body">
                                        <asp:Repeater ID="Repeater3" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                                            <ItemTemplate>
                                                <div class="pdf-page-break print-page page-break">
                                                    <h3 class="modal-title mx-auto text-center centerT" style="font-weight: bold;">MAINTENANCE BILL</h3>
                                                    <div class="text-center mb-2">
                                                        <h4 class="centerT" style="margin: 0;"><%# Eval("society_name") %></h4>
                                                        <p class="centerT" style="margin: 0;">Registration No: <%# Eval("registration_no") %></p>
                                                        <p class="centerT" style="margin: 0;"><%# Eval("address1") %></p>
                                                        <hr />
                                                    </div>
                                                    <table class="table table-bordered mb-3">
                                                        <tbody>
                                                            <tr>
                                                                <td><strong>Owner Name: <%# Eval("owner_name") %></strong></td>
                                                                <td>
                                                                    <asp:Label ID="Label3" runat="server" /></td>
                                                                <td><strong>Flat No: <%# Eval("flat_no") %></strong></td>
                                                                <td>
                                                                    <asp:Label ID="Label5" runat="server" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Wing Name: <%# Eval("w_name") %></strong></td>
                                                                <td>
                                                                    <asp:Label ID="Label7" runat="server" /></td>
                                                                <td><strong>Bill Date: <%# Eval("gen_date") %></strong></td>
                                                                <td>
                                                                    <asp:Label ID="Label8" runat="server" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Due Date: <%# Eval("due_date") %></strong></td>
                                                                <td>
                                                                    <asp:Label ID="Label9" runat="server" /></td>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <asp:Repeater ID="billCharges" runat="server">
                                                        <HeaderTemplate>
                                                            <table class="table table-bordered">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Sr. No</th>
                                                                        <th>Nature of Charges</th>
                                                                        <th>Amount (₹)</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td><%# Eval("SrNo") %></td>
                                                                <td><%# Eval("ChargeName") %></td>
                                                                <td><%# String.Format("{0:N2}", Eval("Amount")) %></td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody></table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                    <table class="table table-bordered mb-3">
                                                        <tbody>
                                                            <tr>
                                                                <td><strong>Sub Total: <%# Eval("total_amount") %></strong></td>
                                                                <td>₹<asp:Label ID="Label10" runat="server" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Principle Amount Brought Forward: <%# Eval("amt_forward") %></strong></td>
                                                                <td>₹<asp:Label ID="Label11" runat="server" Text="0" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Interest Amount Brought Forward: <%# Eval("tax_interest_amt") %></strong></td>
                                                                <td>₹<asp:Label ID="Label12" runat="server" Text="0" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Total: <%# Eval("total_amount") %></strong></td>
                                                                <td><strong>₹<asp:Label ID="Label13" runat="server" /></strong></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Amount in Words: <%# "..." %></strong></td>
                                                                <td>
                                                                    <asp:Label ID="Label14" runat="server" /></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <div class="signature-block text-end">
                                                        <p class="right"><strong>For Gokuldham</strong></p>
                                                        <p class="right"><strong>HON- SECRETARY</strong></p>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <div class="modal-footer no-print d-flex justify-content-end">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-success ml-2" onclick="openPrintDialog()">Print</button>
                                <button type="button" class="btn btn-primary ml-2" onclick="downloadPDF()">Download PDF</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="pdfmodal" role="form" aria-labelledby="myLargeModalLabel" data-backdrop="static">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content resized-model">
                        <div class="modal-header" style="justify-content: center;">
                            <h4 class="modal-title text-center"><strong>Maintenance Details</strong></h4>
                        </div>
                        <asp:UpdatePanel runat="server">
                        <contenttemplate>
                            <div class="modal-body">
                                <div style="text-align: center; margin-bottom: 10px;">
                                    <h4><strong><%= society_name.Value %></strong></h4>
                                </div>
                                <div class="table-responsive" style="padding: 10px; border-radius: 5px; background-color: #f9f9f9;">
                                    <asp:GridView ID="GridView3" runat="server"
                                        CssClass="table table-bordered table-hover table-sm gridview-custom"
                                        AutoGenerateColumns="false"
                                        ShowHeaderWhenEmpty="true"
                                        EmptyDataText="No data found."
                                        HeaderStyle-BackColor="#012970"
                                        HeaderStyle-ForeColor="White"
                                        Font-Size="Small"
                                        GridLines="Both"
                                        CellPadding="6"
                                        BorderStyle="None"
                                        BorderWidth="0px">
                                        <Columns>
                                            <asp:TemplateField HeaderText="No" ItemStyle-Width="80">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" runat="server" Text='<%# Container.DataItemIndex + 1 %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Month" DataField="month_name" SortExpression="month_name" ItemStyle-Width="100" />
                                            <asp:BoundField HeaderText="Year" DataField="year" SortExpression="year" ItemStyle-Width="100" />
                                            <asp:BoundField HeaderText="Building" DataField="build_name" SortExpression="building_name" ItemStyle-Width="200" />
                                            <asp:BoundField HeaderText="Wing" DataField="wings" SortExpression="wings" ItemStyle-Width="150" />
                                            <asp:BoundField HeaderText="Bill Date" DataField="m_date" DataFormatString="{0:dd-MM-yyyy}" SortExpression="m_date" ItemStyle-Width="150" />
                                            <asp:BoundField HeaderText="Due Date" DataField="due_date" DataFormatString="{0:dd-MM-yyyy}" SortExpression="due_date" ItemStyle-Width="150" />
                                            <asp:BoundField HeaderText="Amount" DataField="m_total" SortExpression="m_total" ItemStyle-Width="120" />
                                            <asp:BoundField HeaderText="Status" DataField="Status" SortExpression="Status" ItemStyle-Width="150" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </contenttemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
            <div id="pdf-clone-container" style="position: absolute; top: -10000px; left: -10000px;"></div>

        </div>
    </div>


        
    
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>


<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

<script>
    function downloadPDF() {
        const element = document.getElementById("printModal");

        // Options for html2pdf
        const opt = {
            margin: 10,
            filename: 'maintenance-bill.pdf',
            image: { type: 'jpeg', quality: 1 },
            html2canvas: { scale: 2, useCORS: true },
            jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' },
            pagebreak: { mode: ['css', 'legacy'] }  // enable page break
        };

        html2pdf().set(opt).from(element).save();
    }
</script>--%>

    <script type="text/javascript">
        let formSubmitted = false;
        async function downloadReceipt() {
            const { jsPDF } = window.jspdf;
            const sourceElement = document.querySelector("#pdfmodal .modal-body");
            const cloneContainer = document.getElementById("pdf-clone-container");
            if (!sourceElement || !cloneContainer) {
                alert("Cannot find content to export.");
                return;
            }
            cloneContainer.innerHTML = "";
            const clone = sourceElement.cloneNode(true);
            clone.style.width = "800px";
            cloneContainer.appendChild(clone);
            try {
                const canvas = await html2canvas(clone, {
                    scale: 3,
                    useCORS: true,
                    scrollY: -window.scrollY,
                    allowTaint: true
                });
                const imgData = canvas.toDataURL("image/png");
                const pdf = new jsPDF("p", "pt", "a4");
                const pageWidth = pdf.internal.pageSize.getWidth();
                const pageHeight = pdf.internal.pageSize.getHeight();
                const margin = 40;
                const title = "Maintenance Details";
                pdf.setFontSize(16);
                pdf.setFont("helvetica", "bold");
                const textWidth = pdf.getTextWidth(title);
                const titleX = (pageWidth - textWidth) / 2;
                pdf.text(title, titleX, 40);
                const imgWidth = pageWidth - margin * 2;
                const fullImageHeight = (canvas.height * imgWidth) / canvas.width;
                const contentYStart = 60;
                const availableHeight = pageHeight - contentYStart - margin;
                let remainingHeight = fullImageHeight;
                let yOffset = 0;
                let pageIndex = 0;
                while (remainingHeight > 0) {
                    const sliceHeight = Math.min(availableHeight, remainingHeight);
                    const sliceCanvas = document.createElement("canvas");
                    sliceCanvas.width = canvas.width;
                    sliceCanvas.height = (sliceHeight * canvas.width) / imgWidth;
                    const ctx = sliceCanvas.getContext("2d");
                    ctx.drawImage(
                        canvas,
                        0, yOffset, canvas.width, sliceCanvas.height,
                        0, 0, canvas.width, sliceCanvas.height
                    );
                    const croppedImg = sliceCanvas.toDataURL("image/png");
                    const yPos = pageIndex === 0 ? contentYStart : margin;
                    pdf.addImage(croppedImg, "PNG", margin, yPos, imgWidth, sliceHeight);
                    remainingHeight -= sliceHeight;
                    yOffset += sliceCanvas.height;
                    pageIndex++;
                    if (remainingHeight > 0) {
                        pdf.addPage();
                    }
                }
                pdf.save("MaintenanceReport.pdf");
            } catch (err) {
                console.error("Error generating PDF:", err);
                alert("Failed to generate PDF.");
            }
        }
        function openPrintDialog() {
            const content = document.querySelector("#printModal .model-temp").innerHTML;
            const printWindow = window.open('', '', 'height=800,width=1000');
            printWindow.document.write('<html><head><title>Print</title>');
            printWindow.document.write(`
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; }
                    .page-break { page-break-after: always; }
                    .centerT { text-align: center; }
                    .right { text-align: right; }
                    .table { width: 100%; border-collapse: collapse; }
                    .table td, .table th { border: 1px solid #000; padding: 8px; }
                    @media print {
                        .no-print { display: none !important; }
                    }
                </style>
            `);
            printWindow.document.write('</head><body>');
            printWindow.document.write(content);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        }
        function initDropdownEvents() {
            const textBox1 = document.getElementById("<%= TextBox5.ClientID %>");
            const textBox2 = document.getElementById("<%= TextBox6.ClientID %>");
            const repeaterContainer1 = document.getElementById("RepeaterContainer1");
            const repeaterContainer2 = document.getElementById("RepeaterContainer2");
            textBox1.addEventListener("focus", () => {
                repeaterContainer1.style.display = "block";
                repeaterContainer2.style.display = "none";
            });
            textBox1.addEventListener("input", () => {
                const input = textBox1.value.toLowerCase();
                filterSuggestions("category-link", input, repeaterContainer1);
            });
            textBox2.addEventListener("focus", () => {
                repeaterContainer2.style.display = "block";
                repeaterContainer1.style.display = "none";
            });
            textBox2.addEventListener("input", () => {
                const input = textBox2.value.toLowerCase();
                filterSuggestions("category-link", input, repeaterContainer2);
            });
        }


        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const pdf = new jsPDF("p", "mm", "a4");

            const sections = document.querySelectorAll("#printModal .bill-section");

            let count = 0;

            sections.forEach((section, index) => {
                html2canvas(section, { scale: 2, useCORS: true }).then(canvas => {
                    const imgData = canvas.toDataURL("image/png");
                    const pdfWidth = pdf.internal.pageSize.getWidth();
                    const pdfHeight = pdf.internal.pageSize.getHeight();
                    const imgHeight = canvas.height * pdfWidth / canvas.width;

                    if (index > 0) pdf.addPage();
                    pdf.addImage(imgData, "PNG", 0, 0, pdfWidth, imgHeight);

                    count++;
                    if (count === sections.length) {
                        pdf.save("maintenance-bills.pdf");
                    }
                });
            });
        }





        function filterSuggestions(className, inputValue, container) {
            const items = container.querySelectorAll("." + className);
            let matchFound = false;
            items.forEach(item => {
                if (item.innerText.toLowerCase().includes(inputValue)) {
                    item.style.display = "block";
                    matchFound = true;
                } else {
                    item.style.display = "none";
                }
            });
            let noMatch = container.querySelector(".no-match-message");
            if (!matchFound) {
                if (!noMatch) {
                    noMatch = document.createElement("div");
                    noMatch.className = "no-match-message";
                    noMatch.style.color = "red";
                    noMatch.innerText = "No matching suggestions.";
                    container.appendChild(noMatch);
                }
                noMatch.style.display = "block";
            } else if (noMatch) {
                noMatch.style.display = "none";
            }
        }
        function setTextBox1(value) {
            document.getElementById("<%= TextBox5.ClientID %>").value = value;
            document.getElementById("RepeaterContainer1").style.display = "none";
            document.getElementById("<%= TextBox6.ClientID %>").value = "";
        }
        function setTextBox2(value) {
            document.getElementById("<%= TextBox6.ClientID %>").value = value;
            document.getElementById("RepeaterContainer2").style.display = "none";
        }
        function printmaintenanceDetails() {
            var modalContent = document.querySelector("#pdfmodal .modal-body").innerHTML;
            var printWindow = window.open('', '', 'height=700,width=900');
            printWindow.document.write('<html><head><title>Maintenance Details</title>');
            printWindow.document.write('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">');
            printWindow.document.write('<style>');
            printWindow.document.write('body { font-size: 12px; margin: 30px; font-family: Arial, sans-serif; }');
            printWindow.document.write('h4 { margin-bottom: 10px; text-align: center; }');
            printWindow.document.write('.table { width: 100%; border-collapse: collapse; margin-top: 20px; }');
            printWindow.document.write('th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }');
            printWindow.document.write('th { background-color: #012970; color: white; text-align: center; }');
            printWindow.document.write('.print-header { text-align: center; margin-bottom: 20px; }');
            printWindow.document.write('</style>');
            printWindow.document.write('</head><body>');
            printWindow.document.write('<div class="print-header">');
            printWindow.document.write('<h4><strong>' + document.querySelector("#pdfmodal h4 strong").innerText + '</strong></h4>');
            printWindow.document.write('</div>');
            printWindow.document.write(modalContent);
            printWindow.document.write('<div style="text-align:center; margin-top:20px;">Printed on: ' + new Date().toLocaleString() + '</div>');
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        }

        function setModalData(date, amount, mode, txnRef, upiId) {
            document.getElementById("modalDate").innerText = date;
            document.getElementById("modalAmount").innerText = amount;
            document.getElementById("modalMode").innerText = mode;
            document.getElementById("modalTxnRef").innerText = txnRef;
            document.getElementById("modalUpiId").innerText = upiId;
        }

        function printModalReceipt() {
            var printContents = document.querySelector(".modal-content").innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
            location.reload(); // reload the page to restore event handlers
        }

        function downloadModalPDF() {
            html2canvas(document.querySelector(".modal-content")).then(canvas => {
                const imgData = canvas.toDataURL('image/png');
                const pdf = new jsPDF();
                pdf.addImage(imgData, 'PNG', 10, 10);
                pdf.save("PaymentReceipt.pdf");
            });
        }


        Sys.Application.add_load(initDropdownEvents);
    </script>
</asp:Content>
