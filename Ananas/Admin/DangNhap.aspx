<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="Ananas.DangNhap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <p>
        <br />
    </p>
    <p>
    </p>
    <p>
        <center>
        <asp:Login ID="Login1" runat="server" CreateUserText="Đăng ký" CreateUserUrl="~/DangKy.aspx" DestinationPageUrl="~/TrangChu.aspx" BackColor="#F7F7DE" BorderColor="#CCCC99" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="10pt" Height="227px" LoginButtonText="Đăng nhập" OnAuthenticate="Login1_Authenticate" PasswordLabelText="Mật khẩu:" PasswordRequiredErrorMessage="Nhập mật khẩu!" RememberMeText="Ghi nhớ cho lần đăng nhập sau." style="font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif; font-size: 15pt" TitleText="Đăng nhập ở đây" UserNameLabelText="Tên người dùng: " UserNameRequiredErrorMessage="Nhập tên người dùng!" Width="441px">
            <HyperLinkStyle Font-Bold="True" Font-Names="Cambria" Font-Size="15pt" Font-Underline="False" ForeColor="#ED6A32" />
            <LoginButtonStyle BackColor="#ED6A32" BorderColor="#ED6A32" Font-Names="Cambria" Font-Size="13pt" ForeColor="White" />
            <TitleTextStyle BackColor="#ED6A32" Font-Bold="True" Font-Names="Cambria" Font-Size="18pt" ForeColor="#FFFFFF" Height="50px" />
            <ValidatorTextStyle Font-Names="Cambria" />
        </asp:Login>
    </p>
    <p>
    </p>
    <p>
    </p>
</form>
</asp:Content>
