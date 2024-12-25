<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BCSanpham.aspx.cs" Inherits="Ananas.BCSanpham" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Báo cáo sản phẩm - CTCP Hazza</title>
    
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="report-viewer">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
           
            </div>
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="101%" Height="2500px" CssClass="auto-style1" style="margin-right: 0px">
                    <LocalReport ReportPath="BaoCao\BCSP.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="SqlDataSourceQLSanPham" Name="DataSet1" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
                <asp:SqlDataSource ID="SqlDataSourceQLSanPham" runat="server" ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>" 
                    SelectCommand="SELECT [MaSP], [MaLoaiSP], [TenSP], [GiaSP], [TrangThai], [MauSac] FROM [SanPham]">
                </asp:SqlDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetData" 
                    TypeName="Ananas.QuanliSPTableAdapters.SanPhamTableAdapter" 
                    DeleteMethod="Delete" InsertMethod="Insert" 
                    OldValuesParameterFormatString="original_{0}" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_MaSP" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="MaSP" Type="String" />
                        <asp:Parameter Name="MaLoaiSP" Type="String" />
                        <asp:Parameter Name="TenSP" Type="String" />
                        <asp:Parameter Name="GiaSP" Type="Double" />
                        <asp:Parameter Name="Hinh" Type="String" />
                        <asp:Parameter Name="TrangThai" Type="String" />
                        <asp:Parameter Name="Mota" Type="String" />
                        <asp:Parameter Name="MauSac" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="MaLoaiSP" Type="String" />
                        <asp:Parameter Name="TenSP" Type="String" />
                        <asp:Parameter Name="GiaSP" Type="Double" />
                        <asp:Parameter Name="Hinh" Type="String" />
                        <asp:Parameter Name="TrangThai" Type="String" />
                        <asp:Parameter Name="Mota" Type="String" />
                        <asp:Parameter Name="MauSac" Type="String" />
                        <asp:Parameter Name="Original_MaSP" Type="String" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </div>
        </div>
    </form>
</body>
</html>
