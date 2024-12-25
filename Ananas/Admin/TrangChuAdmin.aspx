<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TrangChuAdmin.aspx.cs" Inherits="Ananas.TrangChuAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td colspan="2" style="font-family: Arial, Helvetica, sans-serif; font-size: xx-large; text-align: center;height: 50px; background-color: #F1F1F1"><strong>TRANG CHỦ QUẢN LÝ</strong></td>
            </tr>
            <tr>
                <td style="width: 911px">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr style="font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif">
                <td style="text-align: left; width: 911px; color: #ED6A32; font-size: x-large; font-weight: bold;">
                    <p style="text-indent: 300px; line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                        <strong>
                        <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="#ED6A32" NavigateUrl="~/QuanLyNhanVien.aspx" style="font-size: x-large; color: #ED6A32">Quản lý nhân viên</asp:HyperLink>
                        </strong>
                    </p>
                </td>
                <td>
                    <p style="text-indent: 100px; line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                        <strong>
                        <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/QuanLyHoaDon.aspx" style="font-size: x-large; color: #ED6A32">Quản lý hóa đơn</asp:HyperLink>
                        </strong>
                    </p>
                </td>
            </tr>
            <tr style="font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif">
                <td style="text-align: left; width: 911px; color: #ED6A32; font-size: x-large; font-weight: bold;">
                    <p style="text-indent: 300px; line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                        <strong>
                        <asp:HyperLink ID="HyperLink2" runat="server" ForeColor="#ED6A32" NavigateUrl="~/QuanLySanPham.aspx" style="font-size: x-large; color: #ED6A32">Quản lý sản phẩm</asp:HyperLink>
                        </strong>
                    </p>
                </td>
                <td>
                    <p style="text-indent: 100px; line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                        <strong>
                        <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/QuanLyKhachHang.aspx" style="font-size: x-large; color: #ED6A32">Quản lý khách hàng</asp:HyperLink>
                        </strong>
                    </p>
                </td>
            </tr>
            <tr style="font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif">
                <td style="text-align: left; width: 911px; color: #ED6A32; font-size: x-large; font-weight: bold;">
                    <p style="text-indent: 300px; line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                        <strong>
                        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/QuanLyLoaiSP.aspx" style="font-size: x-large; color: #ED6A32">Quản lý loại sản phẩm</asp:HyperLink>
                        </strong>
                    </p>
                </td>
                <td>
                    <p style="text-indent: 100px; line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                        <strong>
                        <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="~/QuanLyChiTietSP.aspx" style="font-size: x-large; color: #ED6A32">Quản lý chi tiết sản phẩm</asp:HyperLink>
                        </strong>
                    </p>
                </td>
            </tr>
            <tr style="font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif">
                <td style="text-align: left; width: 911px; color: #ED6A32; font-size: x-large; font-weight: bold;">
                    <p style="text-indent: 300px; line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                        <strong>
                        <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/QuanLySize.aspx" style="font-size: x-large; color: #ED6A32">Quản lý Size</asp:HyperLink>
                        </strong>
                    </p>
                </td>
                <td>
                    <p style="text-indent: 100px; line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                        <strong>
                        <asp:HyperLink ID="HyperLink8" runat="server" NavigateUrl="~/QuanLyCTHD.aspx" style="font-size: x-large; color: #ED6A32">Quản lý chi tiết hóa đơn</asp:HyperLink>
                        </strong>
                    </p>
                </td>
            </tr>
            <tr>
                <td style="width: 911px">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="width: 911px">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="width: 911px">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="width: 911px">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</asp:Content>
