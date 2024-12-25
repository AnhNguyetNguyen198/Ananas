using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;


namespace Ananas.Manage
{
    public partial class Reports : System.Web.UI.Page
    {
        protected string ChartLabels = "[]";
        protected string ChartData = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOverviewData();
                LoadChartData();
                LoadTopProducts();
                LoadRevenueByProduct();
                LoadRevenueGrowthRate();
                
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
        
        private void LoadOverviewData()
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Tổng doanh thu
                SqlCommand cmd = new SqlCommand("SELECT SUM(TongTien) FROM DonDatHang WHERE TrangThai = N'Đã giao'", conn);
                lblTotalRevenue.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                // Tổng đơn hàng
                cmd.CommandText = "SELECT COUNT(*) FROM DonDatHang";
                lblTotalOrders.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                // Sản phẩm còn hàng
                cmd.CommandText = "SELECT COUNT(*) FROM ChiTietSanPham WHERE TrangThai = N'Còn Hàng'";
                lblInStockProducts.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                // Đơn hàng đã hủy
                cmd.CommandText = "SELECT COUNT(*) FROM DonDatHang WHERE TrangThai = N'Đã hủy'";
                lblCanceledOrders.Text = cmd.ExecuteScalar()?.ToString() ?? "0";
            }
        }

        private void LoadChartData()
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(@"
                    SELECT MONTH(NgayDatHang) AS Month, SUM(TongTien) AS Revenue
                    FROM DonDatHang
                    WHERE TrangThai = N'Đã giao'
                    GROUP BY MONTH(NgayDatHang)
                    ORDER BY Month", conn);

                SqlDataReader reader = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(reader);

                ChartLabels = "[";
                ChartData = "[";
                foreach (DataRow row in dt.Rows)
                {
                    ChartLabels += $"'Tháng {row["Month"]}',";
                    ChartData += $"{row["Revenue"]},";
                }
                ChartLabels = ChartLabels.TrimEnd(',') + "]";
                ChartData = ChartData.TrimEnd(',') + "]";
            }
        }

        private void LoadTopProducts()
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(@"
            SELECT TOP 5 
                sp.TenSanPham, 
                SUM(ct.SoLuong) AS TongSoLuong, 
                SUM(ct.SoLuong * sp.Gia) AS TongDoanhThu
            FROM ChiTietDonDatHang ct
            INNER JOIN SanPham sp ON ct.MaSanPham = sp.MaSanPham
            GROUP BY sp.TenSanPham
            ORDER BY TongSoLuong DESC", conn);

                SqlDataReader reader = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(reader);
                GridViewTopProducts.DataSource = dt;
                GridViewTopProducts.DataBind();
            }
        }
        

        protected void ExportTopProductsToPDF(object sender, EventArgs e)
        {
            DataTable dt = GetTopProductsData(); // Replace with your actual data retrieval method
            ExportReportToPDF(dt, "Top Sản Phẩm Bán Chạy", "TopProductsReport");
        }


        private DataTable GetTopProductsData()
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
            SELECT TOP 5 
                sp.TenSanPham, 
                SUM(ct.SoLuong) AS TongSoLuong, 
                SUM(ct.SoLuong * sp.Gia) AS TongDoanhThu
            FROM ChiTietDonDatHang ct
            INNER JOIN SanPham sp ON ct.MaSanPham = sp.MaSanPham
            GROUP BY sp.TenSanPham
            ORDER BY TongSoLuong DESC", conn);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }
        protected void ExportRevenueByProductToPDF(object sender, EventArgs e)
        {
            DataTable dt = GetRevenueByProductData(); // Replace with your data retrieval logic
            ExportReportToPDF(dt, "Doanh Thu Theo Sản Phẩm", "RevenueByProductReport");
        }

        protected void ExportRevenueGrowthToPDF(object sender, EventArgs e)
        {
            DataTable dt = GetRevenueGrowthData(); // Replace with your data retrieval logic
            ExportReportToPDF(dt, "Tỷ Lệ Tăng Trưởng Doanh Thu", "RevenueGrowthReport");
        }

        // Mock methods to retrieve data
        private DataTable GetRevenueByProductData()
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
            SELECT 
                sp.TenSanPham AS [Tên Sản Phẩm],
                SUM(ct.SoLuong) AS [Số Lượng Bán],
                SUM(ct.SoLuong * sp.Gia) AS [Doanh Thu (VND)]
            FROM ChiTietDonDatHang ct
            JOIN SanPham sp ON ct.MaSanPham = sp.MaSanPham
            GROUP BY sp.TenSanPham
            ORDER BY [Doanh Thu (VND)] DESC", conn);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }

        private DataTable GetRevenueGrowthData()
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
            WITH DoanhThuThang AS (
                SELECT 
                    YEAR(NgayDatHang) AS Nam,
                    MONTH(NgayDatHang) AS Thang,
                    SUM(TongTien) AS DoanhThu
                FROM DonDatHang
                WHERE TrangThai = N'Đã giao'
                GROUP BY YEAR(NgayDatHang), MONTH(NgayDatHang)
            )
            SELECT 
                Nam AS [Năm],
                Thang AS [Tháng],
                DoanhThu AS [Doanh Thu (VND)],
                LAG(DoanhThu) OVER (ORDER BY Nam, Thang) AS [Doanh Thu Tháng Trước (VND)],
                (DoanhThu - LAG(DoanhThu) OVER (ORDER BY Nam, Thang)) * 100.0 / LAG(DoanhThu) OVER (ORDER BY Nam, Thang) AS [Tỷ Lệ Tăng Trưởng (%)]
            FROM DoanhThuThang;", conn);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }


        protected void ExportReportToPDF(DataTable dataTable, string title, string fileName)
        {
            string logoPath = Server.MapPath("~/Hinh/Logo.png");

            Document document = new Document(PageSize.A4, 25, 25, 30, 30);
            MemoryStream memoryStream = new MemoryStream();
            PdfWriter.GetInstance(document, memoryStream);

            document.Open();

            // Add logo
            if (File.Exists(logoPath))
            {
                iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(logoPath);
                logo.Alignment = Element.ALIGN_LEFT;
                logo.ScaleToFit(100f, 100f);
                document.Add(logo);
            }

            // Add header
            document.Add(new Paragraph("Công Ty Ananas", new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD)));
            document.Add(new Paragraph("Báo Cáo: " + title, new Font(Font.FontFamily.HELVETICA, 14)));
            document.Add(new Paragraph("Ngày tạo: " + DateTime.Now.ToString("dd/MM/yyyy"), new Font(Font.FontFamily.HELVETICA, 10, Font.ITALIC)));
            document.Add(new Paragraph("\n"));

            // Add table
            PdfPTable pdfTable = new PdfPTable(dataTable.Columns.Count);
            pdfTable.WidthPercentage = 100;

            // Table header
            foreach (DataColumn column in dataTable.Columns)
            {
                PdfPCell cell = new PdfPCell(new Phrase(column.ColumnName, new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
                cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                pdfTable.AddCell(cell);
            }

            // Table data
            foreach (DataRow row in dataTable.Rows)
            {
                foreach (var item in row.ItemArray)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(item.ToString(), new Font(Font.FontFamily.HELVETICA, 10)));
                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                    pdfTable.AddCell(cell);
                }
            }

            document.Add(pdfTable);
            document.Close();

            // Return PDF
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(memoryStream.ToArray());
            Response.End();
        }

        // Ghi đè VerifyRenderingInServerForm
        public override void VerifyRenderingInServerForm(Control control)
        {
            // Bỏ trống - bắt buộc để tránh lỗi "must be placed inside a form tag with runat=server."
        }
        protected void GridViewTopProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                string tenSanPham = e.CommandArgument.ToString();
                Response.Redirect($"ProductDetails.aspx?TenSanPham={tenSanPham}");
            }
        }
        private void LoadRevenueByProduct()
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
            SELECT 
                sp.TenSanPham,
                SUM(ct.SoLuong) AS TongSoLuongBan,
                SUM(ct.SoLuong * sp.Gia) AS TongDoanhThu
            FROM ChiTietDonDatHang ct
            JOIN SanPham sp ON ct.MaSanPham = sp.MaSanPham
            GROUP BY sp.TenSanPham
            ORDER BY TongDoanhThu DESC", conn);

                SqlDataReader reader = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(reader);
                GridViewRevenueByProduct.DataSource = dt;
                GridViewRevenueByProduct.DataBind();
            }
        }
        private void LoadRevenueGrowthRate()
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
            WITH DoanhThuThang AS (
                SELECT 
                    YEAR(NgayDatHang) AS Nam,
                    MONTH(NgayDatHang) AS Thang,
                    SUM(TongTien) AS DoanhThu
                FROM DonDatHang
                WHERE TrangThai = N'Đã giao'
                GROUP BY YEAR(NgayDatHang), MONTH(NgayDatHang)
            )
            SELECT 
                Nam,
                Thang,
                DoanhThu,
                LAG(DoanhThu) OVER (ORDER BY Nam, Thang) AS DoanhThuThangTruoc,
                (DoanhThu - LAG(DoanhThu) OVER (ORDER BY Nam, Thang)) * 100.0 / LAG(DoanhThu) OVER (ORDER BY Nam, Thang) AS TyLeTangTruong
            FROM DoanhThuThang;", conn);

                SqlDataReader reader = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(reader);
                GridViewRevenueGrowth.DataSource = dt;
                GridViewRevenueGrowth.DataBind();
            }
        }
       
    }
}