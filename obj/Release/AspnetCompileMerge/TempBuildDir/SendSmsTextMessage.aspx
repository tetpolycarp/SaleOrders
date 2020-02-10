<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendSmsTextMessage.aspx.cs" Inherits="SaintPolycarp.BanhChung.SendSmsTextMessage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
        <div>
             <asp:Label ID="LabelTitle" Font-Bold="true" Font-Size="Large" runat="server" Text=""></asp:Label>
            <br /><br />
            <table style="width: 100%;">
             
                <tr>
                    <td>  <asp:Label ID="Label1" runat="server" Text="Phone Number:"></asp:Label></td>
                    <td>  <asp:TextBox ID="TextBoxPhoneNumber" AutoPostBack="true" runat="server" Width="430px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td> <td></td>
                </tr>
                  <tr>
                    <td>  <asp:Label ID="Label2" runat="server" Text="Message:"></asp:Label></td>
                    <td><asp:TextBox ID="TextBoxMessage" runat="server" AutoPostBack="true" Width="430px" TextMode="MultiLine"></asp:TextBox></td>
                </tr>
                 </tr>
                <tr>
                    <td></td> 
                    <td>
                         
                    </td>
                </tr>
                 </tr>
                <tr>
                    <td>
                       
                    </td>
                    <td>
                          <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                               <ProgressTemplate>
                                                          <asp:Image ID="Image1" runat="server" ImageUrl="~/images/process2.gif" style="margin-left: 10px" Width="16px" />
                                               </ProgressTemplate>
                                         </asp:UpdateProgress> 
                         <asp:UpdatePanel runat="server" id="Panel">
                                <ContentTemplate>
                                    <asp:Button ID="ButtonSend" runat="server" Text="Send" OnClick="ButtonSend_Click" />
                                </ContentTemplate>
                         </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
