<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="Ananas.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" class="cart-form">
        <style>
            /* Trang giỏ hàng */
            .cart-form {
                font-family: Arial, sans-serif;
                padding: 30px;
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin: 0 auto;
                max-width: 1200px;
            }

            /* Tiêu đề giỏ hàng */
            .cart-title {
                text-align: center;
                font-size: 32px;
                color: #333;
                margin-bottom: 30px;
            }

            /* Bảng giỏ hàng */
            .cart-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 40px;
                font-size: 14px;
            }

                .cart-table th, .cart-table td {
                    padding: 12px;
                    text-align: center;
                    border: 1px solid #ddd;
                }

                .cart-table th {
                    background-color: #ED6A32;
                    color: white;
                    font-weight: bold;
                }

                .cart-table tr:nth-child(even) {
                    background-color: #f2f2f2;
                }

            /* Thiết kế cho hình ảnh sản phẩm */
            .product-image {
                border-radius: 8px;
                object-fit: cover;
            }

            /* Nút Edit */
            .edit-button {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 8px 16px;
                cursor: pointer;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

                .edit-button:hover {
                    background-color: #45a049;
                }

                .edit-button:active {
                    background-color: #388e3c;
                }

            /* Nút thanh toán */
            .checkout-button {
                font-size: 15pt;
                font-weight: bold;
                background-color: #ED6A32;
                color: white;
                height: 40px;
                width: 200px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
                border-radius: 5px;
            }

                .checkout-button:hover {
                    background-color: #d95c2c;
                }

            /* Phần footer (nếu có) */
            .checkout-section {
                text-align: center;
                margin-top: 20px;
            }

            /* Phần responsive */
            @media (max-width: 768px) {
                .cart-form {
                    padding: 15px;
                }

                .cart-title {
                    font-size: 24px;
                }

                .cart-table th, .cart-table td {
                    font-size: 12pt;
                }

                .checkout-button {
                    width: 100%;
                }
            }
        </style>

        <h2 class="cart-title">Giỏ Hàng</h2>

        <asp:GridView ID="GridViewCart" runat="server" AutoGenerateColumns="False"
            OnRowEditing="GridViewCart_RowEditing"
            OnRowUpdating="GridViewCart_RowUpdating"
            OnRowCancelingEdit="GridViewCart_RowCancelingEdit"
            OnRowDeleting="GridViewCart_RowDeleting"
            CssClass="cart-table">
            <Columns>
                <asp:BoundField DataField="MaSanPham" HeaderText="Mã sản phẩm" SortExpression="MaSanPham" ReadOnly="True" />
                <asp:BoundField DataField="TenSanPham" HeaderText="Tên sản phẩm" SortExpression="TenSanPham" ReadOnly="True" />
                <asp:TemplateField HeaderText="Hình">
                    <ItemTemplate>
                        <asp:Image ID="imgSanPham" runat="server"
                            ImageUrl='<%# Eval("Hinh") %>' Width="100px" Height="100px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="GiaKM" HeaderText="Giá" SortExpression="GiaKM" DataFormatString="{0:N}" ReadOnly="True" />
                <asp:TemplateField HeaderText="Size">
                    <ItemTemplate>
                        <asp:Label ID="lblSize" runat="server" Text='<%# Eval("MaSize") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlSize" runat="server" AutoPostBack="True">
                            <asp:ListItem Text="36" Value="36" />
                            <asp:ListItem Text="37" Value="37" />
                            <asp:ListItem Text="38" Value="38" />
                            <asp:ListItem Text="39" Value="39" />
                            <asp:ListItem Text="40" Value="40" />
                            <asp:ListItem Text="41" Value="41" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="SoLuong" HeaderText="Số lượng" SortExpression="SoLuong" />
                <asp:BoundField DataField="ThanhTien" HeaderText="Thành tiền" SortExpression="ThanhTien" DataFormatString="{0:N}" ReadOnly="True" />
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>

        <h3 class="total-price">Tổng tiền:
            <asp:Label ID="lbSUM" runat="server" Text="0"></asp:Label>
        </h3>
        <div class="checkout-section">
            <asp:Button ID="Button1" runat="server" Text="Thanh toán" CssClass="checkout-button" OnClick="btnCheckout_Click" />
        </div>
    </form>
</asp:Content>
