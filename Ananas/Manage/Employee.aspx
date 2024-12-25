<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Employee.aspx.cs" Inherits="Ananas.Manage.Employee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Danh sách nhân viên
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <style>
    .form-check {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); /* Hiển thị nhiều cột nếu đủ chỗ */
        gap: 10px; /* Thêm khoảng cách giữa các checkbox */
    }
</style>

        <script type="text/javascript">
            // Hàm mở modal Thêm Nhân Viên
            function openAddUserModal() {
                $('#ModalAddNhanVien').modal('show');
            }

            // Hàm đóng modal Thêm Nhân Viên
            function closeAddUserModal() {
                $('#ModalAddNhanVien').modal('hide');
            }

            // Hàm mở modal Phân Quyền
            function openPermissionModal() {
                $('#ModalPhanQuyen').modal('show');
            }

            // Hàm đóng modal Phân Quyền
            function closePermissionModal() {
                $('#ModalPhanQuyen').modal('hide');
            }
        </script>

        <asp:ScriptManager ID="ScriptManager2" runat="server" />
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Danh Sách Nhân Viên</h2>
                <asp:Button ID="btnAddNhanVien" runat="server" Text="Thêm Nhân Viên" CssClass="btn btn-success" OnClientClick="openAddUserModal(); return false;" />
            </div>

            <!-- GridView Hiển Thị Nhân Viên -->
            <asp:GridView ID="GridViewNhanVien" runat="server" AutoGenerateColumns="False" DataKeyNames="MaNV" CssClass="table table-striped"
                OnRowCommand="GridViewNhanVien_RowCommand">
                <Columns>
                    <asp:BoundField DataField="MaNV" HeaderText="Mã NV" ReadOnly="True" />
                    <asp:BoundField DataField="HoTen" HeaderText="Họ Tên" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="SoDienThoai" HeaderText="Số Điện Thoại" />
                    <asp:BoundField DataField="TrangThai" HeaderText="Trạng Thái" />
                    <asp:TemplateField HeaderText="Phân Quyền">
                        <ItemTemplate>
                            <asp:Button ID="btnPhanQuyen" runat="server" Text="Phân quyền" CommandArgument='<%# Eval("MaNV") %>' CommandName="PhanQuyen" CssClass="btn btn-primary" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>

        <!-- Modal Thêm Nhân Viên -->
        <div id="ModalAddNhanVien" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm Nhân Viên</h5>
                        <button type="button" class="close" onclick="closeAddUserModal()" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox ID="txtMaNV" runat="server" CssClass="form-control mb-2" Placeholder="Mã Nhân Viên" />
                        <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control mb-2" Placeholder="Họ Tên" />
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control mb-2" Placeholder="Email" />
                        <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="form-control mb-2" Placeholder="Số Điện Thoại" />
                        <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control mb-2" Placeholder="Địa Chỉ" />
                        <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control mb-2" TextMode="Password" Placeholder="Mật Khẩu" />
                        <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-control mb-2">
                            <asp:ListItem Text="Kích hoạt" Value="Kích hoạt" />
                            <asp:ListItem Text="Khóa" Value="Khóa" />
                        </asp:DropDownList>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSaveNhanVien" runat="server" Text="Lưu" CssClass="btn btn-primary" OnClick="btnSaveNhanVien_Click" />
                        <button type="button" class="btn btn-secondary" onclick="closeAddUserModal()">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

       <div id="ModalPhanQuyen" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Phân Quyền Nhân Viên</h5>
                <button type="button" class="close" onclick="closePermissionModal()" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <asp:HiddenField ID="hfMaNV" runat="server" />
                <div class="form-group">
                    <label>Quyền truy cập:</label>
                    <div>
                        <!-- Hiển thị CheckBoxList theo cột -->
                       <asp:CheckBoxList ID="cblQuyen" runat="server" CssClass="form-check">
    <asp:ListItem Value="Dashboard.aspx" Text="Tổng quan" />
    <asp:ListItem Value="Order.aspx" Text="Đơn hàng" />
    <asp:ListItem Value="Product.aspx" Text="Sản phẩm" />
    <asp:ListItem Value="User.aspx" Text="Người dùng" />
    <asp:ListItem Value="Promotions.aspx" Text="Khuyến mãi" />
    <asp:ListItem Value="Reports.aspx" Text="Báo cáo thống kê" />
    <asp:ListItem Value="BackupHistory.aspx" Text="Lịch sử sao lưu" />
</asp:CheckBoxList>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                 <button type="button" class="btn btn-secondary" onclick="closePermissionModal()">Đóng</button>
                <asp:Button ID="btnSavePermissions" runat="server" Text="Lưu" CssClass="btn btn-primary" OnClick="btnSavePermissions_Click" />
               
            </div>
        </div>
    </div>
</div>

    </form>
</asp:Content>
