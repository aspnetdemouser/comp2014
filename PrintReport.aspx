<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintReport.aspx.cs" Inherits="PrintReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div runat="server" id="dvPrint">
    </div>
    <asp:Button ID="btnPrint" runat="server" Text="Print" OnClientClick="javascript:PrintMe();" />
    </form>
</body>
</html>
<script type="text/javascript" language="javascript">
    function PrintMe() {
        window.print();
    }
</script>
