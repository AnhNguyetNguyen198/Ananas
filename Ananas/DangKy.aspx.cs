using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;

namespace Ananas
{
    public partial class DangKy : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                Response.Write("<script>alert('Có lỗi xác thực, vui lòng kiểm tra lại các trường nhập!');</script>");
                return; // Nếu xác thực không hợp lệ, dừng lại
            }

            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string email = txtEmail.Text.Trim();
            string fullName = txtFullName.Text.Trim();
            string dob = txtDOB.Text.Trim();
            string address = txtAddress.Text.Trim();
             // Mặc định vai trò là Khách hàng (KH)

            // Kiểm tra nếu mật khẩu và xác nhận mật khẩu khớp nhau
            if (password != confirmPassword)
            {
                Response.Write("<script>alert('Mật khẩu và xác nhận mật khẩu không trùng khớp!');</script>");
                return;
            }

            // Kiểm tra độ mạnh của mật khẩu
            if (!IsPasswordValid(password))
            {
                Response.Write("<script>alert('Mật khẩu phải có ít nhất 8 ký tự, bao gồm ít nhất một ký tự đặc biệt!');</script>");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Kiểm tra email đã tồn tại chưa
                    string checkQuery = "SELECT COUNT(*) FROM NguoiDung WHERE Email = @Email";
                    using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                    {
                        checkCommand.Parameters.AddWithValue("@Email", email);
                        int exists = (int)checkCommand.ExecuteScalar();
                        if (exists > 0)
                        {
                            Response.Write("<script>alert('Email đã tồn tại!');</script>");
                            return;
                        }
                    }

                    // Tạo mã người dùng duy nhất
                    string newUserId = Guid.NewGuid().ToString().Substring(0, 10); // Mã người dùng mới

                    string insertQuery = @"
                INSERT INTO NguoiDung (MaNguoiDung, SoDienThoai, MatKhau, Email, HoTen, NgaySinh, DiaChi, TrangThai)
                VALUES (@MaNguoiDung, @SoDienThoai, @MatKhau, @Email, @HoTen, @NgaySinh, @DiaChi, @TrangThai)";

                    using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                    {
                        // Thêm các tham số vào câu lệnh SQL
                        insertCommand.Parameters.AddWithValue("@MaNguoiDung", newUserId);
                        insertCommand.Parameters.AddWithValue("@SoDienThoai", phone);
                        insertCommand.Parameters.AddWithValue("@MatKhau", password);
                        insertCommand.Parameters.AddWithValue("@Email", email);
                        insertCommand.Parameters.AddWithValue("@HoTen", fullName);
                        insertCommand.Parameters.AddWithValue("@NgaySinh", string.IsNullOrEmpty(dob) ? (object)DBNull.Value : DateTime.ParseExact(dob, "dd-MM-yyyy", null));
                        insertCommand.Parameters.AddWithValue("@DiaChi", address);
                        insertCommand.Parameters.AddWithValue("@TrangThai", "Kích hoạt");

                        // Thực thi câu lệnh chèn
                        insertCommand.ExecuteNonQuery();
                        Response.Redirect("DangNhap.aspx"); // Sau khi đăng ký thành công, chuyển hướng tới trang đăng nhập
                    }
                }
            }
            catch (Exception ex)
            {
                // Log lỗi chi tiết
                Response.Write($"<script>alert('Lỗi khi lưu vào cơ sở dữ liệu: {ex.Message}');</script>");
            }
        }


        private bool IsPasswordValid(string password)
        {
            // Regex để kiểm tra mật khẩu: ít nhất 8 ký tự, ít nhất 1 ký tự đặc biệt
            string pattern = @"^(?=.*[!@#$%^&*(),.?""{}|<>])[A-Za-z\d!@#$%^&*(),.?""{}|<>]{8,}$";
            return Regex.IsMatch(password, pattern);
        }
       
    }
}
