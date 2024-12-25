using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLyLoaiSP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceLoaiSP.SelectCommand = "SELECT * FROM [LoaiSP]";//viết lại lệnh Select
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            lblmalsp.Visible = !lblmalsp.Visible;
            lbltenloaisp.Visible = !lbltenloaisp.Visible;
        
            txtmalsp.Visible = !txtmalsp.Visible;
            txttenlsp.Visible = !txttenlsp.Visible;
           
            if (btnthem.Text.Trim() == "Thêm mới")// Chuẩn bị thêm MH mới
            {//Xóa trống tất cả các TextBox để chuẩn bị cho nsd nhập thông tin món ăn mới
                txtmalsp.Text = "000"; 
                txtmalsp.ToolTip = "KHÔNG ĐỂ TRỐNG!";
                //SV sau này phải cho mã mh này tự tăng (theo măn, quý, stt); không nên để NSD tự nhập. 
               // txtmalsp.Text = "";
                txttenlsp.Text = "";
               
                //Đổi nhãn btnThem : Thêm => Lưu
                btnthem.Text = "Lưu mới";
            }
            else // Lưu món ăn vào DataBase 
            {
                try
                {
                    SqlDataSourceLoaiSP.InsertParameters.Clear();
                    SqlDataSourceLoaiSP.InsertParameters.Add("MaLoaiSP", txtmalsp.Text.Trim());
                    SqlDataSourceLoaiSP.InsertParameters.Add("TenLoaiSP", txttenlsp.Text);
                   
                    //2.Chạy lệnh Insert để lưu thông tin mặt hàng mới vào DB
                    SqlDataSourceLoaiSP.Insert();
                    //3. Lưu (copy) hình vửa được nsd Upload vào thư mục ~\\Images\\ của App
                    //OFFLINE

                    //Khi App này được Copy đi nơi khác => thì Update lại path này 
                    //ONLINE (khi upload lên Host, VD: somee thì phải dùng path vật lý của somee - tuy nhiên: tùy thuộc vào bảo mật của Host có thể không SaveAs... được
                    //FileUploadHinh.SaveAs("D:\\DZHosts\\LocalUser\\gtwovxthe\\www.drunkshopG506vxthe.somee.com\\" + FileUploadHinh.FileName.Trim());
                }
                catch (System.Exception ex) { this.Title = "LỖI " + ex.Message; }
                //SqlDataSourceLoaiSP.Insert();

                // Show success alert
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Thêm loại sản phẩm thành công!');", true);
                //Tải thông tin MH mới thêm lên GridView trên Web
                GridView1.DataBind();
                //Đối nhãn nút "Lưu.." -> "Thêm ..."
            }
        }

        protected void btnback_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("TrangchuAdmin.aspx");
        }

        protected void btnreset_Click(object sender, ImageClickEventArgs e)
        {
            SqlDataSourceLoaiSP.SelectCommand = "SELECT * FROM [LoaiSP]";
            GridView1.DataBind();
        }
    }
}