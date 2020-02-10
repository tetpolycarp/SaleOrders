<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true" CodeBehind="TrackingSheet.aspx.cs" Inherits="SaintPolycarp.BanhChung.TrackingSheet" %>
<%@ MasterType VirtualPath="~/Site.master" %> 
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="text-align:center;">
    <table style="width: 100%;">
        <tr>
            <td align="left">
                     <!--Place holder-->


            </td>
              <td align="left" style="width: 100%;">
                <asp:Label ID="LabelPageTitle" runat="server" Text="Tracking Sheet" Font-Bold="true"  Font-Size="XX-Large" Font-Underline="true"></asp:Label> 
             </td>
        </tr>
        </table>
        </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConsoleContent" runat="server">
  
    <style type="text/css">
        .datepicker
        {
            width: 80px !important;
            align-content:center;
            align-items: center;
        }
</style>
      <div style="text-align:center;">
        <table style="width: 100%;">
      
                 <td align="center">
      <telerik:RadGrid ID="RadGridMoneyTransfers" ShowFooter="true" runat="server" ActiveItemStyle-BorderStyle="Solid" AllowPaging="false" AllowSorting="False" AllowFilteringByColumn="False" FilterType="CheckList" AutoGenerateColumns="False" OnNeedDataSource="RadGridMoneyTransfers_NeedDataSource" OnPreRender="RadGridMoneyTransfers_PreRender" PageSize="200" ShowStatusBar="True" Width="98%"  Skin="Web20" OnFilterCheckListItemsRequested="RadGridMoneyTransfers_FilterCheckListItemsRequested" OnItemCommand="RadGridMoneyTransfers_ItemCommand" OnItemDataBound="RadGridMoneyTransfers_ItemDataBound" GroupPanelPosition="Top" >
    <ActiveItemStyle BorderStyle="Solid" />
    <PagerStyle Mode="NumericPages" AlwaysVisible="True" />
    <MasterTableView AllowMultiColumnSorting="True" DataKeyNames="InvoiceNumber" Name="InvoiceNumber" Width="100%">
      <Columns>
        <telerik:GridBoundColumn DataField="InvoiceNumber" ItemStyle-BackColor="SteelBlue" ItemStyle-ForeColor ="White" HeaderButtonType="TextButton" HeaderText="Invoice Number" AllowFiltering="true" FilterCheckListEnableLoadOnDemand="true"  SortExpression="InvoiceNumber" FilterControlAltText="Filter Invoice Number" UniqueName="InvoiceNumber" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Width="3%">
          <HeaderStyle Font-Bold="True" Font-Size="Large" />
                   <FooterStyle Font-Bold="true" ForeColor="White" BackColor="SteelBlue" Font-Size="Medium" HorizontalAlign="Right"/>
        </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="CustomerName" ItemStyle-BackColor="SteelBlue" ItemStyle-ForeColor="White" HeaderButtonType="TextButton" HeaderText="Customer Name" AllowFiltering="true" FilterCheckListEnableLoadOnDemand="true"  SortExpression="CustomerName" FilterControlAltText="Filter Customer Name" UniqueName="CustomerName" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Width="3%">
          <HeaderStyle Font-Bold="True" Font-Size="Large" />
                    <FooterStyle Font-Bold="true" ForeColor="White" BackColor="SteelBlue" Font-Size="Medium" HorizontalAlign="Right"/>
        </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="PickupStatus" ItemStyle-BackColor="SteelBlue" ItemStyle-ForeColor="White" HeaderButtonType="TextButton" HeaderText="Pickup Status" AllowFiltering="true" FilterCheckListEnableLoadOnDemand="true"  SortExpression="PickupStatus" FilterControlAltText="Filter Pickup Status" UniqueName="PickupStatus" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Width="3%">
          <HeaderStyle Font-Bold="True" Font-Size="Large" />
                    <FooterStyle Font-Bold="true" ForeColor="White" BackColor="SteelBlue" Font-Size="Medium" HorizontalAlign="Right"/>
        </telerik:GridBoundColumn>
         <telerik:GridBoundColumn DataField="PaidStatus" ItemStyle-BackColor="SteelBlue" ItemStyle-ForeColor="White"  HeaderButtonType="TextButton" HeaderText="Paid Status" AllowFiltering="true" FilterCheckListEnableLoadOnDemand="true"  SortExpression="PaidStatus" FilterControlAltText="Filter Paid Status" UniqueName="PaidStatus" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Width="3%">
          <HeaderStyle Font-Bold="True" Font-Size="Large" />
                 <FooterStyle Font-Bold="true" ForeColor="White" BackColor="SteelBlue" Font-Size="Medium" HorizontalAlign="Right"/>
        </telerik:GridBoundColumn>
         <telerik:GridBoundColumn DataField="InvoiceAmount" ItemStyle-BackColor="SteelBlue" ItemStyle-ForeColor="White" HeaderButtonType="TextButton" HeaderText="Invoice Amount" AllowFiltering="false" FilterCheckListEnableLoadOnDemand="true"  SortExpression="InvoiceAmount" FilterControlAltText="Filter Invoice Amount" UniqueName="InvoiceAmount" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Width="3%">
          <HeaderStyle Font-Bold="True" Font-Size="Large"/>
             <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle Font-Bold="true" ForeColor="White" BackColor="SteelBlue" Font-Size="Medium" HorizontalAlign="Right"/>
        </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="PaidAmount" ItemStyle-BackColor="SteelBlue" ItemStyle-ForeColor="White" HeaderButtonType="TextButton" HeaderText="Paid Amount" AllowFiltering="false" FilterCheckListEnableLoadOnDemand="true"  SortExpression="PaidAmount" FilterControlAltText="Filter Paid Amount" UniqueName="PaidAmount" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Width="3%">
          <HeaderStyle Font-Bold="True" Font-Size="Large" />
                <ItemStyle HorizontalAlign="Right" />
                           <FooterStyle Font-Bold="true" ForeColor="White" BackColor="SteelBlue" Font-Size="Medium" HorizontalAlign="Right"/>
    
        </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn DataField="Giao1" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao1" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao1" Text="Giao #1" runat="server"></asp:Label><br />
                                     <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate1" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                          <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                     </telerik:RadDatePicker><br />
                                       <asp:CheckBox ID="Giao1" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao1"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
                                        <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>  
                                        
                              
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
         </telerik:GridTemplateColumn> 
        <telerik:GridTemplateColumn DataField="Giao2" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao2" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao2" Text="Giao #2" runat="server"></asp:Label><br />
                                        <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate2" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                             <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                     </telerik:RadDatePicker><br />
                                    <asp:CheckBox ID="Giao2" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao2"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                       <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 
             <telerik:GridTemplateColumn DataField="Giao3" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao3" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao3" Text="Giao #3" runat="server"></asp:Label><br />
                                       <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate3" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                            <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                       </telerik:RadDatePicker><br />
                                     <asp:CheckBox ID="Giao3" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao3"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 
             <telerik:GridTemplateColumn DataField="Giao4" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao4" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao4" Text="Giao #4" runat="server"></asp:Label><br />
                                        <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate4" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                             <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                        </telerik:RadDatePicker><br />
                                    <asp:CheckBox ID="Giao4" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao4"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 
             <telerik:GridTemplateColumn DataField="Giao5" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao5" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao5" Text="Giao #5" runat="server"></asp:Label><br />
                                        <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate5" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                             <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                        </telerik:RadDatePicker><br />
                                    <asp:CheckBox ID="Giao5" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao5"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 
             <telerik:GridTemplateColumn DataField="Giao6" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao6" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao6" Text="Giao #6" runat="server"></asp:Label><br />
                                        <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate6" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                             <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                        </telerik:RadDatePicker><br />
                                    <asp:CheckBox ID="Giao6" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao6"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 
             <telerik:GridTemplateColumn DataField="Giao7" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao7" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao7" Text="Giao #7" runat="server"></asp:Label><br />
                                        <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate7" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                             <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                        </telerik:RadDatePicker><br />
                                    <asp:CheckBox ID="Giao7" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao7"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 
             <telerik:GridTemplateColumn DataField="Giao8" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao8" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao8" Text="Giao #8" runat="server"></asp:Label><br />
                                        <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate8" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                             <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                        </telerik:RadDatePicker><br />
                                    <asp:CheckBox ID="Giao8" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao8"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 
             <telerik:GridTemplateColumn DataField="Giao9" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao9" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao9" Text="Giao #9" runat="server"></asp:Label><br />
                                        <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate9" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                             <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                        </telerik:RadDatePicker><br />
                                    <asp:CheckBox ID="Giao9" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao9"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 
             <telerik:GridTemplateColumn DataField="Giao10" HeaderButtonType="TextButton" AllowFiltering="false" UniqueName="Giao10" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />  
                                <HeaderTemplate>
                                      <asp:Label ID="LabeGiao10" Text="Giao #10" runat="server"></asp:Label><br />
                                        <telerik:RadDatePicker ID="RadDatePickerInvoicePickupDate10" CssClass="datepicker" Font-Bold="true" Font-Size="Small" runat="server" OnSelectedDateChanged="RadDatePickerInvoicePickupDate_SelectedDateChanged" Enabled="true" MinDate="2019-01-01">
                                             <DateInput DateFormat="MMM d  yyyy" DisplayDateFormat="MM/dd"> </DateInput>
                                        </telerik:RadDatePicker><br />
                                    <asp:CheckBox ID="Giao10" runat="server" Visible="true" OnCheckedChanged="CheckBoxGiao_CheckedChanged" AutoPostBack="true" />
                                </HeaderTemplate>
                                    <ItemTemplate> 
                                        <asp:TextBox ID="Giao10"  OnTextChanged="TextBoxGiao_TextChanged" AutoPostBack="true" Visible="true" runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
                 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <FooterStyle Font-Bold="true" ForeColor="Blue" Font-Size="Medium" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 


           <telerik:GridTemplateColumn HeaderButtonType="TextButton" AllowFiltering="false" HeaderText="Total" UniqueName="Total" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="8%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />        
                                    <ItemTemplate> 
                                        <asp:TextBox ID="TextBoxTotal" Font-Bold="true" ForeColor="OrangeRed" Enabled="false" Visible="true"  runat="server" style="text-align: right" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                          <FooterStyle Font-Bold="true" ForeColor="OrangeRed" Font-Size="Large" HorizontalAlign="Right"/>
    
         </telerik:GridTemplateColumn> 
              <telerik:GridTemplateColumn HeaderButtonType="TextButton" AllowFiltering="false" HeaderText="Notes" UniqueName="Notes" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="17%" >  
                              <HeaderStyle Font-Bold="True" Font-Size="Large" />        
                                    <ItemTemplate> 
                                        <asp:TextBox ID="TextBoxNotes" Visible="true" TextMode="MultiLine"  runat="server" style="text-align: left" Width="80%">
                                        </asp:TextBox>
                                    </ItemTemplate> 
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                  <FooterStyle Font-Size="Small" HorizontalAlign="Center"/>
         </telerik:GridTemplateColumn> 
      </Columns>
        <PagerStyle AlwaysVisible="True" />
    </MasterTableView>
  <ClientSettings>
           <Selecting AllowRowSelect="true"></Selecting>
                       
   </ClientSettings>
<FilterMenu CssClass="RadFilterMenu_CheckList"></FilterMenu>
          <FilterItemStyle HorizontalAlign="Center"  />
  </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td>
                    <br /><br />
                           <table style="width: 80%;">
                      <tr>
                          <td>
                               <table style="width: 100%;">
                                   <tr>
                                       <td>
                                           <asp:Label ID="LabelNotes" Text="Notes:" runat="server"> </asp:Label> <br />
                                                <asp:TextBox ID="TextBoxNote" runat="server" TextMode="MultiLine" Height="116px" Width="524px"></asp:TextBox>  
                                       </td>
                                   </tr>
                                   </table>
                          </td>
                           <td align="center" valign="middle">
                                 <table style="width: 100%;">
                                               <tr>
                                                  
                                                <td>    <asp:Button ID="ButtonSave" runat="server" Text="Save" Width="120px" BackColor="Orange" BorderStyle="Double" BorderColor="Blue" OnClick="ButtonSave_Click" /> &emsp; </td>
                                                <td>    <asp:Button ID="ButtonExportToExcel" runat="server" Text="Export to Excel" Width="120px" BackColor="Orange" BorderStyle="Double" BorderColor="Blue" OnClick="ButtonExportToExcel_Click"/> &emsp; </td>
                                           <td>    <asp:Button ID="ButtonExport" runat="server" Text="Export" Width="120px" BackColor="Orange" BorderStyle="Double" BorderColor="Blue" OnClick="ButtonExport_Click"/> &emsp; </td>
                                           
                          </td>   
                                                
                                              </tr>
                                                 </table>
                </td>
            </tr>
        
            </table>
          <asp:Literal ID="LiteralLogs" runat="server"></asp:Literal>
         
    </div>
</asp:Content>
