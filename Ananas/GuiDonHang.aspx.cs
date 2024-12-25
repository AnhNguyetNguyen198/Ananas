using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class GuiDonHang : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["txthoten"] != null &&
                 Session["ddlgioitinh"] != null &&
                 Session["txtngaysinh"] != null &&
                 Session["txtsdt"] != null &&
                 Session["txtemail"] != null &&
                 Session["txtdiachi"] != null &&
                 Session["MaHD"] != null &&
                 Session["ddlptgh"] != null &&
                 Session["ddlpttt"] != null)
            {
                string hoten = (string)Session["txthoten"];
                string gioitinh = (string)Session["ddlgioitinh"];
                string ngaysinh = (string)Session["txtngaysinh"];
                string sdt = (string)Session["txtsdt"];
                string email = (string)Session["txtemail"];
                string diachi = (string)Session["txtdiachi"];
                string MaHD = (string)Session["MaHD"];
                string phuongThucGiaoHang = (string)Session["ddlptgh"];
                string phuongThucThanhToan = (string)Session["ddlpttt"];

                lblThongBao.Text = "<br />Xin chào (anh/chị) " + hoten + ",<br />";
                lblThongBao.Text += "Bạn vừa đặt thành công các sản phẩm của Ananas. ";
                lblThongBao.Text += "Số điện thoại của bạn là: " + sdt;
                lblThongBao.Text += ". Mã đơn hàng của bạn là: " + MaHD + ".<br />";
                lblThongBao.Text += " Bạn sẽ được nhận sản phẩm tại ";
                lblThongBao.Text += diachi;
                lblThongBao.Text += " trong 2 - 3 ngày làm việc.<br />";
                lblThongBao.Text += "Mọi thông tin về đơn hàng sẽ được gửi tới email của bạn, ";
                lblThongBao.Text += "vui lòng kiểm tra email để biết thêm chi tiết.<br />";
                lblThongBao.Text += "Cảm ơn bạn đã tin tưởng và mua hàng tại Ananas.<br />";
                lblThongBao.Text += "Mọi thắc mắc vui lòng liên hệ: 0967 867 339.<br /><br />";
            }
            else
            {
                lblThongBao.Text = "Có lỗi xảy ra, không thể lấy thông tin đơn hàng.";
            }

        }
    }
}