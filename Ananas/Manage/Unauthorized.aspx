<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Unauthorized.aspx.cs" Inherits="Ananas.Manage.Unauthorized_aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <div class="container mt-5">
        <div class="alert alert-danger">
            <h4>Bạn không có quyền truy cập trang này!</h4>
            <p>Vui lòng liên hệ với quản trị viên để được cấp quyền truy cập.</p>
            <a href="Dashboard.aspx" class="btn btn-primary">Quay lại trang chính</a>
        </div>
    </div>
        </form>
</asp:Content>
