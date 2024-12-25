<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BaoCaoDoanhThu.aspx.cs" Inherits="Ananas.BaoCaoDoanhThu" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
 
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Báo cáo doanh thu</title>
</head>
<body>
<form id="form1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<div>
<rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="2500px">
<LocalReport ReportPath="Report\BaoCaoDoanhThu.rdlc">
<DataSources>
<rsweb:ReportDataSource DataSourceId="DoanhThuDataSource" Name="DataSet2" />
</DataSources>
</LocalReport>
</rsweb:ReportViewer>
<asp:SqlDataSource ID="DoanhThuDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:AnanasConnectionString2 %>"
                SelectCommand="SELECT 
    chitiethoadon.mahd,
    sanpham.tensp,
    hoadon.ngaytaohd,
    chitiethoadon.soluong,
    chitiethoadon.dongia,
    chitiethoadon.soluong * chitiethoadon.dongia AS ThanhTien
FROM 
    chitiethoadon
INNER JOIN 
    hoadon ON hoadon.mahd = chitiethoadon.mahd
INNER JOIN 
    sanpham ON sanpham.masp = chitiethoadon.masp
WHERE 
    MONTH(hoadon.ngaytaohd) = 3 AND YEAR(hoadon.ngaytaohd) = 2023;">
</asp:SqlDataSource>
</div>
</form>
</body>
</html>