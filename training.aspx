<%@ Page Title="" Language="C#" MasterPageFile="~/Firstlevel.master" AutoEventWireup="true"
    CodeFile="training.aspx.cs" Inherits="training" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="JS/jquery.min.js" type="text/javascript" language="javascript"></script>
    <script type="text/javascript">
        function SetSelectedLinkTab() {
            $('a[href*="training.aspx"]').parent().addClass("sel");
        }
        $(document).ready(function () {
            SetSelectedLinkTab();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="gray_box courses_gray_box">
        <div class="box_title">
            <h2>
                Trainings</h2>
            <h3>
                <strong>
                    <asp:Literal ID="lblNoOfActions" runat="server">##</asp:Literal></strong>Actions</h3>
        </div>
        <p style="font-size:25px;margin-top:25px;">
            <asp:Literal ID="lblInfo1" runat="server">Training Assigned</asp:Literal>
        </p>
        <div class="box_cont">
            <div class="cats_articles">
                <div class="facility_gray_box">
                    <div class="spaser">
                    </div>
                    <div class="jScrollPaneContainer" style="margin-left: 10px; margin-right: 5px; margin-top: 25px;">
                    <asp:GridView ID="gvTraining" runat="server" AutoGenerateColumns="false" PageSize="15"
                        HorizontalAlign="Left" AllowPaging="true" Width="100%" BorderStyle="None" PagerSettings-Mode="NextPreviousFirstLast"
                        PagerSettings-Position="Top" DataKeyNames="TrainingAssignmentId" OnRowDataBound="gvTraining_RowDataBound"
                        OnPageIndexChanged="gvTraining_PageIndexChanged" 
                            OnPageIndexChanging="gvTraining_PageIndexChanging" 
                            onrowcommand="gvTraining_RowCommand">
                        <HeaderStyle CssClass="Header1" />
                        <PagerStyle HorizontalAlign="Right" VerticalAlign="Top" />
                        <AlternatingRowStyle CssClass="gray" />
                        <Columns>
                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Training assigned">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.TrainingAssignmentId") %>'
                                        CommandName="edit" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CourseName") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Date assigned">
                                <ItemTemplate>
                                    <asp:Label ID="lblDateAssigned" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Date due">
                                <ItemTemplate>
                                    <asp:Label ID="lblDueDate" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Completed">
                                <ItemTemplate>
                                    <asp:Label ID="lblCompleted" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
