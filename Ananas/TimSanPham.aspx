<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TimSanPham.aspx.cs" Inherits="Ananas.TimSanPham" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td>
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataList ID="ddlsp" runat="server" DataKeyField="MaSP" DataSourceID="SqlDataSourceSanPham" RepeatColumns="3" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <asp:Image ID="imgHinh" runat="server" ImageUrl='<%# Eval("Hinh") %>' />
                            <br />
                            TenSP:
                            <asp:Label ID="TenSPLabel" runat="server" Text='<%# Eval("TenSP") %>' />
                            <br />
                            GiaSP:
                            <asp:Label ID="GiaSPLabel" runat="server" Text='<%# Eval("GiaSP") %>' />
                            <br />
                            TrangThai:
                            <asp:Label ID="TrangThaiLabel" runat="server" Text='<%# Eval("TrangThai") %>' />
                            <br />
                            MauSac:
                            <asp:Label ID="MauSacLabel" runat="server" Text='<%# Eval("MauSac") %>' />
                            <br />
                            MaSP:
                            <asp:Label ID="MaSPLabel" runat="server" Text='<%# Eval("MaSP") %>' />
<br />
                            <br />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSourceSanPham" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT [TenSP], [GiaSP], [TrangThai], [MauSac], [Hinh], [MaSP] FROM [SanPham]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>

</asp:Content>
