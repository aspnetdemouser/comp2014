<%@ Page Title="" Language="C#" MasterPageFile="~/NotLoginMasterPage.master" AutoEventWireup="true"
    CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Login to site</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="gray_box login_gray_box">
        <div class="box_title">
            <h2>
                Welcome</h2>
        </div>
        <div class="box_cont">
            <h2>
                Please Log In</h2>
            <form id="login_form" name="login_form">
            <div align="center" runat="server" id="lblErr" visible="false" class="error_mess">
                You've entered wrong login (e-mail) or password. Please try again</div>
            <div align="center" class="form_err_message error_mess">
                <br/>
                <span class="form_email_error">Value entered for e-mail is invalid<br/>
                </span><span class="form_password_error">Passwords don't match !<br/>
                </span><span class="form_mandatory_error">Please fill up missing fields below</span>
            </div>
            <div class="form_block login_form">
                <div class="email">
                    <span>E-mail:<b class="madatorystar">*</b></span>
                    <asp:TextBox ID="txtEmail" runat="server" MaxLength="255" size="25" CssClass="mandatory email validateemail"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateEmail" ControlToValidate="txtEmail" runat="server"
                        ValidationGroup="login" Display="Dynamic" ErrorMessage="Email is required"></asp:RequiredFieldValidator>
                </div>
                <div class="pass">
                    <span>Password:<b class="madatorystar">*</b></span>
                    <asp:TextBox ID="txtPassword" TextMode="Password" MaxLength="255" size="25" CssClass="mandatory"
                        runat="server" OnTextChanged="txtPassword_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validateEmailPassword" ControlToValidate="txtPassword"
                        runat="server" ValidationGroup="login" Display="Dynamic" ErrorMessage="Password is required"></asp:RequiredFieldValidator>
                </div>
                <div class="button login">
                    <asp:Button ID="btnLogin" Text="Login to Account" runat="server" CssClass="but_login"
                        Style="align: absmiddle" OnClick="btnLogin_Click" />
                    <div class="text_sm">
                        <a href="#">Forgot your password?</a><br>
                        <em>Request a password reset</em>
                    </div>
                    <div class="spaser">
                    </div>
                </div>
                <input type="hidden" name="section" value="login">
                <input type="hidden" name="ac" value="login">
                <input type="hidden" name="destination" value="acc_bo">
                <input type="hidden" name="next_section" value="login">
                <input type="hidden" name="ACC_TPY" value="CUSTOMERS">
            </div>
            </form>
            <div class="spaser" style="height: 5px;">
            </div>
        </div>
    </div>
</asp:Content>
