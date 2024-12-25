using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Tab;
namespace Ananas
{
    public partial class DangNhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Nếu người dùng đã đăng nhập, chuyển hướng về trang chủ
            if (Session["MaNguoiDung"] != null)
            {
                Response.Redirect("TrangChu.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Check if email and password are not empty
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Vui lòng nhập email và mật khẩu!";
                lblError.Visible = true;
                return;
            }

            // Configure connection string
            string connectionString = "Data Source=LAPTOP-KDT48EKN\\ANHNGUYET;Initial Catalog=Ananas_KLTN;User ID=sa;Password=123;";

            // SQL query to validate login
            string query = @"
        SELECT MaNguoiDung, MatKhau, TrangThai, HoTen
        FROM NguoiDung 
        WHERE Email = @Email";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    // Create SqlCommand with parameters
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Email", email);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                reader.Read();
                                string storedPassword = reader["MatKhau"].ToString();
                                string accountStatus = reader["TrangThai"].ToString();

                                // Check account status
                                if (accountStatus == "Khóa")
                                {
                                    lblError.Text = "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ anhnguyet19082003@gmail.com.";
                                    lblError.Visible = true;
                                    return;
                                }
                                else if (accountStatus != "Kích hoạt")
                                {
                                    lblError.Text = "Tài khoản của bạn chưa được kích hoạt.";
                                    lblError.Visible = true;
                                    return;
                                }

                                // Compare passwords
                                if (storedPassword == password)
                                {
                                    string hoTen = reader["HoTen"].ToString();

                                    // Save user details in Session
                                    Session["UserName"] = hoTen;
                                    Session["MaNguoiDung"] = reader["MaNguoiDung"].ToString();

                                    // Redirect to home page
                                    Response.Redirect("TrangChu.aspx");
                                }
                                else
                                {
                                    lblError.Text = "Mật khẩu không chính xác.";
                                    lblError.Visible = true;
                                }
                            }
                            else
                            {
                                lblError.Text = "Email không tồn tại trong hệ thống.";
                                lblError.Visible = true;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Có lỗi xảy ra: " + ex.Message;
                    lblError.Visible = true;
                }
            }

        }
        protected void btnSendResetLink_Click(object sender, EventArgs e)
        {
            string email = Request.Form["forgotEmail"]; // Lấy giá trị từ trường forgotEmail

            if (string.IsNullOrEmpty(email))
            {
                lblError.Text = "Vui lòng nhập email của bạn.";
                return;
            }

            // Gửi email reset mật khẩu
            bool success = SendResetPasswordEmail(email);

            if (success)
            {
                lblError.Text = "Liên kết đặt lại mật khẩu đã được gửi.";
            }
            else
            {
                lblError.Text = "Không thể gửi liên kết. Vui lòng thử lại sau.";
            }
        }

        private bool SendResetPasswordEmail(string email)
        {
            // Logic gửi email reset mật khẩu
            // Trả về true nếu thành công, false nếu thất bại
            return true;
        }

        private void SaveResetToken(string email, string resetToken)
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ConnectionString;
            string query = "UPDATE NguoiDung SET ResetToken = @ResetToken WHERE Email = @Email";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ResetToken", resetToken);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        private bool IsEmailExists(string email)
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM NguoiDung WHERE Email = @Email";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
        private void SendResetPasswordEmail(string email, string resetLink)
        {
            //try
            //{
            //    var mailMessage = new MailMessage
            //    {
            //        From = new MailAddress("2121013309@sv.ufm.edu.vn", "Hệ Thống Ananas"),
            //        Subject = "Đặt lại mật khẩu - Ananas",
            //        Body = $"<p>Click vào liên kết sau để đặt lại mật khẩu:</p><a href='{resetLink}'>{resetLink}</a>",
            //        IsBodyHtml = true
            //    };
            //    mailMessage.To.Add(email);

            //    using (var smtpClient = new SmtpClient("smtp.gmail.com", 587))
            //    {
            //        smtpClient.Credentials = new NetworkCredential("2121013309@sv.ufm.edu.vn", "cwly vnhi szss vxib");
            //        smtpClient.EnableSsl = true;
            //        smtpClient.Send(mailMessage);
            //    }
            //}
            //catch (Exception ex)
            //{
            //    throw new Exception($"Không thể gửi email: {ex.Message}");
            //}

            //gui email
            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(email);
                mail.From = new MailAddress("2121013309@sv.ufm.edu.vn");
                mail.Subject = "Đặt lại mật khẩu - Ananas";
                mail.Body = $"<p>Click vào liên kết sau để đặt lại mật khẩu:</p><a href='{resetLink}'>{resetLink}</a>";
                mail.IsBodyHtml = true;
                SmtpClient client = new SmtpClient();
                client.Host = "smtp.gmail.com";
                client.Port = 587;
                client.EnableSsl = true;
                client.Credentials = new NetworkCredential("2121013309@sv.ufm.edu.vn", "cwly vnhi szss vxib");
                client.Send(mail);


            }
            catch (SmtpFailedRecipientException ex)
            {

            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string pw = newPassword.Value;
            string confirmpw = confirmPassword.Value;

            if (string.IsNullOrEmpty(pw) || string.IsNullOrEmpty(confirmpw))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng nhập đủ thông tin.');", true);
                return;
            }

            if (pw != confirmpw)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mật khẩu không khớp!');", true);
                return;
            }

            // Logic cập nhật mật khẩu
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mật khẩu đã được thay đổi thành công.');", true);
        }
    }
}
