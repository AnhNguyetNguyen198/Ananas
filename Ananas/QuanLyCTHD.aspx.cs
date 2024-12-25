using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLyCTHD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind GridView with default sort order
                BindGridView("DonGia ASC");
            }
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (Request["__EVENTTARGET"] == "SortGridView")
            {
                string sortExpression = Request["__EVENTARGUMENT"];
                string orderBy;

                switch (sortExpression)
                {
                    case "asc":
                        orderBy = "DonGia ASC";
                        break;
                    case "desc":
                        orderBy = "DonGia DESC";
                        break;
                    case "banchay":
                        orderBy = "SoLuong DESC, MaSP";
                        break;
                    default:
                        orderBy = "MaHD ASC";
                        break;
                }

                BindGridView(orderBy);
            }
        }

        protected void BindGridView(string orderBy)
        {
            SqlDataSourceCTHD.SelectCommand = "SELECT * FROM ChiTietHoaDon ORDER BY " + orderBy;
            GridView1.DataBind();
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            // Toggle visibility of controls
            lblmahd.Visible = !lblmahd.Visible;
            lblmasp.Visible = !lblmasp.Visible;
            lblmasize.Visible = !lblmasize.Visible;
            lblsoluong.Visible = !lblsoluong.Visible;
            lbldongia.Visible = !lbldongia.Visible;

            txtmahd.Visible = !txtmahd.Visible;
            txtmasp.Visible = !txtmasp.Visible;
            txtmasize.Visible = !txtmasize.Visible;
            txtsoluong.Visible = !txtsoluong.Visible;
            txtdongia.Visible = !txtdongia.Visible;

            if (string.IsNullOrWhiteSpace(txtmahd.Text) || string.IsNullOrWhiteSpace(txtmasp.Text) ||
            string.IsNullOrWhiteSpace(txtmasize.Text) || string.IsNullOrWhiteSpace(txtsoluong.Text) ||
            string.IsNullOrWhiteSpace(txtdongia.Text))
            {
                // Hiển thị thông báo lỗi nếu có trường nào bị bỏ trống
                string message = "Vui lòng điền đầy đủ thông tin.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);
                return;
            }
            else // Save new item to database
            {
                try
                {
                    // Clear previous parameters and define new ones
                    SqlDataSourceCTHD.InsertParameters.Clear();
                    SqlDataSourceCTHD.InsertParameters.Add("MaHD", txtmahd.Text.Trim());
                    SqlDataSourceCTHD.InsertParameters.Add("MaSP", txtmasp.Text.Trim());
                    SqlDataSourceCTHD.InsertParameters.Add("MaSize", txtmasize.Text.Trim());
                    SqlDataSourceCTHD.InsertParameters.Add("SoLuong", txtsoluong.Text);
                    SqlDataSourceCTHD.InsertParameters.Add("DonGia", txtdongia.Text);

                    // Execute the insert command
                    SqlDataSourceCTHD.Insert();
                }
                catch (System.Exception ex) { this.Title = "CÓ LỖI " + ex.Message; }

                // Tải thông tin MH mới thêm lên GridView trên Web
                GridView1.DataBind();
                // Change button text back to "Thêm mới"
                btnthem.Text = "Thêm sản phẩm mới";
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Tìm control Label trong TemplateField để gán giá trị
                Label lblSTT = (Label)e.Row.FindControl("lblSTT");
                if (lblSTT != null)
                {
                    lblSTT.Text = (e.Row.RowIndex + 1).ToString();
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Check user role
                if (!User.IsInRole("admin"))
                {
                    LinkButton btnDelete = e.Row.FindControl("Delete") as LinkButton;
                    if (btnDelete != null)
                    {
                        btnDelete.Visible = false; // Hide delete button
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/TrangChuAdmin.aspx");
        }

        protected void btntim_Click(object sender, EventArgs e)
        {
            // Viết mã xử lý tìm hóa đơn ở đây
            // Ví dụ:
            string maHoaDon = txtmahoadon.Text.Trim(); // txtMaHoaDon là TextBox để nhập mã hóa đơn

            // Viết mã SQL hoặc gọi phương thức xử lý tìm kiếm hóa đơn ở đây
            // Ví dụ SQLDataSource
            SqlDataSourceCTHD.SelectCommand = "SELECT * FROM ChiTietHoaDon WHERE MaHD = @MaHD";
            SqlDataSourceCTHD.SelectParameters.Clear();
            SqlDataSourceCTHD.SelectParameters.Add("MaHD", maHoaDon);

            // Refresh GridView (nếu có)
            GridView1.DataBind();

            if (GridView1.Rows.Count == 0)
            {
                // Register a script to display a popup if no results are found
                string script = "alert('Không tìm thấy kết quả nào.');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "NoResults", script, true);
            }
        }

        protected void reset_Click(object sender, ImageClickEventArgs e)
        {
            // Reset the GridView to its default state
            BindGridView("SoLuong asc");

            // Reset any other controls to their default state
            txtmahoadon.Text = string.Empty;
        }
    }
}
