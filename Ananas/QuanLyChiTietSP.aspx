<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyChiTietSP.aspx.cs" Inherits="Ananas.QuanLyChiTietSP" %>
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
                    <strong>QUẢN LÝ CHI TIẾT SẢN PHẨM</strong>
                </td>
            </tr>
            <tr>
                <td style="text-align: left; width: 326px;">
                    <asp:ImageButton ID="btnBack" runat="server" ImageUrl="Hinh/back.png" Width="30px" Height="30px" ToolTip="Quay về trang chủ" OnClick="btnBack_Click" />
                </td>
                <td style="width: 300px; text-align: center;">
                    <asp:Label ID="lblsize" runat="server" Text="Size:"  style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
&nbsp;<asp:DropDownList ID="ddlsize" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceSize" DataTextField="TenSize" DataValueField="MaSize" OnSelectedIndexChanged="ddlsize_SelectedIndexChanged" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="130px" AppendDataBoundItems="True">
                        <asp:ListItem Value="*">Tất cả</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td style="text-align: right; width: 250px; clip: rect(auto, auto, auto, auto);">
                    <asp:HyperLink ID="HyperLink3" runat="server" Font-Bold="True" Font-Names="Cambria" Font-Size="13pt" ForeColor="#ED6A32" NavigateUrl="~/BCCTHD.aspx">Báo cáo thống kê</asp:HyperLink>
                    <asp:ImageButton ID="reset" runat="server" ImageUrl="~/Hinh/resetbutton.png" OnClick="reset_Click" Width="30px" />
                </td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center; padding: 12px;">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
                    <asp:Label ID="lblmasp" runat="server" Text="Mã sản phẩm: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmasp" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    <asp:Label ID="lblphantren" runat="server" Text="Phần trên: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtphantren" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    <asp:Label ID="lbldengoai" runat="server" Text="Đế ngoài: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtdengoai" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    &nbsp;<asp:Button ID="btntim" runat="server" Text="Tìm" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" OnClick="btntim_Click" />
                    &nbsp;<asp:TextBox ID="txttim" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <center>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaSP,MaSize" DataSourceID="SqlDataSourceCTSP" ForeColor="#333333" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; width: 800px;">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                                <asp:BoundField DataField="MaSP" HeaderText="Mã SP" ReadOnly="True" SortExpression="MaSP" />
                                <asp:BoundField DataField="MaSize" HeaderText="Mã Size" ReadOnly="True" SortExpression="MaSize" />
                                <asp:BoundField DataField="PhanTren" HeaderText="Phần Trên" SortExpression="PhanTren" />
                                <asp:BoundField DataField="DeNgoai" HeaderText="Đế Ngoài" SortExpression="DeNgoai" />
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
                    </center>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:SqlDataSource ID="SqlDataSourceCTSP" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" SelectCommand="SELECT MaSP, MaSize, PhanTren, DeNgoai FROM ChiTietSanPham WHERE (MaSize = @Masize)" DeleteCommand="DELETE FROM ChiTietSanPham WHERE (MaSP = @MaSP) AND (MaSize = @MaSize)" InsertCommand="INSERT INTO ChiTietSanPham(MaSP, MaSize, PhanTren, DeNgoai) VALUES (@MaSP, @MaSize, @PhanTren, @DeNgoai)" UpdateCommand="UPDATE ChiTietSanPham SET MaSP = @MaSP, MaSize = @masize, PhanTren = @PhanTren, DeNgoai = @DeNgoai WHERE (MaSP = @MaSP) AND (MaSize = @masize)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlsize" Name="Masize" PropertyName="SelectedValue" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="maSp" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="masize" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="PhanTren" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="DeNgoai" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="masp" PropertyName="SelectedValue" />
                            <asp:Parameter Name="newMaSp" />
                            <asp:Parameter Name="newMaSize" />
                            <asp:Parameter Name="oldMaSp" />
                            <asp:Parameter Name="oldMaSize" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:SqlDataSource ID="SqlDataSourceSize" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" SelectCommand="SELECT * FROM [Size]"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </form>
</asp:Content>
