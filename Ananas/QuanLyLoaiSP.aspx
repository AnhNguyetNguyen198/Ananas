﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLyLoaiSP.aspx.cs" Inherits="Ananas.QuanLyLoaiSP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td style="font-family: Arial, Helvetica, sans-serif; font-size: xx-large; text-align: center; background-color: #F1F1F1; height: 50px" colspan="2"><strong>QUẢN LÝ LOẠI SẢN PHẨM</strong></td>
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
                <td style="height: 27px; text-align: center; font-family: 'Times New Roman', Times, serif; font-size: 13pt;" colspan="2">
                    <p style="margin-top: 12px; margin-bottom: 12px; line-height: 150%;">
                    <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm mới" BackColor="#ED6A32" BorderColor="#ED6A32" ForeColor="White" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" />
&nbsp;<asp:Label ID="lblmalsp" runat="server" Text="Mã loại sản phẩm: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txtmalsp" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
&nbsp;<asp:Label ID="lbltenloaisp" runat="server" Text="Tên loại sản phẩm: " style="font-family: 'Times New Roman', Times, serif; font-size: 13pt"></asp:Label>
                    <asp:TextBox ID="txttenlsp" runat="server" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="120px"></asp:TextBox>
                    </p>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <center>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="MaLoaiSP" DataSourceID="SqlDataSourceLoaiSP" CellPadding="4" ForeColor="#333333" style="font-family: 'Times New Roman', Times, serif; font-size: 13pt" Width="638px" >
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField SelectText="Chọn" ShowSelectButton="True" />
                            <asp:BoundField DataField="MaLoaiSP" HeaderText="Mã loại sản phẩm" ReadOnly="True" SortExpression="MaLoaiSP" />
                            <asp:BoundField DataField="TenLoaiSP" HeaderText="Tên loại sản phẩm" SortExpression="TenLoaiSP" />
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
                    <asp:SqlDataSource ID="SqlDataSourceLoaiSP" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString2 %>" DeleteCommand="DELETE FROM LoaiSP WHERE (MaLoaiSP = @MaLoaiSP)" InsertCommand="INSERT INTO LoaiSP(MaLoaiSP, TenLoaiSP) VALUES (@MaLoaiSP, @TenLoaiSP)" SelectCommand="SELECT * FROM [LoaiSP]" UpdateCommand="UPDATE LoaiSP SET TenLoaiSP = @TenLoaiSP WHERE (MaLoaiSP = @MaLoaiSP)">
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="MaLoaiSP" PropertyName="SelectedValue" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="MaLoaiSP" />
                            <asp:Parameter Name="TenLoaiSP" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="TenLoaiSP" PropertyName="SelectedValue[2]" />
                            <asp:ControlParameter ControlID="GridView1" Name="MaLoaiSP" PropertyName="SelectedValue" />
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