using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.WebRequestMethods;

namespace Ananas
{
    public partial class DonHang : System.Web.UI.Page
    {
        DataTable dt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadData();
        }
        protected void LoadData()
        {
            dt = (DataTable)Session["GioHang"];
            GridViewDonHang.DataSource = dt;
            GridViewDonHang.DataBind();
            GridViewDonHang.Columns[0].ControlStyle.Width = 50;
            GridViewDonHang.Columns[1].ControlStyle.Width = 100;
            GridViewDonHang.Columns[2].ControlStyle.Width = 60;
            GridViewDonHang.Columns[2].ItemStyle.HorizontalAlign = HorizontalAlign.Right;
            GridViewDonHang.Columns[3].ControlStyle.Width = 80;
            GridViewDonHang.Columns[3].ItemStyle.HorizontalAlign = HorizontalAlign.Right;
            GridViewDonHang.Columns[4].ControlStyle.Width = 80;
            GridViewDonHang.Columns[4].ItemStyle.HorizontalAlign = HorizontalAlign.Right;
            GridViewDonHang.Columns[5].ControlStyle.Width = 100;
            GridViewDonHang.Columns[5].ItemStyle.HorizontalAlign = HorizontalAlign.Center;
            
            if (dt != null)
            {
                double tong = (double)Session["ThanhTien"];
                lblTongTien.Text = "Tổng tiền trên giỏ hàng là: " + String.Format("{0:0,000}", tong);
            }
        }
        protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
        {
            DateTime d = DateTime.Now;
            string MaHD = d.Day.ToString() + d.Month.ToString() +
                (d.Year % 100).ToString() + d.Hour.ToString() +
                d.Minute.ToString() + d.Second.ToString();
            Session["txthoten"] = txthoten;
            Session["txtemail"] = txtemail;
            Session["txtsdt"] = txtsdt;
            Session["txtdiachi"] = txtdiachi;
            Session["txtgioitinh"] = txtgioitinh;
            Session["MaHD"] = MaHD;
            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(txtemail.Text);
                mail.From = new MailAddress("2121013309@sv.ufm.edu.vn");
                mail.Subject = "Đơn hàng LovelyClothing";
                mail.Body = "Đơn hàng có mã là: " + MaHD + " sẽ được gửi đến bạn " +
                        txthoten.Text + ". Xin cám ơn!";
                SmtpClient client = new SmtpClient();
                client.Host = "smtp.gmail.com";
                client.Port = 587;
                client.EnableSsl = true;
                client.Credentials = new NetworkCredential("2121013309@sv.ufm.edu.vn", "rwwc iqau lhze uhjn");
                client.Send(mail);

                // Xóa Session "GioHang" sau khi đặt hàng thành công
                Session["GioHang"] = null;

                Server.Transfer("~/GuiDonHang.aspx");
            }
            catch (SmtpFailedRecipientException ex)
            {
                lblstatus.Text = "Mail không được gửi! " + ex.FailedRecipient;
            }
        }
    }
}