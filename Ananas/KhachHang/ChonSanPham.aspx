<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ChonSanPham.aspx.cs" Inherits="Ananas.KhachHang.ChonSanPham" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">
        <asp:DataList ID="DataListChonSP" runat="server" DataSourceID="SqlDataSourceChonSP" DataKeyField="MaSP" EditItemIndex="1" OnItemCommand="DataListChonSP_ItemCommand" RepeatColumns="1" RepeatDirection="Horizontal" SelectedIndex="1">
            <ItemTemplate>
                <asp:Image ID="imghinh" runat="server" ImageUrl='<%# Eval("Hinh") %>' />
                <br />
                MaSP:
                <asp:Label ID="MaSPLabel" runat="server" Text='<%# Eval("MaSP") %>' />
                <br />
                MaLoaiSP:
                <asp:Label ID="MaLoaiSPLabel" runat="server" Text='<%# Eval("MaLoaiSP") %>' />
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
                Mota:
                <asp:Label ID="MotaLabel" runat="server" Text='<%# Eval("Mota") %>' />
                <br />
                MauSac:
                <asp:Label ID="MauSacLabel" runat="server" Text='<%# Eval("MauSac") %>' />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSourceChonSP" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT * FROM [SanPham]"></asp:SqlDataSource>
    </form>

</asp:Content>
