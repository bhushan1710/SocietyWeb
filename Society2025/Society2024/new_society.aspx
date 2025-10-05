<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="new_society.aspx.cs" Inherits="Society2024.society1" MasterPageFile="~/Site.Master" %>

<asp:Content ID="content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
       
        function digit(evt) {
            if (evt.keyCode < 48 || evt.keyCode > 57) {

                return false;
            }
        }
        function openModal() {
            $('#edit_model').modal('show');
        }

        function checkLength(el) {

            if (el.value.length != 10) {

                alert("length must be exactly 10 digits")

                return false;
            }
        }

    </script>
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        function SuccessEntry() {
            Swal.fire({
                title: '✅ Success!',
                text: 'Society Created Successfully  You Can Now Login to your Society',
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
                    window.location.href = 'login1.aspx';
                }
            });
        }
    </script>
    <h2 class="bg-primary text-white">
        <center>New Society Registration</center>
    </h2>
    <hr />
    <div class="box box-primary">
        <div class="box-header with-border">
            <%-- <div class="box-header with-border">
              <h2 class="box-title"></h2>
            </div>--%>

            <div class="box-body">



                <%--                <h4 style="color: Navy">Purchase Entry</h4>--%>
                <asp:HiddenField ID="society_master_id" runat="server" />
                <asp:HiddenField ID="user_id" runat="server" />
                <asp:HiddenField ID="society_id" runat="server" />



                <asp:UpdatePanel ID="upnlCountry" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="form-group">
                            <div class="row ">
                                <div class="col-sm-3">
                                    <asp:Label ID="lbl_co_name" runat="server" Text=" Society Name"></asp:Label>
                                    <asp:Label ID="lbl_co_name_sep" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="lbl_co_name_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>

                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_name" CssClass="form-control" runat="server" placeholder="Enter Name" required autofocus Width="200px"></asp:TextBox>
                                    <div class="invalid-feedback">
                                        Please Enter Society Name
                                    </div>
                                    <br />

                                </div>


                                <div class="col-sm-3">

                                    <asp:Label ID="Label2" runat="server" Text="Establish Date"></asp:Label>
                                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_es_date" CssClass="form-control" TextMode="Date" runat="server" Width="200px" required></asp:TextBox>
                                    <div class="invalid-feedback">
                                        Please Enter Date
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row ">
                                <div class="col-sm-3">
                                    <asp:Label ID="Label5" runat="server" Text="Registration No"></asp:Label>
                                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_registration" CssClass="form-control" runat="server" Width="200px" AutoPostBack="true" placeholder="Enter Registration No" required Autofocus OnTextChanged="txt_registration_TextChanged"></asp:TextBox>
                                    <div class="invalid-feedback">
                                        Please Enter Registration No
                                    </div>
                                    <br />
                                    <asp:Label ID="Label22" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                </div>

                            </div>

                        </div>

                        <hr />

                        <h4>Contact Info</h4>

                        <div class="form-group">
                            <div class="row ">
                                <div class="col-sm-3">
                                    <asp:Label ID="Label8" runat="server" Text=" Office Address"></asp:Label>
                                    <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_off_address1" CssClass="form-control" runat="server" Width="200px" placeholder="Enter Address" required autofocus></asp:TextBox>
                                    <div class="invalid-feedback">
                                        Please Enter Adress
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <asp:Label ID="Label11" runat="server" Text="Alternate address"></asp:Label>
                                    <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_off_address2" CssClass="not-required" runat="server" Width="200px" placeholder="Enter Address" autofocus></asp:TextBox>
                                </div>

                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row ">
                                <div class="col-sm-3">
                                    <asp:Label ID="lbl_pre_mob" runat="server" Text="Contact No."></asp:Label>
                                    <asp:Label ID="lbl_pre_mob_sep" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="lbl_pre_mob_mandatory" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_contact_no1" CssClass="form-control" runat="server" MaxLength="10" Width="200px" ValidationGroup="g1" placeholder="Enter Contact No." TextMode="Phone" required></asp:TextBox>
                                    <div class="invalid-feedback">
                                        Please Enter Contact No
                                    </div>

                                    <br />

                                </div>

                                <div class="col-sm-3">
                                    <asp:Label ID="lbl_mob" runat="server" Text="E-mail ID"></asp:Label>
                                    <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Black" Text=":"></asp:Label>
                                    <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>

                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_email" CssClass="form-control" Width="200px" placeholder="Enter Email" runat="server" required TextMode="Email"></asp:TextBox>
                                    <div class="invalid-feedback">
                                        Please Enter Email
                                    </div>
                                    <br />
                                    <asp:RegularExpressionValidator ID="regexEmailValid" Height="32px" Width="200px" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txt_email" Font-Bold="True" ForeColor="red" ErrorMessage="Invalid Email Format" ValidationGroup="g1" Display="Dynamic"></asp:RegularExpressionValidator>

                                </div>
                            </div>
                        </div>
                        <hr />

                        <div class="form-group">
                            <div class="row ">
                             
                                <div class="col-sm-3">
                                    <asp:Label ID="Label17" runat="server" Text="State"></asp:Label>
                                    <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="Label31" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                </div>
                                <div class="col-sm-3">
                                    <asp:DropDownList CssClass="form-select" ID="ddl_state" Height="32px" Width="200px" OnSelectedIndexChanged="ddl_state_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                                    <div class="invalid-feedback">
                                        Please Select State
                                    </div>

                                </div>

                                <div class="col-sm-3">
                                    <asp:Label ID="Label37" runat="server" Text="District"></asp:Label>
                                    <asp:Label ID="Label38" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="Label39" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                    <%--<asp:Label ID="Label22" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>--%>
                                </div>
                                <div class="col-sm-3">
                                    <asp:DropDownList CssClass="form-select" ID="ddl_district" Height="32px" OnSelectedIndexChanged="ddl_district_SelectedIndexChanged" AutoPostBack="true" Width="200px" runat="server"></asp:DropDownList>
                                    <div class="invalid-feedback">
                                        Please Select District 
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row ">

                                
                                <div class="col-sm-3">
                                    <asp:Label ID="Label40" runat="server" Text="Division"></asp:Label>
                                    <asp:Label ID="Label41" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="Label42" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                    <%--<asp:Label ID="Label22" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>--%>
                                </div>
                                <div class="col-sm-3">
                                       <asp:DropDownList CssClass="form-select" ID="ddl_division" Height="32px"  Width="200px" runat="server"></asp:DropDownList>
                                    <div class="invalid-feedback">
                                        Please Select Division
                                    </div>

                                </div>

                                <div class="col-sm-3">
                                    <asp:Label ID="Label1" runat="server" Text="City"></asp:Label>
                                    <asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                  
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_city" CssClass="form-control" runat="server" Width="200px" MaxLength="10" placeholder="Enter City" required autofocus></asp:TextBox>
                                    <div class="invalid-feedback">
                                        Please Enter City
                                    </div>

                                </div>

                            </div>
                        </div>


                        <div class="form-group">
                            <div class="row ">
                                 <div class="col-sm-3">
                                    <asp:Label ID="Label34" runat="server" Text="Street/Home No"></asp:Label>
                                    <asp:Label ID="Label35" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="Label36" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                    <%--<asp:Label ID="Label22" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>--%>
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_street" CssClass="form-control" runat="server" Width="200px" MaxLength="10" placeholder="Enter Home No" required autofocus></asp:TextBox>
                                    <div class="invalid-feedback">
                                        Please Enter Street/Home No
                                    </div>

                                </div>

                                <div class="col-sm-3">
                                    <asp:Label ID="Label28" runat="server" Text="Pincode"></asp:Label>
                                    <asp:Label ID="Label29" runat="server" Font-Bold="True" Font-Size="Medium" Text=":"></asp:Label>
                                    <asp:Label ID="Label30" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" Text="*"></asp:Label>
                                </div>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txt_pincode" CssClass="form-control" runat="server" Width="200px" MaxLength="6" onkeypress="return digit(event);" placeholder="Enter Pin" required autofocus></asp:TextBox>
                                    <div class="invalid-feedback">
                                        Please Enter Pincode
                                    </div>
                                    <br />

                                    <asp:RegularExpressionValidator ID="regularExp" ControlToValidate="txt_pincode" runat="server" ValidationExpression="[0-9]{6}" ErrorMessage="Invalid Pin Code." Font-Bold="True" ForeColor="red" ValidationGroup="g1"></asp:RegularExpressionValidator>
                                </div>

                            </div>
                        </div>
                        </div>
            </div>
                    </ContentTemplate>
                </asp:UpdatePanel>


            </div>



            <div class="modal-footer">


                <div class="form-group">
                    <div class="row ">
                        <center>
                            <asp:Button ID="btn_save" runat="server" Text="Save" class="btn btn-primary" OnClick="btn_save_Click" ValidationGroup="g1" />
                            <asp:Button ID="btn_delete" runat="server" Text="Delete" class="btn btn-primary" Visible="false" OnClientClick="return confirm('Are you sure want to delete?');" OnClick="btn_delete_Click" />
                            <asp:Button ID="btn_close" runat="server" Text="Close" class="btn btn-primary" OnClick="btn_close_Click" UseSubmitBehavior="False" />
                        </center>
                    </div>
                </div>


            </div>
        </div>
        <!-- /.modal-body -->
    </div>
    <!-- /.modal-content -->
</asp:Content>
