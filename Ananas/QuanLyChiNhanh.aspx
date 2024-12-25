<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyChiNhanh.aspx.cs" Inherits="Ananas.QuanLyChiNhanh" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td style="font-family: Arial, Helvetica, sans-serif; font-size: xx-large; text-align: center; background-color: #F1F1F1; height: 50px" colspan="2"><strong>QUẢN LÝ CHI NHÁNH</strong></td>
            </tr>
            <tr>
                <td style="width: 1499px">
                    <asp:ImageButton ID="btnback" runat="server" ImageUrl="~/Hinh/back.png" OnClick="btnback_Click" style="height: 30px" />
                </td>
                <td><span style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">
                    <asp:ImageButton ID="btnreset" runat="server" ImageUrl="~/Hinh/resetbutton.png" style= "text-align: right; margin-left: 0px;" OnClick="btnreset_Click" />
                </span>
                </td>
            </tr>
            <tr>
                <td style="height: 27px; text-align: center; font-family: 'Times New Roman', Times, serif; font-size: 13pt;" colspan="2">
                    <p style="margin-top: 12px; margin-bottom: 12px; line-height: 150%;">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
&nbsp;<asp:Label ID="lblmacn" runat="server" Text="Mã chi nhánh: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmacn" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
&nbsp;<asp:Label ID="lbltencn" runat="server" Text="Tên chi nhánh: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txttencn" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                        <asp:Label ID="lbldiachi" runat="server" Text="Địa chỉ: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtdiachi" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    &nbsp;<asp:Label ID="lblsdt" runat="server" Text="SĐT: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtsdt" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    </p>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <center>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="MaCN" DataSourceID="SqlDataSourceChiNhanh" CellPadding="4" ForeColor="#333333" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="638px" >
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                            <asp:BoundField DataField="MaCN" HeaderText="Mã chi nhánh" ReadOnly="True" SortExpression="MaCN" />
                            <asp:BoundField DataField="TenCN" HeaderText="Tên chi nhánh" SortExpression="TenCN" />
                            <asp:BoundField DataField="DiaChiCN" HeaderText="Địa chỉ" SortExpression="DiaChiCN" />
                            <asp:BoundField DataField="SDTCN" HeaderText="Số điện thoại" SortExpression="SDTCN" />
                            <asp:CommandField DeleteText="Xóa" ShowDeleteButton="True" />
                            <asp:CommandField CancelText="Hủy" EditText="Sửa" ShowEditButton="True" UpdateText="Cập nhật" />
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
                        <asp:SqlDataSource ID="SqlDataSourceChiNhanh" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" DeleteCommand="DELETE FROM ChiNhanh WHERE (MaCN = @MaCN)" InsertCommand="INSERT INTO ChiNhanh(MaCN, TenCN, DiaChiCN, SDTCN) VALUES (@MaCN, @TenCN, @DiaChiCN, @SDTCN)" SelectCommand="SELECT * FROM [ChiNhanh]" UpdateCommand="UPDATE ChiNhanh SET MaCN = @MaCN, TenCN = @TenCN, DiaChiCN = @DiaChiCN, SDTCN = @SDTCN WHERE (MaCN = @MaCN)">
                            <DeleteParameters>
                                <asp:Parameter Name="MaCN" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="MaCN" />
                                <asp:Parameter Name="TenCN" />
                                <asp:Parameter Name="DiaChiCN" />
                                <asp:Parameter Name="SDTCN" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="MaCN" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="GridView1" Name="TenCN" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="GridView1" Name="DiaChiCN" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="GridView1" Name="SDTCN" PropertyName="SelectedValue" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 1499px">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</asp:Content>
