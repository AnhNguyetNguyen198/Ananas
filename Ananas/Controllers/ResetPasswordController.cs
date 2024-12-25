using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Runtime.InteropServices;
using System.Web.Http;


namespace Ananas.Controllers
{
    public class ResetPasswordController : ApiController
    {
        [HttpPost]
        [Route("api/ResetPassword")]
        public IHttpActionResult ResetPassword([FromBody] ResetPasswordRequest request)
        {
            if (request == null || string.IsNullOrEmpty(request.Email))
            {
                return BadRequest("Email không được để trống.");
            }
            // lấy rết link
            var resetLink = "https://localhost:44398/DangNhap?reset=true&email=" + request.Email;

            // Giả lập logic gửi email
            bool emailSent = SendResetPasswordEmail(request.Email, resetLink);
            if (emailSent)
            {
                return Ok(new { success = true });
            }
            else
            {
                return Ok(new { success = false, message = "Không thể gửi email. Vui lòng thử lại sau." });
            }
        }

        private bool SendResetPasswordEmail(string email, string resetLink)
        {
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

                return true;
            }
            catch (SmtpFailedRecipientException ex)
            {
                return false;
            }
        }
    }

    public class ResetPasswordRequest
    {
        public string Email { get; set; }
    }
}