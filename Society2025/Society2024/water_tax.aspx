<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="water_tax.aspx.cs" Inherits="Society2024.Water_tax" MasterPageFile="~/Site.Master" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
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
                    window.location.href = 'water_tax.aspx';
                }
            });
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
                        <th width="100%">
                            <h1 class=" font-weight-bold " style="color: #012970;">Water Tax</h1>
                        </th>
                    </tr>
                </table>
                <br />

                <asp:UpdatePanel runat="server" ID="update1" UpdateMode="Conditional">
                 <ContentTemplate>
                <asp:HiddenField ID="village_id" runat="server" />
                <asp:HiddenField ID="water_tax_id" runat="server"></asp:HiddenField>
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
                                                onkeyup="removeFocusAfterTyping()"/>

                                            <ajaxtoolkit:calendarextender
                                                id="CalendarExtender1"
                                                runat="server"
                                                targetcontrolid="txt_search"
                                                popupbuttonid="btn_calendar"
                                                format="yyyy-MM" />

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
             <asp:Button ID="Button1" runat="server" class="btn btn-primary" OnClick="btn_import_Click" Text="Import Data From Excel" UseSubmitBehavior="False" />

                                    </div>
                                </div>
                            </div>
                        </div>

                <div class="form-group">
                    <div class="row ">
                        <div class="col-sm-12">
                            <div style="width: 100%; overflow: auto;">
                                <asp:GridView ID="GridView1" runat="server" AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="15" AutoGenerateColumns="false" OnSorting="GridView1_Sorting" CssClass="table table-bordered table-hover table-striped" AllowSorting="true" HeaderStyle-BackColor="lightblue"  OnRowEditing="GridView1_RowEditing"
                                    OnRowDeleting="GridView1_RowDeleting" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found">
                                                                     
                                    <Columns>
                                        <asp:TemplateField HeaderText="No" ItemStyle-Width="50">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="owner_id" SortExpression="owner_id" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="water_tax_id" Text='<%# Bind("water_tax_id")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="House No" Visible="true" SortExpression="house_no">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="house_no" Text='<%# Bind("house_no")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="From Date" Visible="true" SortExpression="from_date">
                                            <ItemTemplate>
                                                <asp:Label ID="from_date" runat="server" Text='<%# Bind("from_date","{0:MMMM yyyy}")%>'></asp:Label>

                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Connection Type" Visible="true" SortExpression="connection_type">
                                            <ItemTemplate>
                                                <asp:Label ID="connection_type" runat="server" Text='<%# Bind("connection_type")%>'></asp:Label>

                                            </ItemTemplate>
                                        </asp:TemplateField>

                                         <asp:TemplateField HeaderText="Water Tax Amount" Visible="true" SortExpression="water_tax_amount">
                                            <ItemTemplate>
                                                <asp:Label ID="water_tax_amount" runat="server" Text='<%# Bind("water_tax_amount")%>'></asp:Label>

                                            </ItemTemplate>
                                        </asp:TemplateField>
                                     
                                        <asp:TemplateField HeaderText="Edit" ItemStyle-Width="50">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="edit" CommandName="Edit" OnCommand="edit_Command" CommandArgument='<%# Bind("water_tax_id")%>'><img src="Images/123.png"/></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete" ItemStyle-Width="50">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="delete" CommandName="Delete"><img src="Images/delete_10781634.png" height="25" width="25" /> </asp:LinkButton>
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

                <div class="modal fade bs-example-modal-sm" id="edit_model" role="form" aria-labelledby="myLargeModalLabel" data-backdrop="static">
                    <div class="modal-dialog modal-sm-4" style="right: 80px">

                        <div class="modal-content" style="height: auto; width: 900px;">
                            <div class="modal-header">
                                <h4 class="modal-title" id="gridSystemModalLabel"><strong>Water tax</strong></h4>
                            </div>

                            <div class="modal-body" id="invoice_data">

                                <asp:UpdatePanel runat="server" ID="update" UpdateMode="Conditional">
                                    <ContentTemplate>

                                        <div class="form-group">
                                            <div class="row ">
                                                <div class="col-sm-3">
                                                    <asp:Label ID="lbl_acc_no" runat="server" Text=" House No :"></asp:Label>
                                                    <asp:Label ID="lbl_acc_no_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-3">
                                                   <asp:DropDownList ID="drp_house_no" Height="32px" parsely-trigger="change" Width="200px" runat="server"></asp:DropDownList>
                                                    <br />
                                                    <asp:CompareValidator ControlToValidate="drp_house_no" ID="CompareValidator2" ValidationGroup="g1" CssClass="errormesg" ErrorMessage="select house no" Font-Bold="true" ForeColor="Red" runat="server" Display="Dynamic" Operator="NotEqual" ValueToCompare="select" Type="String" />
                                                </div>

                                                <div class="col-sm-3">
                                                    <asp:Label ID="Label4" runat="server" Text="  Connection type :"></asp:Label>
                                                    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-3">
                                                    <asp:DropDownList ID="drp_connectiontype" Height="32px" parsely-trigger="change" Width="200px" runat="server"></asp:DropDownList>
                                                    <br />
                                                    <asp:CompareValidator ControlToValidate="drp_connectiontype" ID="CompareValidator1" ValidationGroup="g1" CssClass="errormesg" ErrorMessage="select connection type" Font-Bold="true" ForeColor="Red" runat="server" Display="Dynamic" Operator="NotEqual" ValueToCompare="select" Type="String" />
                                                </div>

                                            </div>
                                        </div>


                                        <div class="form-group">
                                            <div class="row ">
                                                <div class="col-sm-3">
                                                    <asp:Label ID="lbl_name" runat="server" Text="From date"></asp:Label>
                                                    <asp:Label ID="lbl_name_sep" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                    <asp:Label ID="lbl_name_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-3">
                                                    <asp:TextBox ID="Txt_fromdate" runat="server" Height="32px" Width="200px" TextMode="Date" required></asp:TextBox>

                                                </div>



                                                <div class="col-sm-3">
                                                    <asp:Label ID="lbl_mob" runat="server" Text="To date"></asp:Label>
                                                    <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Black" Text=":"></asp:Label>
                                                    <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>

                                                </div>
                                                <div class="col-sm-3">
                                                    <asp:TextBox ID="Txt_todate" runat="server" Height="32px" Width="200px" TextMode="Date" required></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row ">

                                                <div class="col-sm-3">
                                                    <asp:Label ID="Label6" runat="server" Text="size of water connection"></asp:Label>
                                                    <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                </div>
                                                <div class="col-sm-3">
                                                    <asp:TextBox ID="txt_water_con" Height="32px" Width="200px" runat="server" MaxLength="10" placeholder="Enter size of connection"></asp:TextBox>

                                                </div>

                                                <div class="col-sm-3">
                                                    <asp:Label ID="Label10" runat="server" Text="water tax amount"></asp:Label>
                                                    <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                </div>
                                                <div class="col-sm-3">
                                                    <asp:TextBox ID="Txt_watertaxamount" Height="32px" Width="200px" runat="server" MaxLength="10" placeholder="Enter water tax amount"></asp:TextBox>

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
                                    <div class="form-group">
                                        <div class="row">
                                            <center>
                                                <asp:Button ID="btn_save" type="button-submit" runat="server" Text="Save" OnClick="btn_save_Click" ValidationGroup="g1" class="btn btn-primary" />
                                                <asp:Button ID="btn_delete" class="btn btn-primary" Visible="false" runat="server" OnClick="btn_delete_Click" Text="Delete" OnClientClick="return confirm('Are you sure want to delete?');" CausesValidation="false" />
                                                <asp:Button ID="btn_close" type="button-close" class="btn btn-primary" runat="server" OnClick="btn_close_Click" Text="Close" UseSubmitBehavior="False" />
                                            </center>
                                         
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  
</asp:Content>
