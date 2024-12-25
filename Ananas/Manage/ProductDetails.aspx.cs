using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas.Manage
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string maSanPham = Request.QueryString["TenSanPham"];
                if (!string.IsNullOrEmpty(maSanPham))
                {
                    // Truy vấn cơ sở dữ liệu để lấy thông tin sản phẩm
                    LoadProductDetails(maSanPham);
                }
                else
                {
                    lblErrorMessage.Text = "Ten sản phẩm không hợp lệ.";
                    lblErrorMessage.Visible = true;
                }
            }
        }

        private void LoadProductDetails(string maSanPham)
        {
            string query = "SELECT  TenSanPham, MoTa, Gia, Hinh FROM SanPham WHERE TenSanPham = @TenSanPham";
            using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TenSanPham", maSanPham);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblProductName.Text = reader["TenSanPham"].ToString();
                    lblProductDescription.Text = reader["MoTa"].ToString();
                    lblProductPrice.Text = $"{reader["Gia"]:N0} VND";
                    imgProduct.ImageUrl = reader["Hinh"].ToString();
                }
                else
                {
                    lblProductName.Text = "Sản phẩm không tồn tại";
                    lblProductDescription.Text = "";
                    lblProductPrice.Text = "";
                    imgProduct.ImageUrl = ""; // hoặc gán URL của ảnh mặc định
                }
                conn.Close();
            }
        }
    }
}