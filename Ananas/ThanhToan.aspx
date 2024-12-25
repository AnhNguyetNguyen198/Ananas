<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="Ananas.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">
        <style>
            body {
                font-family: Arial, sans-serif;
            }

            .checkout-container {
                display: flex;
                justify-content: space-between;
                margin: 20px auto;
                max-width: 1200px;
                gap: 15px;
            }

            .left-section,
            .right-section {
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }

            .left-section {
                width: 60%;
                padding: 20px 40px 20px 20px;
            }

            .right-section {
                width: 35%;
            }

            .form-group {
                margin-bottom: 15px;
            }

                .form-group label {
                    display: block;
                    font-weight: bold;
                    margin-bottom: 5px;
                }

                .form-group input,
                .form-group select {
                    width: 100%;
                    padding: 10px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                }

                    .form-group input[type="checkbox"] {
                        width: auto;
                    }

            .section-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 15px;
                align-items: center;
                align-content: center;
            }

            .order-summary {
                margin-top: 20px;
            }

                .order-summary h3 {
                    font-size: 18px;
                    font-weight: bold;
                }

            .order-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }

            .total {
                font-size: 20px;
                font-weight: bold;
                color: #ED6A32;
                text-align: right;
            }

            .checkout-button {
                background-color: #ED6A32;
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
            }

                .checkout-button:hover {
                    background-color: #d95c2c;
                }

            .modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4);
    justify-content: center; /* Canh giữa theo chiều ngang */
    align-items: center; /* Canh giữa theo chiều dọc */
}

.modal-content {
    background-color: #fefefe;
    padding: 20px;
    border: 1px solid #888;
    border-radius: 8px;
    max-width: 600px;
    width: 90%; /* Đảm bảo modal vừa với màn hình nhỏ */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
    max-height: 70%;
}

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

                .close:hover,
                .close:focus {
                    color: black;
                    text-decoration: none;
                    cursor: pointer;
                }

            .modal-header {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .modal-body {
                font-size: 16px;
                line-height: 1.6;
            }

                .modal-body li {
                    margin-bottom: 10px;
                }

            .btn-continue {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

                .btn-continue:disabled {
                    background-color: #cccccc;
                    cursor: not-allowed;
                }

            .btn-show-popup {
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
        </style>

       
       
        <div class="checkout-container">
            <!-- Left Section -->
            <div class="left-section">
                <h2 class="section-title">THÔNG TIN GIAO HÀNG</h2>
                <div class="form-group">
                    <label for="txtHoTen">HỌ TÊN</label>
                    <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="txtSDT">Số điện thoại</label>
                    <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="txtDiaChi">Địa chỉ</label>
                    <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" ClientIDMode="Static"/>
                
                </div>
                <div class="form-group">
                    <label for="txtCity">Tỉnh/ Thành Phố</label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="txtDistrict">Quận/ Huyện</label>
                    <asp:TextBox ID="txtDistrict" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="txtWard">Phường/ Xã</label>
                    <asp:TextBox ID="txtWard" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="txtWard">Đường số</label>
                    <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control" />
                </div>
                <div>
                    <h2 class="section-title">PHƯƠNG THỨC GIAO HÀNG</h2>
                    <asp:RadioButtonList ID="rblShippingMethod" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Tốc độ tiêu chuẩn (từ 2 - 5 ngày làm việc)" Value="Standard" />
                    </asp:RadioButtonList>
                </div>

                <div>
                    <h2 class="section-title">PHƯƠNG THỨC THANH TOÁN</h2>
                    
                    <asp:RadioButton ID="rbCOD" runat="server" GroupName="PaymentMethod" Text="Thanh toán khi nhận hàng (COD)" />
                    <asp:RadioButton ID="rbQRCode" runat="server" GroupName="PaymentMethod" Text="Thanh toán qua QR Code" />
                </div>
            </div>



            <!-- Right Section -->
            <div class="right-section">
                <h2 class="section-title">ĐƠN HÀNG</h2>
                <div class="order-summary">
                    <asp:Repeater ID="rptOrderItems" runat="server">
                        <ItemTemplate>
                            <div class="order-item">
                                <span><%# Eval("TenSanPham") %> - <%# Eval("MaSize") %></span>
                                <span>x <%# Eval("SoLuong") %> - <%# Eval("GiaSP", "{0:N0}") %> VND</span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="total">
                        TỔNG CỘNG:
       
                        <asp:Label ID="lblTotalAmount" runat="server" Text="0 VND"></asp:Label>
                    </div>
                </div>
                <asp:Button ID="btnCompletePayment" runat="server" CssClass="checkout-button" Text="HOÀN TẤT ĐẶT HÀNG" OnClientClick="return validateTerms()" OnClick="btnCompletePayment_Click" />
            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                <asp:Label ID="lblSuccessMessage" runat="server" ForeColor="Green" Visible="False"></asp:Label>
            </div>
        </div>
        
        <!-- Popup Modal -->
       <div id="modalPopup" class="modal">
    <div class="modal-content">
        <span class="close" id="closePopup" onclick="closePopup()">&times;</span>
        <div class="modal-header">ĐIỀU KHOẢN THANH TOÁN TRỰC TUYẾN</div>
        <div class="modal-body">
            <h3>1. TRÁCH NHIỆM CỦA KHÁCH HÀNG</h3>
            <ul>
                <li>Kiểm tra cẩn thận thông tin và chi tiết đơn hàng trước khi thực hiện thanh toán.</li>
                <li>Đọc và hiểu rõ các chính sách giao hàng - đổi hàng/bảo hành, các chính sách khác liên quan đến việc mua hàng và thanh toán.</li>
                <li>Chắc chắn rằng thẻ của bạn đã được kích hoạt dịch vụ thanh toán trực tuyến bởi Ngân hàng phát hành thẻ.</li>
                <li>Cung cấp đầy đủ thông tin, đảm bảo việc bạn có quyền sử dụng thẻ tín dụng/ví điện tử đã nêu ở phần "Phương thức thanh toán".</li>
                <li>Thực hiện đúng hướng dẫn thanh toán theo khuyến cáo của Ngân hàng phát hành thẻ hoặc đơn vị cung ứng dịch vụ ví điện tử để đảm bảo an toàn trong giao dịch trực tuyến.</li>
                <li>Không đóng cửa sổ màn hình giao dịch cho đến khi nhận được kết quả giao dịch cuối cùng.</li>
                <li>Lưu trữ các thông tin giao dịch, hóa đơn trực tuyến và các chứng từ liên quan đến giao dịch để làm căn cứ đối chiếu khi cần thiết.</li>
                <li>Liên hệ hotline 0963 429 749 hoặc inbox fanpage Ananas khi gặp phải các vấn đề phát sinh liên quan tới giao dịch.</li>
            </ul>
            <h3>2. TRÁCH NHIỆM CỦA ANANAS</h3>
            <ul>
                <li>Tuân thủ các biện pháp đảm bảo an toàn, bảo mật thông tin thanh toán cá nhân của khách hàng theo quy định của pháp luật.</li>
                <li>Cung cấp đầy đủ thông tin về các chính sách giao hàng - đổi hàng/bảo hành, các chính sách khác liên quan đến việc mua hàng và thanh toán.</li>
            </ul>
            <div>
                <input type="checkbox" id="acceptTerms" onclick="validateCheckbox()" />
                <label for="acceptTerms">Tôi chấp nhận với điều khoản thanh toán trên</label>
            </div>
            <button type="button" id="btnContinue" class="btn-continue" disabled onclick="submitPayment()">Tiếp tục</button>
        </div>
    </div>
</div>
        <script>
            function showPopup() {
                document.getElementById('modalPopup').style.display = 'flex';
            }

            function closePopup() {
                document.getElementById('modalPopup').style.display = 'none';
            }

            function validateCheckbox() {
                var checkbox = document.getElementById('acceptTerms');
                var btnContinue = document.getElementById('btnContinue');
                btnContinue.disabled = !checkbox.checked; // Enable button if checkbox is checked
            }

            function submitPayment() {
                // Logic to submit payment
                alert('Thanh toán thành công!');
                closePopup(); // Close the modal
            }
</script>
       
    </form>
</asp:Content>
