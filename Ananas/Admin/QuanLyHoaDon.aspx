<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyHoaDon.aspx.cs" Inherits="Ananas.QuanLyHoaDon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td style="font-family: Arial, Helvetica, sans-serif; font-size: xx-large; text-align: center;height: 50px; background-color: #f1f1f1"><strong>QUẢN LÝ HÓA ĐƠN</strong></td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" ForeColor="#ED6A32" NavigateUrl="~/Admin/TrangChuAdmin.aspx" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">Trở về trang chủ</asp:HyperLink>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <p style="line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm...mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
                    <asp:Label ID="lblmahd" runat="server" Text="Mã hóa đơn: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmahd" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblmakh" runat="server" Text="Mã khách hàng: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmakh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblmanv" runat="server" Text="Mã nhân viên: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmanv" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lbltongtien" runat="server" Text="Tổng tiền: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txttongtien" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    </p>
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <p style="line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                    <asp:Label ID="lblngaytao" runat="server" Text="Ngày tạo: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtngaytao" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    &nbsp;<asp:Label ID="lblngaygiao" runat="server" Text="Ngày giao: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtngaygiao" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblpttt" runat="server" Text="Phương thức thanh toán: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtpttt" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblptgh" runat="server" Text="Phương thức giao hàng: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                        <asp:TextBox ID="txtptgh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    </p>
                </td>
            </tr>
            <tr>
                <td>
                    <center>
                    <asp:GridView ID="GridViewHoaDon" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaHD" DataSourceID="SqlDataSourceQLHD" ForeColor="Black" GridLines="None" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="1287px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                            <asp:BoundField DataField="MaHD" HeaderText="Mã hóa đơn" ReadOnly="True" SortExpression="MaHD" />
                            <asp:BoundField DataField="MaKH" HeaderText="Mã khách hàng" SortExpression="MaKH" ReadOnly="True" />
                            <asp:BoundField DataField="MaNV" HeaderText="Mã nhân viên" SortExpression="MaNV" ReadOnly="True" />
                            <asp:BoundField DataField="TongTien" HeaderText="Tổng tiền" SortExpression="TongTien" />
                            <asp:BoundField DataField="NgayTao" HeaderText="Ngày tạo" SortExpression="NgayTao" />
                            <asp:BoundField DataField="NgayGiaoHang" HeaderText="Ngày giao hàng" SortExpression="NgayGiaoHang" />
                            <asp:BoundField DataField="PTTT" HeaderText="Phương thức thanh toán" SortExpression="PTTT" />
                            <asp:BoundField DataField="PTGH" HeaderText="Phương thức giao hàng" SortExpression="PTGH" />
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
                    <asp:SqlDataSource ID="SqlDataSourceQLHD" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" InsertCommand="INSERT INTO HoaDon(MaHD, MaKH, MaNV, TongTien, NgayTao, NgayGiaoHang, PTTT, PTGH) VALUES (@MaHD, @MaKH, @MaNV, @TongTien, @NgayTao, @NgayGiaoHang, @PTTT, @PTGH)" SelectCommand="SELECT * FROM [HoaDon]" UpdateCommand="UPDATE HoaDon SET TongTien = @TongTien, NgayTao = @NgayTao, NgayGiaoHang = @NgayGiaoHang, PTTT = @PTTT, PTGH = @PTGH WHERE (MaHD = @MaHD)" DeleteCommand="DELETE FROM HoaDon WHERE (MaHD = @MaHD)">
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaHD" PropertyName="SelectedValue" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaHD" PropertyName="SelectedValue[1]" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaKH" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaNV" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="TongTien" PropertyName="SelectedValue[4]" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" DbType="Date" Name="NgayTao" PropertyName="SelectedValue[5]" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" DbType="Date" Name="NgayGiaoHang" PropertyName="SelectedValue[6]" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="PTTT" PropertyName="SelectedValue[7]" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="PTGH" PropertyName="SelectedValue[8]" />
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
