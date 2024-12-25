<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchBar.ascx.cs" Inherits="Ananas.Manage.SearchBar" %>
<div class="input-group">
    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Nhập từ khóa tìm kiếm..." />
    <div class="input-group-append">
        <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
    </div>
</div>