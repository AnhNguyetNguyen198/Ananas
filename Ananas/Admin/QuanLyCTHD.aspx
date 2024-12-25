<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyCTHD.aspx.cs" Inherits="Ananas.QuanLyCTHD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td colspan="3" style="text-align: center; font-family: Arial; font-size: xx-large;height: 50px; background-color: #F1F1F1"><strong>QUẢN LÝ CHI TIẾT HÓA ĐƠN</strong></td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: right"><strong>
                    <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="#ED6A32" NavigateUrl="~/Admin/TrangChuAdmin.aspx" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">Trở về trang chủ</asp:HyperLink>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center">
                    <p style="line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
                    <asp:Label ID="lblmahd" runat="server" Text="Mã hóa đơn: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmahd" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblmasp" runat="server" Text="Mã sản phẩm: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmasp" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblsoluong" runat="server" Text="Số lượng: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtsoluong" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" ></asp:TextBox>
                    </p>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    <div style="text-align: center">
                        <center>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaHD,MaSP" DataSourceID="SqlDataSourceCTHD" ForeColor="#333333" GridLines="None" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="706px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                            <asp:BoundField DataField="MaHD" HeaderText="Mã hóa đơn" ReadOnly="True" SortExpression="MaHD" />
                            <asp:BoundField DataField="MaSP" HeaderText="Mã sản phẩm" ReadOnly="True" SortExpression="MaSP" />
                            <asp:BoundField DataField="SoLuong" HeaderText="Số lượng" SortExpression="SoLuong" />
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
                    </div>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:SqlDataSource ID="SqlDataSourceCTHD" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT MaHD, MaSP, SoLuong FROM ChiTietHD" DeleteCommand="DELETE FROM ChiTietHD WHERE (MaHD = @MaHD) AND (MaSP = @MaSP)" InsertCommand="INSERT INTO ChiTietHD(MaHD, MaSP, SoLuong) VALUES (@MaHD, @MaSP, @SoLuong)" UpdateCommand="UPDATE ChiTietHD SET SoLuong = @SoLuong WHERE (MaHD = @MaHD) AND (MaSP = @MaSP)">
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="MaHD" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="MaSP" PropertyName="SelectedValue" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="SoLuong" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="MaHD" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="MaSP" PropertyName="SelectedValue" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </form>
</asp:Content>
