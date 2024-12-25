<%@ Page Title="Lịch sử sao lưu và phục hồi" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="BackupHistory.aspx.cs" Inherits="Ananas.Manage.BackupHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Lịch Sử Sao Lưu và Phục Hồi
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h1 class="text-center">Lịch Sử Sao Lưu và Phục Hồi</h1>
            
            <!-- Nút Sao Lưu Thủ Công -->
            <div class="text-center mt-4">
                <asp:Button ID="btnBackup" runat="server" CssClass="btn btn-primary" Text="Thực hiện sao lưu" OnClick="PerformBackup" />
            </div>

            <!-- Lịch sử sao lưu -->
            <asp:GridView ID="GridViewBackupHistory" runat="server" CssClass="table table-bordered mt-4" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="BackupID" HeaderText="ID" />
                    <asp:BoundField DataField="DatabaseName" HeaderText="Tên Cơ Sở Dữ Liệu" />
                    <asp:BoundField DataField="BackupPath" HeaderText="Đường Dẫn Sao Lưu" />
                    <asp:BoundField DataField="BackupDate" HeaderText="Ngày Giờ Sao Lưu" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="Status" HeaderText="Trạng Thái" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnRestore" runat="server" Text="Phục Hồi" CommandArgument='<%# Eval("BackupPath") %>' OnClick="PerformRestore" CssClass="btn btn-danger btn-sm" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</asp:Content>
