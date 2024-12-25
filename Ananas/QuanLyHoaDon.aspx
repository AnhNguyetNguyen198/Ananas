<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyHoaDon.aspx.cs" Inherits="Ananas.QuanLyHoaDon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
<script type="text/javascript">
    function sortGridViewByPrice(value) {
        __doPostBack('SortGridView', value);
    }
</script>

        <table style="width: 100%; border-collapse: collapse;">
            <tr>
                <td colspan="3" style="text-align: center; font-family: Arial; font-size: xx-large; height: 40px; background-color: #F1F1F1; padding: 10px;">
                    <strong>QUẢN LÝ HÓA ĐƠN</strong>
                </td>
            </tr>
            <tr>
                <td style="text-align: left; width: 200px;">
                    <asp:ImageButton ID="btnBack" runat="server" ImageUrl="Hinh/back.png" Width="30px" Height="30px" ToolTip="Quay về trang chủ" OnClick="btnBack_Click" />
                </td>
                <td style="text-align: right;">
                    <asp:HyperLink ID="HyperLink3" runat="server" Font-Bold="True" Font-Names="Cambria" Font-Size="13pt" ForeColor="#ED6A32" NavigateUrl="~/BCCTHD.aspx">Báo cáo thống kê</asp:HyperLink>
                    <asp:ImageButton ID="reset" runat="server" ImageUrl="~/Hinh/resetbutton.png" OnClick="reset_Click" Width="30px" />
                </td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center; padding: 10px; width: 1200px;">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
                    <asp:Label ID="lblmahd" runat="server" Text="Mã hóa đơn: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-left: 10px;"></asp:Label>
                    <asp:TextBox ID="txtmahd" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;" Width="120px"></asp:TextBox>
                    <asp:Label ID="lblmakh" runat="server" Text="Mã khách hàng: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-left: 10px;"></asp:Label>
                    <asp:TextBox ID="txtmakh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;" Width="120px" ></asp:TextBox>
                    <asp:Label ID="lblmanv" runat="server" Text="Mã nhân viên: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-left: 10px;"></asp:Label>
                    <asp:TextBox ID="txtmanv" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;" Width="120px"></asp:TextBox>
                    &nbsp;<asp:Label ID="lblmakm" runat="server" Text="Mã khuyến mãi: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-left: 10px;"></asp:Label>
                    <asp:TextBox ID="txtmakm" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;" Width="120px"></asp:TextBox>
                    <asp:Label ID="lbltongtien" runat="server" Text="Tổng tiền: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-left: 10px;"></asp:Label>
                    <asp:TextBox ID="txttongtien" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;" Width="120px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center; padding: 10px; width: 1200px;">
                    <asp:Label ID="lblngaytao" runat="server" Text="Ngày tạo: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;"></asp:Label>
                    <asp:TextBox ID="txtngaytao" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;" Width="120px"></asp:TextBox>
                    <asp:Label ID="lblpttt" runat="server" Text="Phương thức thanh toán: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-left: 10px;"></asp:Label>
                    <asp:TextBox ID="txtpttt" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;" Width="120px"></asp:TextBox>
                    <asp:Label ID="lblptgh" runat="server" Text="Phương thức giao hàng: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-left: 10px;"></asp:Label>
                    <asp:TextBox ID="txtptgh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;" Height="25px" Width="120px"></asp:TextBox>
                 <asp:Button ID="btntim" runat="server" Text="Tìm" Width="50px" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" OnClick="btntim_Click"/>
 &nbsp;<asp:TextBox ID="txttim" runat="server" Width="150px" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Height="25px"></asp:TextBox>
                &nbsp;<asp:DropDownList ID="Select" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Select_SelectedIndexChanged" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; width: 150px;">
                        <asp:ListItem Text="Sắp xếp" Value="" />
                        <asp:ListItem Text="Tổng tiền từ cao đến thấp" Value="cao" />
                        <asp:ListItem Text="Tổng tiền từ thấp đến cao" Value="thap" />
                        <asp:ListItem Text="Ngày tạo đơn gần đây" Value="gan" />
                        <asp:ListItem Text="Ngày tạo đơn trước đó" Value="xa" />
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center;">
                    <asp:GridView ID="GridViewHoaDon" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="MaHD" DataSourceID="SqlDataSourceQLHoaDon" ForeColor="#333333" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; width: 100%;" OnRowDataBound="GridViewHoaDon_RowDataBound" Width="1100px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" CancelText="Hủy" />
                             <asp:TemplateField HeaderText="STT">
     <ItemTemplate>
         <asp:Label ID="lblSTT" runat="server"></asp:Label>
     </ItemTemplate>
 </asp:TemplateField>
                            <asp:BoundField DataField="MaHD" HeaderText="Mã hóa đơn" ReadOnly="True" SortExpression="MaHD" />
                            <asp:BoundField DataField="MaKH" HeaderText="Mã khách hàng" SortExpression="MaKH" ReadOnly="True" />
                            <asp:BoundField DataField="MaNV" HeaderText="Mã nhân viên" SortExpression="MaNV" ReadOnly="True" />
                            <asp:BoundField DataField="MaKM" HeaderText="Mã khuyến mãi" SortExpression="MaKM" ReadOnly="True" />
                            <asp:BoundField DataField="NgayTaoHD" HeaderText="Ngày tạo đơn" SortExpression="NgayTaoHD" />
                            <asp:BoundField DataField="TongTien" HeaderText="Tổng tiền" SortExpression="TongTien" />
                            <asp:BoundField DataField="PTGH" HeaderText="Phương thức giao hàng" SortExpression="PTGH" />
                            <asp:BoundField DataField="PTTT" HeaderText="Phương thức thanh toán" SortExpression="PTTT" />
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
                    <asp:SqlDataSource ID="SqlDataSourceQLHoaDon" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" SelectCommand="SELECT * FROM [HoaDon]" InsertCommand="INSERT INTO HoaDon(MaHD, MaKH, MaNV, MaKM, NgayTaoHD, PTGH, TongTien, PTTT) VALUES (@MaHD, @MaKH, @MaNV, @MaKM, @NgayTaoHD, @PTGH, @TongTien, @PTTT)" UpdateCommand="UPDATE HoaDon SET MaNV = @MaNV, MaKM = @MaKM, NgayTaoHD = @NgayTaoHD, TongTien = @TongTien, PTGH = @PTGH, PTTT = @PTTT WHERE (MaHD = @MaHD) AND (MaKH = @MaKH) AND (MaNV = @MaNV) AND (MaKM = @MaKM)">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaHD" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaKH" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaNV" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaKM" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="NgayTaoHD" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="PTGH" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="TongTien" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="PTTT" PropertyName="SelectedValue" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaNV" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaKM" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="NgayTaoHD" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="PTGH" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="PTTT" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="TongTien" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaHD" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridViewHoaDon" Name="MaKH" PropertyName="SelectedValue" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceQLKH" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" SelectCommand="SELECT * FROM [KhachHang]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceQLNV" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" SelectCommand="SELECT * FROM [NhanVien]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceQLKM" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" SelectCommand="SELECT * FROM [KhuyenMai]"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </form>
</asp:Content>
