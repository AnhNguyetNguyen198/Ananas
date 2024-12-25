using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLySize : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceSize.SelectCommand = "SELECT * FROM [Size]";//viết lại lệnh Select
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            lblmasize.Visible = !lblmasize.Visible;
            lbltensize.Visible = !lbltensize.Visible;

            txtmasize.Visible = !txtmasize.Visible;
            txttensize.Visible = !txttensize.Visible;

            if (btnthem.Text.Trim() == "Thêm mới")// Chuẩn bị thêm MH mới
            {//Xóa trống tất cả các TextBox để chuẩn bị cho nsd nhập thông tin món ăn mới
                txtmasize.Text = "000"; txtmasize.ToolTip = "KHÔNG ĐỂ TRỐNG!";
                //SV sau này phải cho mã mh này tự tăng (theo măn, quý, stt); không nên để NSD tự nhập. 
               // txtmasize.Text = "";
                txttensize.Text = "";

                //Đổi nhãn btnThem : Thêm => Lưu
                btnthem.Text = "Lưu mới";
            }
            else // Lưu món ăn vào DataBase 
            {
                try
                {
                    SqlDataSourceSize.InsertParameters.Clear();
                    SqlDataSourceSize.InsertParameters.Add("MaSize", txtmasize.Text.Trim());
                    SqlDataSourceSize.InsertParameters.Add("TenSize", txttensize.Text);

                    //2.Chạy lệnh Insert để lưu thông tin mặt hàng mới vào DB
                    SqlDataSourceSize.Insert();
                    //3. Lưu (copy) hình vửa được nsd Upload vào thư mục ~\\Images\\ của App
                    //OFFLINE

                    //Khi App này được Copy đi nơi khác => thì Update lại path này 
                    //ONLINE (khi upload lên Host, VD: somee thì phải dùng path vật lý của somee - tuy nhiên: tùy thuộc vào bảo mật của Host có thể không SaveAs... được
                    //FileUploadHinh.SaveAs("D:\\DZHosts\\LocalUser\\gtwovxthe\\www.drunkshopG506vxthe.somee.com\\" + FileUploadHinh.FileName.Trim());
                }
                catch (System.Exception ex) { this.Title = "!" + ex.Message; }
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Thêm size thành công!');", true);
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
            txtmasize.Text = string.Empty;
            txttensize.Text = string.Empty;
            SqlDataSourceSize.SelectCommand = "SELECT * FROM [Size]";
            GridView1.DataBind();
        }
    }
}