<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Ananas.Manage.Product" %>


<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Danh Sách Sản Phẩm
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Script mở Modal -->
    <script>
        function openModal() {
            $('#productModal').modal('show');
        }
    </script>

    <form id="form1" runat="server" style="margin: 20px;">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3>Danh sách sản phẩm</h3>
            <asp:Button ID="btnAddProduct" runat="server" Text="Thêm Sản Phẩm" OnClientClick="openModal(); return false;" CssClass="btn btn-primary" />
        </div>

        <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="productModalLabel">Thêm Sản Phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <div class="mb-3">
                            <label for="ddlLoai" class="form-label">Loại Sản Phẩm</label>
                            <asp:DropDownList ID="ddlLoaiSanPham" runat="server" CssClass="form-control">
                            </asp:DropDownList>



                        </div>
                    <div class="mb-3">
                        <label for="txtTenSanPham" class="form-label">Tên Sản Phẩm</label>
                        <asp:TextBox ID="txtTenSanPham" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtGia" class="form-label">Giá</label>
                        <asp:TextBox ID="txtGia" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtMoTa" class="form-label">Mô Tả</label>
                        <asp:TextBox ID="txtMoTa" runat="server" CssClass="form-control" TextMode="MultiLine" />
                    </div>
                    <div class="mb-3">
                        <label for="fileHinh" class="form-label">Hình</label>
                        <asp:FileUpload ID="fileHinh" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <asp:Button ID="btnSaveProduct" runat="server" Text="Lưu" CssClass="btn btn-primary" OnClick="btnSaveProduct_Click" />
                </div>
            </div>
        </div>
        </div>
         <div class="table-responsive">
             <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" OnPageIndexChanging="GridView1_PageIndexChanging" Width="100%" DataKeyNames="MaSanPham"
                 OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnSorting="GridView1_Sorting"
                 OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting" AllowPaging="True" AllowSorting="True">
                 <Columns>
                     <asp:CommandField Visible="False" />
                     <asp:TemplateField HeaderText="STT">
                         <ItemTemplate>
                             <asp:Label ID="lblSTT" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:BoundField DataField="MaSanPham" HeaderText="Mã sản phẩm" SortExpression="MaSanPham" ReadOnly="True" Visible="False" />
                     <asp:TemplateField HeaderText="Tên sản phẩm">
                         <ItemTemplate>
                             <asp:Label ID="lblTenSanPham" runat="server" Text='<%# Eval("TenSanPham") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:TextBox ID="txtTenSanPham" runat="server" Text='<%# Bind("TenSanPham") %>' CssClass="form-control"></asp:TextBox>
                         </EditItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Loại">
                         <ItemTemplate>
                             <asp:Label ID="lblLoai" runat="server" Text='<%# Eval("TenLoai") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:DropDownList ID="ddlLoaiEdit" runat="server"
                                 DataSourceID="SqlDataSourceLoai"
                                 DataTextField="TenLoai"
                                 DataValueField="TenLoai"
                                 SelectedValue='<%# Bind("TenLoai") %>' CssClass="form-control">
                             </asp:DropDownList>
                         </EditItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Hình">
    <ItemTemplate>
        <asp:Image ID="imgHinh" runat="server" ImageUrl='<%# Eval("Hinh") %>' Style="width: 100px; height: auto" />
    </ItemTemplate>
    <EditItemTemplate>
        <!-- Hiển thị đường dẫn hình cũ -->
        <asp:TextBox ID="txtHinhEdit" runat="server" Text='<%# Bind("Hinh") %>' CssClass="form-control"></asp:TextBox>
        <!-- Tải lên hình mới -->
        <asp:FileUpload ID="fileUploadHinhEdit" runat="server" CssClass="form-control" />
    </EditItemTemplate>
</asp:TemplateField>
                     <asp:TemplateField HeaderText="Giá">
                         <ItemTemplate>
                             <asp:Label ID="lblGia" runat="server" Text='<%# Eval("Gia", "{0:N0}") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:TextBox ID="txtGiaEdit" runat="server" Text='<%# Bind("Gia") %>' CssClass="form-control" />
                         </EditItemTemplate>
                     </asp:TemplateField>

                     <asp:BoundField DataField="NgayTao" HeaderText="Ngày tạo" SortExpression="NgayTao" ReadOnly="True" />
                     <asp:TemplateField HeaderText="Mô tả">
                         <ItemTemplate>
                             <asp:Label ID="lblMoTa" runat="server" Text='<%# Eval("MoTa") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:TextBox ID="txtMoTaEdit" runat="server" Text='<%# Bind("MoTa") %>' CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                         </EditItemTemplate>
                     </asp:TemplateField>

                     <asp:CommandField CancelText="Hủy" EditText="Sửa" ShowEditButton="True" UpdateText="Cập nhật" />
                     <asp:CommandField CancelText="Hủy" DeleteText="Xóa" ShowDeleteButton="True" />
                 </Columns>
             </asp:GridView>
         </div>
        <asp:SqlDataSource ID="SqlDataSourceProduct" runat="server"
            ConnectionString="<%$ ConnectionStrings:Ananas_KLTNConnectionStringTrustServer %>"
            SelectCommand="SELECT masanpham, tenloai, tensanpham, hinh, gia, mota, ngaytao FROM sanpham inner join loaisanpham on sanpham.maloai = loaisanpham.maloai ORDER BY NgayTao DESC"
            InsertCommand="INSERT INTO SanPham (MaSanPham, TenLoai, TenSanPham, MoTa, Gia, Hinh, NgayTao)
                   VALUES (@MaSanPham, @TenLoai, @TenSanPham, @MoTa, @Gia, @Hinh, @NgayTao)"
            DeleteCommand="DELETE FROM SanPham"
            UpdateCommand="UPDATE SanPham 
                   SET TenSanPham = @TenSanPham, 
                       MaLoai = (SELECT MaLoai FROM LoaiSanPham WHERE TenLoai = @TenLoai),
                       Gia = @Gia, 
                       MoTa = @MoTa, 
                       Hinh = @Hinh
                   WHERE MaSanPham = @MaSanPham">

            <InsertParameters>
                <asp:ControlParameter ControlID="GridView1" Name="masanpham" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="tenloai" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="tensanpham" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="mota" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="gia" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="hinh" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="ngaytao" PropertyName="SelectedValue" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="GridView1" Name="TenSanPham" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="TenLoai" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="Gia" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="MoTa" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="Hinh" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="GridView1" Name="MaSanPham" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceLoai" runat="server" ConnectionString="<%$ ConnectionStrings:Ananas_KLTNConnectionStringTrustServer %>" ProviderName="<%$ ConnectionStrings:Ananas_KLTNConnectionStringTrustServer.ProviderName %>" SelectCommand="SELECT [TenLoai] FROM [LoaiSanPham]" InsertCommand="INSERT INTO LoaiSanPham (TenLoai) VALUES (@TenLoai)" UpdateCommand="UPDATE LoaiSanPham SET TenLoai = @tenloai">
            <InsertParameters>
                <asp:ControlParameter ControlID="GridView1" Name="TenLoai" PropertyName="SelectedValue" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="GridView1" Name="tenloai" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</asp:Content>
