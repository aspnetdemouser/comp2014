<%@ Page Title="" Language="C#" MasterPageFile="~/Firstlevel.master" AutoEventWireup="true"
	CodeFile="reporting.aspx.cs" Inherits="reporting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
      /*  .Table {padding-left:100px;}*/
        
   .Row {
    display: table-row;
}
.Cell {
   
    display: table-cell;
    padding-left: 5px;
    padding-right: 5px;
    
}
/*.celllable{vertical-align:top; text-align: left; height: 32px;}

p.padding {display:inline-block; vertical-align:middle;position:relative;}*/



.Table {
    border: medium none;
    color: #FFFFFF;
    display: block;
    font-size: 13px;
   padding: 40px 20px 20px 20px;
    width: 100%;
    /*padding-left:100px;*/
}
.Table DIV {
    clear: both;
    height: 32px;
    
}
.Table DIV.last {
    border: medium none;
}
.Table DIV.spaser {
    border: medium none;
    height: 1px;
    padding: 0;
}
.Table DIV.title {
    border: medium none;
    text-align: center;
}
.Table DIV.auto {
    height: auto;
}
.Table DIV INPUT {
    background: none repeat scroll 0 0 #757575;
    border: 1px solid #C6C6C6;
    color: #FFFFFF;
    float: left;
    font-size: 13px;
    margin-left: 5px;
    padding: 3px;
    vertical-align: middle;
}
.Table DIV TEXTAREA {
    background: none repeat scroll 0 0 #757575;
    border: 1px solid #C6C6C6;
    color: #FFFFFF;
    float: left;
    font-size: 13px;
    margin-left: 0;
    padding: 5px;
}
.Table DIV SELECT {
    background: none repeat scroll 0 0 #757575;
    border: 1px solid #C6C6C6;
    color: #FFFFFF;
    float: left;
    font-size: 13px;
    margin-left: 5px;
    padding: 3px;
}
.Table DIV SPAN {
    display: block;
    float: left;
    margin-top: 5px;
    padding-top: 1px;
    text-align: right;
    width: 180px;
}
.Table DIV SPAN.text {
    padding-left: 200px;
    text-align: left;
}
.Table DIV SPAN SPAN {
    display: inherit;
    float: right;
    width: 200px;
}
.Table DIV label  
{float:left;
    }
</style>
	<script src="JS/genweb.js" type="text/javascript"></script>
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
		function SetReadonlyControll() {
			if (location.href.indexOf('?') != -1) {
				$('#<%= MESSAGE.ClientID%>').attr("disabled", "disabled");
				$('#<%= REPORT_DATE.ClientID%>').attr("disabled", "disabled");
				$('#<%= drpDepartment.ClientID%>').attr("disabled", "disabled");
				$('#<%= FLNAME.ClientID%>').attr("disabled", "disabled");
				$('#<%= Submitanonymously.ClientID%>').attr("disabled", "disabled");
				$('#<%= Submittedby.ClientID%>').attr("disabled", "disabled");
			}
		}


		function GetQueryStringParams() {
			var sPageURL = window.location.search.substring(1);
			var sURLVariables = sPageURL.split('&');
			if (sURLVariables.length > 0) {
				$(".reporting_gray_box").css("height", "650px");
			}
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

			$('#<%= txtResolution.ClientID%>').keyup(function () {
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

			$('#<%= FLNAME.ClientID%>').keyup(function () {
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
			GetQueryStringParams();
			$('#<%= MESSAGE.ClientID%>').attr('maxlength', '2000');
			$('#<%= txtResolution.ClientID%>').attr('maxlength', '2000');
			$('#<%= FLNAME.ClientID%>').attr('maxlength', '500');
			SetReadonlyControll();
			SetSelectedLinkTab();
			initCommonFunction();
			$("#<%= REPORT_DATE.ClientID %>").datepicker();
			$("#<%= txtDateclosed.ClientID %>").datepicker();

			$('.mytarget').change(function () {
				var selValue = $('input[name=ctl00$ContentPlaceHolder1$anonymously]:checked').val();

				if (selValue == "0") {
					var val = $("#<%=hdnSubmittedby.ClientID%>").val();
					$("#<%=txtSubmittedby.ClientID%>").val(val);
				}
				if (selValue == "1") {
					$("#<%=txtSubmittedby.ClientID%>").val("");
				}
			});
		});

		function SaveAndValidate() {
			if (!tIsDate('<%=REPORT_DATE.ClientID %>')) {
				return false;
			}
			$('.form_err_message.error_mess').html("");
			var bool = validate_any_form($('#form1'));
			if (bool == false)
				return false;

			var Objreportinginfo = new Object();


			var IncidentDateClosed = $('#<%= txtDateclosed.ClientID%>');
			var Resolution = $('#<%= txtResolution.ClientID%>');
			var Status = $('#<%= drpStatus.ClientID%>');

			Objreportinginfo.IncidentDescription = $('#<%= MESSAGE.ClientID%>').val();
			Objreportinginfo.IncidentReportedDate = $('#<%= REPORT_DATE.ClientID%>').val();
			Objreportinginfo.DepartmentId = $('#<%= drpDepartment.ClientID%>').val();
			Objreportinginfo.PersonInvolved = $('#<%= FLNAME.ClientID%>').val();

			if (null != IncidentDateClosed) {
				Objreportinginfo.IncidentDateClosed = IncidentDateClosed.val();
			}
			if (null != Resolution) {
				Objreportinginfo.Resolution = Resolution.val();
			}
			if (null != Status) {
				Objreportinginfo.Status = Status.val();
			}

			var selValue = $('input[name=ctl00$ContentPlaceHolder1$anonymously]:checked').val();

			if (selValue == "1")
				Objreportinginfo.IsAonymously = true;
			else
				Objreportinginfo.IsAonymously = false;

			var DTO = JSON.stringify(
					{
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
							
							if (dataR.d == "Success") {
								var selValue = $('input[name=ctl00$ContentPlaceHolder1$anonymously]:checked').val();

								if (selValue == "1") {
									$('#sub_mess_anonymouse').adialog('open');
									$('.form_err_message.error_mess').css("display", "none");
								}
								if (selValue == "0") {
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
		</span><span class="form_mandatory_error"></span>

	</div>
	<div class="gray_box reporting_gray_box">
		<div class="box_title">
			<h2>
				Incident Report</h2>
		</div>
		<div class="box_cont">
     
      
		

<div class="Table form_block">
    
    <div class="Row">
        <div class="Cell">
            <span class="padding">Incident Date<b class="madatorystar">*</b>:</span>
        </div>
        <div class="Cell">
           <asp:TextBox runat="server" ID="REPORT_DATE" CssClass="mandatory" size="30" MaxLength="225"
							dir="ltr"></asp:TextBox>
        </div>
       
    </div>
    <div class="Row">
        <div class="Cell">
             <span class="padding">Department Involved:<b class="madatorystar">*</b></span>
        </div>
        <div class="Cell">
          <asp:DropDownList runat="server" ID="drpDepartment" CssClass="mandatory" size="1" Style="width: 100px;">
						</asp:DropDownList>
        </div>
       
    </div>
	<div class="Row">
        <div class="Cell celllable">
            <span class="padding">Person(s) Involved:<b class="madatorystar">*</b></span>
        </div>
        <div class="Cell">
            <asp:TextBox runat="server" ID="FLNAME" MaxLength="500" TextMode="MultiLine" Columns="50"
								Style="height: 80px !important; margin: 0 0 0 0 !important;" Rows="2" dir="ltr"
								title="Enter person First and Last Name" CssClass="on_focus_replace mandatory _picker"></asp:TextBox>
        </div>
       
    </div>
   
	<div class="Row">
        <div class="Cell celllable">
             <span class="padding">Description of the Incident:</span>
        </div>
        <div class="Cell">
            <asp:TextBox runat="server" ID="MESSAGE" TextMode="MultiLine" CssClass="on_focus_replace mandatory _picker"
								Style="margin: 0 0 0 0 !important; width: 99%;" MaxLength="2000" title="Enter Description"
								Columns="15" Rows="5"></asp:TextBox>
        </div>
       
    </div>
	<div class="Row">
        <div class="Cell">
          
        </div>
        <div class="Cell">
         <asp:RadioButton ID="Submittedby" Text="Submitted by" Checked="True" CssClass="mytarget"
							value="0" GroupName="anonymously" runat="server" />
           <asp:TextBox runat="server" ID="txtSubmittedby" ReadOnly="true" size="30" ></asp:TextBox>
						<asp:TextBox runat="server" ID="hdnSubmittedby" Style="display: none;"></asp:TextBox>
        </div>
       
    </div>
	<div class="Row">
        <div class="Cell">
           
        </div>
        <div class="Cell">
           <asp:RadioButton ID="Submitanonymously" Text="Submit anonymously" CssClass="mytarget"
							value="1" GroupName="anonymously" runat="server" />
        </div>
       
    </div>
	<asp:PlaceHolder runat="server" ID="plsTracking" Visible="false">
	<div class="Row">
        <div class="Cell">
            <span class="padding">Status<b class="madatorystar">*</b>:</span>
        </div>
        <div class="Cell">
            <asp:DropDownList runat="server" ID="drpStatus" CssClass="mandatory" size="1" Style="width: 100px;">
							 <asp:ListItem Text="" Value="" Selected="True"></asp:ListItem>
							 <asp:ListItem Text="open" Value="1" ></asp:ListItem>
							 <asp:ListItem Text="closed" Value="0" ></asp:ListItem>
						   </asp:DropDownList>
        </div>
       
    </div>
	<div class="Row">
        <div class="Cell">
            <span class="padding">Date closed<b class="madatorystar">*</b>:</span>
        </div>
        <div class="Cell">
            <asp:TextBox runat="server" ID="txtDateclosed" CssClass="mandatory" size="30" MaxLength="225"
							dir="ltr"></asp:TextBox>
        </div>
       
    </div>
	<div class="Row">
        <div class="Cell celllable">
            <span class="padding">Resolution:<b class="madatorystar">*</b></span>
        </div>
        <div class="Cell">
            <asp:TextBox runat="server" ID="txtResolution" MaxLength="500" TextMode="MultiLine" Columns="50"
								Style="height: 80px !important; margin: 0 0 0 0 !important;" Rows="2" dir="ltr"
								title="Enter Resolution" CssClass="on_focus_replace mandatory _picker"></asp:TextBox>
        </div>
       
    </div>
	 </asp:PlaceHolder>
	<div class="Row">
        <div class="Cell">
          
        </div>
        <div class="Cell">
             <asp:Button runat="server" ID="lnkSubmitReporting" Text="Submit" OnClientClick="return SaveAndValidate();"
							CssClass="submit_but" />
        </div>
       
    </div>
	
	
	
</div>


            </div>
			<div class="spaser">
			</div>
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
			<div class="spaser">
			</div>
		</div>

    
	<!--10 pixels gap between middle and bottom-->
	<div class="spaser" style="height: 10px;">
	</div>
	<%--MESSAGE_FORM--%>
</asp:Content>
