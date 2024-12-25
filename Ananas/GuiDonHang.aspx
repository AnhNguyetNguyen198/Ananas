<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="GuiDonHang.aspx.cs" Inherits="Ananas.GuiDonHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Cambria" Font-Size="18pt" style="font-family: cam" Text="THÔNG BÁO"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <p style="text-indent: 100px; margin-top: 12px; margin-bottom: 12px">
                    <asp:Label ID="lblThongBao" runat="server" Font-Names="Cambria" Font-Size="13pt"></asp:Label>
                    </p>
                </td>
            </tr>
        </table>
    </form>
</asp:Content>
