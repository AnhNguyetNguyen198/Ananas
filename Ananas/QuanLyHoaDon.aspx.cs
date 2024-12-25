using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLyHoaDon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceQLHoaDon.SelectCommand = @"
        SELECT 
            *,
            CONVERT(VARCHAR, NgayTaoHD, 111) AS NgayTaoHD_DinhDang
        FROM [HoaDon]";
        }

        protected void btnBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("TrangChuAdmin.aspx");
        }

        protected void reset_Click(object sender, ImageClickEventArgs e)
        {
            SqlDataSourceQLHoaDon.SelectCommand = "SELECT * FROM HoaDon";

            // Load lại dữ liệu của GridView
            GridViewHoaDon.DataBind();
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            // Toggle visibility of labels and textboxes
            lblmahd.Visible = !lblmahd.Visible;
            lblmanv.Visible = !lblmanv.Visible;
            lblmakh.Visible = !lblmakh.Visible;
            lblmakm.Visible = !lblmakm.Visible;
            lbltongtien.Visible = !lbltongtien.Visible;
            lblngaytao.Visible = !lblngaytao.Visible;
            lblpttt.Visible = !lblpttt.Visible;
            lblptgh.Visible = !lblptgh.Visible;

            txtmahd.Visible = !txtmahd.Visible;
            txtmanv.Visible = !txtmanv.Visible;
            txtmakh.Visible = !txtmakh.Visible;
            txtmakm.Visible = !txtmakm.Visible;
            txttongtien.Visible = !txttongtien.Visible;
            txtngaytao.Visible = !txtngaytao.Visible;
            txtpttt.Visible = !txtpttt.Visible;
            txtptgh.Visible = !txtptgh.Visible;

            if (btnthem.Text.Trim() == "Thêm sản phẩm mới") // Prepare for adding new invoice
            {
                // Clear all TextBoxes for new invoice entry
                txtmahd.Text = "";
                txtmahd.ToolTip = "KHÔNG ĐỂ TRỐNG MÃ HÓA ĐƠN, KHÔNG NHẬP TRÙNG MÃ HÓA ĐƠN ĐÃ CÓ!";
                txttongtien.Text = "1";
                txttongtien.ToolTip = "Giá phải >0";
                txtmakh.Text = "";
                txtmanv.Text = "";
                txtmakm.Text = "";
                txtngaytao.Text = "";
                txtpttt.Text = "";
                txtptgh.Text = "";

                // Change button text to "Save"
                btnthem.Text = "Lưu hóa đơn mới";
            }
            else // Save the new invoice to the database
            {
                try
                {
                    // Define parameters for the Insert command
                    SqlDataSourceQLHoaDon.InsertParameters.Clear();
                    SqlDataSourceQLHoaDon.InsertParameters.Add("MaHD", txtmahd.Text.Trim());
                    SqlDataSourceQLHoaDon.InsertParameters.Add("MaKH", txtmakh.Text.Trim());
                    SqlDataSourceQLHoaDon.InsertParameters.Add("MaNV", txtmanv.Text.Trim());
                    SqlDataSourceQLHoaDon.InsertParameters.Add("MaKM", txtmakm.Text.Trim());
                    SqlDataSourceQLHoaDon.InsertParameters.Add("TongTien", DbType.Double, txttongtien.Text.Trim());
                    SqlDataSourceQLHoaDon.InsertParameters.Add("PTTT", txtpttt.Text);
                    SqlDataSourceQLHoaDon.InsertParameters.Add("PTGH", txtptgh.Text);

                    DateTime ngayTaoHD;
                    if (DateTime.TryParse(txtngaytao.Text, out ngayTaoHD))
                    {
                        SqlDataSourceQLHoaDon.InsertParameters.Add("NgayTaoHD", DbType.DateTime, ngayTaoHD.ToString("yyyy/MM/dd"));
                    }
                    else
                    {
                        // Handle invalid date format
                        this.Title = "Ngày tạo không hợp lệ!";
                        return;
                    }

                    // Execute the Insert command to save the new invoice to the database
                    SqlDataSourceQLHoaDon.Insert();

                    // Show success message
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Thêm hóa đơn thành công!');", true);

                    // Reload GridView to show the new record
                    GridViewHoaDon.DataBind();

                    // Change button text back to "Add new"
                    btnthem.Text = "Thêm mới";
                }
                catch (Exception ex)
                {
                    this.Title = "LỖI: " + ex.Message;
                }
            }
        }

        protected void Select_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sortExpression = "";
            switch (Select.SelectedValue)
            {
                case "cao":
                    sortExpression = "TongTien DESC";
                    break;
                case "thap":
                    sortExpression = "TongTien ASC";
                    break;
                case "gan":
                    sortExpression = "NgayTaoHD DESC";
                    break;
                case "xa":
                    sortExpression = "NgayTaoHD ASC";
                    break;
            }

            SqlDataSourceQLHoaDon.SelectCommand = $"SELECT * FROM [HoaDon] ORDER BY {sortExpression}";
            GridViewHoaDon.DataBind();
        }

        protected void btntim_Click(object sender, EventArgs e)
        {
            string searchText = txttim.Text.Trim();

            // Construct the SQL query to search in HoaDon table
            string query = @"
        SELECT * FROM HoaDon 
        WHERE MaHD LIKE '%' + @SearchText + '%' 
        OR MaKH LIKE '%' + @SearchText + '%'
        OR MaNV LIKE '%' + @SearchText + '%'
        OR MaKM LIKE '%' + @SearchText + '%'";

            // Log or output the constructed query for debugging
            System.Diagnostics.Debug.WriteLine("Query: " + query);

            // Set the query and clear previous parameters
            SqlDataSourceQLHoaDon.SelectCommand = query;
            SqlDataSourceQLHoaDon.SelectParameters.Clear();
            SqlDataSourceQLHoaDon.SelectParameters.Add("SearchText", searchText);

            // Log or output parameter values for debugging
            System.Diagnostics.Debug.WriteLine("SearchText Parameter: " + searchText);

            // Re-bind the GridView to apply the search filter
            GridViewHoaDon.DataBind();

            if (GridViewHoaDon.Rows.Count == 0)
            {
                // Register a script to display a popup if no results are found
                string script = "alert('Không tìm thấy kết quả nào.');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "NoResults", script, true);
            }
        }

        protected void GridViewHoaDon_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Kiểm tra xem dòng đang được bind là dữ liệu (DataRow)
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Kiểm tra vai trò của người dùng
                if (!User.IsInRole("admin"))
                {
                    // Nếu không phải admin, ẩn các nút Sửa và Xóa
                    LinkButton btnEdit = e.Row.FindControl("Edit") as LinkButton;
                    LinkButton btnDelete = e.Row.FindControl("Delete") as LinkButton;

                    if (btnEdit != null)
                    {
                        btnEdit.Visible = false; // Ẩn nút Sửa
                    }

                    if (btnDelete != null)
                    {
                        btnDelete.Visible = false; // Ẩn nút Xóa
                    }
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Tìm control Label trong TemplateField để gán giá trị
                Label lblSTT = (Label)e.Row.FindControl("lblSTT");
                if (lblSTT != null)
                {
                    lblSTT.Text = (e.Row.RowIndex + 1).ToString();
                }
            }
        }
    }
}