<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="AddDisciplinaryAction.aspx.cs" Inherits="AddDisciplinaryAction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
    <script language="javascript" type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script language="javascript" type="text/javascript" src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script type="text/javascript" language="javascript">
        $(function () {

            $("#<%=txtDateOfAction.ClientID %>").datepicker();


        });
        $(function () {
            /*  submit button common */
            $(".submit_button_new").bind("click", function () {
                return validate_any_form();
            });
        }); //end ready

        /* start form validation general function */
        function validate_any_form() {
            var frm = $(".form_block"); //pass general div id which is container for all controls
            $(".form_block").find("IFRAME.mandatory_selected").contents().find("body").removeClass('mandatory_selected');
            $(".form_block").find("INPUT, SELECT, TEXTAREA, LABEL, IFRAME").removeClass('mandatory_selected');
            /* are you looking this...*/
            $(".form_block").find(".form_err_message").hide();

            var msg = '';
            $(".ddlEmpName").css("border-color", "#C6C6C6");
            $(".ddlEmpName").css("border-width", "1px");
            $(".txtInfraction").css("border-width", "1px");
            $(".txtInfraction").css("border-color", "#C6C6C6");
            $(".txtDateOfActionCSS").css("border-color", "#C6C6C6");
            $(".txtDateOfActionCSS").css("border-width", "1px");
            $(".txtDesc").css("border-color", "#C6C6C6");
            $(".txtDesc").css("border-width", "1px");


            var ddlValue = $(".ddlEmpName").val();

            if (ddlValue == "0") {
                if (msg == '') {
                    msg += 'Please fill up missing fields below';
                    $(".form_err_message SPAN.form_mandatory_error").show();
                }
                $(".ddlEmpName").css("border-color", "#FF0000");
                $(".ddlEmpName").css("border-width", "1px");
            }


            if (!$.trim($(".txtInfraction").val())) {
                // textarea is empty or contains only white-space
                if (msg == '') {
                    msg += 'Please fill up missing fields below';
                    $(".form_err_message SPAN.form_mandatory_error").show();
                }

                $(".txtInfraction").css("border-color", "#FF0000");
                $(".txtInfraction").css("border-width", "1px");
            }

            if (!$.trim($(".txtDateOfActionCSS").val())) {
                // textarea is empty or contains only white-space
                if (msg == '') {
                    msg += 'Please fill up missing fields below';
                    $(".form_err_message SPAN.form_mandatory_error").show();
                }
                $(".txtDateOfActionCSS").css("border-color", "#FF0000");
                $(".txtDateOfActionCSS").css("border-width", "1px");
            }

            if (!$.trim($(".txtDesc").val())) {
                if (msg == '') {
                    msg += 'Please fill up missing fields below';
                    $(".form_err_message SPAN.form_mandatory_error").show();
                }

                $(".txtDesc").css("border-color", "#FF0000");
                $(".txtDesc").css("border-width", "1px");
            }


            if (msg == '')
                return true;

            $(".mandatory_selected:first").focus();
            if (!$("DIV.form_err_message").length) {
                $(".form_block").prepend('<div class="form_err_message error_mesage" style="color: red;">' + msg + '</div>');
            }

            $("DIV.form_err_message").show();
            if ($(".form_err_message").html() == '')
                $(".form_err_message").html(msg);

            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content">
        <div class="gray_box facility_gray_box employee_box">
            <div class="box_title">
                <h2>
                    <asp:Literal ID="lblFacilityName" runat="server"></asp:Literal>
                </h2>
                <br />
                <div class="cats_articles">
                    <div class="facillity_info">
                        <div>
                            <asp:Literal ID="lblAddress1" runat="server"></asp:Literal><br />
                            <asp:Literal ID="lblCityStateZip" runat="server"></asp:Literal><br />
                            <asp:Literal ID="lblCountry" runat="server"></asp:Literal>
                        </div>
                        <div>
                            Tel:
                            <asp:Literal ID="lblPhone" runat="server"></asp:Literal>
                            <br />
                            Fax:
                            <asp:Literal ID="lblFax" runat="server"></asp:Literal></div>
                        <div>
                            <a href="#"></a>
                        </div>
                    </div>
                    <div class="spaser" style="height: 1px;">
                        &nbsp;</div>
                </div>
            </div>
            <span style="padding-left: 0px; padding-top: 0px; font-size: 25px;">
                <asp:Literal ID="lblInfo1" runat="server">Add Disciplinary Action</asp:Literal>
            </span>
            <br />
            <div class="box_cont form_block">
                <div class="delim">
                </div>
                <div align="center" class="form_err_message error_mess">
                    <span></span><span class="form_mandatory_error" style="width: auto;">Please fill up
                        missing fields below</span>
                </div>
                <div>
                    <span></span>
                    <asp:Label ID="lbltxt" runat="server" CssClass="error_mess" Style="width: 300px;"></asp:Label>
                </div>
                <div class="form_block">
                    <div>
                        <span>Employee Name:</span>
                        <asp:DropDownList ID="ddlEmpName" runat="server" CssClass="ddlEmpName mandatory"
                            size="1" Style="width: 345px;">
                        </asp:DropDownList>
                    </div>
                    <div>
                        <span>Infraction <b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtInfraction" runat="server" TextMode="MultiLine" Rows="2" Columns="40"
                            MaxLength="200" autocomplete="off" CssClass="mandatory txtInfraction"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="req1" runat="server" ControlToValidate="txtInfraction"
                            ValidationGroup="grpValidation"></asp:RequiredFieldValidator>
                    </div>
                    <div class="spaser" style="height: 15px;">
                    </div>
                    <div>
                        <span>Date of action<b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtDateOfAction" runat="server" size="15" autocomplete="off" CssClass="txtDateOfActionCSS mandatory"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="req2" ValidationGroup="grpValidation" runat="server"
                            ErrorMessage="" ControlToValidate="txtDateOfAction"></asp:RequiredFieldValidator>
                    </div>
                    <div class="spaser" style="height: 15px;">
                    </div>
                    <div>
                        <span>Description <b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" Rows="6" Columns="40"
                            MaxLength="500" autocomplete="off" CssClass="txtDesc mandatory"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="req3" ValidationGroup="grpValidation" runat="server"
                            ErrorMessage="" ControlToValidate="txtDateOfAction"></asp:RequiredFieldValidator>
                    </div>
                    <div class="spaser">
                    </div>
                    <div class="spaser" style="height: 25px;">
                    </div>
                    <center>
                        <asp:Button runat="server" ID="btnAddAction" Text="Submit" CssClass="submit_button_new"
                            Style="font-size: 15px; padding: 2px 15px; margin-left: 200px;" OnClick="btnAddAction_Click" />
                        <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="cancel_new" Style="font-size: 15px;
                            padding: 2px 15px; margin-left: 30px;" onclick="btnCancel_Click" />
                    </center>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
