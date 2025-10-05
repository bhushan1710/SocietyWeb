<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contact_master.aspx.cs" Inherits="Society.contact_master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        .card-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

            .card-grid tr, .card-grid td {
                display: contents; /* Remove table layout */
            }

        .card {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            width: 280px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: 0.3s;
        }

            .card:hover {
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            }

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

        .card .card-title {
            font-size: 1.1rem;
            color: #333;
        }

        .card .card-text {
            font-size: 0.9rem;
            color: #555;
        }

        .contact-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid #e0e0e0;
            background: #ffffff;
            position: relative;
            overflow: hidden;
        }

            .contact-card::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                opacity: 0;
                transition: opacity 0.5s ease;
                z-index: 0;
            }

            .contact-card:hover::before {
                opacity: 1;
            }

            .contact-card:hover {
                transform: translateY(-8px) scale(1.02);
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
                z-index: 1;
            }

        .contact-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
        }

            .contact-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1) !important;
            }

        .card-title {
            font-size: 1.25rem;
            color: #1a1a1a;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 0.5rem;
        }

        .contact-icon {
            color: #495057;
            width: 20px;
            text-align: center;
        }

        .contact-detail {
            color: #343a40;
            font-size: 0.95rem;
        }

        .btn-custom {
            border-radius: 50px;
            padding: 0.4rem 1.2rem;
            font-size: 0.9rem;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .btn-outline-primary {
            border-color: #007bff;
            color: #007bff;
        }

            .btn-outline-primary:hover {
                background-color: #007bff;
                color: #fff;
            }

        .btn-outline-danger {
            border-color: #dc3545;
            color: #dc3545;
        }

            .btn-outline-danger:hover {
                background-color: #dc3545;
                color: #fff;
            }

        .card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            width: 250px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: 0.3s ease-in-out;
        }

            .card:hover {
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
                transform: translateY(-3px);
            }

        @media (max-width: 767px) {
            .contact-card {
                max-width: 100%;
            }
        }

        .contact-card {
            border: 2px solid #ccc; /* light border */
            border-radius: 10px;
            transition: transform 0.5s ease, box-shadow 0.5s ease, border-color 0.5s ease;
            will-change: transform;
            z-index: 1;
            position: relative;
        }

            /* On zoom effect */
            .contact-card.zoomed {
                position: fixed !important;
                top: 50% !important;
                left: 50% !important;
                transform: translate(-50%, -50%) scale(1.15);
                z-index: 1050;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
                background: white;
                border: 3px solid #007bff; /* highlight border */
                border-radius: 12px;
            }

        /* File Upload Styling */
        input[type="file"] {
            padding: 10px;
            border: 2px dashed #e0e0e0;
            border-radius: 8px;
            background: #fafafa;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
            width: 100%;
        }

            input[type="file"]:hover {
                border-color: #667eea;
                background: #f5f7ff;
            }

            input[type="file"]::-webkit-file-upload-button {
                padding: 8px 16px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 13px;
                font-weight: 500;
                margin-right: 10px;
                transition: all 0.2s ease;
            }

                input[type="file"]::-webkit-file-upload-button:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
                }

            /* Firefox */
            input[type="file"]::file-selector-button {
                padding: 8px 16px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 13px;
                font-weight: 500;
                margin-right: 10px;
                transition: all 0.2s ease;
            }

                input[type="file"]::file-selector-button:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
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
                    window.location.href = 'contact_master.aspx';
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
                            <h1 class=" tex0 font-weight-bold " style="color: #012970;">Helper Contact 
                            </h1>
                        </th>
                    </tr>
                </table>
                <br />



                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:HiddenField ID="society_id" runat="Server"></asp:HiddenField>
                        <asp:HiddenField ID="usefull_contact_id" runat="Server"></asp:HiddenField>
                        <div class="form-group">

                            <div class="col-12">
                                <div class="" style="display: flex; align-items: center; gap: 4px;">
                                    <!-- Filter Buttons First -->
                                    <div class="">
                                        <asp:TextBox ID="TextBox1" Style="border-radius: 13px; height: 40px;"
                                            runat="server" CssClass="input-box form-control"
                                            placeholder="Select" autocomplete="off" required="required" />
                                        <div id="categoryRepeaterContainer1" class="suggestion-list" style="width: 239px;">
                                            <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="rptTypeFilter_ItemCommand">
                                                <ItemTemplate>
                                                    <asp:LinkButton
                                                        ID="lnkCategory"
                                                        runat="server"
                                                        CssClass="suggestion-item link-button category-link"
                                                        Text='<%# Eval("p_type_name") %>'
                                                        CommandArgument='<%# Eval("p_type_id") %>'
                                                        CommandName="SelectCategory"
                                                        OnClientClick="setCategoryBox1(this.innerText);" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Literal ID="litNoItem" runat="server"
                                                        Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>'
                                                        Text="No items found." />
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>

                                    <div class="search-container">
                                        <asp:TextBox
                                            ID="txt_search"
                                            CssClass="aspNetTextBox flex-grow-1"
                                            placeHolder="Search here"
                                            runat="server"
                                            TextMode="Search"
                                            AutoPostBack="true"
                                            OnTextChanged="btn_search_Click"
                                            onkeyup="removeFocusAfterTyping()" />

                                        <div class="input-buttons ms-2">
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

                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#edit_model">
                                        Add
                                    </button>
                                </div>
                            </div>
                        </div>



                        <div class="form-group">
                            <div class="row ">
                                <div class="col-sm-12">
                                    <div style="width: 100%; overflow: auto;">
                                        <asp:GridView ID="CardGridView" runat="server" AutoGenerateColumns="False"
                                            CssClass="card-grid" GridLines="None" ShowHeader="False">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <div class="card text-center shadow-sm" style="width: 16rem; float: left; margin: 10px;">
                                                            <h5 class="card-title fw-bold mb-3">
                                                                <%# Eval("p_name") %>
                                                                <span class="text-muted fw-normal">- <%# Eval("p_type_name") %></span>
                                                            </h5>


                                                            <!-- Contact details with icons -->
                                                            <div class="contact-detail small mb-4">
                                                                <div class="d-flex align-items-center mb-2">
                                                                    <i class="fa fa-building contact-icon"></i>
                                                                    <span class="ms-2"><%# Eval("org_name") %></span>
                                                                </div>
                                                                <div class="d-flex align-items-center mb-2">
                                                                    <i class="fa fa-phone contact-icon"></i>
                                                                    <span class="ms-2"><%# Eval("contact_no") %></span>
                                                                </div>
                                                                <div class="d-flex align-items-center mb-2">
                                                                    <i class="fa fa-envelope contact-icon"></i>
                                                                    <span class="ms-2"><%# Eval("email") %></span>
                                                                </div>
                                                                <div class="d-flex align-items-center mb-2">
                                                                    <i class="fa fa-home contact-icon"></i>
                                                                    <span class="ms-2"><%# Eval("contact_address") %></span>
                                                                </div>
                                                                <div class="d-flex align-items-center mb-2">
                                                                    <i class="fa fa-comment contact-icon"></i>
                                                                    <span class="ms-2"><%# Eval("remark") %></span>
                                                                </div>
                                                            </div>

                                                            <asp:Button ID="btnViewFile"
                                                                runat="server"
                                                                Text="View File"
                                                                CssClass="btn btn-primary"
                                                                CommandArgument='<%# Eval("id_path") %>'
                                                                OnCommand="btnViewFile_Command" UseSubmitBehavior="false" />

                                                            <div class="d-flex justify-content-center gap-2 mt-auto">
                                                                <div class="btn-group">
                                                                    <asp:LinkButton ID="lnkEdit" runat="server" CssClass="btn btn-sm btn-outline-primary btn-custom"
                                                                        CommandArgument='<%# Eval("usefull_contact_id") %>' OnCommand="lnkEdit_Command"
                                                                        ToolTip="Edit Contact">
                                                                        <i class="fa fa-edit me-1"></i> Edit
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm btn-outline-danger btn-custom"
                                                                        CommandArgument='<%# Eval("usefull_contact_id") %>' OnCommand="lnkDelete_Command"
                                                                        OnClientClick="return confirm('Are you sure you want to delete this contact?');"
                                                                        ToolTip="Delete Contact">
                                                                        <i class="fa fa-trash me-1"></i> Delete
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Message -->
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-3" />

                    </ContentTemplate>
                </asp:UpdatePanel>

                <div class="modal fade bs-example-modal-sm" id="edit_model" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
                    <div class="modal-dialog modal-sm-4">
                        <div class="modal-content resized-model">
                            <div class="modal-header">
                                <h4 class="modal-title" id="gridSystemModalLabel"><strong>New Helper</strong></h4>
                            </div>
                            <div class="modal-body" id="invoice_data">
                                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:HiddenField ID="contact_type_id" runat="Server" />

                                        <!-- Person's Name & Type -->
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-2">
                                                    <asp:Label ID="lbl_acc_no" runat="server" Text="Person's name"></asp:Label>
                                                    <asp:Label ID="lbl_acc_no_sep" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                    <asp:Label ID="lbl_acc_no_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="txt_p_name" CssClass="form-control" runat="server" Style="text-transform: capitalize;" placeholder="Enter person's Name" required></asp:TextBox>
                                                    <div class="invalid-feedback">
                                                        Please Enter Persons Name
                                                    </div>
                                                </div>
                                                <div class="col-sm-2">
                                                    <asp:Label ID="Label7" runat="server" Text="Person's Type"></asp:Label>
                                                    <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                    <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <div class="dropdown-container">
                                                        <asp:TextBox ID="categoryBox" runat="server"
                                                            CssClass="input-box form-control"
                                                            placeholder="Select" autocomplete="off" required="required"
                                                            oninput="clearCategoryId()" />
                                                        <div id="categoryRepeaterContainer" style="width: 100%;" class="suggestion-list">
                                                            <asp:Repeater ID="categoryRepeater" runat="server" OnItemCommand="CategoryRepeater_ItemCommand">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton
                                                                        ID="lnkCategory"
                                                                        runat="server"
                                                                        CssClass="suggestion-item link-button category-link"
                                                                        Text='<%# Eval("p_type_name") %>'
                                                                        CommandArgument='<%# Eval("p_type_id") %>'
                                                                        CommandName="SelectCategory"
                                                                        OnClientClick="setCategoryBox(this.innerText, '<%# Eval("p_type_id") %>'); return false;" />
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <asp:Literal ID="litNoItem" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>'
                                                                        Text="No items found." />
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                    <asp:Label ID="Label10" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Organization Name & Address -->
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-2">
                                                    <asp:Label ID="lbl_name" runat="server" Text="Organization Name"></asp:Label>
                                                    <asp:Label ID="lbl_name_sep" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                    <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="txt_org_name" CssClass="form-control" runat="server" Style="text-transform: capitalize;" MaxLength="50" placeholder="Enter Organization Name" required></asp:TextBox>
                                                    <div class="invalid-feedback">
                                                        Please Enter Organization Name
                                                    </div>
                                                </div>
                                                <div class="col-sm-2">
                                                    <asp:Label ID="lbl_pre_addr1" runat="server" Text="Address"></asp:Label>
                                                    <asp:Label ID="lbl_pre_addr1_sep" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                    <asp:Label ID="Label12" runat="server" ForeColor="Red" Font-Bold="True" Font-Size="Medium" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="txt_org_addr1" CssClass="form-control" Style="text-transform: capitalize;" runat="server" MaxLength="250" placeholder="Enter Organization Address" required></asp:TextBox>
                                                    <div class="invalid-feedback">
                                                        Please Enter Address
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Contact & Address 2 -->
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-2">
                                                    <asp:Label ID="Label1" runat="server" Text="Contact No"></asp:Label>
                                                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                    <asp:Label ID="Label13" runat="server" ForeColor="Red" Font-Bold="True" Font-Size="Medium" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="txt_org_tel" onkeypress="return event.charCode >= 48 && event.charCode <= 57" CssClass="form-control" runat="server" MaxLength="10" placeholder="Enter Mobile No" onblur="checkLength(this)" AutoPostBack="true" required></asp:TextBox>
                                                    <div class="invalid-feedback">
                                                        Please Enter Mobile No
                                                    </div>
                                                </div>
                                                <div class="col-sm-2">
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="txt_org_addr2" CssClass="not-required" Style="text-transform: capitalize;" runat="server" MaxLength="250" placeholder="Enter Address"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Email & Remark -->
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-2">
                                                    <asp:Label ID="Label3" runat="server" Text="Email Address"></asp:Label>
                                                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                    <asp:Label ID="Label14" runat="server" ForeColor="Red" Font-Bold="True" Font-Size="Medium" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="txt_email" CssClass="form-control" Style="text-transform: lowercase;" runat="server" placeholder="Enter Email Address" required></asp:TextBox>
                                                    <div class="invalid-feedback">
                                                        Please Enter Email Address
                                                    </div>
                                                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txt_Email" ForeColor="Red" ErrorMessage="Invalid Email Format" Visible="True" ValidationGroup="g1"></asp:RegularExpressionValidator>
                                                </div>
                                                <div class="col-sm-2">
                                                    <asp:Label ID="Label4" runat="server" Text="Remark"></asp:Label>
                                                    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                                </div>
                                                <div class="col-sm-4">
                                                    <asp:TextBox CssClass="not-required" ID="txt_remark" Style="text-transform: capitalize;" runat="server" placeholder="Enter Remark"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- File Upload -->
                                        <div class="form-group">
                                            <div class="row align-items-center mb-3">
                                                <div class="col-12 col-sm-3">
                                                    <asp:Label ID="Label15" runat="server" Text="ID Proof"></asp:Label>
                                                    <asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                                </div>
                                                <div class="col-12 col-sm-9">
                                                    <asp:FileUpload rquired="required" ID="FileUpload1" runat="server" accept=".pdf, .jpg, .jpge" />
                                                    <div class="overflow-div">
                                                        <asp:Label ID="listofuploadedfiles" runat="server" />
                                                    </div>
                                                    <asp:Label ID="uploadphotopath" runat="server" Visible="false" />
                                                </div>
                                            </div>
                                        </div>

                                    </ContentTemplate>
                                    <Triggers>
                                        <%--<asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />--%>
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>

                            <div class="modal-footer">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-12 text-center">
                                            <asp:Button ID="btn_save" runat="server" OnClientClick="disableSaveButtonIfValid();" Text="Save" class="btn btn-primary" OnClick="btn_save_Click" ValidationGroup="g1" />
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


    </div>


    <div class="modal fade" id="fileModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>

                        <div class="modal-header">
                            <h5 class="modal-title">File Viewer</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!-- iframe for PDF/Image -->
                            <iframe id="iframeFile" runat="server" width="100%" height="500px" style="border: none;"></iframe>
                        </div>

                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="CardGridView" EventName="RowCommand" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
    <script src="js/site_master_js.js"></script>

    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>



        function showPdfModal(filePath) {
            console.log(filepa)
            var iframe = document.getElementById("pdfFrame");
            iframe.src = "Documents/ContactID/aniket/DefaultersReport (1).pdf"; // example: "~/Uploads/sample.pdf"

            var modal = new bootstrap.Modal(document.getElementById('pdfModal'));
            modal.show();
        }

        function initDropdownEvents() {

            const categoryBox = document.getElementById("<%= categoryBox.ClientID %>");

            const categorySuggestions = document.getElementById("categoryRepeaterContainer");

            categoryBox.addEventListener("focus", function () {

                categorySuggestions.style.display = "block";

                itemSuggestions.style.display = "none";

            });

            categoryBox.addEventListener("input", function () {

                const input = categoryBox.value.toLowerCase();

                filterSuggestions("category-link", input);

            });
            const TextBox1 = document.getElementById("<%= TextBox1.ClientID %>");

            const categorySuggestions1 = document.getElementById("categoryRepeaterContainer1");

            TextBox1.addEventListener("focus", function () {

                categorySuggestions1.style.display = "block";

                itemSuggestions.style.display = "none";

            });

            TextBox1.addEventListener("input", function () {

                const input = TextBox1.value.toLowerCase();

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


        function setCategoryBox(value) {

            document.getElementById("<%= categoryBox.ClientID %>").value = value;

            document.getElementById("categoryRepeaterContainer").style.display = "none";

        }
        function setCategoryBox1(value) {

            document.getElementById("<%= TextBox1.ClientID %>").value = value;

            document.getElementById("categoryRepeaterContainer").style.display = "none";

        }

        function openZoomCard(name, type, org, phone, email, address, remark) {
            const content = `
            <h4><strong>${name}</strong> <span style="color: gray;">- ${type}</span></h4>
            <hr />
            <p><strong>Org:</strong> ${org}</p>
            <p><strong>Phone:</strong> ${phone}</p>
            <p><strong>Email:</strong> ${email}</p>
            <p><strong>Address:</strong> ${address}</p>
            <p><strong>Remark:</strong> ${remark}</p>
        `;
            document.getElementById("zoomCardContent").innerHTML = content;
            document.getElementById("zoomOverlay").style.display = "flex";
        }

        function closeZoomCard() {
            document.getElementById("zoomOverlay").style.display = "none";
        }


        Sys.Application.add_load(initDropdownEvents);

        function showPopup() {
            document.getElementById("imagePopup").style.display = "block";
        }

        function closePopup() {
            document.getElementById("imagePopup").style.display = "none";
        }


    </script>

</asp:Content>



