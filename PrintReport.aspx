<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintReport.aspx.cs" Inherits="PrintReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
    <div id="non-printable">
        <asp:Button ID="btnPrint" runat="server" Text="Print" OnClientClick="javascript:PrintMe('dvPrint');" />&nbsp;
        <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" />
    </div>
    <div id="printable">
        <div runat="server" id="dvPrint">
        </div>
    </div>
    </form>
</body>
</html>
<script type="text/javascript" language="javascript">
    function PrintMe(divName) {
        var printContents = document.getElementById(divName).innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;

        window.print();

        document.body.innerHTML = originalContents;
    }
   
</script>
