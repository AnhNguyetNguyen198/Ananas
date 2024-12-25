using Microsoft.ReportingServices.Diagnostics.Internal;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class SanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string searchQuery = Request.QueryString["search"];
                string sortOption = Request.QueryString["sort"];

                // Tạo chuỗi kết nối
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ToString();

                // Khai báo kết nối
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open(); // Mở kết nối

                    // Xây dựng câu lệnh SQL với tham số tìm kiếm và sắp xếp
                    string query = "SELECT masanpham, maloai, tensanpham, mota, gia, hinh, ngaytao FROM sanpham WHERE 1=1";

                    if (!string.IsNullOrEmpty(searchQuery))
                    {
                        query += " AND (tensanpham LIKE @searchQuery)";
                    }

                    if (sortOption == "priceAsc")
                    {
                        query += " ORDER BY gia ASC";
                    }
                    else if (sortOption == "priceDesc")
                    {
                        query += " ORDER BY gia DESC";
                    }

                    // Tạo đối tượng SqlCommand để thực thi truy vấn
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Thêm tham số nếu có
                        if (!string.IsNullOrEmpty(searchQuery))
                        {
                            cmd.Parameters.AddWithValue("@searchQuery", "%" + searchQuery + "%");
                        }

                        // Tạo DataAdapter và lấy dữ liệu vào DataTable
                        SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        dataAdapter.Fill(dt);

                        // Gán dữ liệu vào DataList
                        
                        DataListSP.DataBind();
                    }

                    connection.Close(); // Đóng kết nối khi không còn sử dụng
                }
            }
       
        }

        protected void DataListSP_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Lấy dữ liệu từ DataItem
                decimal originalPrice = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "Gia"));
                decimal priceAfterDiscount = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "PriceAfterDiscount"));
                int isPromo = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "IsPromo"));
                string promoDetails = Convert.ToString(DataBinder.Eval(e.Item.DataItem, "TenKhuyenMai"));

                // Các Label trong DataList
                Label lblOriginalPrice = (Label)e.Item.FindControl("GiaLabel");
                Label lblDiscountedPrice = (Label)e.Item.FindControl("PriceAfterDiscountLabel");
                Label lblPromoDetails = (Label)e.Item.FindControl("PromoDetailsLabel");
                Label lblPromoBadge = (Label)e.Item.FindControl("PromoBadge");

                // Hiển thị giá gốc và giá sau khi giảm
                if (lblOriginalPrice != null)
                {
                    lblOriginalPrice.Text = string.Format("{0:N0} VND", originalPrice);  // Hiển thị giá gốc
                }

                if (lblDiscountedPrice != null && isPromo == 1)
                {
                    lblDiscountedPrice.Text = string.Format("{0:N0} VND", priceAfterDiscount);  // Hiển thị giá sau giảm
                    lblDiscountedPrice.Visible = true;
                }

                // Hiển thị thông tin khuyến mãi
                if (lblPromoDetails != null)
                {
                    lblPromoDetails.Text = promoDetails;  // Hiển thị chi tiết khuyến mãi
                    lblPromoDetails.Visible = isPromo == 1;  // Hiển thị chỉ khi có khuyến mãi
                }

                // Hiển thị badge khuyến mãi
                if (lblPromoBadge != null)
                {
                    lblPromoBadge.Visible = isPromo == 1;  // Hiển thị nếu có khuyến mãi
                }
            }
        }


       
    }
}
