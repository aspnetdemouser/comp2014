<%@ page title="Facility employees" language="C#"
CodeFile="manage_facility_employees.aspx.cs"
 masterpagefile="~/main.master" autoeventwireup="true" inherits="manage_facility_employees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        $(window).bind('load', function () {
            var headerChk = $(".chkHeader input");
            var itemChk = $(".chkItem input");
            headerChk.bind("click", function () {
                itemChk.each(function () { this.checked = headerChk[0].checked; })
            });
            itemChk.bind("click", function () { if ($(this).checked == false) headerChk[0].checked = false; });
        });       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content">
        <div class="gray_box facility_gray_box employee_box">
            <div class="box_title">
                <h2>
                    <asp:Literal ID="lblFacilityName" runat="server"></asp:Literal>
                </h2>
                <br/>
                <div class="cats_articles">
                    <div class="facillity_info">
                        <div>
                            <asp:Literal ID="lblAddress1" runat="server"></asp:Literal><br />
                            <asp:Literal ID="lblCityStateZip" runat="server"></asp:Literal><br />
                            <asp:Literal ID="lblCountry" runat="server"></asp:Literal>
                        </div>
                    </div>
                    <div class="spaser" style="height: 1px;">
                        &nbsp;</div>
                </div>
            </div>
            <div class="box_cont">
                <div class="delim">
                </div>
                
                <div class="add">
                    <a href="employeeprofile.aspx">Add Employee</a></div>
                <div class="remove">
                    <asp:LinkButton runat="server" ID="imgRemoveEmp" Text="Deactivate Selected Employees" 
                        CssClass="RemoveEmployee" OnClientClick="return confirm(&#39;Are you sure you want to inactive this user?&#39;);"
                        OnClick="imgRemoveEmp_Click"></asp:LinkButton>
                    </div>
                <div class="print">
                    <a href="">Print</a></div>
                <div class="search_form">
                    <asp:TextBox ID="search_text" runat="server" ToolTip="Enter your search criteria here" PlaceHolder ="Enter last name to search"
                        class="on_focus_replace" MaxLength="255" align="absmiddle" size="40" onblur="javascript:WaterMark(this, event);"
                        onfocus="javascript:WaterMark(this, event);"></asp:TextBox>
                    <asp:Button ID="btnSearchSubmit" runat="server" Text=" " CssClass="find" OnClick="btnSearchSubmit_Click" />&nbsp;<asp:ImageButton
                        runat="server" ID="btnResetSearch" CssClass="ic_del" value="" Style="float: right;
                        margin-top: 3px;" OnClick="btnResetSearch_Click" />
                </div>
                <div class="spaser">
                </div>
                <div style="float: left;margin-left:22px;">
                    <asp:CheckBox runat="server" ID="chkActive" AutoPostBack="True" Text="Active employees only"
                        OnCheckedChanged="chkActive_CheckedChanged" Checked="True" /></div>
            
                <div class="spaser">
                </div>
                <div class="jScrollPaneContainer"  style="margin-left:10px;margin-right:5px;margin-top:5px;">
                    
                        <div class="spaser">
                        </div>
                        <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="false"
                             PageSize="15"

                            Width="100%" BorderStyle="None" OnRowDataBound="gvEmployees_RowDataBound"
                            AllowPaging="true"
                            OnRowCommand="gvEmployees_RowCommand" DataKeyNames="Id"
                            PagerSettings-Mode="NextPreviousFirstLast"
                            PagerSettings-Position="Top" PagerStyle-HorizontalAlign="Center" 
                            PagerSettings-FirstPageText="First"
                            PagerSettings-LastPageText="Last" 
                            PagerSettings-NextPageText="Next"
                            PagerSettings-PreviousPageText="Previous" 
                            onpageindexchanged="gvEmployees_PageIndexChanged" onpageindexchanging="gvEmployees_PageIndexChanging"
                            >
                            <HeaderStyle CssClass="Header1" />
                            <AlternatingRowStyle CssClass="gray" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select" HeaderStyle-CssClass="header">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkboxSelectEmp" CssClass="chkItem" runat="server" />
                                    </ItemTemplate>
                                    <HeaderStyle VerticalAlign="Middle" Width="50px" />
                                    <ItemStyle VerticalAlign="Middle" Width="50px" />
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkboxSelectAll" CssClass="chkHeader" runat="server" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employee Name">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEdit" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'
                                            CommandName="editEmployee" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ContactName") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Job Title">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPosition" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Position") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date of Hire">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateOfHire" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DateOfHire", "{0:MMM dd, yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="License # and Exp.">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLicNumberAndExp" runat="server" Text=""></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date of Last Exclusion Check">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateLastExclusionCheck" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DateLastExclusionCheck", "{0:MMM dd, yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" Visible="false">
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ID="imgEdit" CssClass="ic_edit" value="" CommandName="Edit"
                                            Visible="false" />&nbsp;<asp:ImageButton runat="server" ID="imgDelete" CssClass="ic_del"
                                                value="" CommandName="DeleteEmployee" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'
                                                OnClientClick="return confirm(&#39;Are you sure you want to inactive this user?&#39;);" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    
                </div>
                <div class="spaser">
                </div>
                <div class="spaser">
                </div>
            </div>
        </div>
        <!--10 pixels gap between middle and bottom-->
        <div class="spaser" style="height: 10px;">
        </div>
    </div>
</asp:Content>
