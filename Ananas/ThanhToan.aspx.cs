using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.Map.WebForms.BingMaps;
using System.Data.SqlClient;
using System.Configuration;
using System.Diagnostics;
using System.Web.Configuration;


namespace Ananas
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra xem có giỏ hàng trong session không
                if (Session["GioHang"] != null)
                {
                    // Lấy giỏ hàng từ session
                    DataTable dtCart = (DataTable)Session["GioHang"];

                    if (dtCart != null && dtCart.Rows.Count > 0)
                    {
                        // Gán DataTable vào Repeater
                        rptOrderItems.DataSource = dtCart;
                        rptOrderItems.DataBind();

                        // Tính tổng tiền
                        decimal totalAmount = 0;
                        foreach (DataRow row in dtCart.Rows)
                        {
                            totalAmount += Convert.ToDecimal(row["ThanhTien"]);
                        }

                        // Hiển thị tổng tiền
                        lblTotalAmount.Text = totalAmount.ToString("N0") + " VND";
                    }
                    else
                    {
                        // Thông báo giỏ hàng trống
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Giỏ hàng trống!');", true);
                    }
                }
                else
                {
                    // Thông báo nếu không có giỏ hàng trong session
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Giỏ hàng của bạn không tồn tại!');", true);
                }
            }
            if (!IsPostBack)
            {


                if (Session["MaNguoiDung"] != null) // Nếu đã đăng nhập
                {
                    int userId = Convert.ToInt32(Session["UserId"]);
                    LoadUserInfo(userId);
                }
            }
        }
        private DataTable CreateCartDataTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("TenSanPham", typeof(string));  // Tên sản phẩm
            dt.Columns.Add("Size", typeof(string));        // Kích cỡ
            dt.Columns.Add("SoLuong", typeof(int));        // Số lượng
            dt.Columns.Add("GiaSP", typeof(decimal));     // Giá sản phẩm
            return dt;
        }

        private void AddProductToCart(DataTable dt, string productName, string size, int quantity, decimal price)
        {
            DataRow row = dt.NewRow();
            row["TenSanPham"] = productName;
            row["Size"] = size;
            row["SoLuong"] = quantity;
            row["GiaSP"] = price;
            dt.Rows.Add(row);
        }
        private void BindCart()
        {
            if (Session["GioHang"] is DataTable)
            {
                DataTable dt = (DataTable)Session["GioHang"];
                rptOrderItems.DataSource = dt;
                rptOrderItems.DataBind();

                // Tính tổng cộng
                decimal totalAmount = 0;
                foreach (DataRow row in dt.Rows)
                {
                    totalAmount += Convert.ToDecimal(row["GiaSP"]) * Convert.ToInt32(row["SoLuong"]);
                }
                lblTotalAmount.Text = totalAmount.ToString("#,##0") + " VND";
            }
        }
        private void LoadUserInfo(int userId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT HoTen, SDT, Email, DiaChi FROM NguoiDung WHERE MaNguoiDung = @MaNguoiDung";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            // Gán dữ liệu vào các TextBox
                            txtHoTen.Text = reader["HoTen"].ToString();
                            txtSDT.Text = reader["SDT"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtDiaChi.Text = reader["DiaChi"].ToString();
                        }
                    }

                    reader.Close();
                }
            }
        }

        protected void btnCompletePayment_Click(object sender, EventArgs e)
        {

            // Lấy thông tin mã người dùng (nếu có)
            string maNguoiDung = Session["MaNguoiDung"]?.ToString();

            // Kiểm tra thông tin giỏ hàng
            DataTable dtCart = Session["GioHang"] as DataTable;
            if (dtCart == null || dtCart.Rows.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Giỏ hàng trống!');", true);
                return;
            }

            string maDonHang = "DH" + DateTime.Now.Ticks.ToString().Substring(8, 8);

            // Tính tổng tiền
            decimal tongTien = dtCart.AsEnumerable().Sum(row => Convert.ToDecimal(row["ThanhTien"]));

            // Phương thức thanh toán
            string phuongThucThanhToan = rbQRCode.Checked ? "QR code" : "COD";

            // Kết nối cơ sở dữ liệu và lưu đơn hàng
            string connStr = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // Thêm đơn hàng vào bảng DonDatHang
                        string insertDonDatHang = @"
                    INSERT INTO DonDatHang (MaDatHang, MaNguoiDung, TenKhachHang, Email, SoDienThoai, DiaChi, 
                                            PhuongThucVanChuyen, TongTien, TrangThai, PhuongThucThanhToan)
                    VALUES (@MaDatHang, @MaNguoiDung, @TenKhachHang, @Email, @SoDienThoai, @DiaChi, 
                            @PhuongThucVanChuyen, @TongTien, @TrangThai, @PhuongThucThanhToan)";
                        using (SqlCommand cmd = new SqlCommand(insertDonDatHang, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@MaDatHang", maDonHang);
                            cmd.Parameters.AddWithValue("@MaNguoiDung", (object)maNguoiDung ?? DBNull.Value); // Cho phép NULL nếu không đăng nhập
                            cmd.Parameters.AddWithValue("@TenKhachHang", txtHoTen.Text);
                            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                            cmd.Parameters.AddWithValue("@SoDienThoai", txtSDT.Text);
                            cmd.Parameters.AddWithValue("@DiaChi", txtDiaChi.Text);
                            cmd.Parameters.AddWithValue("@PhuongThucVanChuyen", "Giao hàng nhanh");
                            cmd.Parameters.AddWithValue("@TongTien", tongTien);
                            cmd.Parameters.AddWithValue("@TrangThai", "Đã đặt");
                            cmd.Parameters.AddWithValue("@PhuongThucThanhToan", phuongThucThanhToan);
                            cmd.ExecuteNonQuery();
                        }

                        // Lưu chi tiết đơn hàng vào bảng ChiTietDonDatHang
                        string insertChiTietDonDatHang = @"
                    INSERT INTO ChiTietDonDatHang (MaDatHang, MaSanPham, MaSize, SoLuong)
                    VALUES (@MaDatHang, @MaSanPham, @MaSize, @SoLuong)";
                        foreach (DataRow row in dtCart.Rows)
                        {
                            using (SqlCommand cmd = new SqlCommand(insertChiTietDonDatHang, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@MaDatHang", maDonHang);
                                cmd.Parameters.AddWithValue("@MaSanPham", row["MaSanPham"]);
                                cmd.Parameters.AddWithValue("@MaSize", row["MaSize"]);
                                cmd.Parameters.AddWithValue("@SoLuong", row["SoLuong"]);
                                cmd.ExecuteNonQuery();
                            }
                        }

                        // Commit transaction
                        transaction.Commit();

                        //gui email
                        try
                        {
                            MailMessage mail = new MailMessage();
                            mail.To.Add(txtEmail.Text);
                            mail.From = new MailAddress("2121013309@sv.ufm.edu.vn");
                            mail.Subject = "Đơn hàng Ananas";
                            mail.Body = "Đơn hàng có mã là: " + maDonHang + " sẽ được gửi đến bạn " +
                                    txtHoTen.Text + ". Xin cám ơn!";
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

                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đặt hàng thành công!');", true);

                        // Xóa giỏ hàng
                        Session["GioHang"] = null;
                    }
                    catch (Exception ex)
                    {
                        // Rollback nếu có lỗi
                        transaction.Rollback();
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Có lỗi xảy ra: {ex.Message}');", true);
                    }
                }
            }
        }

        private void ShowSuccessMessage(string message)
        {
         lblSuccessMessage.Text = message;
         lblSuccessMessage.Visible = true;
         }

        private void ShowTermsPopup()
        {
        // Hiển thị popup điều khoản thanh toán khi chọn thanh toán bằng QR Code
        string script = "alert('Xin vui lòng đọc kỹ điều khoản thanh toán trước khi tiếp tục.');";
        ClientScript.RegisterStartupScript(this.GetType(), "popup", script, true);
            }
        private void UpdateUserInfo(int userId)
        {
            // Kết nối và cập nhật thông tin người dùng trong cơ sở dữ liệu
            string connectionString = "YourConnectionStringHere"; // Cập nhật chuỗi kết nối của bạn
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE nguoidung SET HoTen = @HoTen, SDT = @SDT, Email = @Email, DiaChi = @DiaChi WHERE MaNguoiDung = @MaNguoiDung";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@HoTen", txtHoTen.Text);
                    cmd.Parameters.AddWithValue("@SDT", txtSDT.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@DiaChi", txtDiaChi.Text);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Sau khi cập nhật, bạn có thể chuyển đến trang thanh toán hoặc hiển thị thông báo thành công
            lblSuccessMessage.Text = "Thông tin của bạn đã được cập nhật!";
            lblSuccessMessage.Visible = true;
        }
    }
}