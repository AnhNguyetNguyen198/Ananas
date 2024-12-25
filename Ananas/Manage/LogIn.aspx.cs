using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas.Manage
{
    public partial class LogIn : System.Web.UI.Page
    {
            protected void btnLogin_Click(object sender, EventArgs e)
            {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ConnectionString;
            string query = "SELECT MatKhau FROM NhanVien WHERE Email = @Email";

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", email);

                    conn.Open();
                    object result = cmd.ExecuteScalar(); // Lấy mật khẩu từ cơ sở dữ liệu

                    if (result != null)
                    {
                        string storedPassword = result.ToString(); // Mật khẩu lưu trong DB

                        if (storedPassword == password)
                        {
                            // Đăng nhập thành công
                            Session["Email"] = email;
                            Session["LoggedIn"] = true;

                            // Chuyển hướng về Dashboard
                            Response.Redirect("Dashboard.aspx");
                        }
                        else
                        {
                            // Sai mật khẩu
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sai mật khẩu!');", true);
                        }
                    }
                    else
                    {
                        // Email không tồn tại
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Email không tồn tại!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                // Hiển thị lỗi nếu xảy ra exception
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('Đã xảy ra lỗi: {ex.Message}');", true);
            }
        }

        private string HashPassword(string password)
        {
            return BCrypt.Net.BCrypt.HashPassword(password);
        }

        private bool VerifyPassword(string password, string hashedPassword)
        {
            return BCrypt.Net.BCrypt.Verify(password, hashedPassword);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

    }
}
