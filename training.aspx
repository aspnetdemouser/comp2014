<%@ Page Title="" Language="C#" MasterPageFile="~/Firstlevel.master" AutoEventWireup="true" CodeFile="training.aspx.cs" Inherits="training" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="gray_box courses_gray_box">
    <div class="box_title">
        <h2>
            Trainings</h2>
        <h3>
            <strong>
                <asp:Literal ID="lblNoOfActions" runat="server">##</asp:Literal></strong>Actions</h3>
    </div>
    <div class="box_cont">
        
        <div class="cats_articles">
            <div class="facility_gray_box">
               <asp:GridView ID="gvTraining" runat="server" AutoGenerateColumns="false" PageSize="25" HorizontalAlign="Right"
                            AllowPaging="true" Width="100%" BorderStyle="None"  PagerSettings-Mode="NextPreviousFirstLast"
                            PagerSettings-Position="Top"
                             DataKeyNames="TrainingAssignmentId" 
                    onrowdatabound="gvTraining_RowDataBound" 
                    onpageindexchanged="gvTraining_PageIndexChanged" 
                    onpageindexchanging="gvTraining_PageIndexChanging">
                            <HeaderStyle CssClass="Header1" />
                            <PagerStyle HorizontalAlign="Right" VerticalAlign="Top"  />
                            <AlternatingRowStyle CssClass="gray" />
                            <Columns>
                                <asp:TemplateField HeaderText="Training assigned">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTraingAssigned" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CourseName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date assigned">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateAssigned" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Date due">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDueDate" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Completed">
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
</asp:Content>

