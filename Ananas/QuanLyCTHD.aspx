<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyCTHD.aspx.cs" Inherits="Ananas.QuanLyCTHD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <script type="text/javascript">
            function sortGridViewByPrice(value) {
                __doPostBack('SortGridView', value);
            }
        </script>

        <table style="width: 100%">
            <tr>
                <td colspan="3" style="text-align: center; font-family: Arial; font-size: xx-large;height: 40px; background-color: #F1F1F1"><strong>QUẢN LÝ CHI TIẾT HÓA ĐƠN</strong></td>
            </tr>
            <tr>
                <td style="text-align: left; height: 38px;">
                    <asp:ImageButton ID="btnBack" runat="server" ImageUrl="Hinh/back.png" Width="30px" Height="30px" ToolTip="Quay về trang chủ" OnClick="btnBack_Click" />
                </td>
                <td style="text-align: right; height: 38px;">
                    <asp:HyperLink ID="HyperLink3" runat="server" Font-Bold="True" Font-Names="Cambria" Font-Size="13pt" ForeColor="#ED6A32" NavigateUrl="~/BCCTHD.aspx">Báo cáo thống kê</asp:HyperLink>
                <asp:ImageButton ID="reset" runat="server" ImageUrl="~/Hinh/resetbutton.png" OnClick="reset_Click" style="width: 30px" />
                </td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center">
                    <p style="line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                    &nbsp;<asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px" />
                    <asp:Label ID="lblmahd" runat="server" Text="Mã hóa đơn: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmahd" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblmasp" runat="server" Text="Mã sản phẩm: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmasp" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblmasize" runat="server" Text="Mã size: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmasize" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    </p>
                    <p style="line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                    <asp:Label ID="lblsoluong" runat="server" Text="Số lượng: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtsoluong" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    &nbsp;<asp:Label ID="lbldongia" runat="server" Text="Đơn giá: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtdongia" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    &nbsp;
                    <asp:Button ID="btntim" runat="server" OnClick="btntim_Click" Text="Tìm hóa đơn" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="130px" />
                    &nbsp;<asp:TextBox ID="txtmahoadon" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Height="27px" Width="128px"></asp:TextBox>
                    &nbsp;<select id="Select1" name="D1" onchange="sortGridViewByPrice(this.value)" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt; width: 118px; height: 19px;">
                        <option value="">Sắp xếp</option>
                        <option value="asc">Giá từ thấp đến cao</option>
                        <option value="desc">Giá từ cao đến thấp</option>
                        <option value="banchay">Sản phẩm bán chạy</option>
                        <option value ="hoadon">Sắp xếp theo mã hóa đơn</option>
                    </select>
                    </p>
                </td>
            </tr>
            <tr>
                <td style="height: 264px"></td>
                <td style="height: 264px">
                    <div style="text-align: center">
                        <center>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaHD,MaSP,MaSize" DataSourceID="SqlDataSourceCTHD" ForeColor="#333333" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="1000px" OnRowDataBound="GridView1_RowDataBound" HorizontalAlign="Center">
                                <Columns>
                                    <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                                    <asp:TemplateField HeaderText="STT">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSTT" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="MaHD" HeaderText="Mã hóa đơn" ReadOnly="True" SortExpression="MaHD" />
                                    <asp:BoundField DataField="MaSP" HeaderText="Mã sản phẩm" ReadOnly="True" SortExpression="MaSP" />
                                    <asp:BoundField DataField="MaSize" HeaderText="Mã size" SortExpression="MaSize" ReadOnly="True" />
                                    <asp:BoundField DataField="SoLuong" HeaderText="Số lượng" SortExpression="SoLuong" />
                                    <asp:BoundField DataField="DonGia" HeaderText="Đơn giá" SortExpression="DonGia" />
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
                            <asp:SqlDataSource ID="SqlDataSourceCTHD" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" DeleteCommand="DELETE FROM ChiTietHoaDon WHERE (MaHD = @MaHD) AND (MaSP = @MaSP) AND (MaSize = @MaSize)" InsertCommand="INSERT INTO ChiTietHoaDon(MaHD, MaSP, MaSize, SoLuong, DonGia) VALUES (@MaHD, @MaSP, @MaSize, @SoLuong, @DonGia)" SelectCommand="SELECT * FROM ChiTietHoaDon ORDER BY DonGia ASC" UpdateCommand="UPDATE ChiTietHoaDon SET SoLuong = @SoLuong, DonGia = @DonGia WHERE (MaHD = @MaHD) AND (MaSP = @MaSP) AND (MaSize = @MaSize)">
                                <DeleteParameters>
                                    <asp:Parameter Name="MaHD" Type="String" />
                                    <asp:Parameter Name="MaSP" Type="String" />
                                    <asp:Parameter Name="MaSize" Type="String" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="MaHD" Type="String" />
                                    <asp:Parameter Name="MaSP" Type="String" />
                                    <asp:Parameter Name="MaSize" Type="String" />
                                    <asp:Parameter Name="SoLuong" Type="Int32" />
                                    <asp:Parameter Name="DonGia" Type="Decimal" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="SoLuong" Type="Int32" />
                                    <asp:Parameter Name="DonGia" Type="Decimal" />
                                    <asp:Parameter Name="MaHD" Type="String" />
                                    <asp:Parameter Name="MaSP" Type="String" />
                                    <asp:Parameter Name="MaSize" Type="String" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </center>
                    </div>
                </td>
                <td style="height: 264px"></td>
            </tr>
        </table>
    </form>
</asp:Content>
