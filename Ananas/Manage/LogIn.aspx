<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="Ananas.Manage.LogIn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <form id="form1" runat="server">
        <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
            <div class="card shadow-lg" style="width: 400px;">
                <div class="card-body">
                    <h2 class="text-center text-primary mb-4">Đăng Nhập</h2>
                    <div class="mb-3">
                        <label for="txtEmail" class="form-label">Email:</label>
<asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Nhập email của bạn"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                       <label for="txtPassword" class="form-label">Mật khẩu:</label>
<asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập mật khẩu"></asp:TextBox>
                    </div>
                    <div class="d-grid">
                        <asp:Button ID="btnLogin" runat="server" Text="Đăng Nhập" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                    </div>
                    <div class="text-center mt-3">
                        <a href="QuenMatKhau.aspx" class="text-decoration-none">Quên mật khẩu?</a>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
