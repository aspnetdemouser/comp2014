<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="inbox.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script type="text/javascript">
        function SetSelectedLinkTab() {

            // For attributes:
            //= is exactly equal
            //!= is not equal
            //^= is starts with
            //$= is ends with
            //*= is contains

            $('a[href*="inbox.aspx"]').parent().addClass("sel");
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
					    url: "inbox.aspx/GetReportingDetails",
					    data: DTO,
					    dataType: "json",
					    //  async: false,
					    success: function (dataR) {
					        for (var i = 0; i < dataR.d.length; i++) {

					            $('#MESSAGE_CONTENT').append('Incident Report occured on &nbsp' + dataR.d[i].Date + '<br>');
					            $('#MESSAGE_CONTENT').append('Departments involved:&nbsp' + dataR.d[i].DepartmentName + '<br>');
					            $('#MESSAGE_CONTENT').append('Person(s) involved:&nbsp' + dataR.d[i].PersonInvolved + '<br>');
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
                Inbox</h2>
            <div class="cats_articles">
                <div class="jScrollPaneContainer" style="height: 265px; width: 165px;">
                    <div id="scroll-pane" class="left_menu" style="height: 265px; width: 160px; padding: 0px 5px 0px 0px;">
                        <div class="links">
                        <asp:Repeater runat="server" ID="rptleftCategoryReport">
                        <ItemTemplate>
                        <div class="l_0">
                                <asp:LinkButton runat="server" ID="lnkReportId"  OnCommand="InboxReportCountCommand"  CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ReportType") %>'>
                                <span class="cnt">(<%# Eval("IncidentTypeCount")%>)</span><%# Eval("ReportType") %> 
                                </asp:LinkButton></div>
                        </ItemTemplate>
                        </asp:Repeater>
                            
                          
                        </div>
                    </div>
                </div>
                <div style="height: 1px;" class="spaser">
                    &nbsp;</div>
            </div>
        </div>
        <div class="box_cont">
            <!--<div class="save"><a href="">Save</a></div>-->
            <div class="forward">
                <a id="forward" class="jsLink" href="#">Forward</a></div>
            <div class="respond">
                <a class="jsLink" href="#">Respond To</a>
                <div class="respond_to">
                    <ul>
                        <li><a id="respond_public" class="jsLink" href="#">Public</a></li>
                        <li><a id="respond_private" class="jsLink" href="#">Private</a></li>
                    </ul>
                </div>
            </div>
            <div class="remove">
                <a onclick="deleteall('main_interface_form'); return false;" href="#">Remove Selected</a></div>
            <div class="print">
                <a class="jsLink" href="">Print</a></div>
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
            <form method="POST" action="index.php" id="main_interface_form">
            <div class="jScrollPaneContainer" style="height: 530px; width: 944px;">
                <div class="inbox_box" id="scroll-list-page" style="height: auto; width: 914px; padding-right: 10px;
                    position: absolute; overflow: visible; top: 0px;">
                    <table width="100%" border="1" cellspacing="1" cellpadding="0" style="border-style:None;width:100%;border-collapse:collapse;">
                        <tbody>
                            <tr class="header">
                                <th>
                                    <input type="checkbox" style="cursor: pointer;" onclick="select_all('DATA')">
                                </th>
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
                                    <input type="checkbox" value='<%# Eval("InboxId") %>' name="SELECTED[DATA][]">
                                </td>
                                <td>
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
                                    <a rel='<%# Eval("InboxId") %>' class="ic_edit jsLink open_message" href="#"></a>
                                     <asp:LinkButton ID="lbtnd" CssClass="ic_del" OnClientClick="return confirm('Delete is irreversible, are you sure?');" runat="server"  OnCommand="DeleteCommand"  CommandArgument='<%# DataBinder.Eval(Container.DataItem, "InboxId") %>' ></asp:LinkButton>
                                    </a>
                                </td>
                            </tr>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                            <tr>
                                 <td class="default_selector">
                                    <input type="checkbox" value='<%# Eval("InboxId") %>' name="SELECTED[DATA][]">
                                </td>
                                <td>
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
                                    <a rel='<%# Eval("InboxId") %>' class="ic_edit jsLink open_message" href="javascript:;"></a>
                                       <asp:LinkButton ID="lbtn" CssClass="ic_del" OnClientClick="return confirm('Delete is irreversible, are you sure?');" runat="server"  OnCommand="DeleteCommand"  CommandArgument='<%# DataBinder.Eval(Container.DataItem, "InboxId") %>' ></asp:LinkButton>
                                   
                                    </a>
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
            
            </form>
            <div class="spaser">
            </div>
            <div class="spaser">
            </div>
        </div>
    </div>
    <!--10 pixels gap between middle and bottom-->
    <div style="height: 10px;" class="spaser">
    </div>
    <script type="text/javascript">
       

    </script>
</asp:Content>
