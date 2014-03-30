<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="employeeprofile.aspx.cs" Inherits="employeeprofile" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
    <script language="javascript" type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script language="javascript" type="text/javascript" src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script type="text/javascript" language="javascript">
        $(function () {
            $("#<%= txtDATEHIRE.ClientID %>").datepicker();
            $("#<%= txtLicenceExp.ClientID %>").datepicker();
            $("#<%= txtEXCLUSSION.ClientID %>").datepicker();

        });
        $(function () {
            /*  submit button common */
            $(".submit_button_new").bind("click", function () {
                return validate_any_form();
            });

        });

        /* start form validation general function */
        function validate_any_form() {
            var frm = $(".profile"); //pass general div id which is container for all controls
            $(".profile").find("IFRAME.mandatory_selected").contents().find("body").removeClass('mandatory_selected');
            $(".profile").find("INPUT, SELECT, TEXTAREA, LABEL, IFRAME").removeClass('mandatory_selected');

            $(".profile").find(".form_err_message").hide();

            $("INPUT[name='FORM_VALIDATOR']").addClass('mandatory');

            var msg = '';


            /*check email by css */
            if ($(".validateemail").length) {
                email_filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                $(".validateemail").each(function () {
                    if (($(this).val() != '') && !email_filter.test($(this).val())) {
                        $(this).addClass('mandatory_selected');
                        if (msg == '')
                            msg = 'Entered e-mail is wrong';
                    }
                });
            }


            $(".profile").find(".form_err_message SPAN.form_email_error").hide();
            if (msg != '') {
                $(".form_email_error").show();
            }


            $(".profile").find(".form_password_error").hide();
            $(".profile").find(".form_mandatory_error").hide();


            if ($(".PASSWORD1").length && $(".PASSWORD2").length && ($(".PASSWORD1").val() != $(".PASSWORD2").val())) {

                $(".profile").find(".PASSWORD1").addClass('mandatory_selected');
                $(".profile").find(".PASSWORD2").addClass('mandatory_selected');
                //$(".profile").find("DIV.form_err_message SPAN.form_password_error").show();
                $(".profile").find(".form_password_error").show();
                if (msg) msg += '<br>';
                msg += 'Passwords do not match, please try again...!';
            }



            if ($(".mandatory").not('[value!=""]').length) {
                if (msg) msg += '<br>';
                msg += 'Please fill up missing fields below';
                $(".form_err_message SPAN.form_mandatory_error").show();
            }



            if (msg == '')
                return true;
            $(".mandatory").not('[value!=""]').addClass('mandatory_selected');
            $(".mandatory_selected:first").focus();
            if (!$("DIV.form_err_message").length) {
                $(".profile").prepend('<div class="form_err_message error_mesage" style="color: red;">' + msg + '</div>');
            }

            $("DIV.form_err_message").show();
            if ($(".form_err_message").html() == '')
                $(".form_err_message").html(msg);

            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="gray_box profile_gray_box profile_gray_box_officers">
        <div class="box_title" id="divAddNewEmployeeTitle" runat="server">
            <h2>
                Add Employee Profile</h2>
        </div>
        <div class="box_title" id="divOfficerInfo" runat="server">
            <h2>
                <asp:Label ID="lblProfile" runat="server"></asp:Label>
                <asp:Literal ID="lblCurrentOfficerName" runat="server"></asp:Literal>
            </h2>
            <br>
            <div class="form_block carrent_acc">
                <div class="title" align="center">
                    Current profile:</div>
                <div class="auto">
                    <span><strong>Full name:</strong></span> <span class="text">
                        <asp:Literal ID="lblCurrentFullName" runat="server"></asp:Literal>
                    </span>
                    <div class="spaser">
                    </div>
                </div>
                <div class="auto">
                    <span><strong>Address:</strong></span> <span class="text">
                        <asp:Literal ID="lblCurrentAddress" runat="server"></asp:Literal>
                        <br />
                        <asp:Literal ID="lblCurrentStateCity" runat="server"></asp:Literal><br />
                        <asp:Literal ID="lblCurrentZip" runat="server"></asp:Literal>
                    </span>
                    <div class="spaser">
                    </div>
                </div>
                <div>
                    <span><strong>Email:</strong></span> <span class="text long"><a>
                        <asp:Literal ID="lblCurrentEmail" runat="server"></asp:Literal></a></span>
                </div>
                <div>
                    <span><strong>Job Title:</strong></span> <span class="text">
                        <asp:Literal ID="lblCurrentPosition" runat="server"></asp:Literal></span>
                </div>
                <div>
                    <span><strong>Tel:</strong></span> <span class="text">
                        <asp:Literal ID="lblCurrentPhone" runat="server"></asp:Literal></span>
                </div>
                <div>
                    <span><strong>Fax:</strong></span> <span class="text">
                        <asp:Literal ID="lblCurrentFax" runat="server"></asp:Literal></span>
                </div>
                <div class="spaser">
                </div>
            </div>
        </div>
        <div class="box_cont">
            <div class="profile">
                <%--<form id="profile_form" name="profile_form" action="#">--%>
                <div align="center" class="form_err_message error_mess">
                    <br />
                    <span class="form_email_error">Value entered for e-mail is invalid<br />
                    </span><span class="form_password_error" style="font-size: large; color: #ff0000">Passwords don't match!<br />
                    </span><span class="form_mandatory_error">Please fill up missing fields below</span>
                </div>
                <br />
                <div class="form_block Sign_In_Information Sign_In_Information_acc">
                    <div class="title" style="text-align:left;margin-left: 57px;">1. Sign In Information</div>
                    <div>
                        <span>E-mail:<b class="madatorystar">*</b></span>
                        <asp:TextBox ID="txtemailaddress" name="txtemailaddress" runat="server" autocomplete="off"
                            MaxLength="250" CssClass="mandatory email validateemail" size="30"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="req1" ValidationGroup="emploeeprofile" runat="server"
                            Display="None" ErrorMessage="" ControlToValidate="txtemailaddress"></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <span>Password:<b class="madatorystar">*</b></span>
                        <asp:TextBox ID="txtpassword" TextMode="Password" runat="server" size="30" MaxLength="50"
                            autocomplete="off" CssClass="PASSWORD1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="emploeeprofile"
                            runat="server" Display="None" ErrorMessage="" ControlToValidate="txtpassword"></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <span>Confirm Password:<b class="madatorystar">*</b></span>
                        <asp:TextBox ID="txtconfpassword" TextMode="Password" runat="server" size="30" MaxLength="50"
                            autocomplete="off" CssClass="PASSWORD2"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="emploeeprofile"
                            runat="server" Display="None" ErrorMessage="" ControlToValidate="txtconfpassword"></asp:RequiredFieldValidator>
                    </div>
                    <br>
                    <br>
                    <div class="title" style="text-align: left; margin-left: 57px;">2. Additional Information</div>
                    <div>
                        <span>Job Title<b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtposition" runat="server" size="30" MaxLength="200" autocomplete="off"
                            CssClass="mandatory"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="emploeeprofile"
                            runat="server" ErrorMessage="" ControlToValidate="txtposition"></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <span>Employee Type:</span>
                        <asp:TextBox ID="txtEmployeeType" runat="server" size="30" MaxLength="200" autocomplete="off"
                            CssClass="mandatory"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="reqEmployeeType" ValidationGroup="emploeeprofile"
                            runat="server" ErrorMessage="" ControlToValidate="txtEmployeeType"></asp:RequiredFieldValidator>--%>
                    </div>
                    <div>
                        <span>Date of Hire<b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtDATEHIRE" runat="server" size="15" autocomplete="off" CssClass="mandatory"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="emploeeprofile"
                            runat="server" ErrorMessage="" ControlToValidate="txtDATEHIRE"></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <span>License #<b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtLicenceNo" runat="server" MaxLength="200" autocomplete="off"
                            size="30" CssClass="mandatory"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="emploeeprofile"
                            runat="server" ErrorMessage="" ControlToValidate="txtLicenceNo"></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <span>License Exp.<b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtLicenceExp" runat="server" size="15"  autocomplete="off" CssClass="mandatory"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="emploeeprofile"
                            runat="server" ErrorMessage="" ControlToValidate="txtLicenceExp"></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <span>Date of Last Exclusion Check<b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtEXCLUSSION" runat="server" size="15"  autocomplete="off" CssClass="mandatory"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="emploeeprofile"
                            runat="server" ErrorMessage="" ControlToValidate="txtEXCLUSSION"></asp:RequiredFieldValidator>
                    </div>
                    <div class="spaser" style="height: 25px;">
                    </div>
                    <div class="spaser" style="height: 1px;">
                    </div>
                </div>
                <div class="form_block Personal_Information Personal_Information_acc">
                   <div class="title" style="text-align: left; margin-left: 7px;">3. Contact Information</div>
                    <div>
                        <span>First Name<b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtFNAME" runat="server" size="30" MaxLength="50" autocomplete="off"
                            CssClass="mandatory"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="emploeeprofile"
                            runat="server" ErrorMessage="" ControlToValidate="txtFNAME"></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <span>Last Name<b class="madatorystar">*</b>:</span>
                        <asp:TextBox ID="txtLNAME" runat="server" size="30" MaxLength="50" autocomplete="off"
                            CssClass="mandatory"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="emploeeprofile"
                            runat="server" ErrorMessage="" ControlToValidate="txtLNAME"></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <span>Address Line 1:</span>
                        <asp:TextBox ID="txtADDR1" runat="server" size="30" MaxLength="200" autocomplete="off"
                            CssClass="_picker"></asp:TextBox>
                    </div>
                    <div>
                        <span>Address Line 2:</span>
                        <asp:TextBox ID="txtADDR2" runat="server" size="30" MaxLength="200" autocomplete="off"
                            CssClass="_picker"></asp:TextBox>
                    </div>
                    <div>
                        <span>City:</span>
                        <asp:TextBox ID="txtCITY" runat="server" size="30" MaxLength="50" autocomplete="off"
                            CssClass="_picker"></asp:TextBox>
                    </div>
                    <div>
                        <span>State/Province:</span>
                        <asp:DropDownList ID="ddlState" runat="server" CssClass="mandatory" size="1" Style="width: 100px;">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Value="AL">AL</asp:ListItem>
                            <asp:ListItem Value="AK">AK</asp:ListItem>
                            <asp:ListItem Value="AZ">AZ</asp:ListItem>
                            <asp:ListItem Value="AR">AR</asp:ListItem>
                            <asp:ListItem Value="CA">CA</asp:ListItem>
                            <asp:ListItem Value="CO">CO</asp:ListItem>
                            <asp:ListItem Value="CT">CT</asp:ListItem>
                            <asp:ListItem Value="DE">DE</asp:ListItem>
                            <asp:ListItem Value="DC">DC</asp:ListItem>
                            <asp:ListItem Value="FL">FL</asp:ListItem>
                            <asp:ListItem Value="GA">GA</asp:ListItem>
                            <asp:ListItem Value="HI">HI</asp:ListItem>
                            <asp:ListItem Value="ID">ID</asp:ListItem>
                            <asp:ListItem Value="IL">IL</asp:ListItem>
                            <asp:ListItem Value="IN">IN</asp:ListItem>
                            <asp:ListItem Value="IA">IA</asp:ListItem>
                            <asp:ListItem Value="KS">KS</asp:ListItem>
                            <asp:ListItem Value="KY">KY</asp:ListItem>
                            <asp:ListItem Value="LA">LA</asp:ListItem>
                            <asp:ListItem Value="ME">ME</asp:ListItem>
                            <asp:ListItem Value="MD">MD</asp:ListItem>
                            <asp:ListItem Value="MA">MA</asp:ListItem>
                            <asp:ListItem Value="MI">MI</asp:ListItem>
                            <asp:ListItem Value="MN">MN</asp:ListItem>
                            <asp:ListItem Value="MS">MS</asp:ListItem>
                            <asp:ListItem Value="MO">MO</asp:ListItem>
                            <asp:ListItem Value="MT">MT</asp:ListItem>
                            <asp:ListItem Value="NE">NE</asp:ListItem>
                            <asp:ListItem Value="NV">NV</asp:ListItem>
                            <asp:ListItem Value="NH">NH</asp:ListItem>
                            <asp:ListItem Value="NJ">NJ</asp:ListItem>
                            <asp:ListItem Value="NM">NM</asp:ListItem>
                            <asp:ListItem Value="NY">NY</asp:ListItem>
                            <asp:ListItem Value="NC">NC</asp:ListItem>
                            <asp:ListItem Value="ND">ND</asp:ListItem>
                            <asp:ListItem Value="OH">OH</asp:ListItem>
                            <asp:ListItem Value="OK">OK</asp:ListItem>
                            <asp:ListItem Value="OR">OR</asp:ListItem>
                            <asp:ListItem Value="PA">PA</asp:ListItem>
                            <asp:ListItem Value="RI">RI</asp:ListItem>
                            <asp:ListItem Value="SC">SC</asp:ListItem>
                            <asp:ListItem Value="SD">SD</asp:ListItem>
                            <asp:ListItem Value="TN">TN</asp:ListItem>
                            <asp:ListItem Value="TX">TX</asp:ListItem>
                            <asp:ListItem Value="UT">UT</asp:ListItem>
                            <asp:ListItem Value="VT">VT</asp:ListItem>
                            <asp:ListItem Value="VI">VI</asp:ListItem>
                            <asp:ListItem Value="VA">VA</asp:ListItem>
                            <asp:ListItem Value="WA">WA</asp:ListItem>
                            <asp:ListItem Value="WV">WV</asp:ListItem>
                            <asp:ListItem Value="WI">WI</asp:ListItem>
                            <asp:ListItem Value="WY">WY</asp:ListItem>
                            <asp:ListItem Value="AE">AE</asp:ListItem>
                            <asp:ListItem Value="AP">AP</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div>
                        <span>Zip Code:</span>
                        <asp:TextBox ID="txtZIPCODE" runat="server" size="4" MaxLength="10" autocomplete="off"
                            CssClass="_picker"></asp:TextBox>
                    </div>
                    <div>
                        <span>Telephone:</span>
                        <asp:TextBox ID="txtPHONE" runat="server" size="30" MaxLength="50" autocomplete="off"
                            CssClass="_picker"></asp:TextBox>
                    </div>
                    <div>
                        <span>Fax:</span>
                        <asp:TextBox ID="txtFAX" runat="server" size="30" MaxLength="50" autocomplete="off"
                            CssClass="_picker"></asp:TextBox>
                    </div>
                    <div style="text-align: left;">
                        <span>Active :
                            <asp:Label runat="server" ID="lblActive" Style="margin-top: 0px; margin-left: 7px;"></asp:Label></span>
                        <asp:CheckBox runat="server" ID="chkActive" Style="margin-top: 3px;" Checked="true" />
                    </div>
                    <div class="spaser">
                    </div>
                    <div class="spaser" style="height: 25px;">
                    </div>
                    <center>
                        <asp:Button runat="server" ID="btnEmpCreatInformation" Text="Create Profile" CssClass="submit_button_new"
                            Style="font-size: 15px; padding: 2px 15px;" OnClick="btnEmpCreatInformation_Click" />
                        <asp:Button runat="server" ID="btnEmpUpdateInformation" Text="Update Profile" CssClass="submit_button_new"
                            Style="font-size: 15px; padding: 2px 15px;" OnClick="btnEmpUpdateInformation_Click" />
                        <asp:Label ID="lblErr" runat="server" Font-Bold="true" ForeColor="Red" Font-Size="Medium"></asp:Label>
                    </center>
                </div>
                <div class="spaser">
                </div>
                <%--</form>--%>
                <!-- form profile end -->
            </div>
            <script type="text/javascript" language="javascript">
                function on_custom_jquery_init() {
                    $('.close').click(function () {
                        $('#CORRECTION_ACTION_FORM').adialog('close');
                    });


                    /*$('.open_compliance_dialog').click(function (){
                    var rep_id = $(this).attr('rel');
                    $.get('?ac=get_report&rep_id='+rep_id, function(data){
                    $('#scroll-dd-window').html(data);
                    $('#message_text').adialog('open');		
                    });
                    return false;
                    });*/


                    $('.corrective_action_opener').click(function () {
                        $('.stage_check').click(function () {
                            var tmp_check_id = $(this).attr('ID');
                            if ($(this).attr('checked')) {
                                $('.' + tmp_check_id).removeClass('pasive');
                                $('.' + tmp_check_id).find('INPUT').each(function () {
                                    if ($(this).hasClass('stage_check'))
                                        return;
                                    $(this).attr('disabled', false);
                                    $(this).attr('readonly', false);
                                });

                                return;
                            }
                            $('.' + tmp_check_id).addClass('pasive');
                            $('.' + tmp_check_id).find('INPUT').each(function () {
                                if ($(this).hasClass('stage_check'))
                                    return;
                                $(this).attr('disabled', true);
                                $(this).attr('readonly', true);
                            });
                        });
                        var tmp_id = $(this).attr('ID');

                        $('#CORRECTION_ACTION_FORM_TITLE').html('<b> Correction action for ' + $('#anonse' + tmp_id + ' A').text() + '</b>');
                        $('#CORRECTION_ACTION_FORM_SUBJ').val('RE: Compliance report...');
                        $('#CORRECTION_ACTION_FORM_REFID').val(tmp_id);
                        /*if(!$('.default_selector INPUT:checked').length){
                        alert('Please select at least one message to reply');
                        return false;
                        }
                        var mid = $($('.default_selector INPUT:checked').get(0)).val();
                        $('INPUT#SUBJECT').val('RE: '+$('#SUBJECT_'+mid).text());
                        $('SELECT#TYPE').val($.trim($('#TYPE_'+mid).attr('TYPE')));
                        $('TEXTAREA#MESSAGE').val($.trim($('#MESSAGE_CONTENT_'+mid).text()));
                        $('#PARAMS_PUBLIC').val(1);
                        selectd2message();*/
                        $('#CORRECTION_ACTION_FORM').adialog('open');

                        return false;
                    });

                }
            </script>
            <div class="mess_text" style="position: absolute; z-index: 10000; left: 466px; top: 83px;
                display: none;" id="message_text">
                <div class="close">
                    <a href="" class="jsLink" onclick="$(&#39;#message_text&#39;).adialog(&#39;close&#39;);">
                    </a>
                </div>
                <div class="jScrollPaneContainer" style="height: 304px; width: 500px;">
                    <div id="scroll-dd-window" class="text" style="height: 304px; width: 500px; padding: 0px 10px 0px 0px;
                        top: 0px;">
                    </div>
                </div>
            </div>
            <div id="CORRECTION_ACTION_FORM" class="report_close_dd" style="display: none">
                <span>
                    <div>
                        <a class="jsLink close" href=""></a>
                    </div>
                    <div>
                        <ul>
                            <li class="title" id="CORRECTION_ACTION_FORM_TITLE"><strong></strong></li>
                            <li class="subjname">Subject:</li>
                            <li class="subj">
                                <input type="text" name="DATA[SUBJECT]" id="CORRECTION_ACTION_FORM_SUBJ" size="10"
                                    maxlength="255" value="" dir="ltr" class="_picker"></li>
                            <li class="spaser"></li>
                            <li class="datetext">Dadeline:</li>
                            <li class="month">
                                <select id="COMPLETEDDAYTE_MONTH" name="DATA[COMPLETEDDAYTE_MONTH]" size="1" align="absmiddle"
                                    placeholder="Month" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select></li>
                            <li class="day">
                                <select id="COMPLETEDDAYTE_DAY" name="DATA[COMPLETEDDAYTE_DAY]" size="1" align="absmiddle"
                                    placeholder="Day" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                </select></li>
                            <li class="year">
                                <select id="COMPLETEDDAYTE_YEAR" name="DATA[COMPLETEDDAYTE_YEAR]" size="1" align="absmiddle"
                                    placeholder="Year" class="_picker">
                                    <option value="2012">2012</option>
                                    <option value="2013">2013</option>
                                    <option value="2014">2014</option>
                                </select></li>
                            <li class="spaser"></li>
                            <li class="perstext">Responsible Person:</li>
                            <li class="person">
                                <input type="text" name="DATA[COMPLETED_BY]" id="COMPLETED_BY" size="10" maxlength="255"
                                    value="" dir="ltr" class="_picker"></li>
                            <li class="spaser"></li>
                            <li class="stagetext">Stages:</li>
                            <li class="stage ST1">
                                <input type="hidden" name="DATA[ST1]" value="0"><input type="checkbox" id="ST1" name="DATA[ST1]"
                                    value="1" checked="" class="stage_check"><label for="ST1"></label></li>
                            <li class="stagename ST1">
                                <input type="text" name="DATA[STNAME1]" id="STNAME1" size="10" maxlength="255" value=""
                                    dir="ltr" align="absmiddle" placeholder="Stage1 name" class="_picker"></li>
                            <li class="month ST1">
                                <select id="COMPLETEDDAYTE_MONTH1" name="DATA[COMPLETEDDAYTE_MONTH1]" size="1" align="absmiddle"
                                    placeholder="Month" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select></li>
                            <li class="day ST1">
                                <select id="COMPLETEDDAYTE_DAY1" name="DATA[COMPLETEDDAYTE_DAY1]" size="1" align="absmiddle"
                                    placeholder="Day" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                </select></li>
                            <li class="year ST1">
                                <select id="COMPLETEDDAYTE_YEAR1" name="DATA[COMPLETEDDAYTE_YEAR1]" size="1" align="absmiddle"
                                    placeholder="Year" class="_picker">
                                    <option value="2012">2012</option>
                                    <option value="2013">2013</option>
                                    <option value="2014">2014</option>
                                </select></li>
                            <li class="spaser"></li>
                            <li class="stage pasive ST2">
                                <input type="hidden" name="DATA[ST2]" value="0"><input type="checkbox" id="ST2" name="DATA[ST2]"
                                    value="1" class="stage_check"><label for="ST2"></label></li>
                            <li class="stagename pasive ST2">
                                <input type="text" name="DATA[STNAME2]" id="STNAME2" size="10" maxlength="255" value=""
                                    dir="ltr" align="absmiddle" readonly="1" placeholder="Stage 2 name" class="_picker"></li>
                            <li class="month pasive ST2">
                                <select id="COMPLETEDDAYTE_MONTH2" name="DATA[COMPLETEDDAYTE_MONTH2]" size="1" align="absmiddle"
                                    placeholder="Month" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select></li>
                            <li class="day pasive ST2">
                                <select id="COMPLETEDDAYTE_DAY2" name="DATA[COMPLETEDDAYTE_DAY2]" size="1" align="absmiddle"
                                    placeholder="Day" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                </select></li>
                            <li class="year pasive ST2">
                                <select id="COMPLETEDDAYTE_YEAR2" name="DATA[COMPLETEDDAYTE_YEAR2]" size="1" align="absmiddle"
                                    placeholder="Year" class="_picker">
                                    <option value="2012">2012</option>
                                    <option value="2013">2013</option>
                                    <option value="2014">2014</option>
                                </select></li>
                            <li class="spaser"></li>
                            <li class="stage pasive ST3">
                                <input type="hidden" name="DATA[ST3]" value="0"><input type="checkbox" id="ST3" name="DATA[ST3]"
                                    value="1" class="stage_check"><label for="ST3"></label></li>
                            <li class="stagename pasive ST3">
                                <input type="text" name="DATA[STNAME3]" id="STNAME3" size="10" maxlength="255" value=""
                                    dir="ltr" align="absmiddle" readonly="1" placeholder="Stage 3 name" class="_picker"></li>
                            <li class="month pasive  ST3">
                                <select id="COMPLETEDDAYTE_MONTH3" name="DATA[COMPLETEDDAYTE_MONTH3]" size="1" align="absmiddle"
                                    placeholder="Month" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select></li>
                            <li class="day pasive  ST3">
                                <select id="COMPLETEDDAYTE_DAY3" name="DATA[COMPLETEDDAYTE_DAY3]" size="1" align="absmiddle"
                                    placeholder="Day" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                </select></li>
                            <li class="year pasive  ST3">
                                <select id="COMPLETEDDAYTE_YEAR3" name="DATA[COMPLETEDDAYTE_YEAR3]" size="1" align="absmiddle"
                                    placeholder="Year" class="_picker">
                                    <option value="2012">2012</option>
                                    <option value="2013">2013</option>
                                    <option value="2014">2014</option>
                                </select></li>
                            <li class="spaser"></li>
                            <li class="stage pasive  ST4">
                                <input type="hidden" name="DATA[ST4]" value="0"><input type="checkbox" id="ST4" name="DATA[ST4]"
                                    value="1" class="stage_check"><label for="ST4"></label></li>
                            <li class="stagename pasive  ST4">
                                <input type="text" name="DATA[STNAME4]" id="STNAME4" size="10" maxlength="255" value=""
                                    dir="ltr" align="absmiddle" readonly="1" placeholder="Stage 4 name" class="_picker"></li>
                            <li class="month pasive  ST4">
                                <select id="COMPLETEDDAYTE_MONTH4" name="DATA[COMPLETEDDAYTE_MONTH4]" size="1" align="absmiddle"
                                    placeholder="Month" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select></li>
                            <li class="day pasive  ST4">
                                <select id="COMPLETEDDAYTE_DAY4" name="DATA[COMPLETEDDAYTE_DAY4]" size="1" align="absmiddle"
                                    placeholder="Day" class="_picker">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                </select></li>
                            <li class="year pasive  ST4">
                                <select id="COMPLETEDDAYTE_YEAR4" name="DATA[COMPLETEDDAYTE_YEAR4]" size="1" align="absmiddle"
                                    placeholder="Year" class="_picker">
                                    <option value="2012">2012</option>
                                    <option value="2013">2013</option>
                                    <option value="2014">2014</option>
                                </select></li>
                            <li class="spaser" style="height: 10px;"></li>
                            <li class="stagetext">Description:</li>
                            <li class="memo">
                                <textarea cols="15" rows="5" id="DESCRIPTION" name="DATA[DESCRIPTION]" style="width: 99%;"
                                    class="_picker"> </textarea>
                            </li>
                            <li>
                                <input type="submit" value="Submit" name="submit"></li>
                        </ul>
                    </div>
                    <input type="hidden" name="DATA[REF_ID]" value="" id="CORRECTION_ACTION_FORM_REFID">
                    <input type="hidden" name="section" value="tracking">
                    <input type="hidden" name="ac" value="insert_correction_action">
                    <input type="hidden" value="emploee_profile_officer" name="next_section">
                    <input type="hidden" value="default" name="next_action">
                    <input type="hidden" name="params[ed_id]" value="1">
                </span>
            </div>
            <div class="notes_officers" style="display: none">
                <div class="title" align="center">
                    Notifications</div>
                <div class="next-prev-vert">
                    <span class="prev"><a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#">
                    </a></span><span class="next"><a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#">
                    </a></span>
                </div>
                <div class="jScrollPaneContainer" style="height: 710px; width: 414px;">
                    <ul class="reqests" style="height: auto; overflow: visible; padding-right: 0px; width: 404px;
                        position: absolute; top: 0px;">
                        <li class="blue inbox color_report ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                156 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=159&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="close">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="jsLink corrective_action_opener" itemtag="" id="159"></a>
                                            </div>
                                            <div class="anonse" id="anonse159">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="open_compliance_dialog" rel="102">Compliance Report <span>recevied 10/08/2013</span></a></div>
                                            <!-- report -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_question ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                398 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=158&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse158">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=inbox">Compiance question
                                                    (Delete Emails) <span>recevied 02/08/2013</span></a></div>
                                            <!-- question -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_question ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                512 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=152&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse152">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=inbox">Compiance question
                                                    (Question on IC - 06 - Cultures) <span>recevied 10/17/2012</span></a></div>
                                            <!-- question -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_report ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                512 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=151&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="close">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="jsLink corrective_action_opener" itemtag="" id="151"></a>
                                            </div>
                                            <div class="anonse" id="anonse151">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="open_compliance_dialog" rel="98">Compliance Report <span>recevied 10/17/2012</span></a></div>
                                            <!-- report -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_report ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                545 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=149&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="close">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="jsLink corrective_action_opener" itemtag="" id="149"></a>
                                            </div>
                                            <div class="anonse" id="anonse149">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="open_compliance_dialog" rel="96">Compliance Report <span>recevied 09/14/2012</span></a></div>
                                            <!-- report -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_course ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                545 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=148&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse148">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=training&ac=coursebyid&course_id=2"
                                                    target="_blank">Course 'Med Compliance Advances ' assigned to General AAA <span>recevied
                                                        09/14/2012</span></a></div>
                                            <!-- course -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_question ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                546 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=145&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse145">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=inbox">Compiance question
                                                    (lev question 9/10 about this report ) <span>recevied 09/13/2012</span></a></div>
                                            <!-- question -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_course ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                546 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=144&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse144">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=training&ac=coursebyid&course_id=4"
                                                    target="_blank">Course 'Med Compliance' assigned to General AAA <span>recevied 09/13/2012</span></a></div>
                                            <!-- course -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_course ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                546 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=141&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse141">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=training&ac=coursebyid&course_id=10"
                                                    target="_blank">Course 'How to talk to a patient (advanced)' assigned to General
                                                    AAA <span>recevied 09/13/2012</span></a></div>
                                            <!-- course -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_course ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                546 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=135&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse135">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=training&ac=coursebyid&course_id=6"
                                                    target="_blank">Course 'Compliance Nursing' assigned to General AAA <span>recevied 09/13/2012</span></a></div>
                                            <!-- course -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_course ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                546 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=131&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse131">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=training&ac=coursebyid&course_id=5"
                                                    target="_blank">Course 'Compliance Operational' assigned to General AAA <span>recevied
                                                        09/13/2012</span></a></div>
                                            <!-- course -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_report ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                547 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=104&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="close">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="jsLink corrective_action_opener" itemtag="" id="104"></a>
                                            </div>
                                            <div class="anonse" id="anonse104">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="open_compliance_dialog" rel="90">Compliance Report <span>recevied 09/12/2012</span></a></div>
                                            <!-- report -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_report ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                547 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=103&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="close">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="jsLink corrective_action_opener" itemtag="" id="103"></a>
                                            </div>
                                            <div class="anonse" id="anonse103">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="open_compliance_dialog" rel="89">Compliance Report <span>recevied 09/12/2012</span></a></div>
                                            <!-- report -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_report ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                548 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=102&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="close">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="jsLink corrective_action_opener" itemtag="" id="102"></a>
                                            </div>
                                            <div class="anonse" id="anonse102">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="open_compliance_dialog" rel="88">Compliance Report <span>recevied 09/11/2012</span></a></div>
                                            <!-- report -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_report ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                548 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=101&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="close">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="jsLink corrective_action_opener" itemtag="" id="101"></a>
                                            </div>
                                            <div class="anonse" id="anonse101">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=emploee_profile_officer&params[ed_id]=1#"
                                                    class="open_compliance_dialog" rel="87">Compliance Report <span>recevied 09/11/2012</span></a></div>
                                            <!-- report -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_question ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                548 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=100&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse100">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=inbox">Compiance question
                                                    (Question on IC - 06 - Cultures) <span>recevied 09/11/2012</span></a></div>
                                            <!-- question -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                        <li class="blue inbox color_question ">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td width="5%">
                                            <div class="date">
                                                553 days ago
                                            </div>
                                        </td>
                                        <td width="95%">
                                            <div class="delete">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=profile&ac=hidenotification&ID=99&next_section=profile">
                                                </a>
                                            </div>
                                            <div class="anonse" id="anonse99">
                                                <a href="http://compliance.dev.webstores.net/acc_bo/?section=inbox">Compiance question
                                                    (Question on IC - 06 - Cultures) <span>recevied 09/06/2012</span></a></div>
                                            <!-- question -->
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="spaser">
                            </div>
                        </li>
                    </ul>
                    <div class="jScrollPaneTrack" style="width: 0px; height: 686px; top: 12px; display: none;">
                        <div class="jScrollPaneDrag" style="width: 0px; height: 1px; top: 0px;">
                            <div class="jScrollPaneDragTop" style="width: 0px;">
                            </div>
                            <div class="jScrollPaneDragBottom" style="width: 0px;">
                            </div>
                        </div>
                    </div>
                    <a href="javascript:;" class="jScrollArrowUp disabled" style="width: 0px;">Scroll up</a><a
                        href="javascript:;" class="jScrollArrowDown" style="width: 0px;">Scroll down</a></div>
            </div>
            <div class="spaser">
            </div>
        </div>
        <div class="spaser">
        </div>
    </div>
    <!--10 pixels gap between middle and bottom-->
    <div class="spaser" style="height: 10px;">
    </div>
    <div class="spaser">
    </div>
    <input type="hidden" name="DATA[COUNTRY]" id="COUNTRY" value="USA">
    <input type="hidden" name="section" value="emploee_profile_officer">
    <input type="hidden" name="ac" value="update">
    <input type="hidden" name="next_id" value="emploee_profile">
    <input type="hidden" name="next_action" value="">
    <input type="hidden" name="next_section" value="facilities_employees_officer">
    <input type="hidden" name="BUFFER" value="PROFILE">
    <input type="hidden" name="params[ed_id]" value="1">
    <input type="hidden" name="DATA[ID]" id="ID" value="1">
    <script>
        function switch_states(country) {
            show = ((country != '') && (country != '')) ? 1 : 0;
            SetVisibleById('STATE', 1 - show);
            SetVisibleById('ALT_STATE', show);
        }

        switch_states(893);
			   
    </script>
</asp:Content>
