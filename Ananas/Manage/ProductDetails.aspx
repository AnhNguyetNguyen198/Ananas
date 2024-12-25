<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="Ananas.Manage.ProductDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Chi Tiết Sản Phẩm
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h2>
                <asp:Label ID="lblProductName" runat="server" Text="Tên Sản Phẩm"></asp:Label>
            </h2>
            <asp:Image ID="imgProduct" runat="server" CssClass="img-fluid mb-3" />
            <p><strong>Giá:</strong> <asp:Label ID="lblProductPrice" runat="server" Text=""></asp:Label></p>
            <p><strong>Mô Tả:</strong></p>
            <p>
                <asp:Label ID="lblProductDescription" runat="server" Text=""></asp:Label>
            </p>
            <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
        </div>
    </form>
</asp:Content>