<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BCCTSP.aspx.cs" Inherits="Ananas.BCCTSP" %>

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
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="1155px" Width="1049px" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
                <LocalReport ReportPath="BaoCao\BCCTSP.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="SqlDataSourceCTSP" Name="DataSet1" />
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Ananas.QanLyChiTietSPTableAdapters.ChiTietSPTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_MaSP" Type="String" />
                        <asp:Parameter Name="Original_MaSize" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="MaSP" Type="String" />
                        <asp:Parameter Name="MaSize" Type="String" />
                        <asp:Parameter Name="Phantren" Type="String" />
                        <asp:Parameter Name="DeNgoai" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Phantren" Type="String" />
                        <asp:Parameter Name="DeNgoai" Type="String" />
                        <asp:Parameter Name="Original_MaSP" Type="String" />
                        <asp:Parameter Name="Original_MaSize" Type="String" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:SqlDataSource ID="SqlDataSourceCTSP" runat="server" ConnectionString="<%$ ConnectionStrings:ANANASConnectionString %>" SelectCommand="SELECT * FROM [ChiTietSP]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
