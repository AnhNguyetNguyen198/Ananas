<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BCCTHD.aspx.cs" Inherits="Ananas.WebForm1" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <center>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="766px" Width="758px" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
            <LocalReport ReportPath="BaoCao\BCCTHD.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="SqlDataSourceCTHoaDon" Name="DataSet1" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Ananas.QLCTHDTableAdapters.ChiTietHDTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_MaHD" Type="String" />
                    <asp:Parameter Name="Original_MaSP" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="MaHD" Type="String" />
                    <asp:Parameter Name="MaSP" Type="String" />
                    <asp:Parameter Name="SoLuong" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SoLuong" Type="Int32" />
                    <asp:Parameter Name="Original_MaHD" Type="String" />
                    <asp:Parameter Name="Original_MaSP" Type="String" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:SqlDataSource ID="SqlDataSourceCTHoaDon" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT * FROM [ChiTietHD]"></asp:SqlDataSource>
    </form>
</body>
</html>
