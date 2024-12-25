using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas.Manage
{
    public partial class Promotions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            if (!IsPostBack)
            {
                LoadData();
                string keyword = Request.QueryString["search"];
                if (!string.IsNullOrEmpty(keyword))
                {
                    LoadPromotions(keyword);
                }
                else
                {
                    LoadPromotions();
                }
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
        public void Search(string keyword)
        {
            LoadPromotions(keyword); // Gọi hàm load dữ liệu với từ khóa
        }
        private void LoadPromotions(string keyword = "")
        {
            string query = string.IsNullOrEmpty(keyword)
                ? "SELECT MaKhuyenMai, TenKhuyenMai, MoTa, TyLeKhuyenMai, NgayBatDau, NgayKetThuc FROM KhuyenMai"
                : @"SELECT MaKhuyenMai, TenKhuyenMai, MoTa, TyLeKhuyenMai, NgayBatDau, NgayKetThuc 
             FROM KhuyenMai 
             WHERE TenKhuyenMai LIKE @Keyword OR MoTa LIKE @Keyword";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                if (!string.IsNullOrEmpty(keyword))
                {
                    cmd.Parameters.AddWithValue("@Keyword", "%" + keyword + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();

                    // Hiển thị thông báo pop-up không tìm thấy
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showAlert", "alert('Không có kết quả tìm kiếm khuyến mãi phù hợp!');", true);
                }
            }
        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            LoadData();
        }
        private void LoadData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            string query = "SELECT * FROM KhuyenMai";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            LoadData();
        }
        
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string maKhuyenMai = GridView1.DataKeys[e.RowIndex].Value.ToString();

            string query = "DELETE FROM KhuyenMai WHERE MaKhuyenMai = @MaKhuyenMai";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MaKhuyenMai", maKhuyenMai);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    // Hiển thị lại GridView
                    LoadData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Xóa thành công!');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('Lỗi: {ex.Message}');", true);
                }
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            string tenKhuyenMai = txtTenKhuyenMai.Text;
            string moTa = txtMoTa.Text;
            decimal tyLeKhuyenMai = Convert.ToDecimal(txtTyLeKhuyenMai.Text);
            DateTime ngayBatDau = DateTime.ParseExact(txtNgayBatDau.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime ngayKetThuc = DateTime.ParseExact(txtNgayKetThuc.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            string maKhuyenMai = "KM" + DateTime.Now.Ticks.ToString(); // Sinh mã tự động

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO KhuyenMai (MaKhuyenMai, TenKhuyenMai, MoTa, TyLeKhuyenMai, NgayBatDau, NgayKetThuc) " +
                               "VALUES (@MaKhuyenMai, @TenKhuyenMai, @MoTa, @TyLeKhuyenMai, @NgayBatDau, @NgayKetThuc)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaKhuyenMai", maKhuyenMai);
                cmd.Parameters.AddWithValue("@TenKhuyenMai", tenKhuyenMai);
                cmd.Parameters.AddWithValue("@MoTa", moTa);
                cmd.Parameters.AddWithValue("@TyLeKhuyenMai", tyLeKhuyenMai);
                cmd.Parameters.AddWithValue("@NgayBatDau", ngayBatDau);
                cmd.Parameters.AddWithValue("@NgayKetThuc", ngayKetThuc);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadData();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Thêm khuyến mãi thành công'); closeModal();", true);
        }

        private string GenerateMaKhuyenMai()
        {
            return "KM" + DateTime.Now.ToString("yyyyMMddHHmmss");
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;
            string maKhuyenMai = GridView1.DataKeys[e.RowIndex].Value.ToString();
            TextBox txtTenKhuyenMai = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtTenKhuyenMai");
            TextBox txtMoTa = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtMoTa");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE KhuyenMai SET TenKhuyenMai = @TenKhuyenMai, MoTa = @MoTa WHERE MaKhuyenMai = @MaKhuyenMai";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TenKhuyenMai", txtTenKhuyenMai.Text);
                cmd.Parameters.AddWithValue("@MoTa", txtMoTa.Text);
                cmd.Parameters.AddWithValue("@MaKhuyenMai", maKhuyenMai);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            GridView1.EditIndex = -1;
            LoadData();
        }
    
        protected void ValidateNgayBatDau(object source, ServerValidateEventArgs args)
        {
            DateTime temp;
            args.IsValid = DateTime.TryParseExact(txtNgayBatDau.Text, "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out temp);
        }

        protected void ValidateNgayKetThuc(object source, ServerValidateEventArgs args)
        {
            DateTime temp;
            args.IsValid = DateTime.TryParseExact(txtNgayKetThuc.Text, "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out temp);

            // Nếu ngày bắt đầu hợp lệ, kiểm tra logic ngày kết thúc
            if (args.IsValid && DateTime.TryParseExact(txtNgayBatDau.Text, "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime startDate))
            {
                if (temp <= startDate)
                {
                    args.IsValid = false;
                    ((CustomValidator)source).ErrorMessage = "Ngày kết thúc phải sau ngày bắt đầu.";
                }
            }
        }
        protected void btnShowModal_Click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenModal", "openAddEditModal();", true);

        }
        
    }
}