<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyKhachHang.aspx.cs" Inherits="Ananas.QuanLyKhachHnag" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>

<script type="text/javascript">
    function sortGridViewByPrice(value) {
        __doPostBack('SortGridView', value);
    }
</script>

        <table style="width: 100%">
            <tr>
                <td colspan="3" style="text-align: center; font-family: Arial; font-size: xx-large;height: 40px; background-color: #F1F1F1">
                    <strong>QUẢN LÝ KHÁCH HÀNG</strong>
                </td>
            </tr>
            <tr>
                <td style="text-align: left; height: 38px; width: 96px;">
                    <asp:ImageButton ID="btnBack" runat="server" ImageUrl="Hinh/back.png" Width="30px" Height="30px" ToolTip="Quay về trang chủ" OnClick="btnBack_Click" />
                </td>
                <td style="text-align: right; height: 38px; width: 1554px;">
                    <asp:HyperLink ID="HyperLink3" runat="server" Font-Bold="True" Font-Names="Cambria" Font-Size="13pt" ForeColor="#ED6A32" NavigateUrl="~/BCCTHD.aspx">Báo cáo thống kê</asp:HyperLink>
                    <asp:ImageButton ID="reset" runat="server" ImageUrl="~/Hinh/resetbutton.png" OnClick="reset_Click" style="width: 30px" />
                </td>
            </tr>
            <tr>
                <td colspan="3" style="padding: 10px; text-align: center;">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 10px;" Font-Size="13pt" Height="31px" />
                    <asp:Label ID="lblmakh" runat="server" Text="Mã khách hàng:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 5px;"></asp:Label>
                    <asp:TextBox ID="txtmakh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 10px;" Width="100px" Height="25px"></asp:TextBox>

                    <asp:Label ID="lblhoten" runat="server" Text="Họ và tên:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 5px;" Height="25px"></asp:Label>
                    <asp:TextBox ID="txthoten" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 10px;" Height="25px" Width="150px"></asp:TextBox>

                    <asp:Label ID="lblgioitinh" runat="server" Text="Giới tính:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 5px;"></asp:Label>
                    <asp:DropDownList ID="ddlgioitinh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 10px;" Height="25px">
                    <asp:ListItem Text="Nam" Value="nam" />
                        <asp:ListItem Text="Nữ" Value="nu"/>
                        <asp:ListItem Text="Khác" Value="khac"/>
                    </asp:DropDownList>
                    <asp:Label ID="lblngaysinh" runat="server" Text="Ngày sinh:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 5px;"></asp:Label>
                    <asp:TextBox ID="txtngaysinh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 10px;" Height="25px" Width="120px"></asp:TextBox>

                </td>
            </tr>
            <tr>
                <td colspan="3" style="padding: 10px; text-align: center;">

                    <asp:Label ID="lblsdt" runat="server" Text="Số điện thoại:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 5px;" Height="25px"></asp:Label>
                    <asp:TextBox ID="txtsdt" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 10px;" Height="25px" Width="120px"></asp:TextBox>

                    <asp:Label ID="lblemail" runat="server" Text="Email:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 5px;" Height="25px"></asp:Label>
                    <asp:TextBox ID="txtemail" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 10px;" Height="25px"></asp:TextBox>

                    <asp:Label ID="lbldiachi" runat="server" Text="Địa chỉ:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 5px;" Height="25px"></asp:Label>
                    <asp:TextBox ID="txtdiachi" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 20px;" Height="25px" Width="120px"></asp:TextBox>
                    <asp:Label ID="lblmaloai" runat="server" Text="Mã loại KH:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 5px;"></asp:Label>
                    <asp:DropDownList ID="ddlmaloai" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceMaLoai" DataTextField="MaLoaiKH" DataValueField="MaLoaiKH" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt;">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceMaLoai" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" SelectCommand="SELECT * FROM [LoaiKhachHang]" DeleteCommand="DELETE FROM LoaiKhachHang WHERE (MaLoaiKH = @MaLoaiKH)" InsertCommand="INSERT INTO LoaiKhachHang(MaLoaiKH, TenLoaiKH) VALUES (@MaLoaiKH, @TenLoaiKH)">
                        <DeleteParameters>
                            <asp:Parameter Name="MaLoaiKH" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="MaLoaiKH" />
                            <asp:Parameter Name="TenLoaiKH" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:Button ID="btntim" runat="server" Text="Tìm khách hàng" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 10px;" BackColor="#ED6A32" BorderColor="#ED6A32" Font-Size="13pt" ForeColor="White" Height="31px" OnClick="btntim_Click" Width="161px"/>
                    <asp:TextBox ID="txttim" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; margin-right: 20px;" Font-Size="13pt" Height="25px" Width="170px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="padding: 10px; width: fit-content">
                    <asp:GridView ID="GridViewKhachHang" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaKH" DataSourceID="SqlDataSourceQLKH" ForeColor="#333333" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="1200px" HorizontalAlign="Center" OnRowDataBound="GridViewKhachHang_RowDataBound">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                            <asp:BoundField DataField="MaKH" HeaderText="Mã khách hàng" ReadOnly="True" SortExpression="MaKH" />
                            <asp:BoundField DataField="HoTenKH" HeaderText="Họ và tên" SortExpression="HoTenKH" />
                            <asp:BoundField DataField="GioiTinhKH" HeaderText="Giới tính" SortExpression="GioiTinhKH" />
                            <asp:BoundField DataField="NgaySinh" HeaderText="Ngày sinh" SortExpression="NgaySinh" />
                            <asp:BoundField DataField="DiaChiKH" HeaderText="Địa chỉ" SortExpression="DiaChiKH" />
                            <asp:BoundField DataField="EmailKH" HeaderText="Email" SortExpression="EmailKH" />
                            <asp:BoundField DataField="SDTKH" HeaderText="SĐT" SortExpression="SDTKH" />
                            <asp:BoundField DataField="MaLoaiKH" HeaderText="Mã loại khách hàng" SortExpression="MaLoaiKH" />
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
                    
                    <asp:SqlDataSource ID="SqlDataSourceQLKH" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" 
                        SelectCommand="SELECT * FROM [KhachHang]" 
                        DeleteCommand="DELETE FROM KhachHang WHERE MaKH = @MaKH" 
                        InsertCommand="INSERT INTO KhachHang (MaKH, HoTenKH, GioiTinhKH, DiaChiKH, NgaySinh, EmailKH, SDTKH, MaLoaiKH) VALUES (@MaKH, @HoTenKH, @GioiTinhKH, @DiaChiKH, @NgaySinh, @EmailKH, @SDTKH, @MaLoaiKH)" 
                        UpdateCommand="UPDATE KhachHang SET HoTenKH = @HoTenKH, GioiTinhKH = @GioiTinhKH, NgaySinh = @NgaySinh, DiaChiKH = @DiaChiKH, EmailKH = @EmailKH, SDTKH = @SDTKH, MaLoaiKH = @MaLoaiKH WHERE MaKH = @MaKH">
                        <DeleteParameters>
                            <asp:Parameter Name="MaKH" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="MaKH" Type="String" />
                            <asp:Parameter Name="HoTenKH" Type="String" />
                            <asp:Parameter Name="GioiTinhKH" Type="String" />
                            <asp:Parameter Name="DiaChiKH" Type="String" />
                            <asp:Parameter Name="NgaySinh" Type="DateTime" />
                            <asp:Parameter Name="EmailKH" Type="String" />
                            <asp:Parameter Name="SDTKH" Type="String" />
                            <asp:Parameter Name="MaLoaiKH" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="HoTenKH" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="GioiTinhKH" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="NgaySinh" PropertyName="SelectedValue" Type="DateTime" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="DiaChiKH" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="EmailKH" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="SDTKH" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="MaKH" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="GridViewKhachHang" Name="MaLoaiKH" PropertyName="SelectedValue" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </form>
</asp:Content>
