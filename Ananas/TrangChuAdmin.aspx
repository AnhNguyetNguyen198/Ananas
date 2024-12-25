<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TrangChuAdmin.aspx.cs" Inherits="Ananas.TrangChuAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <script type="text/javascript">
            function showAccessDeniedPopup() {
                alert("Bạn không có quyền truy cập trang này");
            }
        </script>
         <div>
            <asp:Label ID="lblWelcome" runat="server" Text=""></asp:Label>
            <br />
            <asp:Button ID="btnLogout" runat="server" Text="Đăng Xuất" OnClick="btnLogout_Click" />
        </div>
        <table style="width: 100%; font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif; font-size: large;">
            <tr>
                <td colspan="3" style="text-align: center; height: 50px; background-color: #F1F1F1;">
                    <strong style="color: #ED6A32; font-size: xx-large;">TRANG CHỦ QUẢN LÝ</strong>
                </td>
            </tr>

            <tr>
                <td style="font-weight: bold; height: 50px; width: 359px;"></td>
                <td style="font-weight: bold; height: 50px; width: 570px;">
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Navigate" CommandArgument="~/QuanLyNhanVien.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý nhân viên</asp:LinkButton>
                </td>
                <td style="font-weight: bold; height: 50px;">
                    <asp:LinkButton ID="LinkButton5" runat="server" CommandName="Navigate" CommandArgument="~/QuanLyHoaDon.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý hóa đơn</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="font-weight: bold; height: 50px; width: 359px;"></td>
                <td style="font-weight: bold; height: 50px; width: 570px;">
                    <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Navigate" CommandArgument="~/QuanLySanPham.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý sản phẩm</asp:LinkButton>
                </td>
                <td style="font-weight: bold; height: 50px;">
                    <asp:LinkButton ID="LinkButton6" runat="server" CommandName="Navigate" CommandArgument="~/QuanLyKhachHang.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý khách hàng</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="font-weight: bold; height: 50px; width: 359px;"></td>
                <td style="font-weight: bold; height: 50px; width: 570px;">
                    <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Navigate" CommandArgument="~/QuanLyLoaiSP.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý loại sản phẩm</asp:LinkButton>
                </td>
                <td style="font-weight: bold; height: 50px;">
                    <asp:LinkButton ID="LinkButton7" runat="server" CommandName="Navigate" CommandArgument="~/QuanLyChiTietSP.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý chi tiết sản phẩm</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="font-weight: bold; height: 50px; width: 359px;"></td>
                <td style="font-weight: bold; height: 50px; width: 570px;">
                    <asp:LinkButton ID="LinkButton4" runat="server" CommandName="Navigate" CommandArgument="~/QuanLySize.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý Size</asp:LinkButton>
                </td>
                <td style="font-weight: bold; height: 50px;">
                    <asp:LinkButton ID="LinkButton8" runat="server" CommandName="Navigate" CommandArgument="~/QuanLyCTHD.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý chi tiết hóa đơn</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="font-weight: bold; height: 50px; width: 359px;"></td>
                <td style="font-weight: bold; height: 50px; width: 570px;">
                    <asp:LinkButton ID="LinkButton9" runat="server" CommandName="Navigate" CommandArgument="~/QuanLyKhuyenMai.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý khuyến mãi</asp:LinkButton>
                </td>
                <td style="font-weight: bold; height: 50px;">
                    <asp:LinkButton ID="LinkButton10" runat="server" CommandName="Navigate" CommandArgument="~/QuanLyChiNhanh.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý chi nhánh</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="font-weight: bold; height: 50px; width: 359px;"></td>
                <td style="font-weight: bold; height: 50px; width: 570px;">
                    <asp:LinkButton ID="LinkButton11" runat="server" CommandName="Navigate" CommandArgument="~/QuanLoaiKH.aspx" OnCommand="CheckUserAccess" style="font-size: x-large; color: #ED6A32;">Quản lý loại khách hàng</asp:LinkButton>
                </td>
                <td style="font-weight: bold; height: 50px;"></td>
            </tr>
        </table>
    </form>
</asp:Content>
