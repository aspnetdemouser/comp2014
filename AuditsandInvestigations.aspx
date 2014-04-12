<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="AuditsandInvestigations.aspx.cs" Inherits="tracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	
	
    <script type="text/javascript">
        function SetSelectedLinkTab() {

            // For attributes:
            //= is exactly equal
            //!= is not equal
            //^= is starts with
            //$= is ends with
            //*= is contains

            $('a[href*="tracking.aspx"]').parent().addClass("sel");
        }
        $(document).ready(function () {
            SetSelectedLinkTab();

            $('.open_message').click(function () {

                var mid = $(this).attr('rel');
                var DTO = JSON.stringify(
					{
					    id: mid

					});
                $.ajax(
					{
					    type: "POST",
					    contentType: "application/json; charset=utf-8",
					    url: "tracking.aspx/GetReportingDetails",
					    data: DTO,
					    dataType: "json",
					    //  async: false,
					    success: function (dataR) {
					        for (var i = 0; i < dataR.d.length; i++) {

					            $('#MESSAGE_CONTENT').append('Incident Report occured on &nbsp' + dataR.d[i].Date + '<br>');
					            $('#MESSAGE_CONTENT').append('Departments involved:&nbsp' + dataR.d[i].CSVIncidentDepartment + '<br>');
					            $('#MESSAGE_CONTENT').append('Person(s) involved:&nbsp' + dataR.d[i].CSVIncidentPerson + '<br>');
					            $('#MESSAGE_CONTENT').append('Incident description:<br>&nbsp' + dataR.d[i].IncidentDescription);

					        }

					        $('#scroll-dd-window').empty();
					        $('#scroll-dd-window').html($('#MESSAGE_CONTENT').html());
					        $('#MESSAGE_CONTENT').empty();
					        $('#message_text').adialog('open');
					    },
					    error: function (XMLHttpRequest, textStatus, errorThrown) {
					        $('.form_err_message.error_mess').html(JSON.parse(XMLHttpRequest.responseText).Message);
					        $('.form_err_message.error_mess').css("display", "block");
					    }
					});



            });





        });
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="message_text" style="display: none" class="mess_text">
        <div class="close">
            <a onclick="$('#message_text').adialog('close');" class="jsLink" href=""></a>
        </div>
        <div class="jScrollPaneContainer" style="height: 304px; width: 500px;">
            <div class="text" id="scroll-dd-window" style="height: 304px; width: 500px; padding: 0px;">
               
            </div>
        </div>
    </div>
    <div class="gray_box inbox_gray_box">
        <div class="box_title">
            <h2>
                Tracking</h2>
            <div class="cats_articles">
                <div class="jScrollPaneContainer" style="height: 265px; width: 165px;">
                    <div id="scroll-pane" class="left_menu" style="height: 265px; width: 160px; padding: 0px 5px 0px 0px;">
                        <div class="links">
                            <div class="l_0">
                                <a href=""> Incident
                                    Details </a></div>
                            <div class="l_0">
                                <a href=""> File
                                    management</a></div>
                           
                        </div>
                    </div>
                </div>
                <div style="height: 1px;" class="spaser">
                    &nbsp;</div>
            </div>
        </div>
        <div class="box_cont">
            <!--<div class="save"><a href="">Save</a></div>-->
          
            <div class="search_form">
              <asp:TextBox ID="txtSearch" runat="server" ToolTip="Enter your search criteria here"
                        class="on_focus_replace" MaxLength="255" align="absmiddle" size="40" onblur="javascript:WaterMark(this, event);"
                        onfocus="javascript:WaterMark(this, event);"></asp:TextBox>
               <asp:Button ID="btnSearchSubmit" runat="server" Text=" " CssClass="find" OnClick="btnSearchSubmit_Click" />&nbsp;<asp:ImageButton
                        runat="server" ID="btnResetSearch" CssClass="ic_del" value="" Style="float: right;
                        margin-top: 3px;" OnClick="btnResetSearch_Click" />
               
                
            </div>
            <div class="spaser">
            </div>
        
            <div class="jScrollPaneContainer" style="height: 530px; width: 944px;">
                <div class="inbox_box" id="scroll-list-page" style="height: auto; width: 914px; padding-right: 10px;
                    position: absolute; overflow: visible; top: 0px;">
                     <table width="100%" border="1" cellspacing="1" cellpadding="0" style="border-style:None;width:100%;border-collapse:collapse;">
                        <tbody>
                            <tr class="header">
                               
                                <th>
                                    Date
                                </th>
                                <th>
                                    Type
                                </th>
                                <th>
                                    Subject
                               </th>
                                <th>
                                  From
                               </th>
                                <th>
                                    Actions
                                </th>
                            </tr>
                         <asp:Repeater ID="rptInbox" runat="server">
                        <ItemTemplate>
                            <tr class="gray">
                               
                                <td class="default_selector">
                                    <%# Eval("Date")%>
                                </td>
                                <td id='TYPE_<%# Eval("InboxId") %>' type='<%# Eval("ReportType") %>'>
                                   <%# Eval("ReportType")%>
                                </td>
                                <td>
                                    <a id='SUBJECT_<%# Eval("InboxId") %>' rel='<%# Eval("InboxId") %>' class="open_message" href="#">Incident Report occured on &nbsp<%# Eval("Date")%></a><a></a></td>
                                <td>
                                   <%# Eval("From")%>
                                </td>
                                
                                <td>
                                    
                                   <asp:LinkButton ID="lbtn" runat="server"  OnCommand="EditTrackCommand"  CommandArgument='<%# DataBinder.Eval(Container.DataItem, "InboxId") %>' >Edit</asp:LinkButton>
            
                                 
                                </td>
                            </tr>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                            <tr>
                                
                                <td class="default_selector">
                                    <%# Eval("Date")%>
                                </td>
                                <td id='TYPE_<%# Eval("InboxId") %>' type='<%# Eval("ReportType") %>'>
                                   <%# Eval("ReportType")%>
                                </td>
                                <td>
                                    <a id='SUBJECT_<%# Eval("InboxId") %>' rel='<%# Eval("InboxId") %>' class="open_message" href="#">Incident Report occured on &nbsp<%# Eval("Date")%></a><a></a></td>
                                <td>
                                 <%# Eval("From")%>
                                </td>
                                
                                <td>
                                  <asp:LinkButton ID="lnkrptEdit" runat="server"  OnCommand="EditTrackCommand"  CommandArgument='<%# DataBinder.Eval(Container.DataItem, "InboxId") %>' >Edit</asp:LinkButton>
                               
             
                                </td>
                            </tr>
                            </AlternatingItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div style="display: none" id="MESSAGE_CONTENT">

                                       
                                    </div>
                <div class="jScrollPaneTrack" style="width: 20px; height: 486px; top: 22px;">
                    <div class="jScrollPaneDrag" style="width: 20px; height: 50px; top: 0px;">
                        <div class="jScrollPaneDragTop" style="width: 20px;">
                        </div>
                        <div class="jScrollPaneDragBottom" style="width: 20px;">
                        </div>
                    </div>
                </div>
                <a href="javascript:;" class="jScrollArrowUp disabled" style="width: 20px;">Scroll up</a><a
                    href="javascript:;" class="jScrollArrowDown" style="width: 20px;">Scroll down</a></div>
          
         
            <div class="spaser">
            </div>
            <div class="spaser">
            </div>
        </div>
    </div>
    <!--10 pixels gap between middle and bottom-->
    <div style="height: 10px;" class="spaser">
    </div>
  
</asp:Content>


