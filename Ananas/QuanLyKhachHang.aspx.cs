using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLyKhachHnag : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceQLKH.SelectCommand = "SELECT * FROM [KhachHang]";//viết lại lệnh Select
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            lblmakh.Visible = !lblmakh.Visible;
            lblhoten.Visible = !lblhoten.Visible;
            lblgioitinh.Visible = !lblgioitinh.Visible;
            lblsdt.Visible = !lblsdt.Visible;
            lblemail.Visible = !lblemail.Visible;
            lbldiachi.Visible = !lbldiachi.Visible;
            lblngaysinh.Visible = !lblngaysinh.Visible;
            lblmaloai.Visible = !lblmaloai.Visible;

            txtmakh.Visible = !txtmakh.Visible;
            txthoten.Visible = !txthoten.Visible;
            ddlgioitinh.Visible = !ddlgioitinh.Visible;
            txtsdt.Visible = !txtsdt.Visible;
            txtemail.Visible = !txtemail.Visible;
            txtdiachi.Visible = !txtdiachi.Visible;
            txtngaysinh.Visible = !txtngaysinh.Visible;
            ddlmaloai.Visible = !ddlmaloai.Visible;
            if (btnthem.Text.Trim() == "Thêm khách hàng mới") // Prepare to add a new customer
            {
                // Clear all TextBox to prepare for new customer info
                txtmakh.Text = "";
                txthoten.Text = "";
                ddlgioitinh.SelectedIndex = 0;
                txtsdt.Text = "";
                txtemail.Text = "";
                txtdiachi.Text = "";
                txtngaysinh.Text = "";
                ddlmaloai.SelectedIndex = 0;
                // Change button text to "Lưu khách hàng mới"
                btnthem.Text = "Lưu khách hàng mới";
            }
            else // Save new customer to the database
            {
                try
                {
                    // Clear previous parameters
                    SqlDataSourceQLKH.InsertParameters.Clear();

                    // Add parameters with proper data types
                    SqlDataSourceQLKH.InsertParameters.Add("MaKH", System.Data.DbType.String, txtmakh.Text.Trim());
                    SqlDataSourceQLKH.InsertParameters.Add("HoTenKH", System.Data.DbType.String, txthoten.Text);
                    SqlDataSourceQLKH.InsertParameters.Add("GioiTinhKH", System.Data.DbType.String, ddlgioitinh.SelectedValue);
                    //SqlDataSourceQLKH.InsertParameters.Add("NgaySinh", System.Data.DbType.String, txthoten.Text);
                    SqlDataSourceQLKH.InsertParameters.Add("SDTKH", System.Data.DbType.String, txtsdt.Text);
                    SqlDataSourceQLKH.InsertParameters.Add("EmailKH", System.Data.DbType.String, txtemail.Text);
                    SqlDataSourceQLKH.InsertParameters.Add("DiaChiKH", System.Data.DbType.String, txtdiachi.Text);
                    SqlDataSourceQLKH.InsertParameters.Add("MaLoaiKH", System.Data.DbType.String, ddlmaloai.SelectedValue);

                    // Add date parameter and ensure proper format
                    DateTime ngaySinh;
                    if (DateTime.TryParse(txtngaysinh.Text, out ngaySinh))
                    {
                        SqlDataSourceQLKH.InsertParameters.Add("NgaySinh", System.Data.DbType.DateTime, ngaySinh.ToString("yyyy-MM-dd"));
                    }
                    else
                    {
                        // Handle invalid date format
                        this.Title = "Ngày sinh không hợp lệ!";
                        return;
                    }

                    // Insert new customer into the database
                    SqlDataSourceQLKH.Insert();
                   
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Thêm khách hàng thành công!');", true);

                    // Rebind the GridView to display the new customer
                    GridViewKhachHang.DataBind();

                    // Reset button text to "Thêm khách hàng mới"
                    btnthem.Text = "Thêm khách hàng mới";
                }
                catch (Exception ex)
                {
                    // Display error message
                    this.Title = "Lỗi: " + ex.Message;
                }
            }
        }

        protected void btnBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/TrangChuAdmin.aspx");
        }

        protected void reset_Click(object sender, ImageClickEventArgs e)
        {
            txttim.Text = string.Empty;
            SqlDataSourceQLKH.SelectCommand = "SELECT * FROM [KhachHang]";
            GridViewKhachHang.DataBind();

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

        }

        protected void btntim_Click(object sender, EventArgs e)
        {
            string searchText = txttim.Text.Trim();

            // Assuming you want to search both by product code (MaSP) and product name (TenSP)
            SqlDataSourceQLKH.SelectCommand = @"
                SELECT * FROM KhachHang 
                WHERE MaKH LIKE '%' + @SearchText + '%' 
                OR HoTenKH LIKE '%' + @SearchText + '%'";
            SqlDataSourceQLKH.SelectParameters.Clear();
            SqlDataSourceQLKH.SelectParameters.Add("SearchText", searchText);

            GridViewKhachHang.DataBind();
            if (GridViewKhachHang.Rows.Count == 0)
            {
                // Register a script to display a popup if no results are found
                string script = "alert('Không tìm thấy kết quả nào.');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "NoResults", script, true);
            }
        }
        protected void GridViewKhachHang_RowDataBound(object sender, GridViewRowEventArgs e)
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
        }
    }
}