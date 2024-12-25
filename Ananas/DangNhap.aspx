<%@ Page Title="Đăng Nhập" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="Ananas.DangNhap" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">

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

            .link-text {
                display: block;
                text-align: center;
                color: #ff6f00;
                text-decoration: none;
                margin-top: 15px;
                font-size: 14px;
            }

                .link-text:hover {
                    text-decoration: underline;
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

            .forgot-password-container, .change-password-container {
                display: none;
            }

                .forgot-password-container.active, .change-password-container.active {
                    display: block;
                }

            .password-container {
                position: relative;
            }

                .password-container button {
                    position: absolute;
                    right: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                    border: none;
                    background: none;
                    cursor: pointer;
                }

            #lblError {
                display: block; /* Hoặc inline-block tùy vào nhu cầu */
            }

            .popup {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1000;
            }

            .popup-content {
                position: relative;
                background-color: white;
                margin: 10% auto;
                padding: 20px;
                border-radius: 8px;
                width: 300px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .close-btn {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 20px;
                cursor: pointer;
            }

                .close-btn:hover {
                    color: red;
                }

            .btn-submit {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                background-color: #ff6f00;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

                .btn-submit:hover {
                    background-color: #e65b00;
                }
        </style>

        <div class="form-container">
            <h1 class="form-title">Đăng Nhập</h1>

            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Vui lòng nhập email!" CssClass="error" />
            </div>
            <div class="form-group password-container" style="position: relative;">
                <label for="txtPassword">Mật khẩu:</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>

                <!-- Nút ẩn/hiện mật khẩu -->
                <button type="button" onclick="togglePasswordVisibility('txtPassword', this)"
                    style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); border: none; background: none; cursor: pointer;">
                    <!-- Icon mặc định là eye-icon -->
                    <img src="Hinh/eye-icon.png" alt="Hiển thị mật khẩu" style="width: 20px; height: 20px;" id="passwordToggleIcon">
                </button>
            </div>

            <script>
                // Hàm toggle để thay đổi giữa hiển thị và ẩn mật khẩu
                function togglePasswordVisibility(fieldId, button) {
                    var passwordField = document.getElementById(fieldId); // Lấy trường mật khẩu
                    var icon = button.querySelector("img"); // Lấy icon bên trong button

                    // Kiểm tra nếu mật khẩu đang ở chế độ "password" (ẩn)
                    if (passwordField.type === "password") {
                        // Đổi sang hiển thị mật khẩu
                        passwordField.type = "text";
                        icon.src = "Hinh/hide-icon.png";  // Chuyển icon thành hide-icon (ẩn mật khẩu)
                        icon.alt = "Ẩn mật khẩu";  // Thay đổi alt text của icon
                    } else {
                        // Đổi sang ẩn mật khẩu
                        passwordField.type = "password";
                        icon.src = "Hinh/eye-icon.png";  // Chuyển icon thành eye-icon (hiển thị mật khẩu)
                        icon.alt = "Hiển thị mật khẩu";  // Thay đổi alt text của icon
                    }
                }
            </script>

            <asp:Button ID="btnLogin" runat="server" CssClass="btn-submit" Text="Đăng Nhập" OnClick="btnLogin_Click" />

            <a href="DangKy.aspx" class="link-text">Chưa có tài khoản? Đăng ký ngay!</a>

            <a href="javascript:void(0);" class="link-text" id="resetPasswordLink">Quên mật khẩu?</a>
            <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>

            <!-- Quên Mật Khẩu -->
            <div id="forgotPasswordPopup" class="popup">
                <div class="popup-content">
                    <span class="close-btn" id="closeForgotPassword">&times;</span>
                    <h3>Quên Mật Khẩu?</h3>
                    <div class="form-group">
                        <label for="forgotEmail">Nhập email của bạn:</label>
                        <input type="email" id="forgotEmail" class="form-control" placeholder="Nhập email để nhận liên kết" />
                    </div>
                    <button class="btn-submit" id="sendResetLinkBtn">Gửi Liên Kết Đổi Mật Khẩu</button>
                </div>
            </div>

            <div class="change-password-container " id="changePasswordContainer">
                <h3>Đổi Mật Khẩu</h3>
                <div class="form-group">
                    <label for="newPassword">Mật khẩu mới:</label>
                    <input type="password" id="newPassword" class="form-control" placeholder="Nhập mật khẩu mới" runat="server" />
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                    <input type="password" id="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu mới" runat="server" />
                </div>
                <button type="submit" class="btn-submit" id="changePasswordBtn" runat="server" onserverclick="btnChangePassword_Click">Đổi Mật Khẩu</button>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var forgotPasswordLink = document.getElementById("resetPasswordLink");
                var forgotPasswordPopup = document.getElementById("forgotPasswordPopup");
                var resetPasswordPopup = document.getElementById("changePasswordContainer");
                var closeForgotPassword = document.getElementById("closeForgotPassword");
                var sendResetLinkBtn = document.getElementById("sendResetLinkBtn");


                const urlParams = new URLSearchParams(window.location.search);
                const myParam = urlParams.get('reset');

                if (myParam == 'true') {
                    resetPasswordPopup.style.display = "block";
                    resetPasswordPopup.style.display = "block";
                }

                // Hiển thị popup khi nhấn "Quên mật khẩu"
                forgotPasswordLink.addEventListener("click", function () {
                    forgotPasswordPopup.style.display = "block";
                });

                // Đóng popup khi nhấn nút "X" hoặc vùng bên ngoài
                closeForgotPassword.addEventListener("click", function () {
                    forgotPasswordPopup.style.display = "none";
                });

                window.addEventListener("click", function (event) {
                    if (event.target === forgotPasswordPopup) {
                        forgotPasswordPopup.style.display = "none";
                    }
                });

                // Xử lý gửi email trong popup
                sendResetLinkBtn.addEventListener("click", function () {
                    var email = document.getElementById("forgotEmail").value.trim();
                    if (!email) {
                        alert("Vui lòng nhập email của bạn.");
                        return;
                    }

                    // Thực hiện gửi email
                    fetch("/api/ResetPassword", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json",
                        },
                        body: JSON.stringify({ email: email }),
                    })
                        .then((response) => {
                            if (!response.ok) {
                                throw new Error(`HTTP error! Status: ${response.status}`);
                            }
                            return response.json();
                        })
                        .then((data) => {
                            if (data.success) {
                                alert("Liên kết đặt lại mật khẩu đã được gửi đến email của bạn.");
                                forgotPasswordPopup.style.display = "none";
                            } else {
                                alert(`Lỗi từ máy chủ: ${data.message}`);
                            }
                        })
                        .catch((error) => {
                            console.error("Lỗi khi gửi liên kết:", error);
                            alert("Đã xảy ra lỗi khi gửi liên kết đặt lại mật khẩu. Vui lòng thử lại.");
                        });

                    return false;

                });

                // Hàm hiển thị lỗi cho người dùng
                function displayErrorToUser(message) {
                    const errorContainer = document.querySelector("#error-message");
                    if (errorContainer) {
                        errorContainer.innerText = message;
                        errorContainer.style.display = "block";
                    } else {
                        alert(message); // Dự phòng
                    }
                }

                // Hàm ghi log lỗi đến máy chủ (nếu cần)
                function logErrorToServer(error) {
                    fetch("/log-error", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ error: error.toString() }),
                    }).catch((logError) => {
                        console.error("Không thể gửi log lỗi đến máy chủ:", logError);
                    });
                }
            });
        </script>

    </form>
</asp:Content>
