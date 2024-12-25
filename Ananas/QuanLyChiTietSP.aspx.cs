using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLyChiTietSP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ddlsize_SelectedIndexChanged(sender, e);
        }
        protected void ddlsize_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlsize.SelectedValue.Trim() == "*")
            {
                SqlDataSourceCTSP.SelectCommand = "SELECT * FROM [ChiTietSanPham]";//viết lại lệnh Select
                btnthem.Enabled = false;
                btnthem.ToolTip = ddlsize.ToolTip = "Phải chọn nhóm cụ thể trước khi thêm mới"; //nhắc ....
            }
            else
            {
                btnthem.Enabled = true;//Thêm mới được.
                btnthem.ToolTip = ddlsize.ToolTip = ""; //KO nhắc ....
            }
        }
        protected void btnthem_Click(object sender, EventArgs e)
        {
            // Toggle visibility of input fields and labels
            lblmasp.Visible = !lblmasp.Visible;
            lblphantren.Visible = !lblphantren.Visible;
            lbldengoai.Visible = !lbldengoai.Visible;
            lblsize.Visible = !lblsize.Visible;

            txtmasp.Visible = !txtmasp.Visible;
            txtphantren.Visible = !txtphantren.Visible;
            txtdengoai.Visible = !txtdengoai.Visible;
            ddlsize.Visible = !ddlsize.Visible;

            if (btnthem.Text.Trim() == "Thêm mới") // Prepare to add a new product
            {
                // Clear input fields for new product entry
                //txtmasp.Text = string.Empty;
                txtmasp.ToolTip = "KHÔNG ĐỂ TRỐNG MÃ SẢN PHẨM!";

                txtphantren.Text = string.Empty;
                txtdengoai.Text = string.Empty;
                ddlsize.SelectedIndex = 0; // Reset DropDownList to default value

                // Change button label from "Thêm mới" to "Lưu mới"
                btnthem.Text = "Lưu mới";
            }
            else // Save the new product to the database
            {
                if (string.IsNullOrWhiteSpace(txtmasp.Text.Trim()))
                {
                    // Show an alert if MaSP is empty
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Mã sản phẩm không được để trống!');", true);
                    return;
                }

                try
                {
                    // Clear previous parameters
                    SqlDataSourceCTSP.InsertParameters.Clear();

                    // Add parameters for the insert command
                    SqlDataSourceCTSP.InsertParameters.Add("MaSP", txtmasp.Text.Trim());
                    SqlDataSourceCTSP.InsertParameters.Add("MaSize", ddlsize.SelectedValue.Trim());
                    SqlDataSourceCTSP.InsertParameters.Add("PhanTren", txtphantren.Text.Trim());
                    SqlDataSourceCTSP.InsertParameters.Add("DeNgoai", txtdengoai.Text.Trim());

                    // Execute the insert command
                    SqlDataSourceCTSP.Insert();

                    // Show success alert
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Thêm sản phẩm thành công!');", true);

                    // Refresh the GridView to display the new product
                    GridView1.DataBind();

                    // Change button label back to "Thêm mới"
                    btnthem.Text = "Thêm mới";
                }
                catch (Exception ex)
                {
                    // Show error message
                    this.Title = "CÓ LỖI: " + ex.Message;
                }
            }
        }



        protected void btnBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("TrangChuAdmin.aspx");
        }

        protected void btntim_Click(object sender, EventArgs e)
        {
            string searchText = txttim.Text.Trim();

            // Construct the SQL query to search in ChiTietSanPham table
            string query = @"
        SELECT * FROM ChiTietSanPham 
        WHERE MaSP LIKE '%' + @SearchText + '%' 
        OR MaSize LIKE '%' + @SearchText + '%'
        OR PhanTren LIKE '%' + @SearchText + '%'
        OR DeNgoai LIKE '%' + @SearchText + '%'";

            // Set the query and clear previous parameters
            SqlDataSourceCTSP.SelectCommand = query;
            SqlDataSourceCTSP.SelectParameters.Clear();
            SqlDataSourceCTSP.SelectParameters.Add("SearchText", searchText);

            // Re-bind the GridView to apply the search filter
            GridView1.DataBind();

            // Check if there are any results
            if (GridView1.Rows.Count == 0)
            {
                // Register a script to display a popup if no results are found
                string script = "alert('Không tìm thấy kết quả nào.');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "NoResults", script, true);
            }
        }


        protected void reset_Click(object sender, ImageClickEventArgs e)
        {
            txttim.Text = string.Empty;
            SqlDataSourceCTSP.SelectCommand = "SELECT * FROM [ChiTietSanPham]";
            GridView1.DataBind();
        }
    }
}