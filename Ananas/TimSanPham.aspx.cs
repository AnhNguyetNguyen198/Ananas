using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class TimSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra xem có tham số tìm kiếm từ URL không
            if (Request.QueryString["tenSP"] != null)
            {
                string tenSP = Request.QueryString["tenSP"];
                SearchProduct(tenSP);
            }
            else if (IsPostBack)  // Kiểm tra xem có sự kiện postback không
            {
                lblMessage.Text = "Vui lòng nhập tên sản phẩm bạn cần tìm!";
                lblMessage.Visible = true;
                ddlsp.Visible = false; // Ẩn DataList
            }
        }
        private void SearchProduct(string tenSP)
        {
            // Kiểm tra xem người dùng đã nhập tên sản phẩm hay chưa
            if (string.IsNullOrEmpty(tenSP))
            {
                lblMessage.Text = "Vui lòng nhập tên sản phẩm bạn cần tìm!";
                lblMessage.Visible = true;
                ddlsp.Visible = false; // Ẩn DataList
            }
            else
            {

                string connectionString = WebConfigurationManager.ConnectionStrings["AnnanasConnectionString"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlDataAdapter adapt = new SqlDataAdapter();
                    adapt.SelectCommand = new SqlCommand($"SELECT masp, tenSP, GiaSP, Hinh, MauSac, TrangThai FROM SanPham WHERE TenSP LIKE '%{tenSP}%'", connection);
                    DataTable dt = new DataTable();
                    adapt.Fill(dt);

                    //// Hiển thị kết quả tìm kiếm trong DataList hoặc GridView hoặc nơi khác
                    //dlSP.DataSource = dt;
                    //dlSP.DataBind();

                    // Kiểm tra số lượng bản ghi
                    if (dt.Rows.Count > 0)
                    {
                        // Có kết quả tìm kiếm, hiển thị trong DataList
                        ddlsp.DataSource = dt;
                        ddlsp.DataBind();
                    }
                    else
                    {
                        // Không có kết quả, hiển thị thông báo
                        ddlsp.Visible = false; // Ẩn DataList
                        lblMessage.Text = "Không có sản phẩm bạn cần tìm.";
                        lblMessage.Visible = true;
                    }
                }
            }
        }
    }
}