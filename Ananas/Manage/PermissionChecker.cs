using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace Ananas
{
    public static class PermissionChecker
    {
        public static bool HasPermission(HttpContext context, string page)
        {
            if (context.Session["Email"] == null)
                return false;

            string email = context.Session["Email"].ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["Ananas_KLTNConnectionStringTrustServer"].ToString();
            string query = "SELECT QuyenTruyCap FROM NhanVien WHERE Email = @Email";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                string quyenTruyCap = cmd.ExecuteScalar()?.ToString();
                conn.Close();

                // Kiểm tra quyền
                return quyenTruyCap?.Contains(page) ?? false;
            }
        }
        
    }
}
