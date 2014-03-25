<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="ManageTraining.aspx.cs" Inherits="ManageTraining" %>

<%@ Register Src="~/controls/training_courses_listing.ascx" TagName="courses" TagPrefix="TC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script language="javascript" type="text/javascript" src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="JS/managetraining.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <TC:courses ID="trainingcoures1" runat="server" />
    
    
</asp:Content>
