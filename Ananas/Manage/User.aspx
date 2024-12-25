<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="Ananas.Manage.User" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server" style="margin-top: 65px">
          <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function showNoResultsAlert() {
                // Tạo một alert đơn giản
                alert("Không có kết quả tìm kiếm phù hợp!");
            }
        </script>
        <style>
            .text-danger {
    color: red;
}
.fw-bold {
    font-weight: bold;
}
        </style>

       <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="mb-0">Danh Sách Người Dùng</h2>
                <asp:Button ID="btnShowModal" runat="server" Text="Thêm Người Dùng" CssClass="btn btn-primary" OnClientClick="$('#myModal').modal('show'); return false;" />
            </div>
               <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Thêm Người Dùng</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Form để thêm người dùng -->
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control mb-2" Placeholder="Họ tên" />
                <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="form-control mb-2" Placeholder="Số điện thoại" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control mb-2" Placeholder="Email" />
                <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control mb-2" TextMode="Password" Placeholder="Mật khẩu" />
                <asp:TextBox ID="txtNgaySinh" runat="server" CssClass="form-control mb-2" TextMode="Date" Placeholder="Ngày sinh" />
                <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control mb-2" Placeholder="Địa chỉ" />
                <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-control mb-2">
                    <asp:ListItem Value="Kích hoạt" Text="Kích hoạt"></asp:ListItem>
                    <asp:ListItem Value="Khóa" Text="Khóa"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnAddUser" runat="server" Text="Thêm" CssClass="btn btn-success" OnClick="btnAddUser_Click" />
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            DataKeyNames="MaNguoiDung" DataSourceID="SqlDataSourceUser" AllowPaging="True" CssClass="table table-striped table-bordered">
            <Columns>
                <asp:BoundField DataField="MaNguoiDung" HeaderText="MaNguoiDung" ReadOnly="True" SortExpression="MaNguoiDung" Visible="False" />
                <asp:BoundField DataField="HoTen" HeaderText="Họ Tên" SortExpression="HoTen" />
                <asp:BoundField DataField="SoDienThoai" HeaderText="SĐT" SortExpression="SoDienThoai" />
               <asp:TemplateField HeaderText="Mật khẩu">
            <ItemTemplate>
                ****
            </ItemTemplate>
        </asp:TemplateField>
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ReadOnly="True" />
                <asp:BoundField DataField="NgaySinh" HeaderText="Ngày sinh" SortExpression="NgaySinh" ReadOnly="True" />
                <asp:BoundField DataField="DiaChi" HeaderText="Địa chỉ" SortExpression="DiaChi" />
                <asp:BoundField DataField="VaiTroID" HeaderText="VaiTroID" SortExpression="VaiTroID" Visible="False" />
                <asp:BoundField DataField="NgayDangKy" HeaderText="Ngày đăng ký" SortExpression="NgayDangKy" ReadOnly="True" />
               <asp:TemplateField HeaderText="Trạng thái">
    <ItemTemplate>
        <asp:Label ID="lblTrangThai" runat="server" 
            Text='<%# Bind("TrangThai") %>' 
            CssClass='<%# Eval("TrangThai").ToString() == "Khóa" ? "text-danger fw-bold" : "" %>'>
        </asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlTrangThaiEdit" runat="server" SelectedValue='<%# Bind("TrangThai") %>'>
            <asp:ListItem Text="Kích hoạt" Value="Kích hoạt"></asp:ListItem>
            <asp:ListItem Text="Khóa" Value="Khóa"></asp:ListItem>
        </asp:DropDownList>
    </EditItemTemplate>
</asp:TemplateField>
                <asp:CommandField CancelText="Hủy" EditText="Sửa" ShowEditButton="True" UpdateText="Cập nhật" />
                <asp:CommandField CancelText="Hủy" DeleteText="Xóa" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
       <asp:SqlDataSource ID="SqlDataSourceUser" runat="server" 
    ConnectionString="<%$ ConnectionStrings:Ananas_KLTNConnectionStringTrustServer %>" 
    InsertCommand="INSERT INTO NguoiDung(HoTen, SoDienThoai, MatKhau, Email, NgaySinh, DiaChi, TrangThai) 
                   VALUES (@HoTen, @SoDienThoai, @MatKhau, @Email, @NgaySinh, @DiaChi, @TrangThai)"
    SelectCommand="SELECT * FROM [NguoiDung]" 
    UpdateCommand="UPDATE NguoiDung SET SoDienThoai = @SoDienThoai, HoTen = @HoTen, 
                   TrangThai = @TrangThai, DiaChi = @DiaChi
                   WHERE MaNguoiDung = @MaNguoiDung" DeleteCommand="Delete from nguoidung where manguoidung = @manguoidung">
</asp:SqlDataSource>
   
    </form>
</asp:Content>
