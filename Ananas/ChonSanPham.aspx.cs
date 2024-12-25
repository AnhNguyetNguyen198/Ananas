using System;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class ChonSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string masp = "";
                if (Request.QueryString["MaSanPham"] != null)
                    masp = Request.QueryString["MaSanPham"];

                //// Debugging: Check if MaSP is valid
                //if (string.IsNullOrEmpty(masp))
                //{
                //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mã sản phẩm không hợp lệ.');", true);
                //    return;
                //}

                Session["MaSanPham"] = masp;
                LoadSP(masp);
                LoadSizeDropDownList(); // Load size data for the dropdown
            }

        }
        protected void LoadSizeDropDownList()
        {
            string conStr = WebConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT MaSize FROM Size", con);
                SqlDataAdapter adapt = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapt.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    ddlsize.DataSource = dt;
                    ddlsize.DataTextField = "MaSize"; // Display size name
                    ddlsize.DataValueField = "MaSize"; // Use MaSize as the value
                    ddlsize.DataBind();
                }
            }
        }
        // Method to load the product details based on MaSP
        protected void LoadSP(string masp)
        {
            string conStr = WebConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "SELECT sp.MaSanPham, sp.TenSanPham, sp.Gia AS GiaSP, sp.MoTa, ctsp.TrangThai, " +
                               "ms.TenMau AS MauSac, ctsp.SoLuongTon AS SoLuongTon, sz.MaSize AS Size, sp.Hinh, " +
                               "km.TyLeKhuyenMai, km.NgayBatDau, km.NgayKetThuc, 0 as 'GiaKM' " +
                               "FROM SanPham sp " +
                               "INNER JOIN ChiTietSanPham ctsp ON ctsp.MaSanPham = sp.MaSanPham " +
                               "INNER JOIN MauSac ms ON ctsp.MaMau = ms.MaMau " +
                               "INNER JOIN Size sz ON ctsp.MaSize = sz.MaSize " +
                               "LEFT JOIN ChiTietKhuyenMai ctkm ON sp.MaSanPham = ctkm.MaSanPham " +
                               "LEFT JOIN KhuyenMai km ON ctkm.MaKhuyenMai = km.MaKhuyenMai " +
                               "WHERE sp.MaSanPham = @MaSanPham";

                SqlDataAdapter adapt = new SqlDataAdapter(query, con);
                adapt.SelectCommand.Parameters.AddWithValue("@MaSanPham", masp);

                DataTable dt = new DataTable();
                adapt.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Sản phẩm không tìm thấy.');", true);
                    return;
                }

                decimal giaSP = dt.Rows[0]["GiaSP"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["GiaSP"]) : 0;
                decimal tyLeKhuyenMai = dt.Rows[0]["TyLeKhuyenMai"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["TyLeKhuyenMai"]) : 0;

                // Tính giá khuyến mãi nếu có
                decimal giaKhuyenMai = giaSP - (giaSP * tyLeKhuyenMai / 100);
                dt.Rows[0]["GiaKM"] = giaKhuyenMai;

                // Kiểm tra xem khuyến mãi còn hiệu lực hay không
                string discountPrice = "";
                DateTime? startDate = dt.Rows[0]["NgayBatDau"] as DateTime?;
                DateTime? endDate = dt.Rows[0]["NgayKetThuc"] as DateTime?;

                // Nếu có khuyến mãi, kiểm tra ngày khuyến mãi có hiệu lực hay không
                if (tyLeKhuyenMai > 0 && startDate.HasValue && endDate.HasValue && startDate <= DateTime.Now && endDate >= DateTime.Now)
                {
                    discountPrice = $"→ {giaKhuyenMai.ToString("#,0")} VND";
                    lblgiamoi.Visible = true; // Hiển thị giá khuyến mãi
                    lblgiamoi.Text = discountPrice;
                }
                else
                {
                    lblgiamoi.Visible = false; // Ẩn giá khuyến mãi nếu không có khuyến mãi hoặc khuyến mãi không còn hiệu lực
                }

                // Hiển thị giá gốc
                lblgiasp.Text = string.Format("{0:N0} VND", giaSP);

                // Cập nhật các control trên trang
                lbltensp.Text = dt.Rows[0]["TenSanPham"].ToString();
                lblmasp.Text = "Mã sản phẩm: " + dt.Rows[0]["MaSanPham"].ToString();
                lbltrangthai.Text = dt.Rows[0]["TrangThai"].ToString();
                lblmota.Text = dt.Rows[0]["MoTa"].ToString();
                lblmausac.Text = "Màu sắc: " + dt.Rows[0]["MauSac"].ToString();
                lblSoLuongTon.Text = dt.Rows[0]["SoLuongTon"].ToString();
                imgHinh.ImageUrl = dt.Rows[0]["Hinh"].ToString();
                imgHinh.Height = 400;
                imgHinh.Width = 400;

                ViewState["SanPham"] = dt;
            }
        }

        // Method to handle adding product to the shopping cart
        protected void btnthem_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtsoluong.Text) || txtsoluong.Text == "0")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng nhập số lượng sản phẩm.');", true);
                return;
            }

            int SoLuongYeuCau = int.Parse(txtsoluong.Text);
            DataTable dtSP = (DataTable)ViewState["SanPham"];
            DataTable dtGH; // Giỏ hàng
            int Soluong = 0;

            // Kiểm tra số lượng tồn kho
            int SoLuongTon = int.Parse(dtSP.Rows[0]["SoLuongTon"].ToString());
            if (SoLuongYeuCau > SoLuongTon)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Số lượng sản phẩm không đủ trong kho.');", true);
                return;
            }

            if (Session["GioHang"] == null) // Nếu giỏ hàng chưa có, tạo mới
            {
                dtGH = new DataTable();
                dtGH.Columns.Add("MaSanPham");
                dtGH.Columns.Add("TenSanPham");
                dtGH.Columns.Add("Hinh");
                dtGH.Columns.Add("MaSize");
                dtGH.Columns.Add("GiaSP");
                dtGH.Columns.Add("GiaKM");
                dtGH.Columns.Add("SoLuong");
                dtGH.Columns.Add("ThanhTien");
            }
            else
            {
                dtGH = (DataTable)Session["GioHang"];
            }

            string masp = (string)Session["MaSanPham"];
            int pos = TimSP(masp, dtGH); // Tìm sản phẩm trong giỏ hàng

            if (pos != -1) // Nếu tìm thấy sản phẩm trong giỏ hàng, cập nhật số lượng và thành tiền
            {
                Soluong = Convert.ToInt32(dtGH.Rows[pos]["SoLuong"]) + SoLuongYeuCau;
                dtGH.Rows[pos]["SoLuong"] = Soluong;                
                dtGH.Rows[pos]["ThanhTien"] = Convert.ToDouble(dtSP.Rows[0]["GiaKM"]) * Soluong;
            }
            else // Nếu chưa có, thêm sản phẩm mới vào giỏ hàng
            {
                Soluong = SoLuongYeuCau;
                DataRow dr = dtGH.NewRow(); // Tạo một dòng mới cho sản phẩm

                // Gán giá trị cho dòng sản phẩm
                dr["MaSanPham"] = dtSP.Rows[0]["MaSanPham"];
                dr["TenSanPham"] = dtSP.Rows[0]["TenSanPham"];
                dr["Hinh"] = imgHinh.ImageUrl;
                dr["MaSize"] = ddlsize.SelectedValue;
                dr["GiaSP"] = dtSP.Rows[0]["GiaSP"];
                dr["GiaKM"] = dtSP.Rows[0]["GiaKM"];
                dr["SoLuong"] = Soluong;
                dr["ThanhTien"] = Convert.ToDouble(dtSP.Rows[0]["GiaKM"]) * Soluong;

                // Thêm sản phẩm vào giỏ hàng
                dtGH.Rows.Add(dr);
            }
            masp = Session["MaSanPham"].ToString();  // Lấy mã sản phẩm từ session

            decimal giaSP = dtSP.Rows[0]["GiaSP"] != DBNull.Value ? Convert.ToDecimal(dtSP.Rows[0]["GiaSP"]) : 0;
            decimal tyLeKhuyenMai = dtSP.Rows[0]["TyLeKhuyenMai"] != DBNull.Value ? Convert.ToDecimal(dtSP.Rows[0]["TyLeKhuyenMai"]) : 0;

            // Tính giá khuyến mãi nếu có
            decimal giaKhuyenMai = giaSP - (giaSP * tyLeKhuyenMai / 100);


            if (Session["GioHang"] == null)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("MaSanPham");
                dt.Columns.Add("TenSanPham");
                dt.Columns.Add("GiaSP");
                dt.Columns.Add("GiaKM");
                dt.Columns.Add("SoLuong");
                dt.Columns.Add("ThanhTien");
                dt.Columns.Add("Hinh");
                dt.Columns.Add("MaSize");
                Session["GioHang"] = dt;
            }

            // Sau đó bạn có thể tiếp tục làm việc với giỏ hàng
            DataTable gioHang = (DataTable)Session["GioHang"];
            DataRow newRow = gioHang.NewRow();
            newRow["MaSanPham"] = masp;
            newRow["TenSanPham"] = dtSP.Rows[0]["TenSanPham"];
            newRow["Hinh"] = dtSP.Rows[0]["Hinh"];
            newRow["MaSize"] = dtSP.Rows[0]["Size"];
            newRow["GiaSP"] = dtSP.Rows[0]["GiaSP"];  // Lưu giá khuyến mãi vào giỏ hàng
            newRow["GiaKM"] = giaKhuyenMai;  // Lưu giá khuyến mãi vào giỏ hàng
            newRow["SoLuong"] = SoLuongYeuCau;  // Ví dụ cho số lượng sản phẩm
            newRow["ThanhTien"] = giaKhuyenMai * SoLuongYeuCau;  // Tính thành tiền

            gioHang.Rows.Add(newRow);
            Session["GioHang"] = gioHang;
            
            //Session["GioHang"] = dtGH;

            // Chuyển hướng sang trang giỏ hàng
            Response.Redirect("GioHang.aspx");
        }

        // Method to find product position in the cart
        public static int TimSP(string masp, DataTable dt)
        {
            int pos = -1;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["MaSanPham"].ToString().ToLower() == masp.ToLower())
                {
                    pos = i;
                    break;
                }
            }
            return pos;
        }
    }
}
