using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLyKhuyenMai : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceKhuyenMai.SelectCommand = "SELECT * FROM [KhuyenMai]";
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            lblmakm.Visible = !lblmakm.Visible;
            lbltenkm.Visible = !lbltenkm.Visible;
            lblngaybatdau.Visible = !lblngaybatdau.Visible;
            lblngayketthuc.Visible = !lblngayketthuc.Visible;
            lblchietkhau.Visible = !lblchietkhau.Visible;

            txtmakm.Visible = !txtmakm.Visible;
            txttenkm.Visible = !txttenkm.Visible;
            txtngaybatdau.Visible = !txtngaybatdau.Visible;
            txtngayketthuc.Visible = !txtngayketthuc.Visible;
            txtchietkhau.Visible = !txtchietkhau.Visible;

            if (btnthem.Text.Trim() == "Thêm mới")
            {
                txtmakm.Text = "000";
                txtmakm.ToolTip = "KHÔNG ĐỂ TRỐNG!";
                txttenkm.Text = "";
                txtngaybatdau.Text = "dd/MM/yyyy";
                txtngayketthuc.Text = "dd/MM/yyyy";

                btnthem.Text = "Lưu mới";
            }
            else
            {
                try
                {
                    SqlDataSourceKhuyenMai.InsertParameters.Clear();
                    SqlDataSourceKhuyenMai.InsertParameters.Add("MaKM", txtmakm.Text.Trim());
                    SqlDataSourceKhuyenMai.InsertParameters.Add("TenKM", txttenkm.Text);
                    SqlDataSourceKhuyenMai.InsertParameters.Add("NgayBatDau", txtngaybatdau.Text);
                    SqlDataSourceKhuyenMai.InsertParameters.Add("NgayKetThuc", txtngayketthuc.Text);
                    SqlDataSourceKhuyenMai.InsertParameters.Add("ChietKhau", txtchietkhau.Text);

                    SqlDataSourceKhuyenMai.Insert();
                }
                catch (System.Exception ex)
                {
                    this.Title = "LỖI " + ex.Message;
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Thêm khuyến mãi mới thành công!');", true);
                GridView1.DataBind();
            }
        }

        
        protected void btnreset_Click(object sender, ImageClickEventArgs e)
        {
            SqlDataSourceKhuyenMai.SelectCommand = "SELECT * FROM [KhuyenMai]";
            GridView1.DataBind();
        }

        protected void btnback_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("TrangchuAdmin.aspx");
        }
    }
}