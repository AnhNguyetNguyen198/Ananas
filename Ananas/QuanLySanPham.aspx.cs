using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas.Admin
{
    public partial class QuanLySanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ddlLoaiSP_SelectedIndexChanged(sender, e);
            if (!IsPostBack)
            {
                // Bind GridView with default sort order
                BindGridView("GiaSP ASC");
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
                        orderBy = "GiaSP ASC";
                        break;
                    case "desc":
                        orderBy = "GiaSP DESC";
                        break;
                    case "random":
                        orderBy = "random";
                        break;
                    default:
                        orderBy = "GiaSP ASC";
                        break;
                }

                BindGridView(orderBy);
            }
        }

        protected void BindGridView(string orderBy)
        {
            if (orderBy == "random")
            {
                SqlDataSourceQLSP.SelectCommand = "SELECT * FROM SanPham ORDER BY NEWID()";
            }
            else
            {
                SqlDataSourceQLSP.SelectCommand = "SELECT * FROM SanPham ORDER BY " + orderBy;
            }
            GridView1.DataBind();
        }


        protected void btntim_Click(object sender, EventArgs e)
        {
            string searchText = txttim.Text.Trim();

            // Assuming you want to search both by product code (MaSP) and product name (TenSP)
            SqlDataSourceQLSP.SelectCommand = @"
                SELECT * FROM SanPham 
                WHERE MaSP LIKE '%' + @SearchText + '%' 
                OR TenSP LIKE '%' + @SearchText + '%'";
            SqlDataSourceQLSP.SelectParameters.Clear();
            SqlDataSourceQLSP.SelectParameters.Add("SearchText", searchText);

            GridView1.DataBind();
        }

        protected void ddlLoaiSP_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlLoaiSP.SelectedValue.Trim() == "*")
            {
                SqlDataSourceQLSP.SelectCommand = "SELECT * FROM [SanPham]";//viết lại lệnh Select
                btnthem.Enabled = false;
                btnthem.ToolTip = ddlLoaiSP.ToolTip = "Phải chọn nhóm cụ thể trước khi thêm mới"; //nhắc ....
            }
            else
            {
                btnthem.Enabled = true;//Thêm mới được.
                btnthem.ToolTip = ddlLoaiSP.ToolTip = ""; //KO nhắc ....
            }
            FileUploadHinh.Visible = !FileUploadHinh.Visible;

        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            lblmasp.Visible = !lblmasp.Visible;
            lbltensp.Visible = !lbltensp.Visible;
            lblgiasp.Visible = !lblgiasp.Visible;
            lbltrangthai.Visible = !lbltrangthai.Visible;
            lblmota.Visible = !lblmota.Visible;
            lblmausac.Visible = !lblmausac.Visible;

            txtmasp.Visible = !txtmasp.Visible;
            txttensp.Visible = !txttensp.Visible;
            txtgiasp.Visible = !txtgiasp.Visible;
            txtmausac.Visible = !txtmausac.Visible;
            txtmota.Visible = !txtmota.Visible;
            ddltrangthai.Visible = !ddltrangthai.Visible;

            if (btnthem.Text.Trim() == "Thêm sản phẩm mới")
            {
                txtmasp.Text = "";
                txtgiasp.Text = "1";
                txtmausac.Text = "";
                txtmota.Text = "";
                ddltrangthai.SelectedValue = "1";
                txttensp.Text = "";

                btnthem.Text = "Lưu sản phẩm mới";
            }
            else
            {
                try
                {
                    SqlDataSourceQLSP.InsertParameters.Clear();
                    SqlDataSourceQLSP.InsertParameters.Add("MaSP", txtmasp.Text.Trim());
                    SqlDataSourceQLSP.InsertParameters.Add("MaLoaiSP", ddlLoaiSP.SelectedValue.Trim());
                    SqlDataSourceQLSP.InsertParameters.Add("TenSP", txttensp.Text);
                    SqlDataSourceQLSP.InsertParameters.Add("GiaSP", System.Data.DbType.Double, txtgiasp.Text.Trim());
                    SqlDataSourceQLSP.InsertParameters.Add("Hinh", "~\\Hinh\\" + FileUploadHinh.FileName);
                    SqlDataSourceQLSP.InsertParameters.Add("TrangThai", ddltrangthai.SelectedValue);
                    SqlDataSourceQLSP.InsertParameters.Add("Mota", txtmota.Text);
                    SqlDataSourceQLSP.InsertParameters.Add("MauSac", txtmausac.Text);

                    SqlDataSourceQLSP.Insert();

                    FileUploadHinh.SaveAs(Server.MapPath("~/Hinh/") + FileUploadHinh.FileName.Trim());
                }
                catch (System.Exception ex) { this.Title = "CÓ LỖI THÊM MÓN ĂN MỚI = " + ex.Message; }

                GridView1.DataBind();
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
        }

        protected void btnBack_Click(object sender, ImageClickEventArgs e)
        {
           Response.Redirect("~/TrangChuAdmin.aspx");
        }

        protected void reset_Click(object sender, ImageClickEventArgs e)
        {
            // Reset the GridView to its default state
            BindGridView("GiaSP asc");

            // Reset any other controls to their default state
            ddlLoaiSP.SelectedIndex = 0;  // Assuming the first item is the default
            txttim.Text = string.Empty;
        }

        
    }
}
