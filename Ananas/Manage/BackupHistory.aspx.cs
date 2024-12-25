using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas.Manage
{
    public partial class BackupHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBackupHistory();
            }
            // Kiểm tra Session
            //if (Session["Email"] == null || Session["LoggedIn"] == null || !(bool)Session["LoggedIn"])
            //{
            //    // Nếu Session không tồn tại hoặc hết hạn, chuyển hướng về trang đăng nhập
            //    Response.Redirect("Login.aspx");
            //    return;
            //}

            // Lấy quyền truy cập từ cơ sở dữ liệu
            //string email = Session["Email"].ToString();
            //string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
            //string query = "SELECT QuyenTruyCap FROM NhanVien WHERE Email = @Email";

            //using (SqlConnection conn = new SqlConnection(connString))
            //{
            //    SqlCommand cmd = new SqlCommand(query, conn);
            //    cmd.Parameters.AddWithValue("@Email", email);

            //    conn.Open();
            //    string quyenTruyCap = cmd.ExecuteScalar()?.ToString();
            //    conn.Close();

            //    // Lấy tên trang hiện tại
            //    string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

            //    // Kiểm tra xem trang hiện tại có trong quyền truy cập không
            //    if (quyenTruyCap == null || !quyenTruyCap.Split(',').Contains(currentPage))
            //    {
            //        // Nếu không có quyền, chuyển hướng tới Unauthorized
            //        Response.Redirect("Unauthorized.aspx");
            //    }
           //}
        }
        

        private void LoadBackupHistory()
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM BackupHistory ORDER BY BackupDate DESC", conn);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                GridViewBackupHistory.DataSource = dt;
                GridViewBackupHistory.DataBind();
            }
        }

        protected void PerformBackup(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("BackupDatabase", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    LoadBackupHistory();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Sao lưu thành công!');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Lỗi sao lưu: {ex.Message}');", true);
                }
            }
        }

        protected void PerformRestore(object sender, EventArgs e)
        {
            string backupPath = (sender as Button).CommandArgument;
            string connString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("RestoreDatabase", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@BackupPath", backupPath);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Phục hồi dữ liệu thành công!');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Lỗi phục hồi: {ex.Message}');", true);
                }
            }
        }
    }
}
