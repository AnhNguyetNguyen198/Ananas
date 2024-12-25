<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BCHoadon.aspx.cs" Inherits="Ananas.BCHoadon" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <center>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="" ClientIDMode="AutoID" CssClass="auto-style1" Height="761px" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" style="margin-top: 30px" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" Width="1352px">
                <LocalReport ReportPath="BaoCao\BCDH.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="QLHD" Name="DataSet1" />
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
        </div>
        <center>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Ananas.BCHoaDonTableAdapters.HoaDonTableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_MaHD" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MaHD" Type="String" />
                <asp:Parameter Name="MaKH" Type="String" />
                <asp:Parameter Name="MaNV" Type="String" />
                <asp:Parameter Name="TongTien" Type="Double" />
                <asp:Parameter Name="NgayTao" Type="DateTime" />
                <asp:Parameter Name="NgayGiaoHang" Type="DateTime" />
                <asp:Parameter Name="PTTT" Type="String" />
                <asp:Parameter Name="PTGH" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="MaKH" Type="String" />
                <asp:Parameter Name="MaNV" Type="String" />
                <asp:Parameter Name="TongTien" Type="Double" />
                <asp:Parameter Name="NgayTao" Type="DateTime" />
                <asp:Parameter Name="NgayGiaoHang" Type="DateTime" />
                <asp:Parameter Name="PTTT" Type="String" />
                <asp:Parameter Name="PTGH" Type="String" />
                <asp:Parameter Name="Original_MaHD" Type="String" />
            </UpdateParameters>
           
        </asp:ObjectDataSource>
         <center>
        <asp:SqlDataSource ID="QLHD" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT * FROM [HoaDon]"></asp:SqlDataSource>
    </form>
</body>
</html>
