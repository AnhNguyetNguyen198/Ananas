<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="Ananas.Admin.QuanLySanPham" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <script type="text/javascript">
    function sortGridViewByPrice(order) {
        __doPostBack('SortGridView', order);
    }
</script>
       <table style="width: 100%">
    <tr>
        <td colspan="3" style="text-align: center; font-family: Arial; font-size: xx-large;height: 40px; background-color: #F1F1F1"><strong>QUẢN LÝ SẢN PHẨM</strong></td>
    </tr>
    <tr>
        <td style="text-align: left; height: 38px;">
            <asp:ImageButton ID="btnBack" runat="server" ImageUrl="Hinh/back.png" Width="30px" Height="30px" ToolTip="Quay về trang chủ" OnClick="btnBack_Click" />
        </td>
        <td style="text-align: right; height: 38px;">
            <asp:HyperLink ID="HyperLink3" runat="server" Font-Bold="True" Font-Names="Cambria" Font-Size="13pt" ForeColor="#ED6A32" NavigateUrl="~/BCCTHD.aspx">Báo cáo thống kê</asp:HyperLink>
            <asp:ImageButton ID="reset" runat="server" ImageUrl="~/Hinh/resetbutton.png" OnClick="reset_Click" />
        </td>
    </tr>
                    </table>
                    <p style="margin-top: 5px; text-align: center;">&nbsp;<asp:Label ID="lblchonloaisp" runat="server" Text="Loại sản phẩm" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:DropDownList ID="ddlLoaiSP" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceLoaiSP" DataTextField="TenLoaiSP" DataValueField="MaLoaiSP" OnSelectedIndexChanged="ddlLoaiSP_SelectedIndexChanged" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">
                        <asp:ListItem Value="*">Tất cả</asp:ListItem>
                    </asp:DropDownList>
                    </p>
                </td>
            </tr>
            <tr>
                <td style="height: 50px; text-align: center;">
                    <p style="line-height: 100%; margin-top: 0px; margin-bottom: 0px; text-align: center;">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" Font-Bold="False" Font-Overline="False" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Height="45px" Width="109px" />
                    &nbsp;<asp:Label ID="lblmasp" runat="server" Text="Mã sản phẩm: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmasp" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    &nbsp;<asp:Label ID="lbltensp" runat="server" Text="Tên sản phẩm:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txttensp" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="150px"></asp:TextBox>
                    &nbsp;<asp:Label ID="lblgiasp" runat="server" Text="Giá: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtgiasp" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    &nbsp;<asp:Label ID="lblmota" runat="server" Text="Mô tả: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmota" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                        &nbsp;<br />
                        <table style="width: 100%">
                            <tr>
                                <td style="height: 48px; text-align: center;">
                    <asp:Label ID="lblmausac" runat="server" Text="Màu sắc:" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmausac" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    &nbsp;<asp:Label ID="lbltrangthai" runat="server" Text="Trạng thái: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                                    <asp:DropDownList ID="ddltrangthai" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">
                                     <asp:ListItem Value="0">Còn hàng</asp:ListItem>
                                     <asp:ListItem Value="1">Hết hàng</asp:ListItem>
                                     <asp:ListItem Value="2">New arival</asp:ListItem>
                                    </asp:DropDownList>
&nbsp;
                                    </select>&nbsp;
                                    <asp:Button ID="btntim" runat="server" Text="Tìm sản phẩm" Width="130px" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" OnClick="btntim_Click"/>
                                    <asp:TextBox ID="txttim" runat="server" Width="152px" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Height="31px"></asp:TextBox>
                                &nbsp;<select id="Select1" name="D1" onchange="sortGridViewByPrice(this.value)"style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; width: 145px; height: 24px;">
                        <option value="">Sắp xếp</option>
                        <option value="asc">Giá từ thấp đến cao</option>
                        <option value="desc">Giá từ cao đến thấp</option>
                    </select><br />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 48px; text-align: center;">
                                    <asp:FileUpload ID="FileUploadHinh" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="250px"  />
                                </td>
                            </tr>
                        </table>
                    </p>
                </td>
            </tr>
            <tr>
                <td style="height: 10px">
                    <center>
                   <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" padding="0px 30px" DataKeyNames="MaSP" DataSourceID="SqlDataSourceQLSP" ForeColor="#333333" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; background-color: #FF9999" Width="1300px" OnRowDataBound="GridView1_RowDataBound" GridLines="None">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
        <asp:TemplateField HeaderText="STT">
            <ItemTemplate>
                <asp:Label ID="lblSTT" runat="server"></asp:Label>
        
             
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="MaSP" HeaderText="Mã sản phẩm" ReadOnly="True" SortExpression="MaSP" />
        <asp:BoundField DataField="MaLoaiSP" HeaderText="Mã loại sản phẩm" SortExpression="MaLoaiSP" />
        <asp:BoundField DataField="TenSP" HeaderText="Tên sản phẩm" SortExpression="TenSP" />
        <asp:BoundField DataField="GiaSP" HeaderText="Giá" SortExpression="GiaSP" />
        <asp:TemplateField HeaderText="Hình">
            <ItemTemplate>
                <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("Hinh") %>' Height="200px" Width="150px" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="TrangThai" HeaderText="Trạng thái" SortExpression="TrangThai" />
        <asp:BoundField DataField="Mota" HeaderText="Mô tả" SortExpression="Mota" />
        <asp:BoundField DataField="MauSac" HeaderText="Màu sắc" SortExpression="MauSac" />
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

                    <asp:SqlDataSource ID="SqlDataSourceLoaiSP" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" SelectCommand="SELECT * FROM [LoaiSP]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceQLSP" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" InsertCommand="INSERT INTO SanPham(MaSP, MaLoaiSP, TenSP, GiaSP, Hinh, TrangThai, Mota, MauSac) VALUES (@MaSP, @MaLoaiSP, @TenSP, @GiaSP, @Hinh, @TrangThai, @Mota, @Mausac)" SelectCommand="SELECT * FROM [SanPham]" UpdateCommand="UPDATE SanPham SET MaSP = @MaSP, MaLoaiSP = @MaLoaiSP, TenSP = @TenSP, GiaSP = @GiaSP, Hinh = @Hinh, TrangThai = @TrangThai, Mota = @Mota, MauSac = @MauSac FROM SanPham INNER JOIN SanPham AS SanPham_1 ON SanPham.MaSP = SanPham_1.MaSP WHERE (SanPham.MaSP = @MaSP)">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="MaSP" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="MaLoaiSP" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="TenSP" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="GiaSP" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="Hinh" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="TrangThai" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="Mota" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="Mausac" PropertyName="SelectedValue" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="MaSP" />
                            <asp:Parameter Name="MaLoaiSP" />
                            <asp:Parameter Name="TenSP" />
                            <asp:Parameter Name="GiaSP" />
                            <asp:Parameter Name="Hinh" />
                            <asp:Parameter Name="TrangThai" />
                            <asp:Parameter Name="Mota" />
                            <asp:Parameter Name="MauSac" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</asp:Content>
