using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas.Manage
{
    public partial class Employee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNhanVien();
            }

            // Kiểm tra Session
            if (Session["Email"] == null || Session["LoggedIn"] == null || !(bool)Session["LoggedIn"])
            {
                // Nếu Session không tồn tại hoặc hết hạn, chuyển hướng về trang đăng nhập
                Response.Redirect("Login.aspx");
                return;
            }

            // Lấy quyền truy cập từ cơ sở dữ liệu
            string email = Session["Email"].ToString();
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
            string query = "SELECT QuyenTruyCap FROM NhanVien WHERE Email = @Email";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                string quyenTruyCap = cmd.ExecuteScalar()?.ToString();
                conn.Close();

                // Lấy tên trang hiện tại
                string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

                // Kiểm tra xem trang hiện tại có trong quyền truy cập không
                if (quyenTruyCap == null || !quyenTruyCap.Split(',').Contains(currentPage))
                {
                    // Nếu không có quyền, chuyển hướng tới Unauthorized
                    Response.Redirect("Unauthorized.aspx");
                }
            }
        }
        

        public static bool HasPermission(HttpContext context, string pageName)
        {
            // Lấy email từ Session
            string email = context.Session["Email"]?.ToString();

            // Kiểm tra quyền của email trên trang pageName
            // (Giả sử bạn đã triển khai logic kiểm tra quyền)
            return CheckUserPermission(email, pageName);
        }
        public static bool CheckUserPermission(string email, string pageName)
        {
            // Nếu email hoặc pageName bị null hoặc rỗng, trả về false
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(pageName))
            {
                return false;
            }

            // Chuỗi kết nối tới cơ sở dữ liệu
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();

            // Câu lệnh SQL để kiểm tra quyền
            string query = "SELECT COUNT(*) FROM PhanQuyen WHERE Email = @Email AND PageName = @PageName";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@PageName", pageName);

                conn.Open();
                int count = (int)cmd.ExecuteScalar(); // Trả về số lượng bản ghi tìm thấy
                conn.Close();

                // Nếu tìm thấy ít nhất 1 bản ghi, trả về true
                return count > 0;
            }
        }
        private void LoadNhanVien()
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
            string query = "SELECT * FROM NhanVien";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewNhanVien.DataSource = dt;
                GridViewNhanVien.DataBind();
            }
        }
        protected void btnAddNhanVien_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "show", "$('#ModalAddNhanVien').modal('show');", true);
        }

        protected void btnPhanQuyen_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "show", "$('#ModalPhanQuyen').modal('show');", true);
        }
        protected void GridViewNhanVien_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "PhanQuyen")
            {
                string maNV = e.CommandArgument.ToString(); // Lấy mã nhân viên
                hfMaNV.Value = maNV;

                // Lấy quyền hiện tại của nhân viên
                string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
                string query = "SELECT QuyenTruyCap FROM NhanVien WHERE MaNV = @MaNV";

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MaNV", maNV);

                    conn.Open();
                    string quyenTruyCap = cmd.ExecuteScalar()?.ToString();
                    conn.Close();

                    // Đánh dấu các quyền hiện có trong CheckBoxList
                    foreach (ListItem item in cblQuyen.Items)
                    {
                        item.Selected = quyenTruyCap?.Contains(item.Value) ?? false;
                    }
                }

                // Hiển thị modal phân quyền
                ScriptManager.RegisterStartupScript(this, this.GetType(), "show", "$('#ModalPhanQuyen').modal('show');", true);
            }
        }
        protected void btnSavePermissions_Click(object sender, EventArgs e)
        {
            string maNV = hfMaNV.Value; // Lấy mã nhân viên từ HiddenField

            // Lấy danh sách các quyền đã chọn
            List<string> selectedPermissions = cblQuyen.Items.Cast<ListItem>()
                .Where(i => i.Selected)
                .Select(i => i.Value) // Lấy Value (link trang)
                .ToList();

            // Chuỗi các link được chọn, phân cách bằng dấu phẩy
            string quyenTruyCap = string.Join(",", selectedPermissions);

            // Lưu vào cơ sở dữ liệu
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
            string query = "UPDATE NhanVien SET QuyenTruyCap = @QuyenTruyCap WHERE MaNV = @MaNV";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@QuyenTruyCap", quyenTruyCap);
                cmd.Parameters.AddWithValue("@MaNV", maNV);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            // Hiển thị thông báo thành công
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cập nhật quyền thành công!');", true);

            // Đóng modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#ModalPhanQuyen').modal('hide');", true);

            // Tải lại danh sách nhân viên
            LoadNhanVien();
        }
        
        protected void btnSaveNhanVien_Click(object sender, EventArgs e)
        {
            try
            {
                // Lấy thông tin từ modal
                string maNV = txtMaNV.Text.Trim();
                string hoTen = txtHoTen.Text.Trim();
                string email = txtEmail.Text.Trim();
                string soDienThoai = txtSoDienThoai.Text.Trim();
                string diaChi = txtDiaChi.Text.Trim();
                string matKhau = txtMatKhau.Text.Trim();
                string trangThai = ddlTrangThai.SelectedValue;

                // Kiểm tra email đã tồn tại chưa
                if (IsEmailExists(email))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Email đã tồn tại!');", true);
                    return;
                }

                // Thêm nhân viên vào cơ sở dữ liệu
                string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
                string query = @"INSERT INTO NhanVien (MaNV, HoTen, Email, SoDienThoai, DiaChi, MatKhau, TrangThai)
                         VALUES (@MaNV, @HoTen, @Email, @SoDienThoai, @DiaChi, @MatKhau, @TrangThai)";

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MaNV", maNV);
                    cmd.Parameters.AddWithValue("@HoTen", hoTen);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@SoDienThoai", soDienThoai);
                    cmd.Parameters.AddWithValue("@DiaChi", diaChi);
                    cmd.Parameters.AddWithValue("@MatKhau", matKhau);
                    cmd.Parameters.AddWithValue("@TrangThai", trangThai);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Reload GridView
                LoadNhanVien();

                // Đóng modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "hide", "$('#ModalAddNhanVien').modal('hide');", true);

                // Hiển thị thông báo thành công
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Thêm nhân viên thành công!');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('Lỗi: {ex.Message}');", true);
            }
        }
        
        private bool IsEmailExists(string email)
        {
            string query = "SELECT COUNT(*) FROM NhanVien WHERE Email = @Email";
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
       
    }
}