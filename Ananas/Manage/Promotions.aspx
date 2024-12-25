<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Promotions.aspx.cs" Inherits="Ananas.Manage.Promotions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <form id="form1" runat="server" class="auto-style1" style="margin-top: 43px">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


        <script type="text/javascript">
            function showMessage(message) {
                document.getElementById('messageContent').innerHTML = message;
                document.getElementById('messageModal').style.display = 'block';
            }

            function closeMessageModal() {
                document.getElementById('messageModal').style.display = 'none';
            }
            function closeAddEditModal() {
                document.getElementById('addEditModal').style.display = 'none';
            }
            function openAddEditModal() {
                document.getElementById('addEditModal').style.display = 'block';
            }

            // Hàm đóng modal
            function closeAddEditModal() {
                document.getElementById('addEditModal').style.display = 'none';
            }

        </script>
        

        <!-- Modal -->
        <div class="d-flex justify-content-between align-items-center mb-3">
             <h3>Danh sách khuyến mãi</h3>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addEditModal">Thêm Khuyến Mãi</button>
        </div>

        <!-- Modal Thêm/Sửa Khuyến Mãi -->
        <div class="modal fade" id="addEditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Thêm Khuyến Mãi</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="txtTenKhuyenMai">Tên Khuyến Mãi</label>
                            <asp:TextBox ID="txtTenKhuyenMai" runat="server" CssClass="form-control" Placeholder="Nhập tên khuyến mãi"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtMoTa">Mô Tả</label>
                            <asp:TextBox ID="txtMoTa" runat="server" CssClass="form-control" Placeholder="Nhập mô tả"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtTyLeKhuyenMai">Tỷ Lệ (%)</label>
                            <asp:TextBox ID="txtTyLeKhuyenMai" runat="server" CssClass="form-control" Placeholder="Nhập tỷ lệ (%)"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtNgayBatDau">Ngày Bắt Đầu</label>
                            <asp:TextBox ID="txtNgayBatDau" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtNgayKetThuc">Ngày Kết Thúc</label>
                            <asp:TextBox ID="txtNgayKetThuc" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Lưu" OnClick="btnSave_Click" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true" style="display:none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="messageModalLabel">Thông báo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closeMessageModal()">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="messageContent">
                <!-- Nội dung thông báo sẽ được thay đổi động -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="closeMessageModal()">Đóng</button>
            </div>
        </div>
    </div>
</div>
        <div class="d-flex justify-content-center">
    <div class="w-75">
       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="MaKhuyenMai" CssClass="table table-bordered table-hover" Width="100%"
            OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"
            OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting">
            <Columns>
                <asp:BoundField DataField="MaKhuyenMai" HeaderText="Mã Khuyến Mãi" ReadOnly="True" />
                <asp:TemplateField HeaderText="Tên Khuyến Mãi">
                    <ItemTemplate><%# Eval("TenKhuyenMai") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTenKhuyenMai" runat="server" Text='<%# Bind("TenKhuyenMai") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mô Tả">
                    <ItemTemplate><%# Eval("MoTa") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtMoTa" runat="server" Text='<%# Bind("MoTa") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" CancelText="Hủy" DeleteText="Xóa" EditText="Sửa" UpdateText="Cập nhật" />
            </Columns>
        </asp:GridView>
        </div>
            </div>


                


           
        <asp:SqlDataSource ID="SqlDataSourcePromo" runat="server" ConnectionString="<%$ ConnectionStrings:Ananas_KLTNConnectionStringTrustServer %>" SelectCommand="SELECT * FROM [KhuyenMai]"
            InsertCommand="INSERT INTO KhuyenMai(MaKhuyenMai, TenKhuyenMai, MoTa, TyLeKhuyenMai, NgayBatDau, NgayKetThuc) VALUES (@MaKhuyenMai, @TenKhuyenMai, @MoTa, @TyLeKhuyenMai, @NgayBatDau, @NgayKetThuc)"
            UpdateCommand="UPDATE KhuyenMai SET TenKhuyenMai = @TenKhuyenMai, MoTa = @MoTa, TyLeKhuyenMai = @TyLeKhuyenMai, NgayBatDau = @NgayBatDau, NgayKetThuc = @NgayKetThuc WHERE MaKhuyenMai = @MaKhuyenMai"
            DeleteCommand="Delete from khuyenmai where makhuyenmai=@makhuyenmai">
            <UpdateParameters>
                <asp:ControlParameter ControlID="GridView1" Name="TenKhuyenMai" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="MoTa" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="TyLeKhuyenMai" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="NgayBatDau" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="NgayKetThuc" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="MaKhuyenMai" PropertyName="SelectedValue" />
            </UpdateParameters>

        </asp:SqlDataSource>


    </form>
</asp:Content>
