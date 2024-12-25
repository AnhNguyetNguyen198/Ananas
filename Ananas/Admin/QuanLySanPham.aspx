<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="Ananas.Admin.QuanLySanPham" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaSP" DataSourceID="SqlDataSourceQLSP" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                            <asp:BoundField DataField="MaSP" HeaderText="MaSP" ReadOnly="True" SortExpression="MaSP" />
                            <asp:BoundField DataField="MaLoaiSP" HeaderText="MaLoaiSP" SortExpression="MaLoaiSP" />
                            <asp:BoundField DataField="TenSP" HeaderText="TenSP" SortExpression="TenSP" />
                            <asp:BoundField DataField="GiaSP" HeaderText="GiaSP" SortExpression="GiaSP" />
                            <asp:BoundField DataField="Hinh" HeaderText="Hinh" SortExpression="Hinh" />
                            <asp:BoundField DataField="TrangThai" HeaderText="TrangThai" SortExpression="TrangThai" />
                            <asp:BoundField DataField="Mota" HeaderText="Mota" SortExpression="Mota" />
                            <asp:BoundField DataField="MauSac" HeaderText="MauSac" SortExpression="MauSac" />
                            <asp:CommandField DeleteText="Xóa" ShowDeleteButton="True" />
                            <asp:CommandField CancelText="Hủy" ShowEditButton="True" UpdateText="Sửa" />
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceQLSP" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT * FROM [SanPham]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="height: 27px"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</asp:Content>
