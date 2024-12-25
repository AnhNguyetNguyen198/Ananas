<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyKhuyenMai.aspx.cs" Inherits="Ananas.QuanLyKhuyenMai" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td style="font-family: Arial, Helvetica, sans-serif; font-size: xx-large; text-align: center; background-color: #F1F1F1; height: 50px" colspan="2">
                    <strong>QUẢN LÝ KHUYẾN MÃI</strong>
                </td>
            </tr>
            <tr>
                <td style="width: 1499px">
                    <asp:ImageButton ID="btnback" runat="server" ImageUrl="~/Hinh/back.png" OnClick="btnback_Click" style="height: 30px" />
                </td>
                <td>
                    <span style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">
                        <asp:ImageButton ID="btnreset" runat="server" ImageUrl="~/Hinh/resetbutton.png" style="text-align: right; margin-left: 0px;" OnClick="btnreset_Click" />
                    </span>
                </td>
            </tr>
            <tr>
                <td style="height: 27px; text-align: center; font-family: 'Times New Roman', Times, serif; font-size: 13pt;" colspan="2">
                    <p style="margin-top: 12px; margin-bottom: 12px; line-height: 150%;">
                        <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
                        &nbsp;<asp:Label ID="lblmakm" runat="server" Text="Mã khuyến mãi: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                        <asp:TextBox ID="txtmakm" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                        &nbsp;<asp:Label ID="lbltenkm" runat="server" Text="Tên khuyến mãi: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                        <asp:TextBox ID="txttenkm" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                        &nbsp;<asp:Label ID="lblngaybatdau" runat="server" Text="Ngày bắt đầu: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                        <asp:TextBox ID="txtngaybatdau" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                        &nbsp;<asp:Label ID="lblngayketthuc" runat="server" Text="Ngày kết thúc: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                        <asp:TextBox ID="txtngayketthuc" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    &nbsp;<asp:Label ID="lblchietkhau" runat="server" Text="Chiết khấu: "></asp:Label>
                        <asp:TextBox ID="txtchietkhau" runat="server"></asp:TextBox>
                    </p>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <center>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="MaKM" DataSourceID="SqlDataSourceKhuyenMai" CellPadding="4" ForeColor="#333333" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="800px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="MaKM" HeaderText="MaKM" ReadOnly="True" SortExpression="MaKM" />
                                <asp:BoundField DataField="TenKM" HeaderText="TenKM" SortExpression="TenKM" />
                                <asp:BoundField DataField="NgayBatDau" HeaderText="NgayBatDau" SortExpression="NgayBatDau" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" />
                                <asp:BoundField DataField="NgayKetThuc" HeaderText="NgayKetThuc" SortExpression="NgayKetThuc" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" />
                                <asp:BoundField DataField="ChietKhau" HeaderText="ChietKhau" SortExpression="ChietKhau" />
                            </Columns>
                            <EditRowStyle BackColor="#7C6F57" />
                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#ED6A32" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" Height="50px" />
                            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F1F1F1" />
                            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F8FAFA" />
                            <SortedAscendingHeaderStyle BackColor="#246B61" />
                            <SortedDescendingCellStyle BackColor="#D4DFE1" />
                            <SortedDescendingHeaderStyle BackColor="#15524A" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceKhuyenMai" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" SelectCommand="SELECT * FROM [KhuyenMai]" DeleteCommand="DELETE FROM KhuyenMai WHERE (MaKM = @MaKM)" InsertCommand="INSERT INTO KhuyenMai(MaKM, TenKM, NgayBatDau, NgayKetThuc, ChietKhau) VALUES (@MaKM, @TenKM, @NgayBatDau, @NgayKetThuc, @ChietKhau)">
                            <DeleteParameters>
                                <asp:Parameter Name="MaKM" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </center>
                </td>
            </tr>
            <tr>
                <td style="width: 1499px">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</asp:Content>
