<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="Ananas.Manage.Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Đơn hàng
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <form id="form1" runat="server" style="margin-left: 34px;">
        <script type="text/javascript">
            function openAddOrderModal() {
                $('#addOrderModal').modal('show'); // Hiển thị modal thêm đơn hàng
            }
            function closeAddOrderModal() {
                $('#addOrderModal').modal('hide'); // Đóng modal thêm đơn hàng
            }
            function openEditOrderModal() {
                $('#editOrderModal').modal('show'); // Hiển thị modal chỉnh sửa đơn hàng
            }
            function closeEditOrderModal() {
                $('#editOrderModal').modal('hide'); // Đóng modal chỉnh sửa đơn hàng
            }
        </script>
        <asp:ScriptManager ID="ScriptManager2" runat="server" />

        <style>
            .modal-dialog {
                max-width: 600px; /* Giới hạn chiều rộng modal */
            }

            .modal-content {
                max-height: 80vh; /* Giới hạn chiều cao tối đa modal */
                overflow-y: auto; /* Thêm thanh cuộn dọc khi cần thiết */
            }
        </style>
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Danh sách đơn hàng</h3>

                <button type="button" class="btn btn-primary" onclick="openAddOrderModal()">Thêm Đơn Đặt Hàng</button>

            </div>
        </div>
        <!-- Modal Thêm Đơn Hàng -->
        <div id="addOrderModal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <!-- Header Modal -->
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm Đơn Đặt Hàng</h5>
                        <button type="button" class="close" onclick="closeAddOrderModal()" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!-- Body Modal -->
                    <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
                        <div class="form-group">
                            <label>Chọn Sản Phẩm:</label>
                            <asp:DropDownList ID="ddlSanPham" runat="server" CssClass="form-control" DataSourceID="SqlDataSourceSanPham" AutoPostBack="true"
                                DataTextField="TenSanPham" DataValueField="MaSanPham" AppendDataBoundItems="true">
                                <asp:ListItem Text="-- Chọn sản phẩm --" Value="" />
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label>Chọn Size:</label>
                            <asp:DropDownList ID="ddlSize" runat="server" CssClass="form-control" DataSourceID="SqlDataSourceSize"
                                DataTextField="TenSize" DataValueField="MaSize">
                                <asp:ListItem Text="-- Chọn size --" Value="" />
                            </asp:DropDownList>
                        </div>
                        <asp:DropDownList ID="ddlKhuyenMai" runat="server" CssClass="form-control"
                            AutoPostBack="true" OnTextChanged="ddlKhuyenMai_SelectedIndexChanged">
                            <asp:ListItem Text="-- Chọn khuyến mãi --" Value="" />
                        </asp:DropDownList>
                        <div class="form-group">
                            <label>Số Điện Thoại Khách Hàng:</label>
                            <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="form-control" AutoPostBack="true"
                                OnTextChanged="txtSoDienThoai_TextChanged"></asp:TextBox>
                        </div>


                        <div class="form-group">
                            <label>Họ Tên Khách Hàng:</label>
                            <asp:TextBox ID="txtTenKhachHang" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Email:</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Địa Chỉ:</label>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Số Lượng:</label>
                            <asp:TextBox ID="txtSoLuong" runat="server" CssClass="form-control" TextMode="Number" Placeholder="Nhập số lượng" AutoPostBack="true"
                                OnTextChanged="txtSoLuong_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSoLuong" runat="server" ControlToValidate="txtSoLuong" ErrorMessage="Số lượng là bắt buộc!" ForeColor="Red" />
                            <asp:RangeValidator ID="rvSoLuong" runat="server" ControlToValidate="txtSoLuong" MinimumValue="1" MaximumValue="1000" Type="Integer" ErrorMessage="Số lượng phải từ 1 đến 1000!" ForeColor="Red" />
                        </div>
                        <div class="form-group">
                            <label>Tổng Tiền:</label>
                            <asp:TextBox ID="txtTongTien" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Tiền Khuyến Mãi:</label>
                            <asp:TextBox ID="txtTienKhuyenMai" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Thành Tiền:</label>
                            <asp:TextBox ID="txtThanhTien" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Phương Thức Vận Chuyển:</label>
                            <div>
                                <label>
                                    <input type="radio" name="PhuongThucVanChuyen" value="Giao hàng nhanh" checked />
                                    Giao hàng nhanh
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Phương Thức Thanh Toán:</label>
                            <asp:DropDownList ID="ddlPhuongThucThanhToan" runat="server" CssClass="form-control">
                                <asp:ListItem Text="COD" Value="COD"></asp:ListItem>
                                <asp:ListItem Text="QR Code" Value="QR Code"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group" id="statusField" style="display: none;">
                        <label>Trạng Thái:</label>
                        <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Đã đặt" Value="Đã đặt"></asp:ListItem>
                            <asp:ListItem Text="Đang xử lý" Value="Đang xử lý"></asp:ListItem>
                            <asp:ListItem Text="Đã giao" Value="Đã giao"></asp:ListItem>
                            <asp:ListItem Text="Đã hủy" Value="Đã hủy"></asp:ListItem>
                        </asp:DropDownList>
                    </div>


                    <!-- Footer Modal -->
                    <div class="modal-footer">
                        <asp:Button ID="btnAddOrder" runat="server" Text="Thêm Đơn Hàng" CssClass="btn btn-success" OnClick="btnAddOrder_Click" />
                        <button type="button" class="btn btn-secondary" onclick="closeAddOrderModal()">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="editOrderModal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <!-- Header Modal -->
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm Đơn Đặt Hàng</h5>
                        <button type="button" class="close" onclick="closeEditOrderModal()" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!-- Body Modal -->
                    <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
                        <div class="form-group">
                            <label>Chọn Sản Phẩm:</label>
                            <asp:DropDownList ID="ddlSanPhamEdit" runat="server" CssClass="form-control" DataSourceID="SqlDataSourceSanPham" AutoPostBack="true"
                                DataTextField="TenSanPham" DataValueField="MaSanPham" AppendDataBoundItems="true">
                                <asp:ListItem Text="-- Chọn sản phẩm --" Value="" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSanPham" runat="server" ControlToValidate="ddlSanPham" InitialValue="" ErrorMessage="Vui lòng chọn sản phẩm!" ForeColor="Red" />
                        </div>
                        <asp:HiddenField ID="hdfMaSanPham" runat="server" />
                        <div class="form-group">
                            <label>Chọn Size:</label>
                            <asp:DropDownList ID="ddlSizeEdit" runat="server" CssClass="form-control" DataSourceID="SqlDataSourceSize" DataTextField="TenSize" DataValueField="MaSize">
                                <asp:ListItem Text="-- Chọn size --" Value="" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSize" runat="server" ControlToValidate="ddlSize" InitialValue="" ErrorMessage="Vui lòng chọn size!" ForeColor="Red" />
                        </div>
                        <asp:DropDownList ID="ddlKhuyenMaiEdit" runat="server" CssClass="form-control"
                            AutoPostBack="true" OnTextChanged="ddlKhuyenMai_SelectedIndexChanged">
                            <asp:ListItem Text="-- Chọn khuyến mãi --" Value="" />
                        </asp:DropDownList>
                        <div class="form-group">
                            <label>Số Điện Thoại Khách Hàng:</label>
                            <asp:TextBox ID="txtSoDienThoaiEdit" runat="server" CssClass="form-control" AutoPostBack="true"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSoDienThoai" runat="server" ControlToValidate="txtSoDienThoai" ErrorMessage="Vui lòng nhập số điện thoại!" ForeColor="Red" />
                        </div>
                        <asp:HiddenField ID="hdfMaNguoiDung" runat="server" />

                        <div class="form-group">
                            <label>Họ Tên Khách Hàng:</label>
                            <asp:TextBox ID="txtTenKhachHangEdit" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Email:</label>
                            <asp:TextBox ID="txtEmailEdit" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Địa Chỉ:</label>
                            <asp:TextBox ID="txtDiaChiEdit" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDiaChi" runat="server" ControlToValidate="txtDiaChi" ErrorMessage="Vui lòng nhập địa chỉ!" ForeColor="Red" />
                        </div>

                        <div class="form-group">
                            <label>Số Lượng:</label>
                            <asp:TextBox ID="txtSoLuongEdit" runat="server" CssClass="form-control" TextMode="Number" Placeholder="Nhập số lượng" AutoPostBack="true"
                                OnTextChanged="txtSoLuong_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSoLuong" ErrorMessage="Số lượng là bắt buộc!" ForeColor="Red" />
                            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtSoLuong" MinimumValue="1" MaximumValue="1000" Type="Integer" ErrorMessage="Số lượng phải từ 1 đến 1000!" ForeColor="Red" />
                        </div>
                        <div class="form-group">
                            <label>Tổng Tiền:</label>
                            <asp:TextBox ID="txtTongTienEdit" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Tiền Khuyến Mãi:</label>
                            <asp:TextBox ID="txtTienKhuyenMaiEdit" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Thành Tiền:</label>
                            <asp:TextBox ID="txtThanhTienEdit" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Phương Thức Vận Chuyển:</label>
                            <div>
                                <label>
                                    <input type="radio" name="PhuongThucVanChuyen" value="Giao hàng nhanh" checked />
                                    Giao hàng nhanh
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Phương Thức Thanh Toán:</label>
                            <asp:DropDownList ID="ddlPhuongThucThanhToanEdit" runat="server" CssClass="form-control">
                                <asp:ListItem Text="COD" Value="COD"></asp:ListItem>
                                <asp:ListItem Text="QR Code" Value="QR Code"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group" style="display: none;">
                        <label>Trạng Thái:</label>
                        <asp:DropDownList ID="ddlTrangThaiEdit" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Đã đặt" Value="Đã đặt"></asp:ListItem>
                            <asp:ListItem Text="Đang xử lý" Value="Đang xử lý"></asp:ListItem>
                            <asp:ListItem Text="Đã giao" Value="Đã giao"></asp:ListItem>
                            <asp:ListItem Text="Đã hủy" Value="Đã hủy"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <asp:HiddenField ID="hfMaDatHang" runat="server" />
                <asp:HiddenField ID="hfMaNguoiDung" runat="server" />
                <asp:HiddenField ID="hfMaKhuyenMai" runat="server" />
                <!-- Footer Modal -->
                <div class="modal-footer">
                    <asp:Button ID="btnEditOrder" runat="server" Text="Chỉnh sửa" CssClass="btn btn-success" OnClick="btnEditOrder_Click" />
                    <button type="button" class="btn btn-secondary" onclick="closeEditOrderModal()">Đóng</button>
                </div>
            </div>
        </div>


        <asp:SqlDataSource ID="SqlDataSourceSanPham" runat="server"
            ConnectionString="<%$ ConnectionStrings:Ananas_KLTNConnectionStringTrustServer %>"
            SelectCommand="SELECT MaSanPham, TenSanPham FROM SanPham"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceSize" runat="server"
            ConnectionString="<%$ ConnectionStrings:Ananas_KLTNConnectionStringTrustServer %>"
            SelectCommand="SELECT MaSize, TenSize FROM Size"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceKhuyenMai" runat="server"
            ConnectionString="<%$ ConnectionStrings:Ananas_KLTNConnectionStringTrustServer %>"
            SelectCommand="SELECT MaKhuyenMai, TenKhuyenMai FROM KhuyenMai"></asp:SqlDataSource>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="10" CssClass="table table-bordered table-hover" OnPageIndexChanging="GridView1_PageIndexChanging"
            Width="100%"
            OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowCommand="GridView1_RowCommand">
            <Columns>

                <asp:BoundField DataField="MaDatHang" HeaderText="Mã Đơn Hàng" ReadOnly="True" />

                <asp:TemplateField HeaderText="Tên Khuyến Mãi">
                    <ItemTemplate>
                        <asp:Label ID="lblTenKhuyenMai" runat="server" Text='<%# Eval("TenKhuyenMai") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlTenKhuyenMai" runat="server" DataTextField="TenKhuyenMai" DataValueField="MaKhuyenMai">
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>


                <asp:BoundField DataField="TenKhachHang" HeaderText="Họ Tên Khách Hàng" />

                <asp:BoundField DataField="Email" HeaderText="Email" />

                <asp:BoundField DataField="SoDienThoai" HeaderText="Số Điện Thoại" />

                <asp:BoundField DataField="DiaChi" HeaderText="Địa Chỉ" />

                <asp:BoundField DataField="NgayDatHang" HeaderText="Ngày Đặt Hàng" DataFormatString="{0:dd/MM/yyyy HH:mm}" ReadOnly="True" />

                <asp:TemplateField HeaderText="Phương Thức Thanh Toán">
                    <ItemTemplate>
                        <asp:Label ID="lblPhuongThucThanhToan" runat="server" Text='<%# Eval("PhuongThucThanhToan") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlPhuongThucThanhToan" runat="server">
                            <asp:ListItem Text="COD" Value="COD" />
                            <asp:ListItem Text="QR Code" Value="QR Code" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Trạng Thái">
                    <ItemTemplate>
                        <asp:Label ID="lblTrangThai" runat="server" Text='<%# Eval("TrangThai") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlTrangThaiEdit" runat="server">
                            <asp:ListItem Text="Đã đặt" Value="Đã đặt"></asp:ListItem>
                            <asp:ListItem Text="Đang xử lý" Value="Đang xử lý"></asp:ListItem>
                            <asp:ListItem Text="Đã giao" Value="Đã giao"></asp:ListItem>
                            <asp:ListItem Text="Đã hủy" Value="Đã hủy"></asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="TongTien" HeaderText="Tổng Tiền" DataFormatString="{0:N0}" ReadOnly="True" />

                <asp:BoundField DataField="TienKhuyenMai" HeaderText="Tiền Khuyến Mãi" DataFormatString="{0:N0}" ReadOnly="True" />

                <asp:BoundField DataField="ThanhTien" HeaderText="Thành Tiền" DataFormatString="{0:N0}" ReadOnly="True" />
                <asp:BoundField DataField="NgayDatHang" HeaderText="Ngày Đặt Hàng"
                    DataFormatString="{0:dd/MM/yyyy HH:mm}" SortExpression="NgayDatHang" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" CausesValidation="false" runat="server" CommandName="Edit" CommandArgument='<%# Eval("MaDatHang") %>' Text="Chỉnh sửa" CssClass="btn btn-primary" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" CausesValidation="false" runat="server" CommandName="Delete" CommandArgument='<%# Eval("MaDatHang") %>' Text="Xóa" CssClass="btn btn-primary" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
</asp:Content>
