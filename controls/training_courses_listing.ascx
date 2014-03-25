<%@ Control Language="C#" AutoEventWireup="true" CodeFile="training_courses_listing.ascx.cs"
    Inherits="controls_training_courses_listing" %>
<div class="gray_box courses_gray_box">
    <div class="box_title">
        <h2>
            Courses</h2>
        <h3>
            <strong>
                <asp:Literal ID="lblNoOfActions" runat="server">##</asp:Literal></strong>Actions</h3>
    </div>
    <div class="box_cont">
       
        <%--<div class="next-prev-vert">
            <span class="prev"><a href="#" class="jsLink"></a></span><span class="next"><a href="#"
                class="jsLink"></a></span>
        </div>--%>
        <div class="cats_articles">
            <div class="category_menu">
                <%--<div class="jScrollPaneContainer" style="height: 300px; width: 910px;">--%>
                    <div class="links" style="height: auto; overflow: visible; padding-right: 0px; width: 900px;
                        position: absolute; top: 0px;">
                        <br />
                        <asp:DataGrid ID="rptData" Style="height: 330px; overflow: auto; padding-right: 0px;
                            width: 900px; position: absolute; top: 0px; border: 0;" CellPadding="2" ShowHeader="false"
                            PagerStyle-Position="Top" PagerStyle-HorizontalAlign="Right" class="links" AllowPaging="true"
                            PageSize="5" CellSpacing="2" Width="100%" AutoGenerateColumns="false" runat="server"
                            Visible="true" BorderWidth="0px"   BorderStyle="None" 
                            BorderColor="Transparent" onpageindexchanged="rptData_PageIndexChanged">
                            <ItemStyle VerticalAlign="Top" Height="25px" />
                            <PagerStyle Height="10px" Font-Bold="true" NextPageText="Next" PrevPageText="Prev" Position="Top" HorizontalAlign="Right"/>
                            <Columns>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                        <div class="l_0">
                                            <a href="#" course_id='<%# DataBinder.Eval(Container, "DataItem.course_id")%>'>
                                                <%# DataBinder.Eval(Container, "DataItem.course_title")%></a> <a href="#" class="jsLink assign-course do"
                                                    dialog="assign_course_popup" course_id='<%# DataBinder.Eval(Container, "DataItem.course_id")%>'>
                                                    Assign to user</a>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </div>
                    <div class="jScrollPaneTrack" style="width: 0px; height: 276px; top: 12px; display: none;">
                        <div class="jScrollPaneDrag" style="width: 0px; height: 1px; top: 0px;">
                            <div class="jScrollPaneDragTop" style="width: 0px;">
                            </div>
                            <div class="jScrollPaneDragBottom" style="width: 0px;">
                            </div>
                        </div>
                    </div>
                    <!-- end jScrollPaneTrack -->
                    <%--<a href="javascript:;" class="jScrollArrowUp disabled" style="width: 0px;">Scroll up</a><a
                        href="javascript:;" class="jScrollArrowDown" style="width: 0px;">Scroll down</a>
                 </div>--%>
            </div>
            <!-- end jScrollPaneContainer -->
        </div>
    </div>
</div>

 <div id="modalOverlay" style="display: none; position: absolute; z-index: 9999; left: 0px;
            top: 0px; width: 1265px; height: 904px; background-color: rgb(0, 0, 0); opacity: 0.7;
            background-position: initial initial; background-repeat: initial initial;">
        </div>
        <div class="popup events-popup adialog" style="position: absolute; z-index: 10000;
            display: none; left: 310px; top: 250.5px;">
            <div class="popup-inner">
                <h2>
                </h2>
                <div class="long-desc">
                </div>
            </div>
            <a class="close jsLink" href="#">
            </a>
        </div>
        <div id="assign_course_popup" class="edit_facility_wrapper adialog assign_course_popup"
            style="position: absolute; z-index: 10000; display: none; left: 482.5px; top: 162px;">
            <div class="edit_facility" title="Assign course">
                <h2>
                    Assign user</h2>
                <div class="message">
                    <div class="message-inner">
                    </div>
                </div>
                <div class="popup-inner" style="overflow:scroll;">
                </div>
                <a class="close jsLink" href="#"></a>
            </div>
        </div>
