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
    public partial class User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string keyword = Request.QueryString["search"];
                if (!string.IsNullOrEmpty(keyword))
                {
                    Search(keyword); // Gọi tìm kiếm nếu có từ khóa
                }
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
        public void Search(string keyword)
        {
            // Cập nhật SelectCommand của SqlDataSource để lọc dữ liệu
            SqlDataSourceUser.SelectCommand = string.IsNullOrEmpty(keyword)
                ? "SELECT * FROM NguoiDung"
                : "SELECT * FROM NguoiDung WHERE HoTen LIKE @Keyword OR Email LIKE @Keyword OR SoDienThoai LIKE @Keyword";

            // Thêm tham số nếu có từ khóa
            SqlDataSourceUser.SelectParameters.Clear();
            if (!string.IsNullOrEmpty(keyword))
            {
                SqlDataSourceUser.SelectParameters.Add("Keyword", $"%{keyword}%");
            }
        }
        private string GenerateMaNguoiDung()
        {
            string newID = "ND0001"; // Mặc định nếu không có bản ghi nào

            string query = "SELECT TOP 1 MaNguoiDung FROM NguoiDung ORDER BY MaNguoiDung DESC";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    // Lấy mã cuối cùng và tăng thêm 1
                    string lastID = result.ToString(); // VD: ND0001
                    int number = int.Parse(lastID.Substring(2)) + 1;
                    newID = "ND" + number.ToString("D4"); // Format thành ND0002, ND0003,...
                }
                conn.Close();
            }

            return newID;
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string trangThai = DataBinder.Eval(e.Row.DataItem, "TrangThai").ToString();
                if (trangThai == "Khóa")
                {
                    e.Row.BackColor = System.Drawing.Color.LightGray; // Màu xám
                    e.Row.ForeColor = System.Drawing.Color.Red; // Chữ đỏ
                    e.Row.Font.Bold = true;
                }
            }
        }
        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                string trangThai = ddlTrangThai.SelectedValue;

                // Kiểm tra giá trị hợp lệ cho Trạng thái
                if (trangThai != "Kích hoạt" && trangThai != "Khóa")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Giá trị trạng thái không hợp lệ!');", true);
                    return;
                }

                // Kiểm tra định dạng email
                if (!System.Text.RegularExpressions.Regex.IsMatch(txtEmail.Text, @"^[^@\s]+@gmail\.com$"))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Email không hợp lệ! Email phải có đuôi @gmail.com.');", true);
                    return;
                }
                string email = txtEmail.Text.Trim();

                // Kiểm tra email đã tồn tại hay chưa
                if (IsEmailExists(email))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Email đã tồn tại! Vui lòng sử dụng email khác.');", true);
                    return;
                }
                // Kiểm tra số điện thoại
                if (!System.Text.RegularExpressions.Regex.IsMatch(txtSoDienThoai.Text, @"^\d+$"))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Số điện thoại không hợp lệ! Chỉ được chứa số.');", true);
                    return;
                }

                // Kiểm tra ngày sinh
                DateTime ngaySinh;
                if (!DateTime.TryParseExact(txtNgaySinh.Text, "yyyy-MM-dd", null, System.Globalization.DateTimeStyles.None, out ngaySinh))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Ngày sinh không hợp lệ! Định dạng phải là yyyy-MM-dd.');", true);
                    return;
                }

                // Thêm người dùng
                string maNguoiDung = GenerateMaNguoiDung();
                string query = @"INSERT INTO NguoiDung (MaNguoiDung, HoTen, SoDienThoai, MatKhau, Email, NgaySinh, DiaChi, TrangThai)
                         VALUES (@MaNguoiDung, @HoTen, @SoDienThoai, @MatKhau, @Email, @NgaySinh, @DiaChi, @TrangThai)";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MaNguoiDung", maNguoiDung);
                    cmd.Parameters.AddWithValue("@HoTen", txtHoTen.Text.Trim());
                    cmd.Parameters.AddWithValue("@SoDienThoai", txtSoDienThoai.Text.Trim());
                    cmd.Parameters.AddWithValue("@MatKhau", HashPassword(txtMatKhau.Text.Trim()));
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@NgaySinh", ngaySinh.Date);
                    cmd.Parameters.AddWithValue("@DiaChi", txtDiaChi.Text.Trim());
                    cmd.Parameters.AddWithValue("@TrangThai", trangThai);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                GridView1.DataBind();

                // Hiển thị thông báo thành công
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Thêm người dùng thành công!');", true);

                ClearFormFields();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('Lỗi: {ex.Message}');", true);
            }
        }

        // Phương thức mã hóa mật khẩu
        private string HashPassword(string password)
        {
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string maNguoiDung = GridView1.DataKeys[e.RowIndex].Value.ToString();

                // Retrieve controls for editable fields
                DropDownList ddlTrangThai = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlTrangThaiEdit");
                TextBox txtSoDienThoai = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtSoDienThoaiEdit");
                TextBox txtHoTen = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtHoTenEdit");
                TextBox txtDiaChi = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtDiaChiEdit");

                // Validate inputs
                if (string.IsNullOrEmpty(txtSoDienThoai.Text) || string.IsNullOrEmpty(txtHoTen.Text))
                {
                    // Display error (use a label or modal for feedback)
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Họ tên và số điện thoại không được để trống!');", true);
                    return;
                }

                // Query for updating
                string query = @"
            UPDATE NguoiDung
            SET SoDienThoai = @SoDienThoai, 
                HoTen = @HoTen, 
                TrangThai = @TrangThai, 
                DiaChi = @DiaChi
            WHERE MaNguoiDung = @MaNguoiDung";

                // Execute the query
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@SoDienThoai", txtSoDienThoai.Text.Trim());
                    cmd.Parameters.AddWithValue("@HoTen", txtHoTen.Text.Trim());
                    cmd.Parameters.AddWithValue("@TrangThai", ddlTrangThai.SelectedValue);
                    cmd.Parameters.AddWithValue("@DiaChi", txtDiaChi.Text.Trim());
                    cmd.Parameters.AddWithValue("@MaNguoiDung", maNguoiDung);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                // Exit edit mode
                GridView1.EditIndex = -1;

                // Rebind GridView
                GridView1.DataBind();

                // Display success message
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Cập nhật thành công!');", true);
            }
            catch (Exception ex)
            {
                // Log error and display a message
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Lỗi: {ex.Message}');", true);
            }
        }
    
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string maNguoiDung = GridView1.DataKeys[e.RowIndex].Value.ToString();

            string query = "DELETE FROM NguoiDung WHERE MaNguoiDung=@MaNguoiDung";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaNguoiDung", maNguoiDung);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            GridView1.DataBind();
        }
        private bool IsEmailExists(string email)
        {
            string query = "SELECT COUNT(*) FROM NguoiDung WHERE Email = @Email";
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                conn.Close();

                return count > 0;
            }
        }
        private void ClearFormFields()
        {
            txtHoTen.Text = string.Empty;
            txtSoDienThoai.Text = string.Empty;
            txtMatKhau.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtNgaySinh.Text = string.Empty;
            txtDiaChi.Text = string.Empty;
            ddlTrangThai.SelectedIndex = 0;
        }
        private void ShowModal(string message)
        {
            string script = $"$('#messageContent').text('{message}');$('#messageModal').modal('show');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModalScript", script, true);
        }
    }


}