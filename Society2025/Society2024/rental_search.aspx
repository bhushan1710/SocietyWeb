<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rental_search.aspx.cs" Inherits="Society.rental_search" MasterPageFile="~/Site.Master" MaintainScrollPositionOnPostback="True" %>
<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />
    <style>
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
        .suggestion-item:hover {
            background: #f0f0f0;
        }
        .overflow-div {
            word-wrap: break-word;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        @media (max-width: 576px) {
            .resized-model {
                max-width: 100%;
                margin-top: 0;
            }
            .modal-dialog {
                margin: 0.5rem;
            }
            .search-container {
                width: 100%;
            }
            .input-buttons {
                display: flex;
                justify-content: flex-end;
            }
            .suggestion-list {
                width: 100% !important;
            }
            .form-control {
                width: 100% !important;
            }
            .overflow-div {
                width: 100%;
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
                    window.location.href = 'rental_search.aspx';
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
                            <h1 class="font-weight-bold" style="color: #012970;">Tenant</h1>
                        </th>
                    </tr>
                </table>
                <br />
                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:HiddenField ID="owner_id" runat="server" />
                        <asp:HiddenField ID="o_ex_id" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="society_id" runat="Server"></asp:HiddenField>
                        <asp:HiddenField ID="flat_id" runat="server" />
                        <asp:Label runat="server" Visible="false" ID="Label11"></asp:Label>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex align-items-center flex-wrap">
                                        <div class="search-container">
                                            <asp:TextBox
                                                ID="txt_search"
                                                CssClass="aspNetTextBox form-control"
                                                placeHolder="Search here"
                                                runat="server"
                                                TextMode="Search"
                                                AutoPostBack="true"
                                                OnTextChanged="btn_search_Click"
                                                onkeyup="removeFocusAfterTyping()" />
                                            <div class="input-buttons">
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
                                        <button type="button" class="btn btn-primary mt-2 mt-sm-0" data-toggle="modal" data-target="#edit_model">Add</button>
                                        &nbsp;
                                        <button class="btn btn-primary mt-2 mt-sm-0" onclick="printFlatMaster()">Print</button>
                                        &nbsp;
                                        <button class="btn btn-success mt-2 mt-sm-0" onclick="downloadReceipt()">Download PDF</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-12">
                                    <div class="table-responsive">
                                        <asp:GridView ID="GridView1" runat="server" AllowPaging="true" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" OnRowUpdating="GridView1_RowUpdating" AllowSorting="true" HeaderStyle-BackColor="lightblue" OnSorting="GridView1_Sorting" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" OnRowDeleting="GridView1_RowDeleting">
                                            <Columns>
                                                <asp:TemplateField HeaderText="No" ItemStyle-Width="50">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="owner_id" Visible="false" SortExpression="owner_id">
                                                    <ItemTemplate>
                                                        <asp:Label ID="owner_id" runat="server" Text='<%# Bind("owner_id")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Name" SortExpression="name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="name" runat="server" Text='<%# Bind("name")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Building" SortExpression="build_name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="addr3" runat="server" Text='<%# Bind("build_name")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Unit" SortExpression="unit">
                                                    <ItemTemplate>
                                                        <asp:Label ID="addr" runat="server" Text='<%# Bind("unit")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Sq.ft" SortExpression="sq_ft">
                                                    <ItemTemplate>
                                                        <asp:Label ID="addr2" runat="server" Text='<%# Bind("sq_ft")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Type" SortExpression="flat_type">
                                                    <ItemTemplate>
                                                        <asp:Label ID="addr1" runat="server" Text='<%# Bind("flat_type")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Edit" ItemStyle-Width="50">
                                                    <ItemTemplate>
                                                        <asp:LinkButton runat="server" ID="edit" OnCommand="edit_Command" CommandName="Update" CommandArgument='<%# Bind("owner_id")%>'><img src="Images/123.png"/></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete" Visible="false" ItemStyle-Width="50">
                                                    <ItemTemplate>
                                                        <asp:ImageButton
                                                            ID="imgDelete"
                                                            ImageUrl="~/Images/delete_10781634.png"
                                                            CommandName="Delete"
                                                            runat="server"
                                                            Height="25px"
                                                            ToolTip="Delete this row"
                                                            OnClientClick="return confirm('Are you sure you want to delete this row?');" />
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
            <div class="modal fade" id="edit_model" role="form" aria-labelledby="myLargeModalLabel" data-backdrop="static">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content resized-model">
                        <div class="modal-header">
                            <h4 class="modal-title" id="gridSystemModalLabel"><strong>Rental Details</strong></h4>
                        </div>
                        <div class="modal-body" id="invoice_data">
                            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:HiddenField ID="flat_no_id" runat="server" />
                                    <asp:HiddenField ID="Buildling_wing_id" runat="server" />
                                    <asp:HiddenField ID="type_id" runat="server" />
                                    <asp:HiddenField ID="married_id" runat="server" />
                                    <asp:HiddenField ID="doc_id_id" runat="server" />
                                    <asp:HiddenField ID="society_name" runat="server" />
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_acc_no" runat="server" Text="Build & Wing"></asp:Label>
                                                <asp:Label ID="lbl_acc_no_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <div class="dropdown-container">
                                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="input-box form-control" placeholder="Select" autocomplete="off" required="required" />
                                                    <div id="RepeaterContainer1" class="suggestion-list">
                                                        <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound" OnItemCommand="CategoryRepeater_ItemCommand1">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="lnkCategory"
                                                                    runat="server"
                                                                    CssClass="suggestion-item link-button category-link"
                                                                    Text='<%# Eval("name") %>'
                                                                    CommandArgument='<%# Eval("wing_id") %>'
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
                                                <asp:Label ID="lbl_date" runat="server" Text="Poss Date"></asp:Label>
                                                <asp:Label ID="lbl_date_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_poss_date" CssClass="form-control" runat="server" TextMode="Date" required></asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please Select Date
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="Label5" runat="server" Text="Type"></asp:Label>
                                                <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <div class="dropdown-container">
                                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="input-box form-control" placeholder="Select" autocomplete="off" required="required" />
                                                    <div id="RepeaterContainer2" class="suggestion-list">
                                                        <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound" OnItemCommand="CategoryRepeater_ItemCommand2">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="lnkCategory"
                                                                    runat="server"
                                                                    CssClass="suggestion-item link-button category-link"
                                                                    Text='<%# Eval("flat_type") %>'
                                                                    CommandArgument='<%# Eval("flat_type_id") %>'
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
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="Label8" runat="server" Text="Flat No"></asp:Label>
                                                <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <div class="dropdown-container">
                                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="input-box form-control" placeholder="Select" autocomplete="off" required="required" />
                                                    <div id="RepeaterContainer3" class="suggestion-list">
                                                        <asp:Repeater ID="Repeater3" runat="server" OnItemDataBound="Repeater3_ItemDataBound" OnItemCommand="CategoryRepeater_ItemCommand3">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="lnkCategory"
                                                                    runat="server"
                                                                    CssClass="suggestion-item link-button category-link"
                                                                    Text='<%# Eval("flat_type") %>'
                                                                    CommandArgument='<%# Eval("flat_id") %>'
                                                                    CommandName="SelectCategory"
                                                                    OnClientClick="setTextBox3(this.innerText);" />
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Literal ID="litNoItem" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>'
                                                                    Text="No items found." />
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_name" runat="server" Text="Name"></asp:Label>
                                                <asp:Label ID="lbl_name_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_name" CssClass="form-control" runat="server" Style="text-transform: capitalize;" MaxLength="50" placeholder="Enter Name" required></asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please Enter Name
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_mob" runat="server" Text="E-mail ID"></asp:Label>
                                                <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_email" CssClass="form-control" TextMode="Email" placeholder="Enter Email" required runat="server"></asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please Enter valid Email ID
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_pre_mob" runat="server" Text="Mobile No."></asp:Label>
                                                <asp:Label ID="lbl_pre_mob_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_pre_mob" onkeypress="return event.charCode >= 48 && event.charCode <= 57" CssClass="form-control" runat="server" OnTextChanged="txt_pre_mob_TextChanged" MaxLength="10" TextMode="Phone" placeholder="Enter Mobile No." AutoPostBack="true" required></asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please Enter Mobile No
                                                </div>
                                                <asp:Label ID="Label31" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_add_mob" runat="server" Text="Alternate Mobile No."></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_add_mob" runat="server" MaxLength="10" TextMode="Phone" placeholder="Enter Mobile No." CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_married" runat="server" Text="Married"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <div class="dropdown-container">
                                                    <asp:TextBox ID="TextBox4" runat="server" CssClass="input-box form-control" placeholder="Select" autocomplete="off" required="required" />
                                                    <div id="RepeaterContainer4" class="suggestion-list">
                                                        <asp:Repeater ID="Repeater4" runat="server" OnItemDataBound="Repeater4_ItemDataBound" OnItemCommand="CategoryRepeater_ItemCommand4">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="lnkCategory"
                                                                    runat="server"
                                                                    CssClass="suggestion-item link-button category-link"
                                                                    Text='<%# Eval("married_name") %>'
                                                                    CommandArgument='<%# Eval("married_id") %>'
                                                                    CommandName="SelectCategory"
                                                                    OnClientClick="setTextBox4(this.innerText);" />
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
                                                <asp:Label ID="Label27" runat="server" Text="DOB"></asp:Label>
                                                <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_dob" CssClass="form-control" runat="server" TextMode="Date" required></asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please Select Date
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <asp:Label runat="server" Visible="false" ID="building_lbl"></asp:Label>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="Label3" runat="server" Text="ID Proof"></asp:Label>
                                                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <div class="dropdown-container">
                                                    <asp:TextBox ID="TextBox5" runat="server" CssClass="input-box form-control" placeholder="Select" autocomplete="off" required="required" />
                                                    <div id="RepeaterContainer5" class="suggestion-list">
                                                        <asp:Repeater ID="Repeater5" runat="server" OnItemDataBound="Repeater5_ItemDataBound" OnItemCommand="CategoryRepeater_ItemCommand5">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="lnkCategory"
                                                                    runat="server"
                                                                    CssClass="suggestion-item link-button category-link"
                                                                    Text='<%# Eval("doc_name") %>'
                                                                    CommandArgument='<%# Eval("doc_id") %>'
                                                                    CommandName="SelectCategory"
                                                                    OnClientClick="setTextBox5(this.innerText);" />
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
                                                <asp:FileUpload ID="FileUpload2" runat="server" />
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:Button ID="btnotice_id_upload" runat="server" Text="Upload" Class="btn btn-primary" OnClick="btnotice_id_upload_Click" UseSubmitBehavior="False" />
                                                <div class="overflow-div">
                                                    <asp:Label ID="listofuploadedfiles1" runat="server" />
                                                </div>
                                                <asp:Label ID="uploadphotopath" runat="server" Visible="false" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="Label2" runat="server" Text="Photo Proof"></asp:Label>
                                                <asp:Label ID="Label29" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-9">
                                                <asp:FileUpload ID="FileUpload1" runat="server" accept=".jpg,.jpeg" />
                                                <asp:Button ID="btn_photo_upload" runat="server" Text="Upload" Class="btn btn-primary" OnClick="btn_photo_upload_Click" UseSubmitBehavior="False" />
                                                <div class="overflow-div">
                                                    <asp:Label ID="listofuploadedfiles" runat="server" />
                                                </div>
                                                <asp:Label ID="uploadidpath" runat="server" Visible="false" />
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="box-header">
                                        <div class="row">
                                            <div class="col-12">
                                                <h3 class="box-title"><b>Occupation Details</b></h3>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_occup" runat="server" Text="Occupation"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_occup" runat="server" Style="text-transform: capitalize;" MaxLength="250" placeholder="Enter Occupation" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_mon_inc" runat="server" Text="Organization"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_org" runat="server" Style="text-transform: capitalize;" MaxLength="50" placeholder="Enter Organization Name" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_off_addr1" runat="server" Text="Office Address"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_off_addr1" runat="server" Style="text-transform: capitalize;" MaxLength="250" placeholder="Enter Office Address" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_off_tel" runat="server" Text="Office Tel."></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_off_tel" runat="server" MaxLength="50" onkeypress="return digit(event);" placeholder="Enter Office Tel." CssClass="form-control"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txt_off_tel" ErrorMessage="Numbers Only" Font-Bold="True" ForeColor="Red" ValidationExpression="^\d+" Display="Dynamic" ValidationGroup="g1"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="box-header">
                                        <div class="row">
                                            <div class="col-12">
                                                <h3 class="box-title"><b>Agreement Details</b></h3>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="Label13" runat="server" Text="Agreement Date"></asp:Label>
                                                <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_aggrement_date" CssClass="form-control" runat="server" MaxLength="8" TextMode="Date" required></asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please Select Date
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="Label25" runat="server" Text="Police Verification Date"></asp:Label>
                                                <asp:Label ID="Label20" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_police_verification" CssClass="form-control" runat="server" MaxLength="8" TextMode="Date" required></asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please Select Date
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="Label16" runat="server" Text="Agreement Period From"></asp:Label>
                                                <asp:Label ID="Label30" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_period_from" CssClass="form-control" runat="server" TextMode="Date" required></asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please Select Date
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="Label21" runat="server" Text="Agreement Period To"></asp:Label>
                                                <asp:Label ID="Label23" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_period_to" CssClass="form-control" runat="server" MaxLength="8" TextMode="Date" required></asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please Select Date
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <asp:Panel runat="server" Visible="false">
                                    <div class="box-header">
                                        <div class="row">
                                            <div class="col-12">
                                                <h3 class="box-title"><b>Family Details</b></h3>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_tof_acc" runat="server" Text="Family Member"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_fam_mem_name" Style="text-transform: capitalize;" runat="server" placeholder="Enter family member" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_bank_acc" runat="server" Text="Relation"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_owner_rel" runat="server" Style="text-transform: capitalize;" MaxLength="50" placeholder="Enter Relation" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row align-items-center mb-3">
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_bank" runat="server" Text="Occupation"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_f_occu" runat="server" Style="text-transform: capitalize;" MaxLength="50" placeholder="Enter Occupation" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:Label ID="lbl_bank_addr1" runat="server" Text="DOB"></asp:Label>
                                            </div>
                                            <div class="col-12 col-sm-3">
                                                <asp:TextBox ID="txt_f_dob" runat="server" MaxLength="50" placeholder="Enter DOB" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-12 text-center">
                                                <asp:Button ID="btn_add" class="btn btn-primary" runat="server" Text="Add" OnClick="btn_add_Click"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView2_RowDeleting" HeaderStyle-BackColor="lightblue" ShowHeaderWhenEmpty="true" OnSorting="GridView2_Sorting" EmptyDataText="No Record Found" AllowSorting="True">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="detail_id" Visible="false">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="o_ex_id" runat="server" Text='<%# Bind("o_ex_id")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="owner_id" Visible="false">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="owner_id" runat="server" Text='<%# Bind("owner_id")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Name" SortExpression="f_name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="f_name" runat="server" Text='<%# Bind("f_name")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Relation" SortExpression="relation">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="relation" runat="server" Text='<%# Bind("relation")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Occupation" SortExpression="f_occu">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="f_occu" runat="server" Text='<%# Bind("f_occu")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="DOB" SortExpression="f_dob">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="f_dob" runat="server" Text='<%# Bind("f_dob", "{0:dd-MM-yyyy}")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="50">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton runat="server" ID="edit551" CommandName="Delete" OnClientClick="return confirm('Are you sure want to delete?');"><img src="Images/delete_10781634.png" height="25" width="25" /> </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                        </asp:Panel>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                                    <asp:PostBackTrigger ControlID="btn_photo_upload" />
                                    <asp:PostBackTrigger ControlID="btnotice_id_upload" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <div class="modal-footer">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 text-center">
                                        <asp:Button ID="btn_save" OnClientClick="disableSaveButtonIfValid();" type="button-submit" runat="server" Text="Save" OnClick="btn_save_Click1" ValidationGroup="g1" class="btn btn-primary" />
                                        <asp:Button ID="btn_delete" class="btn btn-primary" Visible="false" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure want to delete?');" OnClick="btn_delete_Click" />
                                        <asp:Button ID="btn_close" runat="server" Text="Close" class="btn btn-primary" UseSubmitBehavior="False" OnClientClick="resetForm(); return false;" data-dismiss="modal" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- rental PDF Modal -->
    <div class="modal fade" id="pdfmodal" role="form" aria-labelledby="myLargeModalLabel" data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content resized-model">
                <div class="modal-header" style="justify-content: center;">
                    <h4 class="modal-title text-center"><strong>Rental Details</strong></h4>
                </div>
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
                                <asp:TemplateField HeaderText="No">
                                    <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblRowNumber" runat="server" Text='<%# Container.DataItemIndex + 1 %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="owner_id" DataField="owner_id" SortExpression="owner_id" Visible="false" />
                                <asp:BoundField HeaderText="Name" DataField="name" SortExpression="name">
                                    <HeaderStyle Width="150px" />
                                    <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Building" DataField="build_name" SortExpression="build_name">
                                    <HeaderStyle Width="150px" />
                                    <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Unit" DataField="unit" SortExpression="unit">
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle Width="100px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Sq.ft" DataField="sq_ft" SortExpression="sq_ft">
                                    <HeaderStyle Width="80px" />
                                    <ItemStyle Width="80px" HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Type" DataField="flat_type" SortExpression="flat_type">
                                    <HeaderStyle Width="120px" />
                                    <ItemStyle Width="120px" HorizontalAlign="Center" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="pdf-clone-container" style="position: absolute; top: -10000px; left: -10000px;"></div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script>
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
            cloneContainer.appendChild(clone);
            try {
                const canvas = await html2canvas(clone, {
                    scale: 2,
                    useCORS: true
                });
                const imgData = canvas.toDataURL("image/png");
                const pdf = new jsPDF("p", "pt", "a4");
                const pageWidth = pdf.internal.pageSize.getWidth();
                const margin = 40;
                const title = "Rental Details";
                pdf.setFontSize(16);
                pdf.setFont("helvetica", "bold");
                const textWidth = pdf.getTextWidth(title);
                const x = (pageWidth - textWidth) / 2;
                pdf.text(title, x, 40);
                const imgWidth = pageWidth - margin * 2;
                const imgHeight = (canvas.height * imgWidth) / canvas.width;
                const imageY = 60;
                pdf.addImage(imgData, "PNG", margin, imageY, imgWidth, imgHeight);
                pdf.save("RentalReport.pdf");
            } catch (err) {
                console.error("Error generating PDF:", err);
                alert("Failed to generate PDF.");
            }
        }
        function initDropdownEvents() {
            const textBox1 = document.getElementById("<%= TextBox1.ClientID %>");
            const repeaterContainer1 = document.getElementById("RepeaterContainer1");
            const textBox2 = document.getElementById("<%= TextBox2.ClientID %>");
            const repeaterContainer2 = document.getElementById("RepeaterContainer2");
            const textBox3 = document.getElementById("<%= TextBox3.ClientID %>");
            const repeaterContainer3 = document.getElementById("RepeaterContainer3");
            const textBox4 = document.getElementById("<%= TextBox4.ClientID %>");
            const repeaterContainer4 = document.getElementById("RepeaterContainer4");
            const textBox5 = document.getElementById("<%= TextBox5.ClientID %>");
            const repeaterContainer5 = document.getElementById("RepeaterContainer5");
            textBox1.addEventListener("focus", function () {
                repeaterContainer1.style.display = "block";
                repeaterContainer2.style.display = "none";
                repeaterContainer3.style.display = "none";
                repeaterContainer4.style.display = "none";
                repeaterContainer5.style.display = "none";
            });
            textBox1.addEventListener("input", function () {
                const input = textBox1.value.toLowerCase();
                filterSuggestions("category-link", input);
            });
            textBox2.addEventListener("focus", function () {
                repeaterContainer2.style.display = "block";
                repeaterContainer1.style.display = "none";
                repeaterContainer3.style.display = "none";
                repeaterContainer4.style.display = "none";
                repeaterContainer5.style.display = "none";
            });
            textBox2.addEventListener("input", function () {
                const input = textBox2.value.toLowerCase();
                filterSuggestions("category-link", input);
            });
            textBox3.addEventListener("focus", function () {
                repeaterContainer3.style.display = "block";
                repeaterContainer1.style.display = "none";
                repeaterContainer2.style.display = "none";
                repeaterContainer4.style.display = "none";
                repeaterContainer5.style.display = "none";
            });
            textBox3.addEventListener("input", function () {
                const input = textBox3.value.toLowerCase();
                filterSuggestions("category-link", input);
            });
            textBox4.addEventListener("focus", function () {
                repeaterContainer4.style.display = "block";
                repeaterContainer1.style.display = "none";
                repeaterContainer2.style.display = "none";
                repeaterContainer3.style.display = "none";
                repeaterContainer5.style.display = "none";
            });
            textBox4.addEventListener("input", function () {
                const input = textBox4.value.toLowerCase();
                filterSuggestions("category-link", input);
            });
            textBox5.addEventListener("focus", function () {
                repeaterContainer5.style.display = "block";
                repeaterContainer1.style.display = "none";
                repeaterContainer2.style.display = "none";
                repeaterContainer3.style.display = "none";
                repeaterContainer4.style.display = "none";
            });
            textBox5.addEventListener("input", function () {
                const input = textBox5.value.toLowerCase();
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
            document.getElementById("<%= TextBox2.ClientID %>").value = "";
            document.getElementById("<%= TextBox3.ClientID %>").value = "";
        }
        function setTextBox2(value) {
            document.getElementById("<%= TextBox2.ClientID %>").value = value;
            document.getElementById("RepeaterContainer2").style.display = "none";
            document.getElementById("<%= TextBox3.ClientID %>").value = "";
        }
        function setTextBox3(value) {
            document.getElementById("<%= TextBox3.ClientID %>").value = value;
            document.getElementById("RepeaterContainer3").style.display = "none";
        }
        function setTextBox4(value) {
            document.getElementById("<%= TextBox4.ClientID %>").value = value;
            document.getElementById("RepeaterContainer4").style.display = "none";
        }
        function setTextBox5(value) {
            document.getElementById("<%= TextBox5.ClientID %>").value = value;
            document.getElementById("RepeaterContainer5").style.display = "none";
        }
        function printFlatMaster() {
            var modalContent = document.querySelector("#pdfmodal .modal-body").innerHTML;
            var printWindow = window.open('', '', 'height=700,width=900');
            printWindow.document.write('<html><head><title>Rental Details</title>');
            printWindow.document.write('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">');
            printWindow.document.write('<style>');
            printWindow.document.write('body {font-size: 12px; margin: 30px; font-family: Arial, sans-serif;}');
            printWindow.document.write('h4 {margin-bottom: 10px; text-align: center;}');
            printWindow.document.write('.table {width: 100%; border-collapse: collapse; margin-top: 20px;}');
            printWindow.document.write('th, td {border: 1px solid #ccc; padding: 8px; text-align: left;}');
            printWindow.document.write('th {background-color: #012970; color: white; text-align: center;}');
            printWindow.document.write('.print-header {text-align: center; margin-bottom: 20px;}');
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
        Sys.Application.add_load(initDropdownEvents);
    </script>
</asp:Content>