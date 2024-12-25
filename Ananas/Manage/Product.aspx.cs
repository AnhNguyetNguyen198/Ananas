using Microsoft.ReportingServices.Diagnostics.Internal;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas.Manage
{
    public partial class Product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                    LoadData();
                LoadLoaiSanPham();
                string keyword = Request.QueryString["search"];
                if (!string.IsNullOrEmpty(keyword))
                {
                    LoadProducts(keyword);
                }
                else
                {
                    LoadProducts();
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
            LoadProducts(keyword); // Gọi hàm load dữ liệu với từ khóa
        }
        private void LoadProducts(string keyword = "")
        {
            string query = string.IsNullOrEmpty(keyword)
                ? @"SELECT sp.MaSanPham, ls.TenLoai, sp.TenSanPham, sp.Gia, sp.Hinh, sp.MoTa, sp.NgayTao 
             FROM SanPham sp 
             INNER JOIN LoaiSanPham ls ON sp.MaLoai = ls.MaLoai"
                : @"SELECT sp.MaSanPham, ls.TenLoai, sp.TenSanPham, sp.Gia, sp.Hinh, sp.MoTa, sp.NgayTao 
             FROM SanPham sp 
             INNER JOIN LoaiSanPham ls ON sp.MaLoai = ls.MaLoai
             WHERE sp.TenSanPham LIKE @Keyword OR ls.TenLoai LIKE @Keyword OR sp.MoTa LIKE @Keyword";

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

                    // Hiển thị pop-up thông báo không tìm thấy sản phẩm
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showAlert", "alert('Không có kết quả tìm kiếm sản phẩm phù hợp!');", true);
                }
            }
        }
        private void LoadLoaiSanPham()
        {
            string query = "SELECT MaLoai, TenLoai FROM LoaiSanPham";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                // Bind dữ liệu vào DropDownList
                ddlLoaiSanPham.DataSource = reader;
                ddlLoaiSanPham.DataTextField = "TenLoai"; // Hiển thị tên loại
                ddlLoaiSanPham.DataValueField = "MaLoai"; // Giá trị là mã loại
                ddlLoaiSanPham.DataBind();

                // Thêm giá trị mặc định
                ddlLoaiSanPham.Items.Insert(0, new ListItem("-- Chọn loại sản phẩm --", ""));
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Tính số thứ tự
                int index = (GridView1.PageIndex * GridView1.PageSize) + e.Row.RowIndex + 1;
                Label lblSTT = (Label)e.Row.FindControl("lblSTT");
                if (lblSTT != null)
                {
                    lblSTT.Text = index.ToString();
                }
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            LoadData();
        }

        // Sự kiện khi hủy bỏ việc chỉnh sửa
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            LoadData();
        }

        // Sự kiện khi cập nhật sản phẩm
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string maSanPham = GridView1.DataKeys[e.RowIndex].Value.ToString();
                string tenSanPham = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtTenSanPham")).Text;
                string loaiSanPham = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlLoaiEdit")).SelectedValue;
                string gia = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtGiaEdit")).Text;
                string moTa = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtMoTaEdit")).Text;

                // Lấy thông tin hình ảnh từ TextBox và FileUpload
                TextBox txtHinhEdit = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtHinhEdit");
                FileUpload fileUploadHinhEdit = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("fileUploadHinhEdit");

                string hinh = txtHinhEdit.Text; // Giá trị hiện tại từ cơ sở dữ liệu

                // Kiểm tra nếu có tải lên hình mới
                if (fileUploadHinhEdit.HasFile)
                {
                    // Lấy tên file và đảm bảo tên file là duy nhất
                    string fileName = Path.GetFileNameWithoutExtension(fileUploadHinhEdit.FileName);
                    string fileExtension = Path.GetExtension(fileUploadHinhEdit.FileName);
                    string uniqueFileName = $"{fileName}_{DateTime.Now.Ticks}{fileExtension}";

                    // Đường dẫn đầy đủ để lưu file
                    string serverPath = Server.MapPath("~/Hinh/" + uniqueFileName);

                    // Lưu file vào thư mục trên máy chủ
                    fileUploadHinhEdit.SaveAs(serverPath);

                    // Cập nhật đường dẫn hình ảnh
                    hinh = "~/Hinh/" + uniqueFileName;
                }

                // Câu lệnh SQL cập nhật sản phẩm
                string query = @"
            UPDATE SanPham 
            SET TenSanPham = @TenSanPham, 
                MaLoai = (SELECT MaLoai FROM LoaiSanPham WHERE TenLoai = @TenLoai),
                Gia = @Gia, 
                MoTa = @MoTa, 
                Hinh = @Hinh
            WHERE MaSanPham = @MaSanPham";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@TenSanPham", tenSanPham);
                    cmd.Parameters.AddWithValue("@TenLoai", loaiSanPham);
                    cmd.Parameters.AddWithValue("@Gia", gia);
                    cmd.Parameters.AddWithValue("@MoTa", moTa);
                    cmd.Parameters.AddWithValue("@Hinh", hinh);
                    cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Thoát chế độ chỉnh sửa
                GridView1.EditIndex = -1;
                LoadData();

                // Thông báo thành công
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cập nhật sản phẩm thành công!');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('Lỗi: {ex.Message}');", true);
            }
        }

        // Sự kiện khi xóa sản phẩm
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string maSanPham = GridView1.DataKeys[e.RowIndex].Value.ToString();

            // Chuỗi kết nối cơ sở dữ liệu
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionString"].ToString();

            // Câu lệnh SQL để xóa sản phẩm
            string query = "DELETE FROM SanPham WHERE MaSanPham = @MaSanPham";

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Gán tham số cho câu lệnh SQL
                        cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);

                        // Thực thi câu lệnh
                        cmd.ExecuteNonQuery();
                    }
                }

                // Tải lại dữ liệu sau khi xóa
                LoadData();

                // Hiển thị thông báo thành công qua script JavaScript
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Xóa sản phẩm thành công!');", true);
            }
            catch (Exception ex)
            {
                // Hiển thị thông báo lỗi qua script JavaScript
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Đã xảy ra lỗi khi xóa sản phẩm: {ex.Message}');", true);
            }
        }


        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            // Lấy cột cần sắp xếp
            string sortExpression = e.SortExpression;
            string sortDirection = "ASC";

            // Kiểm tra nếu cột được sắp xếp trước đó
            if (ViewState["SortDirection"] != null)
            {
                sortDirection = (ViewState["SortDirection"].ToString() == "ASC") ? "DESC" : "ASC";
            }

            // Lưu trạng thái sắp xếp cho lần tiếp theo
            ViewState["SortDirection"] = sortDirection;

            // Cập nhật câu lệnh SQL cho SqlDataSource
            SqlDataSourceProduct.SelectCommand = "SELECT sp.MaSanPham, ls.TenLoai, sp.TenSanPham, sp.Gia, sp.Hinh, sp.MoTa, sp.NgayTao " +
                "FROM SanPham sp INNER JOIN LoaiSanPham ls ON sp.MaLoai = ls.MaLoai " +
                "ORDER BY " + sortExpression + " " + sortDirection;

            // Ràng buộc lại dữ liệu vào GridView mà không gọi LoadData()
            GridView1.DataBind();
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#productModal').modal('show');", true);
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            try
            {
                string maLoai = ddlLoaiSanPham.SelectedValue;
                string tenSanPham = txtTenSanPham.Text.Trim();
                string moTa = txtMoTa.Text.Trim();
                decimal gia = decimal.Parse(txtGia.Text);
                string hinh = SaveImage(); 
                DateTime ngayTao = DateTime.Now;

                string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
                string maSanPham = "SP" + DateTime.Now.Ticks.ToString().Substring(8, 8);

                string query = "INSERT INTO SanPham (MaSanPham, MaLoai, TenSanPham, MoTa, Gia, Hinh, NgayTao) " +
                               "VALUES (@MaSanPham, @MaLoai, @TenSanPham, @MoTa, @Gia, @Hinh, @NgayTao)";

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);
                    cmd.Parameters.AddWithValue("@MaLoai", maLoai);
                    cmd.Parameters.AddWithValue("@TenSanPham", tenSanPham);
                    cmd.Parameters.AddWithValue("@MoTa", moTa);
                    cmd.Parameters.AddWithValue("@Gia", gia);
                    cmd.Parameters.AddWithValue("@Hinh", hinh);
                    cmd.Parameters.AddWithValue("@NgayTao", ngayTao);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Tải lại dữ liệu sản phẩm
                LoadData();

                // Ẩn modal và thông báo thành công
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "$('#productModal').modal('hide'); alert('Thêm sản phẩm thành công!');", true);
            }
            catch (Exception ex)
            {
                // Ghi log hoặc xử lý lỗi
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", $"alert('Có lỗi xảy ra: {ex.Message}');", true);
            }
        }

        private int GetNextProductId()
        {
            int nextId = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
            string query = "SELECT MAX(CAST(SUBSTRING(MaSanPham, 3, LEN(MaSanPham)) AS INT)) FROM SanPham";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                object result = cmd.ExecuteScalar();
                conn.Close();

                if (result != DBNull.Value)
                {
                    nextId = Convert.ToInt32(result);
                }
            }

            return nextId;
        }
        
        private string SaveImage()
        {
            string hinh = string.Empty;
            if (fileHinh.HasFile)
            {
                string fileName = Path.GetFileName(fileHinh.PostedFile.FileName);
                hinh = "~/Hinh/" + fileName;
                fileHinh.SaveAs(Server.MapPath(hinh));
            }
            return hinh;
        }
        private void LoadData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();

            // SQL Query để lấy thông tin sản phẩm và tên loại từ bảng LoaiSanPham
            string query = @"
        SELECT 
            ROW_NUMBER() OVER (ORDER BY sp.MaSanPham) AS STT,
            sp.MaSanPham,
            ls.TenLoai,
            sp.TenSanPham,
            sp.Gia,
            sp.Hinh,
            sp.MoTa,
            sp.NgayTao
        FROM SanPham sp
        INNER JOIN LoaiSanPham ls ON sp.MaLoai = ls.MaLoai
    ";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }

        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            LoadData();
        }

    }
}