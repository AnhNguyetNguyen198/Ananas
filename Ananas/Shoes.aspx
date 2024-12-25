<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeFile="Shoes.aspx.cs" Inherits="Ananas.Shoes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
               <style>
            /* General page styles */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            /* Container for all products */
            .product-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-around;
                align-items: flex-start;
                margin: 20px auto;
                max-width: 1200px;
                width: fit-content;
                padding: 10px;
            }

            /* Product item style */
            .product-item {
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 15px;
                margin: 15px;
                width: fit-content;
                text-align: center;
                box-sizing: border-box;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease, padding 0.3s ease;
                position: relative;
                min-height: 500px;
            }

            /* Hover effect */
            .product-item:hover {
                transform: scale(1.05);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
                padding: 20px;
            }

            /* Product image style */
            .product-image {
                border-radius: 8px;
                object-fit: cover;
                width: 100%;
                height: 200px;
            }

            /* Title of product */
            .product-title {
                display: flex;
                margin: 15px 0;
                font-size: 1.1em;
                font-weight: bold;
                text-decoration: none;
                color: #333;
                transition: color 0.3s ease;
                max-width: 300px;
                align-content: center;
                justify-content: center;
            }

            .product-title:hover {
                color: #ED6A32;
            }

            /* Price of product */
            .product-price {
                font-size: 1.2em;
                font-weight: bold;
                color: #28a745;
                margin: 10px 0;
            }

            /* Original price for discounts */
            .original-price {
                /*text-decoration: line-through;*/
                color: #888;
                font-size: 1em;
                margin-right: 10px;
            }

            /* Price after discount */
            .discount-price {
                color: #ff5733;
                font-size: 1.5em;
                font-weight: bold;
                margin-top: 10px;
            }

            /* Promo badge */
            .promo-badge {
                background-color: #ff5733;
                color: #fff;
                padding: 5px 10px;
                font-size: 0.9em;
                font-weight: bold;
                border-radius: 15px;
                position: absolute;
                top: 10px;
                left: 10px;
                z-index: 1;
            }
 /* Định dạng chung cho banner */


/* Hiệu ứng hover: làm banner nổi bật nhẹ */
/* Banner style */
.promo-banner {
    position: relative;
    background-color: #bc0001; /* Màu nền xanh đậm */
    color: #fff;
    text-align: center;
    padding: 30px 0;
    font-size: 1.4em;
    overflow: hidden; /* Đảm bảo tuyết không tràn ra ngoài */
    height: fit-content;
}

/* Banner text style */
.promo-text {
    font-weight: bold;
    font-size: 1.4em;
    color: #fbec00;
}

/* Hiệu ứng tuyết */
.snowflake {
    position: absolute;
    top: -10px;
    font-size: 1em;
    color: #fff;
    animation: snowflakes 10s linear infinite;
}

/* Animation for snowflakes */
@keyframes snowflakes {
    0% {
        top: -10px;
        opacity: 1;
    }
    100% {
        top: 100%;
        opacity: 0;
    }
}

/* Cây thông */
            .tree {
                position:
            }
.product-list {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-around;
                gap: 20px;
           }

            .promo-details {
                font-size: 0.9em;
                color: #ff9800;
                margin-top: 5px;
            }
            .auto-style1 {
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 15px;
                margin: 15px;
                width: fit-content;
                text-align: center;
                box-sizing: border-box;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease, padding 0.3s ease;
                position: relative;
                min-height: 500px;
                left: 0px;
                top: 0px;
            }
        </style>

     <div class="promo-banner">
    <div class="promo-text">
        <strong>Giáng Sinh Giảm 10% Cho Các Sản Phẩm VINTAS!</strong> <!-- Đây là dòng chữ chính -->
        
    </div>

    <!-- Phần dưới của banner -->
    <div>
        <strong>1/12 - 25/12/2024!</strong> <!-- Đây là phần sau "Giáng Sinh Giảm 20%" sẽ xuống dòng -->
    </div>
</div>

<!-- JavaScript cho hiệu ứng tuyết -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var snowflakesCount = 50; // Số lượng bông tuyết rơi
        var banner = document.querySelector('.promo-banner'); // Chọn banner để thêm tuyết

        for (var i = 0; i < snowflakesCount; i++) {
            var snowflake = document.createElement('div');
            snowflake.classList.add('snowflake');
            snowflake.innerHTML = '❄'; // Ký tự bông tuyết
            banner.appendChild(snowflake);

            // Cài đặt các vị trí và hiệu ứng rơi cho tuyết
            snowflake.style.left = Math.random() * 100 + '%'; // Vị trí ngẫu nhiên theo chiều ngang
            snowflake.style.animationDuration = Math.random() * 3 + 5 + 's'; // Thời gian rơi ngẫu nhiên
            snowflake.style.animationDelay = Math.random() * 3 + 's'; // Độ trễ ngẫu nhiên
        }
    });
</script>


        <!-- Product Container -->
        <div class="product-container">
            <asp:DataList ID="DataListShoes" runat="server" DataSourceID="SqlDataSourceShoes" 
                          RepeatColumns="3" RepeatDirection="Horizontal" class="product-list" 
                          OnItemDataBound="DataListShoes_ItemDataBound">
                <ItemTemplate>
                    <div class="auto-style1">
                        <!-- Hình ảnh sản phẩm -->
                        <asp:ImageButton ID="imgHinh" runat="server" 
                                         CssClass="product-image" 
                                         ImageUrl='<%# Eval("Hinh") %>' 
                                         Width="300px" Height="300px" />
                       
                        <!-- Tên sản phẩm -->
                        <div class="product-title">
 <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/ChonSanPham.aspx?MaSanPham=" + Eval("MaSanPham") %>' Text='<%# Eval("TenSanPham") %>' Font-Bold="True" Font-Italic="False" Font-Size="13pt" Font-Underline="False" ForeColor="Black"></asp:HyperLink>
                            </div>

                        <!-- Giá sản phẩm -->
                        <div class="product-price">
                            <asp:Label ID="GiaLabel" runat="server" Text='<%# Eval("Gia") %>' class="original-price"></asp:Label>
                        </div>

                        <!-- Giá giảm nếu có -->
                        <div class="product-price">
                            <asp:Label ID="PriceAfterDiscountLabel" runat="server" 
                                       Text='<%# Eval("PriceAfterDiscount") %>' 
                                       Visible='<%# Eval("IsPromo") == "1" %>' 
                                       class="discount-price"></asp:Label>
                        </div>

                        <!-- Thông tin khuyến mãi -->
                        <div class="promo-details">
                            <asp:Label ID="PromoDetailsLabel" runat="server" 
                                       Text='<%# Eval("TenKhuyenMai") %>' 
                                       Visible='<%# Eval("IsPromo") == "1" %>'></asp:Label>
                        </div>

                        <!-- Badge khuyến mãi -->
                        <div class="promo-badge" visible='<%# Eval("IsPromo") == "1" %>'>
                            <asp:Label ID="PromoBadge" runat="server" Text="Khuyến mãi"></asp:Label>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>

        <!-- SQL DataSource to fetch product data -->
        <asp:SqlDataSource ID="SqlDataSourceShoes" runat="server" 
                           ConnectionString="<%$ ConnectionStrings:Ananas_KLTNConnectionString %>" 
                           SelectCommand="SELECT 
    p.MaSanPham,
    p.TenSanPham, 
    p.Gia,
    p.Hinh,
    p.MaLoai,
    CASE 
        WHEN km.MaKhuyenMai = 'KM001' AND GETDATE() BETWEEN km.NgayBatDau AND km.NgayKetThuc
        THEN p.Gia * (1 - km.TyLeKhuyenMai / 100.0) 
        ELSE p.Gia
    END AS PriceAfterDiscount,
    CASE 
        WHEN km.MaKhuyenMai = 'KM001' AND GETDATE() BETWEEN km.NgayBatDau AND km.NgayKetThuc
        THEN 1
        ELSE 0
    END AS IsPromo,
    km.TenKhuyenMai
FROM 
    SanPham p
LEFT JOIN 
    ChiTietKhuyenMai ctkm ON p.MaSanPham = ctkm.MaSanPham 
LEFT JOIN 
    KhuyenMai km ON km.MaKhuyenMai = ctkm.MaKhuyenMai
WHERE 
    p.MaLoai in (1,2,3,4) -- Điều kiện lọc theo mã loại sản phẩm
    AND (
        (km.MaKhuyenMai = 'KM001' AND GETDATE() BETWEEN km.NgayBatDau AND km.NgayKetThuc)  -- Điều kiện khuyến mãi còn hiệu lực
        OR km.MaKhuyenMai IS NULL  -- Lấy cả sản phẩm không có khuyến mãi
    );
">
        </asp:SqlDataSource>
    </form>
</asp:Content>
