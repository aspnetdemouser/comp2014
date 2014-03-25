<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="manage_facility_employees.aspx.cs" Inherits="manage_facility_employees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
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
                <br>
                <div class="cats_articles">
                    <div class="facillity_info">
                        <div>
                            <asp:Literal ID="lblAddress1" runat="server"></asp:Literal><br />
                            <asp:Literal ID="lblCityStateZip" runat="server"></asp:Literal><br />
                            <asp:Literal ID="lblCountry" runat="server"></asp:Literal>
                        </div>
                        <div>
                            Tel:
                            <asp:Literal ID="lblPhone" runat="server"></asp:Literal>
                            <br>
                            Fax:
                            <asp:Literal ID="lblFax" runat="server"></asp:Literal></div>
                        <div>
                            <a href="#"></a>
                        </div>
                    </div>
                    <div class="spaser" style="height: 1px;">
                        &nbsp;</div>
                </div>
            </div>
            <div class="box_cont">
                <div class="delim">
                </div>
                <div class="save">
                    <a>Save Facility</a></div>
                <div class="add">
                    <a href="emploeeprofile.aspx">Add Employee</a></div>
                <div class="remove">
                    <asp:LinkButton runat="server" ID="imgRemoveEmp" Text="Remove Selected Employees"
                        CssClass="RemoveEmployee" OnClientClick="return confirm(&#39;Delete is irreversible, are you sure?&#39;);"
                        OnClick="imgRemoveEmp_Click"></asp:LinkButton>
                    <%--<a href="http://compliance.dev.webstores.net/acc_bo/?section=facilities_employees_officer#"
                        onclick="deleteall(&#39;main_interface_form&#39;); return false;">Remove Selected
                        Empoyees</a>--%></div>
                <div class="print">
                    <a href="">Print</a></div>
                <div class="search_form">
                    <asp:TextBox ID="search_text" runat="server" title="Enter your search criteria here"
                        class="on_focus_replace" MaxLength="255" align="absmiddle" size="40"></asp:TextBox>
                    <asp:Button ID="btnSearchSubmit" runat="server" Text=" " CssClass="find" OnClick="btnSearchSubmit_Click" />
                </div>
                <div class="spaser">
                </div>
                <div class="edit_facility">
                    <fieldset id="FACILITY_FORM">
                        <div>
                            <span>Facility Name<b class="madatorystar">*</b>:</span>
                            <asp:TextBox ID="txtFacilityName" MaxLength="100" runat="server" CssClass="_picker"></asp:TextBox>
                        </div>
                        <div>
                            <span>Address</span>
                            <asp:TextBox ID="txtAddressLine" MaxLength="255" runat="server" CssClass="_picker"></asp:TextBox>
                        </div>
                        <div>
                            <span>City<b class="madatorystar">*</b>:</span>
                            <asp:TextBox ID="txtCity" MaxLength="50" runat="server" CssClass="mandatory"></asp:TextBox>
                        </div>
                        <div class="st">
                            <span>State:</span>
                            <asp:DropDownList ID="ddlState" runat="server" CssClass="mandatory" size="1">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                <asp:ListItem Value="AL">AL</asp:ListItem>
                                <asp:ListItem Value="AK">AK</asp:ListItem>
                                <asp:ListItem Value="AZ">AZ</asp:ListItem>
                                <asp:ListItem Value="AR">AR</asp:ListItem>
                                <asp:ListItem Value="CA">CA</asp:ListItem>
                                <asp:ListItem Value="CO">CO</asp:ListItem>
                                <asp:ListItem Value="CT">CT</asp:ListItem>
                                <asp:ListItem Value="DE">DE</asp:ListItem>
                                <asp:ListItem Value="DC">DC</asp:ListItem>
                                <asp:ListItem Value="FL">FL</asp:ListItem>
                                <asp:ListItem Value="GA">GA</asp:ListItem>
                                <asp:ListItem Value="HI">HI</asp:ListItem>
                                <asp:ListItem Value="ID">ID</asp:ListItem>
                                <asp:ListItem Value="IL">IL</asp:ListItem>
                                <asp:ListItem Value="IN">IN</asp:ListItem>
                                <asp:ListItem Value="IA">IA</asp:ListItem>
                                <asp:ListItem Value="KS">KS</asp:ListItem>
                                <asp:ListItem Value="KY">KY</asp:ListItem>
                                <asp:ListItem Value="LA">LA</asp:ListItem>
                                <asp:ListItem Value="ME">ME</asp:ListItem>
                                <asp:ListItem Value="MD">MD</asp:ListItem>
                                <asp:ListItem Value="MA">MA</asp:ListItem>
                                <asp:ListItem Value="MI">MI</asp:ListItem>
                                <asp:ListItem Value="MN">MN</asp:ListItem>
                                <asp:ListItem Value="MS">MS</asp:ListItem>
                                <asp:ListItem Value="MO">MO</asp:ListItem>
                                <asp:ListItem Value="MT">MT</asp:ListItem>
                                <asp:ListItem Value="NE">NE</asp:ListItem>
                                <asp:ListItem Value="NV">NV</asp:ListItem>
                                <asp:ListItem Value="NH">NH</asp:ListItem>
                                <asp:ListItem Value="NJ">NJ</asp:ListItem>
                                <asp:ListItem Value="NM">NM</asp:ListItem>
                                <asp:ListItem Value="NY">NY</asp:ListItem>
                                <asp:ListItem Value="NC">NC</asp:ListItem>
                                <asp:ListItem Value="ND">ND</asp:ListItem>
                                <asp:ListItem Value="OH">OH</asp:ListItem>
                                <asp:ListItem Value="OK">OK</asp:ListItem>
                                <asp:ListItem Value="OR">OR</asp:ListItem>
                                <asp:ListItem Value="PA">PA</asp:ListItem>
                                <asp:ListItem Value="RI">RI</asp:ListItem>
                                <asp:ListItem Value="SC">SC</asp:ListItem>
                                <asp:ListItem Value="SD">SD</asp:ListItem>
                                <asp:ListItem Value="TN">TN</asp:ListItem>
                                <asp:ListItem Value="TX">TX</asp:ListItem>
                                <asp:ListItem Value="UT">UT</asp:ListItem>
                                <asp:ListItem Value="VT">VT</asp:ListItem>
                                <asp:ListItem Value="VI">VI</asp:ListItem>
                                <asp:ListItem Value="VA">VA</asp:ListItem>
                                <asp:ListItem Value="WA">WA</asp:ListItem>
                                <asp:ListItem Value="WV">WV</asp:ListItem>
                                <asp:ListItem Value="WI">WI</asp:ListItem>
                                <asp:ListItem Value="WY">WY</asp:ListItem>
                                <asp:ListItem Value="AE">AE</asp:ListItem>
                                <asp:ListItem Value="AP">AP</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="zip">
                            <span>Zip Code:</span>
                            <asp:TextBox ID="txtZipCode" runat="server" MaxLength="10" CssClass="_picker"></asp:TextBox>
                        </div>
                        <div>
                            <span>Country<b class="madatorystar">*</b>:</span>
                            <asp:DropDownList ID="ddlCountry" runat="server">
                                <asp:ListItem Value="USA">UNITED STATES</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div>
                            <span>Telephone:</span>
                            <asp:TextBox ID="txtPhone" runat="server" MaxLength="50" CssClass="_picker"></asp:TextBox>
                        </div>
                        <div>
                            <span>Fax:</span>
                            <asp:TextBox ID="txtFax" runat="server" MaxLength="50" CssClass="_picker"></asp:TextBox>
                        </div>
                        <div>
                            <span>E-mail:<b class="madatorystar">*</b></span>
                            <asp:TextBox ID="txtEmail" runat="server" MaxLength="255" CssClass="mandatory mail"></asp:TextBox>
                        </div>
                        <div class="spacer" style="width: auto; float: none;">
                        </div>
                    </fieldset>
                </div>
                <div class="spaser">
                </div>
                <div class="jScrollPaneContainer" style="height: 360px; width: 944px;">
                    <div id="scroll-list-small" class="employee_list" style="height: 360px; width: 944px;
                        padding: 0px;">
                        <div class="spaser">
                        </div>
                        <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="false" PageSize="25"
                            AllowPaging="true" Width="100%" BorderStyle="None" OnRowDataBound="gvEmployees_RowDataBound"
                            OnRowCommand="gvEmployees_RowCommand" DataKeyNames="Id">
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
                                <asp:TemplateField HeaderText="Position">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPosition" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Position") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date of Hire">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateOfHire" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DateOfHire", "{0:MMM dd yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Licence # and Exp">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLicNumberAndExp" runat="server" Text=""></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date of Last Exclusion Check">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateLastExclusionCheck" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DateLastExclusionCheck", "{0:MMM dd yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ID="imgEdit" CssClass="ic_edit" value="" CommandName="Edit"
                                            Visible="false" />&nbsp;<asp:ImageButton runat="server" ID="imgDelete" CssClass="ic_del"
                                                value="" CommandName="DeleteEmployee" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'
                                                OnClientClick="return confirm(&#39;Delete is irreversible, are you sure?&#39;);" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
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
