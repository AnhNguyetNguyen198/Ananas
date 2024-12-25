<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyKhachHang.aspx.cs" Inherits="Ananas.QuanLyKhachHnag" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td style="font-size: xx-large; height: 50px; background-color: #f1f1f1; text-align: center;"><strong>QUẢN LÝ KHÁCH HÀNG</strong></td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="#ED6A32" NavigateUrl="~/Admin/TrangChuAdmin.aspx" style="font-family: 'Times New Roman', Times, serif; font-weight: bold; font-size: 13pt">Trở về trang chủ</asp:HyperLink>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <p style="line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
                    <asp:Label ID="lblmakh" runat="server" Text="Mã khách hàng: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmakh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
&nbsp;<asp:Label ID="lblhoten" runat="server" Text="Họ và tên: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txthoten" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
&nbsp;<asp:Label ID="lblgioitinh" runat="server" Text="Giới tính: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtgioitinh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                        <span style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">&nbsp;</span></p>
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <p style="line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                        <asp:Label ID="lblsdt" runat="server" Text="Số điện thoại: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtsdt" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
&nbsp;<asp:Label ID="lblemail" runat="server" Text="Email: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtemail" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
&nbsp;<asp:Label ID="lbldiachi" runat="server" Text="Địa chỉ: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtdiachi" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                        <span style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">&nbsp;&nbsp;</span></p>
                </td>
            </tr>
            <tr>
                <td>
                    <center>
                    <asp:GridView ID="GridViewKhachHang" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaKH" DataSourceID="SqlDataSourceQLKH" ForeColor="#333333" GridLines="None" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="969px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                            <asp:BoundField DataField="MaKH" HeaderText="Mã khách hàng" ReadOnly="True" SortExpression="MaKH" />
                            <asp:BoundField DataField="HoTen" HeaderText="Họ và tên" SortExpression="HoTen" />
                            <asp:BoundField DataField="GioiTinh" HeaderText="Giới tính" SortExpression="GioiTinh" />
                            <asp:BoundField DataField="SDT" HeaderText="Số điện thoại" SortExpression="SDT" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                            <asp:BoundField DataField="DiaChi" HeaderText="Địa chỉ" SortExpression="DiaChi" />
                            <asp:CommandField DeleteText="Xóa" ShowDeleteButton="True" />
                            <asp:CommandField CancelText="Hủy" EditText="Sửa" ShowEditButton="True" UpdateText="Cập nhật" />
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#ED6A32" Font-Bold="True" ForeColor="White" Height="50px" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F1F1F1" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                    
                    <asp:SqlDataSource ID="SqlDataSourceQLKH" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT * FROM [KhachHang]" DeleteCommand="DELETE FROM KhachHang WHERE (MaKH = @MaKH)" InsertCommand="INSERT INTO KhachHang(MaKH, HoTen, GioiTinh, SDT, Email, DiaChi) VALUES (@MaKH, @HoTen, @GioiTinh, @SDT, @Email, @DiaChi)" UpdateCommand="UPDATE KhachHang SET HoTen = @HoTen, GioiTinh = @GioiTinh, SDT = @SDT, Email = @Email, DiaChi = @DiaChi WHERE (MaKH = @MaKH)">
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="MaKH" PropertyName="SelectedValue" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="HoTen" PropertyName="SelectedValue[2]" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="GioiTinh" PropertyName="SelectedValue[3]" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="SDT" PropertyName="SelectedValue[4]" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="Email" PropertyName="SelectedValue[5]" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="DiaChi" PropertyName="SelectedValue[6]" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="MaKH" PropertyName="SelectedValue" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</asp:Content>
