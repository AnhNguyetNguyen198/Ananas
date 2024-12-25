<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ChonSanPham.aspx.cs" Inherits="Ananas.ChonSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Đảm bảo content không bị đẩy lên footer */
body {
    font-family: 'Nunito', sans-serif;
    background-color: #f9f9f9;
    color: #333;
    margin: 0;
    padding: 0;
    min-height: 100vh; /* Đảm bảo chiều cao tối thiểu của body */
}

.main-content {
    padding-bottom: 60px; /* Điều chỉnh sao cho đủ chỗ cho footer */
}


        /* Thêm margin-bottom cho container sản phẩm */
.product-container {
    display: flex;
    justify-content: space-between;
    margin: 40px;
    flex-wrap: wrap;
    gap: 20px;
    margin-bottom: 50px; /* Thêm khoảng cách dưới container */
}

/* Đảm bảo footer không bị đẩy lên */
footer {
    padding-top: 20px;
    background-color: #333;
    color: white;
}


        /* Product Image Section */
        .product-image {
            flex: 1 1 45%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Product Info Section */
        .product-info {
            flex: 1 1 40%;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .product-info .product-name {
            font-size: 32px;
            font-weight: bold;
            color: #333;
            line-height: 1.5;
            margin-bottom: 15px;
        }

        .product-info .price-section {
            font-size: 24px;
            color: #ED6A32;
            font-weight: bold;
            margin-top: 20px;
        }

        .product-info .line-container {
            margin: 20px 0;
            border-bottom: 2px solid #ddd;
            width: 100%;
        }

        .label {
            font-size: 16px;
            color: #666;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .list-row-info {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .custom-dropdown, .custom-textbox {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 16px;
            box-sizing: border-box;
            margin-bottom: 15px;
            transition: border-color 0.3s ease;
        }

        .custom-dropdown:focus, .custom-textbox:focus {
            border-color: #ED6A32;
            outline: none;
        }

        .custom-dropdown {
            font-size: 14pt;
            width: 300px;
        }

        .custom-textbox {
            font-size: 14pt;
        }

        .dropdown-toggle {
            font-size: 18pt;
            font-weight: bold;
            color: #ED6A32;
            text-decoration: underline;
            cursor: pointer;
            margin-top: 20px;
        }

        .dropdown-content {
            display: none;
            background-color: #f1f1f1;
            padding: 15px;
            border-radius: 8px;
            margin-top: 10px;
            font-size: 16px;
        }

        .dropdown-content p {
            margin: 5px 0;
        }

        .dropdown-content p:last-child {
            margin-bottom: 0;
        }

        /* Quy định đổi trả và bảo hành */
        .right-column {
            flex: 1 1 35%;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin-left: 20px;
            height: fit-content;
        }

        .right-column .dropdown-container {
            margin-top: 20px;
        }

        .right-column .dropdown-container a:hover {
            color: #ED6A32;
        }

        /* Button Style */
        .add-to-cart-button {
            width: 100%;
            background-color: #ED6A32;
            border: none;
            color: white;
            padding: 15px;
            font-size: 20px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        .add-to-cart-button:hover {
            background-color: #d85d1f;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .product-container {
                flex-direction: column;
                gap: 20px;
            }

            .product-image, .product-info, .right-column {
                flex: 1 1 100%;
            }

            .add-to-cart-button {
                width: 100%;
            }
        }
        .discount-price {
    font-size: 28px;
    color: red;
    font-weight: bold;
    /*text-decoration: line-through;*/ /* Gạch bỏ giá gốc */
}

    </style>

    <form id="form1" runat="server">
        <div class="product-container">
            <!-- Product Image Section -->
            <div class="product-image">
                <asp:Image ID="imgHinh" runat="server" Height="400px" Width="400px" />
            </div>

            <!-- Product Info Section -->
            <div class="product-info">
                <!-- Product Name -->
                <asp:Label ID="lbltensp" runat="server" CssClass="product-name" Font-Bold="True" Font-Size="32pt" />
                <br />

                <div class="list-row-info">
                    <div class="list-row">
                        <asp:Label ID="lblmasp" runat="server" style="font-size: 16px;" />
                    </div>

                    <div class="list-row">
                        <asp:Label ID="lbltrangthai" runat="server" style="font-size: 16px;" />
                        &nbsp;<asp:Label ID="lblSoLuongTon" runat="server" style="font-size: 16pt; color: green;"></asp:Label>
                    </div>
                </div>

                <!-- Price Section -->
                <div class="price-section">
                    <asp:Label ID="lblgiasp" runat="server" />
                
                <asp:Label ID="lblgiamoi" runat="server" Text="" CssClass="discount-price" />
                    </div>
                <!-- Line Separator -->
                <div class="line-container"></div>
                <asp:Label ID="lblmausac" runat="server" style="font-size: 16px;" />
                <!-- Color and Size Dropdowns -->
                <div class="line-container"></div>
                <div class="list-row-info">
                    <!-- Size Dropdown -->
                    <div class="list-column">
                        <div class="label">Size</div>
                        <asp:DropDownList ID="ddlsize" runat="server" AutoPostBack="True" DataTextField="MaSize" DataValueField="MaSize" class="custom-dropdown" />
                    </div>

                    <!-- Quantity Textbox -->
                    <div class="list-column">
                        <div class="label">Số lượng</div>
                        <asp:TextBox ID="txtsoluong" runat="server" class="custom-textbox" />
                    </div>
                </div>

                <!-- Product Description -->
                <asp:Label ID="lblmota" runat="server" style="font-size: 14pt;" />

                <!-- Add to Cart Button -->
                <asp:Button ID="btnthem" runat="server" OnClick="btnthem_Click" Text="Thêm vào giỏ hàng" CssClass="add-to-cart-button" />
            </div>

            <!-- Right Column for Return Policy and Warranty -->
            <div class="right-column">
                <!-- Quy Định Đổi Sản Phẩm -->
               <div class="dropdown-container">
    <a href="javascript:void(0);" onclick="toggleDropdown('returnPolicyDropdown')" class="dropdown-toggle">QUY ĐỊNH ĐỔI SẢN PHẨM</a>
    <div id="returnPolicyDropdown" class="dropdown-content">
        <p>Chỉ đổi hàng 1 lần duy nhất, mong bạn cân nhắc kĩ trước khi quyết định.</p>
        <p>Thời hạn đổi sản phẩm khi mua trực tiếp tại cửa hàng là 07 ngày, kể từ ngày mua. Đổi sản phẩm khi mua online là 14 ngày, kể từ ngày nhận hàng.</p>
        <p>Sản phẩm đổi phải kèm hóa đơn. Bắt buộc phải còn nguyên tem, hộp, nhãn mác...</p>
        <p>Sản phẩm đổi không có dấu hiệu đã qua sử dụng, không giặt tẩy, bám bẩn, biến dạng.</p>
        <p>Ananas chỉ ưu tiên hỗ trợ đổi size. Trong trường hợp sản phẩm hết size cần đổi, bạn có thể đổi sang 01 sản phẩm khác:</p>
        <ul>
            <li>Nếu sản phẩm muốn đổi ngang giá trị hoặc có giá trị cao hơn, bạn sẽ cần bù khoảng chênh lệch tại thời điểm đổi (nếu có).</li>
            <li>Nếu bạn mong muốn đổi sản phẩm có giá trị thấp hơn, chúng tôi sẽ không hoàn lại tiền.</li>
        </ul>
        <p>Trong trường hợp sản phẩm - size bạn muốn đổi không còn hàng trong hệ thống. Vui lòng chọn sản phẩm khác.</p>
        <p>Không hoàn trả bằng tiền mặt dù bất cứ trong trường hợp nào. Mong bạn thông cảm.</p>
        <p>Không áp dụng chính sách đổi hàng với các sản phẩm đang áp dụng chương trình Sale Off từ 40% trở lên.</p>
    </div>
</div>

              

                <!-- Bảo Hành -->
               <div class="dropdown-container">
    <a href="javascript:void(0);" onclick="toggleDropdown('warrantyDropdown')" class="dropdown-toggle">BẢO HÀNH</a>
    <div id="warrantyDropdown" class="dropdown-content">
        <p>Mỗi đôi giày Ananas trước khi xuất xưởng đều trải qua nhiều khâu kiểm tra. Tuy vậy, trong quá trình sử dụng, nếu nhận thấy các lỗi: gãy đế, hở đế, đứt chỉ may,... trong thời gian 6 tháng từ ngày mua hàng, mong bạn sớm gửi sản phẩm về Ananas nhằm giúp chúng tôi có cơ hội phục vụ bạn tốt hơn.</p>
        <p>Vui lòng gửi sản phẩm về bất kỳ cửa hàng Ananas nào, hoặc gửi đến trung tâm bảo hành Ananas ngay trong trung tâm TP.HCM trong giờ hành chính:</p>
        <p>Địa chỉ: 5C Tân Cảng, P.25, Q.Bình Thạnh, TP. Hồ Chí Minh.</p>
        <p>Hotline: 028 2211 0067</p>
    </div>
</div>
</div>
       </div>
    </form>

    <script>
        function toggleDropdown(dropdownId) {
            var content = document.getElementById(dropdownId);
            content.style.display = content.style.display === "block" ? "none" : "block";
        }
    </script>
</asp:Content>
