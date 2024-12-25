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
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRevenueChartData();
                LoadOverviewData();
                Response.Write($"<script>console.log('Labels: {ChartLabels}, Data: {ChartDataArray}');</script>");
            }
        }
        protected string[] ChartLabels;
        protected int[] ChartDataArray;

        private void LoadRevenueChartData()
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(@"
            SELECT 
                MONTH(NgayDatHang) AS Thang, 
                SUM(TongTien) AS DoanhThu
            FROM DonDatHang
            WHERE TrangThai = N'Đã giao'
            GROUP BY MONTH(NgayDatHang)
            ORDER BY Thang", conn);

                SqlDataReader reader = cmd.ExecuteReader();

                List<string> months = new List<string>();
                List<decimal> revenues = new List<decimal>();

                while (reader.Read())
                {
                    months.Add($"Tháng {reader["Thang"]}");
                    revenues.Add(Convert.ToDecimal(reader["DoanhThu"]));
                }

                reader.Close();

                // Kiểm tra dữ liệu và gán giá trị mặc định nếu không có dữ liệu
                if (months.Count == 0 || revenues.Count == 0)
                {
                    ChartLabels = new[] { "No Data" };
                    ChartDataArray = new[] { 0 };
                }
                else
                {
                    ChartLabels = months.ToArray();
                    ChartDataArray = revenues.Select(r => (int)r).ToArray();
                }
            }
        }

        private void LoadOverviewData()
            {
                string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    // Tổng doanh thu
                    SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(TongTien), 0) FROM DonDatHang WHERE TrangThai = N'Đã giao'", conn);
                    lblTotalRevenue.Text = $"{cmd.ExecuteScalar()} VND";

                    // Tổng đơn hàng
                    cmd.CommandText = "SELECT COUNT(*) FROM DonDatHang";
                    lblTotalOrders.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                    // Khách hàng đã đăng ký
                    cmd.CommandText = "SELECT COUNT(*) FROM NguoiDung";
                    lblTotalCustomers.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                    // Sản phẩm còn hàng
                    cmd.CommandText = "SELECT COUNT(*) FROM ChiTietSanPham WHERE TrangThai = N'Còn Hàng'";
                    lblInStockProducts.Text = cmd.ExecuteScalar()?.ToString() ?? "0";
                }
            }

    }
}