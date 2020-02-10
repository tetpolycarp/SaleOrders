<%@ Page Title="Log Info" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Logs.aspx.cs" Inherits="Mitchell.ScmConsoles.Logs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        Logs:<br />
    </p>
    <p>
        <asp:Literal ID="Literal_logs" runat="server"></asp:Literal>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>
