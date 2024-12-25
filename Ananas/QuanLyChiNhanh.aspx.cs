using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLyChiNhanh : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceChiNhanh.SelectCommand = "SELECT * FROM [ChiNhanh]";
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            lblmacn.Visible = !lblmacn.Visible;
            lbltencn.Visible = !lbltencn.Visible;
            lbldiachi.Visible = !lbldiachi.Visible;
            lblsdt.Visible = !lblsdt.Visible;

            txtmacn.Visible = !txtmacn.Visible;
            txttencn.Visible = !txttencn.Visible;
            txtdiachi.Visible = !txtdiachi.Visible;
            txtsdt.Visible = !txtsdt.Visible;

            if (btnthem.Text.Trim() == "Thêm mới")// Chuẩn bị thêm MH mới
            {//Xóa trống tất cả các TextBox để chuẩn bị cho nsd nhập thông tin món ăn mới
                txtmacn.Text = "000";
                txtmacn.ToolTip = "KHÔNG ĐỂ TRỐNG!";
                //SV sau này phải cho mã mh này tự tăng (theo măn, quý, stt); không nên để NSD tự nhập. 
                // txtmalsp.Text = "";
                //txtmacn.Text = "";
                txttencn.Text = "";
                txtdiachi.Text = "";
                txtsdt.Text = "";

                //Đổi nhãn btnThem : Thêm => Lưu
                btnthem.Text = "Lưu mới";
            }
            else // Lưu món ăn vào DataBase 
            {
                try
                {
                    SqlDataSourceChiNhanh.InsertParameters.Clear();
                    SqlDataSourceChiNhanh.InsertParameters.Add("MaCN", txtmacn.Text.Trim());
                    SqlDataSourceChiNhanh.InsertParameters.Add("TenCN", txttencn.Text);
                    SqlDataSourceChiNhanh.InsertParameters.Add("DiaChiCN", txtdiachi.Text);
                    SqlDataSourceChiNhanh.InsertParameters.Add("SDTCN", txtsdt.Text);

                    //2.Chạy lệnh Insert để lưu thông tin mặt hàng mới vào DB
                    SqlDataSourceChiNhanh.Insert();
                    //3. Lưu (copy) hình vửa được nsd Upload vào thư mục ~\\Images\\ của App
                    //OFFLINE

                    //Khi App này được Copy đi nơi khác => thì Update lại path này 
                    //ONLINE (khi upload lên Host, VD: somee thì phải dùng path vật lý của somee - tuy nhiên: tùy thuộc vào bảo mật của Host có thể không SaveAs... được
                    //FileUploadHinh.SaveAs("D:\\DZHosts\\LocalUser\\gtwovxthe\\www.drunkshopG506vxthe.somee.com\\" + FileUploadHinh.FileName.Trim());
                }
                catch (System.Exception ex) { this.Title = "LỖI " + ex.Message; }
                //SqlDataSourceLoaiSP.Insert();

                // Show success alert
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Thêm chi nhánh mới thành công!');", true);
                //Tải thông tin MH mới thêm lên GridView trên Web
                GridView1.DataBind();
            }
        }

        protected void btnback_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/TrangChuAdmin.aspx");
        }

        protected void btnreset_Click(object sender, ImageClickEventArgs e)
        {
            SqlDataSourceChiNhanh.SelectCommand = "SELECT * FROM [ChiNhanh]";
            GridView1.DataBind();
        }
    }
}