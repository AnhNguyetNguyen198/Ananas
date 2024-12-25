<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyNhanVien.aspx.cs" Inherits="Ananas.QuanLyNhanVien" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <table style="width: 100%">
        <tr>
            <td style="font-family: Arial, Helvetica, sans-serif; font-size: xx-large; text-align: center; height: 30px; background-color: #F1F1F1"><strong>QUẢN LÝ NHÂN VIÊN</strong></strong></td>
        </tr>
        <tr>
            <td style="text-align: right; height: 29px">
                <strong>
                <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="#ED6A32" NavigateUrl="~/Admin/TrangChuAdmin.aspx" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">Trở về trang chủ</asp:HyperLink>
                </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
        </tr>
        <tr>
            <td style="text-align: center; height: 79px;">
                <p style="margin-top: 12px; margin-bottom: 12px; line-height: 150%;">
                <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#EC6A32" BorderColor="#EC6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
&nbsp;<asp:Label ID="lblmanv" runat="server" Text="Mã nhân viên: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                <asp:TextBox ID="txtmanv" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
&nbsp;<asp:Label ID="lblhoten" runat="server" Text="Họ và tên: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                <asp:TextBox ID="txthoten" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
&nbsp;</p>
                <p style="margin-top: 12px; margin-bottom: 12px; line-height: 150%;">
                    <asp:Label ID="lblgioitinh" runat="server" Text="Giới tính: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                <asp:TextBox ID="txtgioitinh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblsdt" runat="server" Text="SĐT: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                <asp:TextBox ID="txtsdt" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblemail" runat="server" Text="Email: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                <asp:TextBox ID="txtemail" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lbldiachi" runat="server" Text="Địa chỉ: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                <asp:TextBox ID="txtdiachi" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                </p>
            </td>
        </tr>
        <tr>
            <td style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; text-align: center">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <center>
                <asp:GridView ID="GridViewNhanVien" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaNV" DataSourceID="SqlDataSourceNhanVien" ForeColor="Black" GridLines="None" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Height="30px" Width="834px">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                        <asp:BoundField DataField="MaNV" HeaderText="Mã nhân viên" ReadOnly="True" SortExpression="MaNV" />
                        <asp:BoundField DataField="HoTenNV" HeaderText="Họ và tên" SortExpression="HoTenNV" />
                        <asp:BoundField DataField="GioiTinhNV" HeaderText="Giới tính" SortExpression="GioiTinhNV" />
                        <asp:BoundField DataField="SDTNV" HeaderText="SĐT" SortExpression="SDTNV" />
                        <asp:BoundField DataField="EmailNV" HeaderText="Email" SortExpression="EmailNV" />
                        <asp:BoundField DataField="DiaChiNV" HeaderText="Địa chỉ" SortExpression="DiaChiNV" />
                        <asp:CommandField DeleteText="Xóa" ShowDeleteButton="True" />
                        <asp:CommandField CancelText="Hủy" EditText="Sửa" ShowEditButton="True" UpdateText="Cập nhật" />
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#ED6A32" Font-Bold="True" ForeColor="White" Height="50px" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F1F1F1" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" DeleteCommand="DELETE FROM NhanVien WHERE (MaNV = @MANV)" InsertCommand="INSERT INTO NhanVien(MaNV, HoTenNV, GioiTinhNV, SDTNV, EmailNV, DiaChiNV) VALUES (@MaNV, @HoTenNV, @GioiTinhNV, @SDTNV, @EmailNV, @DiaChiNV)" SelectCommand="SELECT * FROM [NhanVien]" UpdateCommand="UPDATE NhanVien SET HoTenNV = @HoTenNV, GioiTinhNV = @GioiTinhNV, SDTNV = @SDTNV, EmailNV = @EmailNV, DiaChiNV = @DiaChiNV WHERE (MaNV = @MaNV)">
                    <InsertParameters>
                        <asp:Parameter Name="MaNV" />
                        <asp:Parameter Name="HoTenNV" />
                        <asp:Parameter Name="GioiTinhNV" />
                        <asp:Parameter Name="SDTNV" />
                        <asp:Parameter Name="EmailNV" />
                        <asp:Parameter Name="DiaChiNV" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="GridViewNhanVien" Name="HoTenNV" PropertyName="SelectedValue[2]" />
                        <asp:ControlParameter ControlID="GridViewNhanVien" Name="GioiTinhNV" PropertyName="SelectedValue[3]" />
                        <asp:ControlParameter ControlID="GridViewNhanVien" Name="SDTNV" PropertyName="SelectedValue[4]" />
                        <asp:ControlParameter ControlID="GridViewNhanVien" Name="EmailNV" PropertyName="SelectedValue[5]" />
                        <asp:ControlParameter ControlID="GridViewNhanVien" Name="DiaChiNv" PropertyName="SelectedValue[6]" />
                        <asp:ControlParameter ControlID="GridViewNhanVien" Name="MaNV" PropertyName="SelectedValue" />
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
