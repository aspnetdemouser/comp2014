<%@ Page Title="" Language="C#" MasterPageFile="~/Firstlevel.master" AutoEventWireup="true"
	CodeFile="reporting.aspx.cs" Inherits="reporting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<!-- Following Meta is for a canonical link -->
	<%--<link href="CSS/jquery-ui-1.8.14.custom.css" type="text/css" rel="stylesheet">
	<link href="CSS/jquery.lightbox-0.5.css" type="text/css" rel="stylesheet">
	<link href="CSS/font-face.css" type="text/css" rel="stylesheet">
	<link href="CSS/bbcode_editor.css" type="text/css" rel="stylesheet">
	<link href="CSS/listing.css" type="text/css" rel="stylesheet">
	<link media="screen" type="text/css" href="CSS/lightslideshow.css" rel="stylesheet">
	<link type="text/css" href="CSS/slideshow.css" rel="stylesheet">
	<link href="CSS/comments.css" type="text/css" rel="stylesheet">
	<link rel="STYLESHEET" type="text/css" href="CSS/main_index.css">
	<link rel="STYLESHEET" type="text/css" href="CSS/extra.css">--%>
	<!--Old JS functions for backword compatibility-->
	<%--<script src="JS/functions.js" type="text/javascript" language="javascript"></script>
	<script src="JS/AJAX.js" type="text/javascript" language="javascript"></script>--%>
	<script src="JS/jquery.min.js" type="text/javascript" language="javascript"></script>
	<!--Jquery UI Core (used for dialogs)-->
	<script src="JS/jquery-ui.min.js" type="text/javascript" language="javascript"></script>
	<!--Jquery Adrecom Extensions-->
	<script src="JS/jquery.extends.js" type="text/javascript" language="javascript"></script>
	<script src="JS/jquery.adialog.js" type="text/javascript" language="javascript"></script>
	<!--Light box-->
	<script src="JS/jquery.lightbox-0.5.js" type="text/javascript" language="javascript"></script>
	<!--Scroller for gallery-->
	<script src="JS/jquery.scrollTo-min.js" type="text/javascript" language="javascript"></script>
	<script src="JS/jquery.serialScroll-min.js" type="text/javascript" language="javascript"></script>
	<script src="JS/jquery.bbcode_wysiwyg.js" type="text/javascript" language="javascript"></script>
	<!--Main page tabulator-->
	<script src="JS/jquery.listing.js" type="text/javascript" language="javascript"></script>
	<!--Plug-in to slow down mouse in and mouse out events firing-->
	<script src="JS/jquery.hoverIntent.minified.js" type="text/javascript" language="javascript"></script>
	<!--Slideshow for galleries-->
	<script type="text/javascript" src="JS/lightslideshow.js"></script>
	<script type="text/javascript" src="JS/jquery.jcarousel.min.js"></script>
	<link rel="stylesheet" type="text/css" href="CSS/jcarousel.css" />
	<script src="JS/jquery.mousewheel.min.js" type="text/javascript" language="javascript"></script>
	<script src="JS/jquery.em.js" type="text/javascript" language="javascript"></script>
	<script src="JS/jScrollPane.js" type="text/javascript" language="javascript"></script>
	<link href="CSS/jScrollPane.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="JS/jquery.form.js"></script>
	<!--Main Jquery Scripts: -->
	<script src="JS/main.js" type="text/javascript" language="javascript"></script>
	<!--This one is required for video to play:-->
	<script type="text/javascript" src="JS/AC_RunActiveContent.js"></script>
	<!--To ensuure menu works under IE DO NOT REMOVE this comment!!!!-->
	<!--[if IE]>
		<LINK REL="STYLESHEET" TYPE="text/css" HREF="../css/ddmenu_ie.css">
		<LINK REL="STYLESHEET" TYPE="text/css" HREF="../css/ie7.css">
	<![endif]-->
	<!--[if IE 6]>
		<script src="../css/unitpngfix.js" type="text/javascript" language="javascript"></script>
		<link rel="stylesheet" href="../css/ie6.css" type="text/css">
	<![endif]-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<script type="text/javascript">

	    function SetSelectedLinkTab() {

	        // For attributes:
	        //= is exactly equal
	        //!= is not equal
	        //^= is starts with
	        //$= is ends with
	        //*= is contains

	        $('a[href*="reporting.aspx"]').parent().addClass("sel");
	    }
	    function initCommonFunction() {
	        $('#<%= MESSAGE.ClientID%>').keyup(function () {
	            //get the limit from maxlength attribute  
	            var limit = parseInt($(this).attr('maxlength'));
	            //get the current text inside the textarea  
	            var text = $(this).val();
	            //count the number of characters in the text  
	            var chars = text.length;

	            //check if there are more characters then allowed  
	            if (chars > limit) {
	                //and if there are use substr to get the text before the limit  
	                var new_text = text.substr(0, limit);

	                //and change the current text with the new text  
	                $(this).val(new_text);
	            }
	        });

	    }
	    $(document).ready(function () {
	        $('#<%= MESSAGE.ClientID%>').attr('maxlength', '200');
	        SetSelectedLinkTab();
	        initCommonFunction();
	    });

	    function on_custom_jquery_init() {
	        $('#rep_calendar').datepicker({
	            dateFormat: "yy-mm-dd",
	            onSelect: function (dateText, inst) { $('#<%= REPORT_DATE.ClientID%>').val(dateText); }
	        });

	        $('.department').click(function () {
	            debugger;
	            var s = $(this).parent('SPAN')
	            if (s.hasClass('sel'))
	                s.removeClass('sel');
	            else
	                s.addClass('sel');
	            $('#<%= REPORT_DEPARTMENTS.ClientID%>').val('');
	            $('.department').each(function () {
	                var s = $(this).parent('SPAN');
	                if (!s.hasClass('sel'))
	                    return;
	                var v = $('#<%= REPORT_DEPARTMENTS.ClientID%>').val();
	                if (v != '') v += ',';
	                v += $(this).text();
	                $('#<%= REPORT_DEPARTMENTS.ClientID%>').val(v);
	            });
	        });
	    }

	    function SaveAndValidate() {
	        var bool = validate_any_form($('#form1'));
	        if (bool == false)
	            return false;

	        var Objreportinginfo = new Object();
	        var Departmentreport = [];
	        var IncidentPerson = [];

	        var $replicators = $('.replicator');

	        Objreportinginfo.IncidentDescription = $('#<%= MESSAGE.ClientID%>').val();
	        Objreportinginfo.IncidentReportedDate = $('#<%= REPORT_DATE.ClientID%>').val();
	        if ($('#<%= rdANONYMOUSE.ClientID%> input:checked').val() == 1)
	            Objreportinginfo.IsAonymously = true;
	        else
	            Objreportinginfo.IsAonymously = false;

	        var i = 0;
	        $('.department').each(function () {
	            var s = $(this).parent('SPAN');
	            if (!s.hasClass('sel'))
	                return;

	            var departmentvalue = $(this).attr('val');
	            var DepartmentNameText = $(this).text(); ;
	            Departmentreport.push({
	                DepartmentId: departmentvalue,
	                DepartmentName: DepartmentNameText
	            });

	            i = i + 1;
	        });

	        var fname = "";
	        var lname = "";
	        $replicators.find('input[type=text]').each(function () {
	            var title = $(this).attr('title')

	            if (title == 'First Name') {
	                fname = $(this).val();
	            }
	            if (title == 'Last Name') {
	                lname = $(this).val();
	            }
	            if (fname != "" && lname != "") {
	                var PersonFirstName = fname;
	                var PersonLastName = lname;
	                IncidentPerson.push({ PersonFirstName: PersonFirstName, PersonLastName: PersonLastName });

	                fname = "";
	                lname = "";
	            }
	        });

	        var DTO = JSON.stringify(
					{
					    IncidentPerson: IncidentPerson,
					    Departmentreport: Departmentreport,
					    Objreportinginfo: Objreportinginfo

					});
	        $.ajax(
					{
					    type: "POST",
					    contentType: "application/json; charset=utf-8",
					    url: "reporting.aspx/SaveReporting",
					    data: DTO,
					    dataType: "json",
					    //  async: false,
					    success: function (dataR) {

					        if (dataR.d == "success") {
					            if ($('#<%= rdANONYMOUSE.ClientID%> input:checked').val() == "1") {
					                $('#sub_mess_anonymouse').adialog('open');
					                $('.form_err_message.error_mess').css("display", "none");

					            } else if ($('#<%= rdANONYMOUSE.ClientID%> input:checked').val() == "0") {
					                $('#sub_mess_regular').adialog('open');
					                $('.form_err_message.error_mess').css("display", "none");
					            }
					        } else {
					            $('.form_err_message.error_mess').html(dataR.d);
					            $('.form_err_message.error_mess').css("display", "block");
					        }
					        //resetForms();
					    },
					    error: function (XMLHttpRequest, textStatus, errorThrown) {
					        $('.form_err_message.error_mess').html(JSON.parse(XMLHttpRequest.responseText).Message);
					        $('.form_err_message.error_mess').css("display", "block");
					    }
					});



	        return false;
	    }

	    var resetForms = function () {
	        $('form').each(function () {
	            this.reset();
	        });
	    };

	    resetForms();
	</script>
	<div class="form_err_message error_mess" align="center">
		<span class="form_email_error">Value entered for e-mail is invalid<br>
		</span><span class="form_password_error">Passwords don't match<br>
		</span><span class="form_mandatory_error">Please fill up missing fields below</span>
	   
	</div>
	<div class="gray_box reporting_gray_box">
		<div class="box_title">
			<h2>
				Incident Report</h2>
		</div>
		<div class="box_cont">
			<ul>
				<li class="box">
					<h3>
						Incident Date</h3>
					<div class="box_in">
						<div class="rep_calendar" id="rep_calendar">
						</div>
						<asp:TextBox runat="server" ID="REPORT_DATE" CssClass="mandatory" MaxLength="225" dir="ltr" Style="display: none"></asp:TextBox>
					</div>
				</li>
				<li class="box">
					<h3>
						Department Involved</h3>
					<div class="box_in">
						<asp:Repeater ID="rptDepartmentInvolved" runat="server">
							<ItemTemplate>
								<span><a href="#" val='<%#Eval("DepartmentId") %>' class="jsLink department">
									<%#Eval("DepartmentName")%></a></span>
							</ItemTemplate>
						</asp:Repeater>
						<asp:HiddenField runat="server" ID="REPORT_DEPARTMENTS" />
					</div>
				</li>
				<li class="box">
					<h3>
						Person(s) Involved</h3>
					<div class="box_in box_in_form">
						<div class="form replicator">
							<asp:TextBox runat="server" ID="FNAME" MaxLength="100" dir="ltr" title="First Name"
								CssClass="on_focus_replace mandatory"></asp:TextBox>
							<asp:TextBox runat="server" ID="LNAME" MaxLength="100" dir="ltr" title="Last Name"
								class="on_focus_replace mandatory"></asp:TextBox>
							<a href="#" class="plus jsLink"></a><a href="#" class="minus jsLink" style="display: none;">
							</a>
						</div>
					</div>
				</li>
			</ul>
			<div class="spaser">
			</div>
			<div class="sub_mess" id="sub_mess_anonymouse" style="display: none">
				<h2>
					This incident report has been submitted.</h2>
				<h3>
					Since you selected to submit anonymously, rest assured that none of your personal
					data has been sent with this report.</h3>
				<a href="default.aspx">Back to Dashboard</a>
			</div>
			<div class="sub_mess" id="sub_mess_regular" style="display: none">
				<h2>
					This incident report has been submitted.</h2>
				<a href="default.aspx">Back to Dashboard</a>
			</div>
			<div class="description">
				<h3>
					Description of the Incident</h3>
				<asp:TextBox runat="server" ID="MESSAGE" TextMode="MultiLine" CssClass="_picker" maxlength="200"
					Columns="15" Rows="5" Style="width: 99%;"></asp:TextBox>
				<div class="spaser">
				</div>
				Would you like this incident submitted anonymously?
				<asp:RadioButtonList ID="rdANONYMOUSE" runat="server" RepeatDirection="Horizontal">
					<asp:ListItem Value="1" Text="Yes" />
					<asp:ListItem Value="0" Text="No" Selected="True" />
				</asp:RadioButtonList>
				<asp:Button runat="server" ID="lnkSubmitReporting" Text="Submit" OnClientClick="return SaveAndValidate();" CssClass="submit_but" />
			</div>
			<div class="spaser">
			</div>
		</div>
	</div>
	<input type="hidden" name="DATA[TYPE]" id="TYPE" value="REPORT">
	<input type="hidden" value="insert" name="ac">
	<input type="hidden" value="inbox" name="section">
	<input type="hidden" value="reporting" name="next_section">
	<!--10 pixels gap between middle and bottom-->
	<div class="spaser" style="height: 10px;">
	</div>
	<%--MESSAGE_FORM--%>
</asp:Content>
