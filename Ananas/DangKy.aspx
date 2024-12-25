<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="Ananas.DangKy" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Ananas_KLTNConnectionString %>" InsertCommand="INSERT INTO NguoiDung(MaNguoiDung, SoDienThoai, MatKhau, Email, HoTen, NgaySinh, DiaChi, VaiTroID, TrangThai) VALUES (@MaNguoiDung, @SoDienThoai, @MatKhau, @Email, @HoTen, @NgaySinh, @DiaChi, @VaiTroID, 'Kích hoạt')" SelectCommand="SELECT * FROM [NguoiDung]">
            <InsertParameters>
                 <asp:Parameter Name="MaNguoiDung" Type="String" />
        <asp:Parameter Name="SoDienThoai" Type="String" />
        <asp:Parameter Name="MatKhau" Type="String" />
        <asp:Parameter Name="Email" Type="String" />
        <asp:Parameter Name="HoTen" Type="String" />
        <asp:Parameter Name="NgaySinh" Type="DateTime" />
        <asp:Parameter Name="DiaChi" Type="String" />
        <asp:Parameter Name="VaiTroID" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <script>
    function togglePasswordVisibility(fieldId, button) {
        var passwordField = document.getElementById(fieldId);
        if (passwordField.type === "password") {
            passwordField.type = "text";
            button.innerHTML = '<img src="Hinh/hide-icon.png" alt="Hide Password" style="width: 20px; height: 20px;">';
        } else {
            passwordField.type = "password";
            button.innerHTML = '<img src="Hinh/eye-icon.png" alt="Show Password" style="width: 20px; height: 20px;">';
        }
            } 
        </script>
    <style>
        .form-container {
            max-width: 400px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .form-title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #ff6f00;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: #ff6f00;
            box-shadow: 0 0 5px rgba(255, 111, 0, 0.5);
        }

        .error {
            color: red;
            font-size: 14px;
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background-color: #ff6f00;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #e65b00;
        }
        .toggle-icon {
    width: 20px;
    height: 20px;
    cursor: pointer;
    opacity: 0.8;
    transition: opacity 0.3s ease;
}

.toggle-icon:hover {
    opacity: 1;
}

    </style>

    <div class="form-container">
        <h1 class="form-title">Đăng ký</h1>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <div class="form-group">
                <label for="txtPhone">Số điện thoại:</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Vui lòng nhập số điện thoại!" CssClass="error" />
            </div>
          <div class="form-group">
        <label for="txtPassword">Mật khẩu:</label>
        <div style="position: relative;">
            <!-- TextBox ASP.NET để nhập mật khẩu -->
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            
            <!-- Nút hiển thị/ẩn mật khẩu -->
            <button type="button" onclick="togglePasswordVisibility('txtPassword', this)" 
                    style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); border: none; background: none; cursor: pointer;">
                <img src="Hinh/eye-icon.png" alt="Hiển thị/Ẩn mật khẩu" style="width: 20px; height: 20px;" class="toggle-icon">
            </button>
        </div>
    </div>

    <script type="text/javascript">
        function togglePasswordVisibility(inputId, button) {
            // Lấy thẻ input mật khẩu
            var passwordInput = document.getElementById(inputId);

            // Lấy thẻ hình ảnh (icon)
            var icon = button.querySelector("img");

            // Kiểm tra trạng thái hiện tại của input
            if (passwordInput.type === "password") {
                // Đổi sang hiển thị văn bản
                passwordInput.type = "text";
                icon.src = "Hinh/hide-icon.png"; // Biểu tượng "Ẩn"
                icon.alt = "Ẩn mật khẩu";
            } else {
                // Đổi sang ẩn mật khẩu
                passwordInput.type = "password";
                icon.src = "Hinh/eye-icon.png"; // Biểu tượng "Hiển thị"
                icon.alt = "Hiển thị mật khẩu";
            }
        }
    </script>
        <div class="form-group">
    <label for="txtConfirmPassword">Xác nhận mật khẩu:</label>
    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
    <asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Mật khẩu không trùng khớp!" CssClass="error" />
</div>

            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Vui lòng nhập email!" CssClass="error" />
            </div>
            <div class="form-group">
                <label for="txtFullName">Họ tên:</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Vui lòng nhập họ tên!" CssClass="error" />
            </div>
             <div class="form-group">
                <label for="txtDOB">Ngày sinh:</label>
                <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" placeholder="dd-MM-yyyy"></asp:TextBox>
                <ajax:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDOB" Format="dd-MM-yyyy" />
                <i class="calendar-icon fas fa-calendar"></i> <!-- Font Awesome icon -->
                <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="txtDOB" ErrorMessage="Vui lòng nhập ngày sinh!" CssClass="error" />
            </div>
            <div class="form-group">
                <label for="txtAddress">Địa chỉ:</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Vui lòng nhập địa chỉ!" CssClass="error" />
            </div>
            <asp:Button ID="btnRegister" runat="server" CssClass="btn-submit" Text="Đăng ký" OnClick="btnRegister_Click" />
     
    </div>

        </form>
</asp:Content>
