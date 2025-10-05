<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="facility_booking.aspx.cs" Inherits="Society.facility_booking" MasterPageFile="~/Site.Master" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .resized-model {
            width: 800px;
            height: auto;
            right: 82px;
        }

        @media(max-width: 431px) {
            .resized-model {
                height: auto;
                margin: auto;
                width: 292px;
                margin-top: 168px;
                right: 1px;
            }
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
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
                    window.location.href = 'facility_booking.aspx';
                }
            });
        }

        function openModal() {
            $('#edit_model').modal('show');
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

                return false; // prevent default to avoid double postback
            }

            return false; // prevent postback if not valid
        }
    </script>

    <div class="box box-primary">
        <div class="box-header with-border">
            <div class="box-body">

                <table width="100%">
                    <tr>
                        <th width="100%" class="">
                            <h1 class=" tex0 font-weight-bold " style="color: #012970;">Facility Bookings
                            </h1>
                        </th>
                    </tr>
                </table>

                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <contenttemplate>

                        <asp:HiddenField ID="society_id" runat="Server"></asp:HiddenField>
                        <asp:HiddenField ID="facility_book_id" runat="server" />
                        <asp:HiddenField ID="owner_id" runat="server" />
                        <asp:HiddenField ID="slot_id" runat="server" />
                        <asp:HiddenField ID="hidden_total_amount" runat="server" />



                        <div class="form-group">
                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex align-items-center">
                                        <div class="search-container">

                                            <asp:TextBox
                                                ID="txt_search"
                                                CssClass="aspNetTextBox"
                                                placeHolder="Search here"
                                                runat="server"
                                                TextMode="Search"
                                                AutoPostBack="true"
                                                OnTextChanged="btn_search_Click"
                                                onkeyup="removeFocusAfterTyping()" />

                                            <ajaxtoolkit:calendarextender
                                                id="CalendarExtender1"
                                                runat="server"
                                                targetcontrolid="txt_search"
                                                popupbuttonid="btn_calendar"
                                                format="yyyy-MM-dd" />

                                            <!-- Calendar and Search Buttons -->
                                            <div class="input-buttons">
                                                <img
                                                    id="btn_calendar"
                                                    src="img/calendar.png"
                                                    alt="Pick Date"
                                                    class="calendar-icon"
                                                    style="cursor: pointer;" />

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
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#edit_model">Add</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row ">
                                <div class="col-sm-12">
                                    <div style="width: 100%; overflow: auto;">
                                        <asp:GridView AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="15" ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowUpdating="GridView1_RowUpdating" CssClass="table table-bordered table-hover table-striped" AllowSorting="true" HeaderStyle-BackColor="lightblue" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" OnSorting="GridView1_Sorting" OnRowDeleting="GridView1_RowDeleting">
                                            <columns>
                                                <asp:TemplateField HeaderText="No" ItemStyle-Width="50">
                                                    <itemtemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="parking_id" Visible="false">
                                                    <itemtemplate>
                                                        <asp:Label ID="facility_book_id" runat="server" Text='<%# Bind("facility_book_id")%>'></asp:Label>

                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Name" Visible="true" SortExpression="name">
                                                    <itemtemplate>
                                                        <asp:Label ID="gfg" runat="server" Text='<%# Bind("name")%>'></asp:Label>

                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Facility" Visible="true" SortExpression="facility_name">
                                                    <itemtemplate>
                                                        <asp:Label ID="addr" runat="server" Text='<%# Bind("facility_name")%>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Date" Visible="true">
                                                    <itemtemplate>
                                                        <asp:Label ID="addr23" runat="server" Text='<%#!string.IsNullOrEmpty(Eval("to_date").ToString()) ? Eval("from_date", "{0:yyyy-MM-dd}") + " to  " + Eval("to_date", "{0:yyyy-MM-dd}"):Eval("from_date","{0:yyyy-MM-dd}")%>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Time" Visible="true">
                                                    <itemtemplate>
                                                        <asp:Label ID="addr1" runat="server" Text='<%# Eval("from_time") + " -   "+  Eval("to_time")%>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Charges" ItemStyle-Width="150" Visible="true">
                                                    <itemtemplate>
                                                        <asp:Label ID="charges" runat="server" Text='<%# Bind("amount")%>'></asp:Label>

                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <%-- <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="edit" OnCommand="edit_Command" CommandName="Update" CommandArgument='<%# Bind("parking_id")%>'><img src="Images/123.png"/></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Edit" ItemStyle-Width="50" Visible="false">
                                                    <itemtemplate>
                                                        <asp:LinkButton runat="server" ID="edit551" CommandName="Delete" OnClientClick="return confirm('Are you sure want to delete?');">
                                                            <img src="Images/delete_10781634.png" height="25" width="25" />
                                                        </asp:LinkButton>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                            </columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </contenttemplate>
                </asp:UpdatePanel>
                <div class="modal fade bs-example-modal-sm" id="edit_model" role="form" aria-labelledby="myLargeModalLabel" data-backdrop="static">
                    <div class="modal-dialog modal-sm-4">
                        <div class="modal-content resized-model">
                            <div class="modal-header">
                                <h4 class="modal-title" id="gridSystemModalLabel"><strong>Facility Booking</strong></h4>
                            </div>
                            <div class="modal-body" id="invoice_data">

                                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                    <contenttemplate>
                                        <asp:HiddenField ID="facility_id" runat="server" />
                                        <asp:HiddenField ID="name_id" runat="server" />

                                        <div class="form-group">
                                            <div class="row ">
                                                <div class="col-sm-2">
                                                    <asp:Label ID="Label7" runat="server" Text="Facilities"></asp:Label>
                                                    <asp:Label ID="Label28" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                    <asp:Label ID="Label29" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*" required></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <div class="dropdown-container">
                                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="input-box form-control"
                                                            placeholder="Select" autocomplete="off" required="required" />
                                                        <div id="RepeaterContainer1" class="suggestion-list">
                                                            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound" OnItemCommand="CategoryRepeater_ItemCommand1">
                                                                <itemtemplate>
                                                                    <asp:LinkButton
                                                                        ID="lnkCategory"
                                                                        runat="server"
                                                                        CssClass="suggestion-item link-button category-link"
                                                                        Text='<%# Eval("name") %>'
                                                                        CommandArgument='<%# Eval("facility_id") %>'
                                                                        CommandName='<%# Eval("slot") %>'
                                                                        OnClientClick="setTextBox1(this.innerText);" />
                                                                </itemtemplate>
                                                                <footertemplate>
                                                                    <asp:Literal ID="litNoItem" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>'
                                                                        Text="No items found." />
                                                                </footertemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>

                                                </div>


                                                <div class="col-sm-2">
                                                    <asp:Label ID="Label33" runat="server" Text="Date :"></asp:Label>

                                                    <asp:Label ID="Label34" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="txt_date" CssClass="form-control" runat="server" TextMode="Date" OnTextChanged="txt_date_TextChanged" Height="32px" Width="200px" AutoPostBack="true" required autofocus></asp:TextBox>
                                                    <div class="invalid-feedback">
                                                        Please Enter Date
                                                    </div>

                                                </div>


                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row ">
                                                <div class="col-sm-12">
                                                    <div style="width: 100%; overflow: auto;">
                                                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" AllowSorting="true" OnRowDataBound="GridView2_RowDataBound" HeaderStyle-BackColor="lightblue">
                                                            <columns>
                                                                <asp:TemplateField HeaderText="No" ItemStyle-Width="100">
                                                                    <itemtemplate>
                                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                                    </itemtemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Reason" SortExpression="reason" Visible="false">
                                                                    <itemtemplate>
                                                                        <asp:Label ID="status" runat="server" Text='<%# Bind("status")%>'></asp:Label>
                                                                    </itemtemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="parking_id" Visible="false">
                                                                    <itemtemplate>
                                                                        <asp:Label ID="slot_id" runat="server" Text='<%# Bind("slot_id")%>'></asp:Label>

                                                                    </itemtemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="From Time" SortExpression="from_time">
                                                                    <itemtemplate>
                                                                        <asp:Label ID="start_time" runat="server" Text='<%# Eval("start_time", "{0:hh:mm tt}") %>'></asp:Label>
                                                                    </itemtemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="To Time" SortExpression="to_time">
                                                                    <itemtemplate>
                                                                        <asp:Label ID="end_time" runat="server" Text='<%# Bind("end_time","{0:hh:mm tt}")%>'></asp:Label>
                                                                    </itemtemplate>
                                                                </asp:TemplateField>



                                                                <asp:TemplateField Visible="true" SortExpression="reason">
                                                                    <itemtemplate>
                                                                        <asp:Label ID="reason" runat="server"></asp:Label>
                                                                        <asp:CheckBox ID="chk" runat="server" AutoPostBack="true" OnCheckedChanged="chk_CheckedChanged" />
                                                                    </itemtemplate>
                                                                </asp:TemplateField>

                                                            </columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>



                                        <asp:Panel ID="Panel2" runat="server" Visible="false">
                                            <div class="form-group">
                                                <div class="row ">
                                                    <div class="col-sm-2">
                                                        <asp:Label ID="Label10" runat="server" Text="Name"></asp:Label>
                                                        <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                        <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="dropdown-container">
                                                            <asp:TextBox ID="TextBox2" runat="server" CssClass="input-box form-control"
                                                                placeholder="Select" autocomplete="off" required="required" />
                                                            <div id="RepeaterContainer2" class="suggestion-list">
                                                                <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound" OnItemCommand="CategoryRepeater_ItemCommand2">
                                                                    <itemtemplate>
                                                                        <asp:LinkButton
                                                                            ID="lnkCategory"
                                                                            runat="server"
                                                                            CssClass="suggestion-item link-button category-link"
                                                                            Text='<%# Eval("name") %>'
                                                                            CommandArgument='<%# Eval("owner_id") %>'
                                                                            CommandName="SelectCategory"
                                                                            OnClientClick="setTextBox2(this.innerText);" />
                                                                    </itemtemplate>
                                                                    <footertemplate>
                                                                        <asp:Literal ID="litNoItem" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>'
                                                                            Text="No items found." />
                                                                    </footertemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <asp:Label ID="Label13" runat="server" Text="Flat no"></asp:Label>
                                                        <asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                        <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="txt_flat" CssClass="form-control" runat="server" Style="text-transform: capitalize;" Height="32px" Width="200px" AutoPostBack="true" placeholder="Enter Flat No" required autofocus></asp:TextBox>
                                                        <div class="invalid-feedback">
                                                            Please Enter Flat No
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel1" Visible="false" runat="server">
                                            <div class="form-group">
                                                <div class="row ">
                                                    <div class="col-sm-2">
                                                        <asp:Label ID="Label2" runat="server" Text="Name"></asp:Label>
                                                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="txt_name" runat="server" Height="32px" Width="200px" Style="text-transform: capitalize;" placeholder="Enter Name" required autofocus></asp:TextBox>

                                                    </div>
                                                    <div class="col-sm-2">
                                                        <asp:Label ID="Label1" runat="server" Text="Address"></asp:Label>
                                                        <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="txt_add" CssClass="form-control" runat="server" Style="text-transform: capitalize;" Height="32px" Width="200px" placeholder="Enter Address" required autofocus></asp:TextBox>
                                                        <div class="invalid-feedback">
                                                            Please Enter Address
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row ">
                                                    <div class="col-sm-2">
                                                        <asp:Label ID="Label25" runat="server" Text="Contact No:"></asp:Label>
                                                        <asp:Label ID="Label26" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                        <asp:Label ID="Label27" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="txt_contact" CssClass="form-control" runat="server" MaxLength="10" Height="32px" Width="200px" placeholder="Enter Mobile no" required autofocus></asp:TextBox>
                                                        <div class="invalid-feedback">
                                                            Please Enter Contact No
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel3" runat="server" Visible="false">
                                            <div class="form-group">
                                                <div class="row ">
                                                    <div class="col-sm-2">
                                                        <asp:Label ID="lbl_co_name" runat="server" TextMode="Date" Text="From Date :"></asp:Label>

                                                        <asp:Label ID="lbl_co_name_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="txt_from_date" runat="server" TextMode="Date" Height="32px" Width="200px" placeholder="Enter Date" required autofocus></asp:TextBox>

                                                    </div>
                                                    <div class="col-sm-2">
                                                        <asp:Label ID="Label6" runat="server" TextMode="Date" Text="To Date:"></asp:Label>
                                                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-4">

                                                        <asp:TextBox ID="txt_to_date" runat="server" Height="32px" Width="200px" TextMode="Date" placeholder="Enter Date" OnTextChanged="txt_to_date_TextChanged" AutoPostBack="true" autofocus required></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                        </asp:Panel>
                                        <asp:Panel ID="Panel4" runat="server" Visible=" 
                                            false">
                                            <div class="form-group">
                                                <div class="row ">
                                                    <div class="col-sm-2">
                                                        <asp:Label ID="Label16" runat="server" TextMode="Date" Text="From Time"></asp:Label>
                                                        <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                        <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-4">

                                                        <asp:TextBox ID="from_time" runat="server" Height="32px" Width="200px" TextMode="Time" required></asp:TextBox>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <asp:Label ID="Label19" runat="server" TextMode="Date" Text="To Time"></asp:Label>
                                                        <asp:Label ID="Label20" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                        <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <asp:TextBox ID="to_time" runat="server" TextMode="Time" OnTextChanged="to_time_TextChanged" AutoPostBack="true" Height="32px" Width="200px" required autofocus></asp:TextBox>

                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>

                                        <div class="form-group">
                                            <div class="row ">

                                                <div class="col-sm-2">
                                                    <asp:Label ID="Label22" runat="server" Text="Charges"></asp:Label>
                                                    <asp:Label ID="Label23" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                    <asp:Label ID="Label24" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="txt_amount" CssClass="form-control" runat="server" Height="50px" Width="200px" Enabled="false" TextMode="MultiLine" Rows="10"></asp:TextBox>
                                                    <div class="invalid-feedback">
                                                        Please Enter Charges
                                                    </div>

                                                </div>

                                                <div class="col-sm-2">
                                                    <asp:Label ID="Label30" runat="server" Text="Note to Admin"></asp:Label>
                                                    <asp:Label ID="Label31" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="txt_note" CssClass="not-required" runat="server" Height="50px" Width="200px" placeholder="Enter Note" TextMode="MultiLine"></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-2">
                                            <asp:CheckBox ID="society_in" Text="In Society" runat="server" Checked="true" AutoPostBack="true" OnCheckedChanged="society_in_CheckedChanged" />

                                        </div>
                                    </contenttemplate>
                                    <triggers>
                                        <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                                    </triggers>
                                </asp:UpdatePanel>

                            </div>
                            <div class="modal-footer">
                                <div class="form-group">
                                    <div class="row">
                                        <center>
                                            <asp:Button ID="btn_save" OnClientClick="disableSaveButtonIfValid();" type="button-submit" runat="server" Text="Save" OnClick="btn_save_Click" ValidationGroup="g1" class="btn btn-primary" />
                                            <asp:Button ID="btn_delete" class="btn btn-primary" Visible="false" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure want to delete?');" OnClick="btn_delete_Click" />
                                            <asp:Button ID="btn_close" runat="server" Text="Close" class="btn btn-primary" UseSubmitBehavior="False" OnClientClick="resetForm(); return false;" data-dismiss="modal" />

                                        </center>
                                        <br />
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
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
