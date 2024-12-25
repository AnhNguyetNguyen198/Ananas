<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLySize.aspx.cs" Inherits="Ananas.QuanLySize" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <table style="width: 100%">
     <tr>
         <td style="font-family: Arial, Helvetica, sans-serif; font-size: xx-large; text-align: center; background-color: #F1F1F1; height: 50px" colspan="2"><strong>QUẢN LÝ SIZE</strong></td>
     </tr>
     <tr>
         <td style="width: 1499px">
             <asp:ImageButton ID="btnback" runat="server" ImageUrl="~/Hinh/back.png" OnClick="btnback_Click" />
         </td>
         <td><span style="font-family: 'Times New Roman', Times, serif; font-size: 13pt">
             <asp:ImageButton ID="btnreset" runat="server" ImageUrl="~/Hinh/resetbutton.png" style= "text-align: right; margin-left: 0px;" OnClick="btnreset_Click" />
         </span>
         </td>
     </tr>
            <tr>
                <td style="text-align: center" colspan="2">
                    <asp:Button ID="btnthem" runat="server" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" Text="Thêm mới" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" OnClick="btnthem_Click" />
&nbsp;<asp:Label ID="lblmasize" runat="server" Text="Mã size: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmasize" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
&nbsp;<asp:Label ID="lbltensize" runat="server" Text="Tên size: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txttensize" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                    <center>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MaSize" DataSourceID="SqlDataSourceSize" ForeColor="#333333" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="468px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                            <asp:BoundField DataField="MaSize" HeaderText="Mã size" ReadOnly="True" SortExpression="MaSize" />
                            <asp:BoundField DataField="TenSize" HeaderText="Tên size" SortExpression="TenSize" />
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
                    <asp:SqlDataSource ID="SqlDataSourceSize" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" DeleteCommand="DELETE FROM Size WHERE (MaSize = @MaSize)" InsertCommand="INSERT INTO Size(MaSize, TenSize) VALUES (@MaSize, @TenSize)" SelectCommand="SELECT * FROM [Size]" UpdateCommand="UPDATE Size SET MaSize = @MaSize, TenSize = @TenSize WHERE (MaSize = @MaSize)">
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="MaSize" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="GridView1" Name="TenSize" PropertyName="SelectedValue" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 1499px">&nbsp;</td>
            </tr>
        </table>
    </form>
</asp:Content>
