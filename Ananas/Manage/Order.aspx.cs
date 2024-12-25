using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas.Manage
{
    public partial class Order : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
                BindKhuyenMaiDropdown();
                string keyword = Request.QueryString["search"];
                if (!string.IsNullOrEmpty(keyword))
                {
                    LoadOrders(keyword);
                }
                else
                {
                    LoadOrders();
                }
            }
            // Kiểm tra Session
            //if (Session["Email"] == null || Session["LoggedIn"] == null || !(bool)Session["LoggedIn"])
            //{
            //    // Nếu Session không tồn tại hoặc hết hạn, chuyển hướng về trang đăng nhập
            //    Response.Redirect("Login.aspx");
            //    return;
            //}

            // Lấy quyền truy cập từ cơ sở dữ liệu
            //string email = Session["Email"].ToString();
            //string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
            //string query = "SELECT QuyenTruyCap FROM NhanVien WHERE Email = @Email";

            //using (SqlConnection conn = new SqlConnection(connString))
            //{
            //    SqlCommand cmd = new SqlCommand(query, conn);
            //    cmd.Parameters.AddWithValue("@Email", email);

            //    conn.Open();
            //    string quyenTruyCap = cmd.ExecuteScalar()?.ToString();
            //    conn.Close();

            //    // Lấy tên trang hiện tại
            //    string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

            //    // Kiểm tra xem trang hiện tại có trong quyền truy cập không
            //    if (quyenTruyCap == null || !quyenTruyCap.Split(',').Contains(currentPage))
            //    {
            //        // Nếu không có quyền, chuyển hướng tới Unauthorized
            //        Response.Redirect("Unauthorized.aspx");
            //    }
            //}
        }
        public void Search(string keyword)
        {
            LoadOrders(keyword);
        }

        private void LoadOrders(string keyword = "")
        {
            string query = string.IsNullOrEmpty(keyword)
        ? @"
        SELECT 
            DDH.MaDatHang, 
            DDH.TenKhachHang, 
            DDH.Email, 
            DDH.SoDienThoai, 
            DDH.DiaChi, 
            DDH.PhuongThucThanhToan, 
            DDH.PhuongThucVanChuyen,
            DDH.NgayDatHang, 
            DDH.TienKhuyenMai, 
            DDH.ThanhTien,
            DDH.TongTien, 
            DDH.TrangThai, 
            KM.TenKhuyenMai, 
            KM.MaKhuyenMai
        FROM DonDatHang DDH
        LEFT JOIN KhuyenMai KM ON DDH.MaKhuyenMai = KM.MaKhuyenMai
        ORDER BY DDH.NgayDatHang DESC"
        : @"
        SELECT 
            DDH.MaDatHang, 
            DDH.TenKhachHang, 
            DDH.Email, 
            DDH.SoDienThoai, 
            DDH.DiaChi, 
            DDH.PhuongThucThanhToan, 
            DDH.PhuongThucVanChuyen,
            DDH.NgayDatHang, 
            DDH.TienKhuyenMai, 
            DDH.ThanhTien,
            DDH.TongTien, 
            DDH.TrangThai, 
            KM.TenKhuyenMai, 
            KM.MaKhuyenMai
        FROM DonDatHang DDH
        LEFT JOIN KhuyenMai KM ON DDH.MaKhuyenMai = KM.MaKhuyenMai
        WHERE DDH.TenKhachHang LIKE @Keyword 
           OR DDH.Email LIKE @Keyword 
           OR DDH.SoDienThoai LIKE @Keyword
        ORDER BY DDH.NgayDatHang DESC";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                if (!string.IsNullOrEmpty(keyword))
                {
                    cmd.Parameters.AddWithValue("@Keyword", "%" + keyword + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();

                    // Hiển thị thông báo pop-up không tìm thấy
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showAlert", "alert('Không có kết quả tìm kiếm đơn hàng phù hợp!');", true);
                }
            }
        }
        protected void txtSoLuong_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlSanPham.SelectedValue) && !string.IsNullOrEmpty(txtSoLuong.Text))
            {
                decimal giaSanPham = 0, tyLeKhuyenMai = 0;

                // Lấy giá sản phẩm
                string queryGiaSanPham = "SELECT Gia FROM SanPham WHERE MaSanPham = @MaSanPham";
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(queryGiaSanPham, conn);
                    cmd.Parameters.AddWithValue("@MaSanPham", ddlSanPham.SelectedValue);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    giaSanPham = result != null ? Convert.ToDecimal(result) : 0;
                    conn.Close();
                }

                if (giaSanPham == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Không tìm thấy giá sản phẩm!');", true);
                    return;
                }

                // Tính tổng tiền
                int soLuong = int.Parse(txtSoLuong.Text);
                decimal tongTien = giaSanPham * soLuong;

                // Lấy tỷ lệ khuyến mãi
                if (!string.IsNullOrEmpty(ddlKhuyenMai.SelectedValue))
                {
                    string queryTyLe = "SELECT TyLeKhuyenMai FROM KhuyenMai WHERE MaKhuyenMai = @MaKhuyenMai";
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        SqlCommand cmd = new SqlCommand(queryTyLe, conn);
                        cmd.Parameters.AddWithValue("@MaKhuyenMai", ddlKhuyenMai.SelectedValue);
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        tyLeKhuyenMai = result != null ? Convert.ToDecimal(result) : 0;
                        conn.Close();
                    }
                }

                // Tính tiền khuyến mãi và thành tiền
                decimal tienKhuyenMai = tongTien * (tyLeKhuyenMai / 100);
                decimal thanhTien = tongTien - tienKhuyenMai;

                // Hiển thị kết quả
                txtTongTien.Text = tongTien.ToString("N2");
                txtTienKhuyenMai.Text = tienKhuyenMai.ToString("N2");
                txtThanhTien.Text = thanhTien.ToString("N2");
            }
            else
            {
                txtTongTien.Text = "0";
                txtTienKhuyenMai.Text = "0";
                txtThanhTien.Text = "0";
            }
        }
        private void BindKhuyenMaiDropdown()
        {
            string query = @"SELECT MaKhuyenMai, TenKhuyenMai 
                     FROM KhuyenMai 
                     WHERE GETDATE() BETWEEN NgayBatDau AND NgayKetThuc";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                // Xóa dữ liệu cũ và bind dữ liệu mới
                ddlKhuyenMai.Items.Clear();
                ddlKhuyenMai.DataSource = reader;
                ddlKhuyenMai.DataTextField = "TenKhuyenMai";
                ddlKhuyenMai.DataValueField = "MaKhuyenMai";
                ddlKhuyenMai.DataBind();
                conn.Close();
            }

            // Thêm giá trị mặc định "Không có khuyến mãi"
            ddlKhuyenMai.Items.Insert(0, new ListItem("-- Không có khuyến mãi --", ""));
        }


        protected void ddlKhuyenMai_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlSanPham.SelectedValue) && !string.IsNullOrEmpty(txtSoLuong.Text))
            {
                decimal giaSanPham = 0, tyLeKhuyenMai = 0;

                // Lấy giá sản phẩm
                string queryGiaSanPham = "SELECT Gia FROM SanPham WHERE MaSanPham = @MaSanPham";
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand(queryGiaSanPham, conn);
                    cmd.Parameters.AddWithValue("@MaSanPham", ddlSanPham.SelectedValue);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    giaSanPham = result != null ? Convert.ToDecimal(result) : 0;
                    conn.Close();
                }

                // Kiểm tra giá sản phẩm
                if (giaSanPham == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Không tìm thấy giá sản phẩm!');", true);
                    return;
                }

                // Tính tổng tiền
                int soLuong = int.Parse(txtSoLuong.Text);
                decimal tongTien = giaSanPham * soLuong;

                // Lấy tỷ lệ khuyến mãi
                if (!string.IsNullOrEmpty(ddlKhuyenMai.SelectedValue))
                {
                    string queryTyLe = "SELECT TyLeKhuyenMai FROM KhuyenMai WHERE MaKhuyenMai = @MaKhuyenMai";
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString))
                    {
                        SqlCommand cmd = new SqlCommand(queryTyLe, conn);
                        cmd.Parameters.AddWithValue("@MaKhuyenMai", ddlKhuyenMai.SelectedValue);
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        tyLeKhuyenMai = result != null ? Convert.ToDecimal(result) : 0;
                        conn.Close();
                    }
                }

                // Tính tiền khuyến mãi và thành tiền
                decimal tienKhuyenMai = tongTien * (tyLeKhuyenMai / 100);
                decimal thanhTien = tongTien - tienKhuyenMai;

                // Hiển thị kết quả
                txtTongTien.Text = tongTien.ToString("N2");
                txtTienKhuyenMai.Text = tienKhuyenMai.ToString("N2");
                txtThanhTien.Text = thanhTien.ToString("N2");
            }
            else
            {
                txtTongTien.Text = "0";
                txtTienKhuyenMai.Text = "0";
                txtThanhTien.Text = "0";
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView();
        }

        protected void txtSoDienThoai_TextChanged(object sender, EventArgs e)
        {
            string soDienThoai = txtSoDienThoai.Text.Trim();

            string query = @"
        SELECT MaNguoiDung, HoTen, DiaChi, Email
        FROM NguoiDung 
        WHERE SoDienThoai = @SoDienThoai";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SoDienThoai", soDienThoai);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    hfMaNguoiDung.Value = reader["MaNguoiDung"].ToString();
                    txtTenKhachHang.Text = reader["HoTen"].ToString();

                    txtEmail.Text = reader["Email"].ToString();
                    
                }
                else
                {
                    hfMaNguoiDung.Value = null; // Không tìm thấy người dùng
                    txtTenKhachHang.Text = "";
                    txtEmail.Text = "";
                    txtDiaChi.Text = "";
                }
            }
        }
        protected void ddlTenSanPham_SelectedIndexChanged(object sender, EventArgs e)
        {
            hdfMaSanPham.Value = ddlSanPham.SelectedValue;
        }

        protected void ddlTenKhuyenMaiEdit_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfMaKhuyenMai.Value = ddlKhuyenMai.SelectedValue;
        }
        protected void btnAddOrder_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;

            // Tạo mã đơn hàng duy nhất
            string maDatHang = "DH" + DateTime.Now.Ticks.ToString().Substring(8, 8);

            string maNguoiDung = hdfMaNguoiDung.Value;
            string maSanPham = ddlSanPham.SelectedValue;
            string maSize = ddlSize.SelectedValue;
            string maKhuyenMai = ddlKhuyenMai.SelectedValue;
            string tenKhachHang = txtTenKhachHang.Text;
            string email = txtEmail.Text;
            string soDienThoai = txtSoDienThoai.Text;
            string diaChi = txtDiaChi.Text;
            string phuongThucVanChuyen = "Giao hàng nhanh";
            string phuongThucThanhToan = ddlPhuongThucThanhToan.SelectedValue;
            int soLuong = 0;

            decimal giaSanPham = 0, tongTien = 0, tyLeKhuyenMai = 0, tienKhuyenMai = 0, thanhTien = 0;

            // Kiểm tra dữ liệu nhập vào
            if (string.IsNullOrEmpty(maSanPham) || string.IsNullOrEmpty(maSize) || !int.TryParse(txtSoLuong.Text, out soLuong) || soLuong <= 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Dữ liệu nhập không hợp lệ!');", true);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // 1. Lấy giá sản phẩm
                    string queryGiaSanPham = "SELECT Gia FROM SanPham WHERE MaSanPham = @MaSanPham";
                    using (SqlCommand cmd = new SqlCommand(queryGiaSanPham, conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);
                        object result = cmd.ExecuteScalar();
                        if (result == null) throw new Exception("Không tìm thấy sản phẩm!");
                        giaSanPham = Convert.ToDecimal(result);
                    }

                    // 2. Tính tổng tiền
                    tongTien = giaSanPham * soLuong;

                    // 3. Lấy tỷ lệ khuyến mãi
                    if (!string.IsNullOrEmpty(maKhuyenMai))
                    {
                        string queryTyLeKhuyenMai = "SELECT TyLeKhuyenMai FROM KhuyenMai WHERE MaKhuyenMai = @MaKhuyenMai";
                        using (SqlCommand cmd = new SqlCommand(queryTyLeKhuyenMai, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@MaKhuyenMai", maKhuyenMai);
                            object result = cmd.ExecuteScalar();
                            tyLeKhuyenMai = result != null ? Convert.ToDecimal(result) : 0;
                        }
                    }

                    // 4. Tính tiền khuyến mãi và thành tiền
                    tienKhuyenMai = tongTien * (tyLeKhuyenMai / 100);
                    thanhTien = tongTien - tienKhuyenMai;

                    // 5. Thêm vào bảng DonDatHang
                    string queryInsertDonHang = @"
        INSERT INTO DonDatHang (MaDatHang, MaNguoiDung, MaKhuyenMai, TenKhachHang, Email, SoDienThoai, DiaChi, 
                                PhuongThucVanChuyen, TongTien, TienKhuyenMai, ThanhTien, PhuongThucThanhToan, NgayDatHang, TrangThai)
        VALUES (@MaDatHang, @MaNguoiDung, @MaKhuyenMai, @TenKhachHang, @Email, @SoDienThoai, @DiaChi,
                @PhuongThucVanChuyen, @TongTien, @TienKhuyenMai, @ThanhTien, @PhuongThucThanhToan, @NgayDatHang, @TrangThai)";
                    using (SqlCommand cmd = new SqlCommand(queryInsertDonHang, conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@MaDatHang", maDatHang);
                        cmd.Parameters.AddWithValue("@MaNguoiDung", string.IsNullOrEmpty(maNguoiDung) ? (object)DBNull.Value : maNguoiDung);
                        cmd.Parameters.AddWithValue("@MaKhuyenMai", string.IsNullOrEmpty(maKhuyenMai) ? (object)DBNull.Value : maKhuyenMai);
                        cmd.Parameters.AddWithValue("@TenKhachHang", tenKhachHang);
                        cmd.Parameters.AddWithValue("@SoDienThoai", soDienThoai);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@DiaChi", diaChi);
                        cmd.Parameters.AddWithValue("@PhuongThucVanChuyen", phuongThucVanChuyen);
                        cmd.Parameters.AddWithValue("@TongTien", tongTien);
                        cmd.Parameters.AddWithValue("@TienKhuyenMai", tienKhuyenMai);
                        cmd.Parameters.AddWithValue("@ThanhTien", thanhTien);
                        cmd.Parameters.AddWithValue("@PhuongThucThanhToan", phuongThucThanhToan);
                        cmd.Parameters.AddWithValue("@NgayDatHang", DateTime.Now);
                        cmd.Parameters.AddWithValue("@TrangThai", ddlTrangThai.SelectedValue ?? "Đã đặt");
                        cmd.ExecuteNonQuery();
                    }

                    // 6. Thêm vào bảng ChiTietDonDatHang
                    string queryInsertChiTiet = @"
        INSERT INTO ChiTietDonDatHang (MaDatHang, MaSanPham, MaSize, SoLuong)
        VALUES (@MaDatHang, @MaSanPham, @MaSize, @SoLuong)";
                    using (SqlCommand cmd = new SqlCommand(queryInsertChiTiet, conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@MaDatHang", maDatHang);
                        cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);
                        cmd.Parameters.AddWithValue("@MaSize", maSize);
                        cmd.Parameters.AddWithValue("@SoLuong", soLuong);
                        cmd.ExecuteNonQuery();
                    }

                    // Commit transaction
                    transaction.Commit();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Thêm đơn hàng thành công!');", true);
                }
                catch (Exception ex)
                {
                    if (transaction.Connection != null) // Kiểm tra transaction có còn khả dụng
                    {
                        transaction.Rollback();
                    }
                    Debug.WriteLine($"Lỗi: {ex.Message}");
                    string errorMessage = ex.Message.Replace("'", "\\'").Replace("\n", "").Replace("\r", "");
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Lỗi: {errorMessage}');", true);
                }
                finally
                {
                    transaction.Dispose(); // Đảm bảo transaction được giải phóng
                }
            }
        }

        private void BindGridView()
        {
            string query = @"
        SELECT 
            DDH.MaDatHang, 
            DDH.TenKhachHang, 
            DDH.Email, 
            DDH.SoDienThoai, 
            DDH.DiaChi, 
            DDH.PhuongThucThanhToan, 
            DDH.PhuongThucVanChuyen,
            DDH.NgayDatHang, DDH.TienKhuyenMai, DDH.ThanhTien,
            DDH.TongTien, 
            DDH.TrangThai, 
            KM.TenKhuyenMai, 
            KM.MaKhuyenMai
        FROM DonDatHang DDH
        LEFT JOIN KhuyenMai KM ON DDH.MaKhuyenMai = KM.MaKhuyenMai
ORDER BY DDH.NgayDatHang desc";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                conn.Open();
                da.Fill(dt);
                conn.Close();

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
        


        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;

            DropDownList ddlTenKhuyenMai = (DropDownList)GridView1.Rows[e.NewEditIndex].FindControl("ddlTenKhuyenMai");
            if (ddlTenKhuyenMai != null)
            {
                string query = "SELECT MaKhuyenMai, TenKhuyenMai FROM KhuyenMai";
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    ddlTenKhuyenMai.DataSource = dataTable;
                    ddlTenKhuyenMai.DataTextField = "TenKhuyenMai";
                    ddlTenKhuyenMai.DataValueField = "MaKhuyenMai";
                    ddlTenKhuyenMai.DataBind();
                }

                // Gán giá trị hiện tại vào DropDownList
                string currentMaKhuyenMai = ((Label)GridView1.Rows[e.NewEditIndex].FindControl("lblTenKhuyenMai")).Text;
                ddlTenKhuyenMai.SelectedValue = currentMaKhuyenMai;
            }
            BindGridView();

        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string maDatHang = GridView1.DataKeys[e.RowIndex].Value.ToString();

            // Lấy DropDownList và giá trị mới
            DropDownList ddlTenKhuyenMai = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlTenKhuyenMai");
            string maKhuyenMai = ddlTenKhuyenMai?.SelectedValue;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString))
            {
                string query = "UPDATE DonDatHang SET MaKhuyenMai = @MaKhuyenMai WHERE MaDatHang = @MaDatHang";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaKhuyenMai", string.IsNullOrEmpty(maKhuyenMai) ? (object)DBNull.Value : maKhuyenMai);
                cmd.Parameters.AddWithValue("@MaDatHang", maDatHang);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // Hủy chế độ chỉnh sửa
            GridView1.EditIndex = -1;
            BindGridView();
        }
        
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddlTenKhuyenMai = (DropDownList)e.Row.FindControl("ddlTenKhuyenMai");

                if (ddlTenKhuyenMai != null)
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString))
                    {
                        string query = "SELECT MaKhuyenMai, TenKhuyenMai FROM KhuyenMai";
                        SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                        DataTable dt = new DataTable(); 
                        adapter.Fill(dt);

                        ddlTenKhuyenMai.DataSource = dt;
                        ddlTenKhuyenMai.DataTextField = "TenKhuyenMai";
                        ddlTenKhuyenMai.DataValueField = "MaKhuyenMai";
                        ddlTenKhuyenMai.DataBind();

                        // Gán giá trị hiện tại vào DropDownList
                        string currentValue = DataBinder.Eval(e.Row.DataItem, "MaKhuyenMai")?.ToString();
                        if (!string.IsNullOrEmpty(currentValue))
                        {
                            ddlTenKhuyenMai.SelectedValue = currentValue;
                        }
                    }
                }
            }
        
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                string maDatHang = e.CommandArgument.ToString();

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                SELECT 
                    DDH.MaDatHang, 
                    DDH.MaKhuyenMai, 
                    KM.TenKhuyenMai, 
                    DDH.TenKhachHang, 
                    DDH.Email, 
                    DDH.SoDienThoai, 
                    DDH.DiaChi, 
                    DDH.TongTien, 
                    DDH.TienKhuyenMai, 
                    DDH.ThanhTien, 
                    DDH.TrangThai, 
                    DDH.PhuongThucThanhToan, 
                    CTDDH.MaSanPham, 
                    CTDDH.MaSize, 
                    CTDDH.SoLuong
                FROM DonDatHang DDH
                LEFT JOIN KhuyenMai KM ON DDH.MaKhuyenMai = KM.MaKhuyenMai
                LEFT JOIN ChiTietDonDatHang CTDDH ON DDH.MaDatHang = CTDDH.MaDatHang
                WHERE DDH.MaDatHang = @MaDatHang";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MaDatHang", maDatHang);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        // Populate fields in the modal
                        ddlSanPhamEdit.SelectedValue = reader["MaSanPham"]?.ToString() ?? string.Empty;
                        ddlSizeEdit.SelectedValue = reader["MaSize"]?.ToString() ?? string.Empty;
                        ddlKhuyenMaiEdit.SelectedValue = reader["MaKhuyenMai"]?.ToString() ?? string.Empty;
                        txtSoDienThoaiEdit.Text = reader["SoDienThoai"].ToString();
                        txtTenKhachHangEdit.Text = reader["TenKhachHang"].ToString();
                        txtEmailEdit.Text = reader["Email"].ToString();
                        txtDiaChiEdit.Text = reader["DiaChi"].ToString();
                        txtTongTienEdit.Text = reader["TongTien"].ToString();
                        txtTienKhuyenMaiEdit.Text = reader["TienKhuyenMai"].ToString();
                        txtThanhTienEdit.Text = reader["ThanhTien"].ToString();
                        ddlPhuongThucThanhToanEdit.SelectedValue = reader["PhuongThucThanhToan"].ToString();
                        ddlTrangThaiEdit.SelectedValue = reader["TrangThai"].ToString();

                        // Populate SoLuong field
                        txtSoLuongEdit.Text = reader["SoLuong"].ToString();
                    }

                    conn.Close();
                }

                // Save the order ID for further updates
                ViewState["EditMaDatHang"] = maDatHang;

                // Trigger UpdatePanel to refresh and open modal
                ScriptManager.RegisterStartupScript(this, GetType(), "openEditModal", $"openEditOrderModal('{maDatHang}');", true);
            }
        }
  
        protected void BindTrangThaiDropdown()
        {
            List<string> trangThaiOptions = new List<string>
    {
        "Đã đặt",
        "Đang xử lý",
        "Đã giao",
        "Đã hủy"
    };

            ddlTrangThaiEdit.DataSource = trangThaiOptions;
            ddlTrangThaiEdit.DataBind();

            // Set default value if needed
            ddlTrangThaiEdit.SelectedValue = "Đã đặt";
        }
        
            protected void btnEditOrder_Click(object sender, EventArgs e)
            {
                // Lấy giá trị từ các trường trong modal
                string maDatHang = hfMaDatHang.Value; // Mã đơn hàng không đổi
           
                string maSanPham = ddlSanPhamEdit.SelectedValue;
                string maSize = ddlSizeEdit.SelectedValue;
                string maKhuyenMai = ddlKhuyenMaiEdit.SelectedValue;
                string soDienThoai = txtSoDienThoaiEdit.Text.Trim();
                string tenKhachHang = txtTenKhachHangEdit.Text.Trim();
                string email = txtEmailEdit.Text.Trim();
                string diaChi = txtDiaChiEdit.Text.Trim();
                int soLuong = int.Parse(txtSoLuongEdit.Text.Trim());
                string phuongThucThanhToan = ddlPhuongThucThanhToanEdit.SelectedValue;
                string trangThai = ddlTrangThaiEdit.SelectedValue;

                // Biến tính toán
                decimal giaSanPham = 0, tongTien = 0, tyLeKhuyenMai = 0, tienKhuyenMai = 0, thanhTien = 0;

                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString))
                    {
                        conn.Open();
                        SqlTransaction transaction = conn.BeginTransaction();

                        try
                        {
                            // 1. Lấy giá sản phẩm
                            string queryGiaSanPham = "SELECT Gia FROM SanPham WHERE MaSanPham = @MaSanPham";
                            using (SqlCommand cmd = new SqlCommand(queryGiaSanPham, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);
                                object result = cmd.ExecuteScalar();
                                if (result == null) throw new Exception("Không tìm thấy giá sản phẩm.");
                                giaSanPham = Convert.ToDecimal(result);
                            }

                            // 2. Tính tổng tiền
                            tongTien = giaSanPham * soLuong;

                            // 3. Lấy tỷ lệ khuyến mãi
                            if (!string.IsNullOrEmpty(maKhuyenMai))
                            {
                                string queryTyLeKhuyenMai = @"
                        SELECT TyLeKhuyenMai 
                        FROM KhuyenMai 
                        WHERE MaKhuyenMai = @MaKhuyenMai 
                        AND GETDATE() BETWEEN NgayBatDau AND NgayKetThuc";
                                using (SqlCommand cmd = new SqlCommand(queryTyLeKhuyenMai, conn, transaction))
                                {
                                    cmd.Parameters.AddWithValue("@MaKhuyenMai", maKhuyenMai);
                                    object result = cmd.ExecuteScalar();
                                    tyLeKhuyenMai = result != null ? Convert.ToDecimal(result) : 0;
                                }
                            }

                            // 4. Tính tiền khuyến mãi và thành tiền
                            tienKhuyenMai = tongTien * (tyLeKhuyenMai / 100);
                            thanhTien = tongTien - tienKhuyenMai;

                            // 5. Cập nhật bảng DonDatHang
                            string queryUpdateDonDatHang = @"
                    UPDATE DonDatHang
                    SET MaKhuyenMai = @MaKhuyenMai, 
                        TenKhachHang = @TenKhachHang, 
                        Email = @Email, 
                        SoDienThoai = @SoDienThoai, 
                        DiaChi = @DiaChi, 
                        TongTien = @TongTien, 
                        TienKhuyenMai = @TienKhuyenMai, 
                        ThanhTien = @ThanhTien, 
                        PhuongThucThanhToan = @PhuongThucThanhToan, 
                        TrangThai = @TrangThai
                    WHERE MaDatHang = @MaDatHang";
                            using (SqlCommand cmd = new SqlCommand(queryUpdateDonDatHang, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@MaDatHang", maDatHang);
                                cmd.Parameters.AddWithValue("@MaKhuyenMai", string.IsNullOrEmpty(maKhuyenMai) ? (object)DBNull.Value : maKhuyenMai);
                                cmd.Parameters.AddWithValue("@TenKhachHang", tenKhachHang);
                                cmd.Parameters.AddWithValue("@Email", email);
                                cmd.Parameters.AddWithValue("@SoDienThoai", soDienThoai);
                                cmd.Parameters.AddWithValue("@DiaChi", diaChi);
                                cmd.Parameters.AddWithValue("@TongTien", tongTien);
                                cmd.Parameters.AddWithValue("@TienKhuyenMai", tienKhuyenMai);
                                cmd.Parameters.AddWithValue("@ThanhTien", thanhTien);
                                cmd.Parameters.AddWithValue("@PhuongThucThanhToan", phuongThucThanhToan);
                                cmd.Parameters.AddWithValue("@TrangThai", trangThai);
                                cmd.ExecuteNonQuery();
                            }

                            // 6. Cập nhật bảng ChiTietDonDatHang
                            string queryUpdateChiTiet = @"
                    UPDATE ChiTietDonDatHang
                    SET MaSanPham = @MaSanPham, 
                        MaSize = @MaSize, 
                        SoLuong = @SoLuong
                    WHERE MaDatHang = @MaDatHang";
                            using (SqlCommand cmd = new SqlCommand(queryUpdateChiTiet, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@MaDatHang", maDatHang);
                                cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);
                                cmd.Parameters.AddWithValue("@MaSize", maSize);
                                cmd.Parameters.AddWithValue("@SoLuong", soLuong);
                                cmd.ExecuteNonQuery();
                            }

                            // Commit transaction nếu thành công
                            transaction.Commit();
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Cập nhật đơn hàng thành công!');", true);
                        }
                        catch
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Lỗi: {ex.Message}');", true);
                }
            }
        }
    }




