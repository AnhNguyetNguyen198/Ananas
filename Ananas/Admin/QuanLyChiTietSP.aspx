<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyChiTietSP.aspx.cs" Inherits="Ananas.QuanLyChiTietSP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td style="font-family: Arial; font-size: xx-large; text-align: center; height: 50px; background-color: #F1F1F1"><strong>QUẢN LÝ CHI TIẾT SẢN PHẨM</strong></td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <div style="text-align: left">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 746px">
                                    <p style="line-height: 150%; text-align: center; margin-top: 12px; margin-bottom: 12px">
                                        <span style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">Size&nbsp;
                    </span>
                    <asp:DropDownList ID="ddlsize" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceSize" DataTextField="TenSize" DataValueField="MaSize" OnSelectedIndexChanged="ddlsize_SelectedIndexChanged" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="100px" AppendDataBoundItems="True">
                        <asp:ListItem Value="*">Tất cả</asp:ListItem>
                    </asp:DropDownList>
                                    </p>
                                </td>
                                <td style="text-align: right">
                                    <p style="line-height: 150%; margin-top: 12px; margin-bottom: 12px">
                                        <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" ForeColor="#ED6A32" NavigateUrl="~/Admin/TrangChuAdmin.aspx" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">Trở về trang chủ</asp:HyperLink>
                                        <span style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <p style="line-height: 150%; text-align: center; margin-top: 12px; margin-bottom: 12px">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
                    <asp:Label ID="lblmasp" runat="server" Text="Mã sản phẩm: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmasp" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lblphantren" runat="server" Text="Phần trên: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtphantren" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    <asp:Label ID="lbldengoai" runat="server" Text="Đế ngoài: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtdengoai" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:TextBox>
                    </p>
                </td>
            </tr>
            <tr>
                <td>
                    <center>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaSP,MaSize" DataSourceID="SqlDataSourceCTSP" ForeColor="#333333" GridLines="None" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                            <asp:BoundField DataField="MaSP" HeaderText="Mã sản phẩm" ReadOnly="True" SortExpression="MaSP" />
                            <asp:BoundField DataField="MaSize" HeaderText="Mã size" ReadOnly="True" SortExpression="MaSize" />
                            <asp:BoundField DataField="Phantren" HeaderText="Phần trên" SortExpression="Phantren" />
                            <asp:BoundField DataField="DeNgoai" HeaderText="Đế ngoài" SortExpression="DeNgoai" />
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
                </td>
            </tr>
            <tr>
                <td>
                    <asp:SqlDataSource ID="SqlDataSourceCTSP" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT MaSP, MaSize, Phantren, DeNgoai FROM ChiTietSP WHERE (MaSize = @MaSize)" DeleteCommand="DELETE FROM ChiTietSP WHERE (MaSP = @MaSP) AND (MaSize = @MaSize)" InsertCommand="INSERT INTO ChiTietSP(MaSP, MaSize, Phantren, DeNgoai) VALUES (@MaSP, @MaSize, @PhanTren, @DeNgoai)" UpdateCommand="UPDATE ChiTietSP SET Phantren = @Phantren, DeNgoai = @DeNgoai WHERE (MaSP = @MaSP) AND (MaSize = @MaSize)">
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="MaSP" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="MaSize" PropertyName="SelectedValue" />
                            <asp:Parameter Name="Phantren" />
                            <asp:Parameter Name="DeNgoai" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlsize" Name="MaSize" PropertyName="SelectedValue" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="Phantren" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="DeNgoai" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="MaSP" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="MaSize" PropertyName="SelectedValue" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:SqlDataSource ID="SqlDataSourceSize" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT * FROM [Size]"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </form>
</asp:Content>
