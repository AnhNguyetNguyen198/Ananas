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
                SqlDataSourceCTSP.SelectCommand = "SELECT * FROM [ChiTietSP]";//viết lại lệnh Select
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
            lblmasp.Visible = !lblmasp.Visible;
            lblphantren.Visible = !lblphantren.Visible;
            lbldengoai.Visible = !lbldengoai.Visible;
            
            txtmasp.Visible = !txtmasp.Visible;
            txtphantren.Visible = !txtphantren.Visible;
            txtdengoai.Visible = !txtdengoai.Visible;
            
            if (btnthem.Text.Trim() == "Thêm mới")// Chuẩn bị thêm MH mới
            {//Xóa trống tất cả các TextBox để chuẩn bị cho nsd nhập thông tin món ăn mới
                txtmasp.Text = "000"; txtmasp.ToolTip = "KHÔNG ĐỂ TRỐNG!";
                //SV sau này phải cho mã mh này tự tăng (theo măn, quý, stt); không nên để NSD tự nhập. 
                txtmasp.Text = "";
                
                txtphantren.Text = "";
                txtdengoai.Text = "";
                
                //Đổi nhãn btnThem : Thêm => Lưu
                btnthem.Text = "Lưu mới";
            }
            else // Lưu món ăn vào DataBase 
            {
                try
                {
                    //1.Đinh nghĩa các tham số parameters cho Insertcommnand : tham số cho field hinh có dạng ~\\Images\\Tên file hình được upload.filename
                    SqlDataSourceCTSP.InsertParameters.Clear();
                    SqlDataSourceCTSP.InsertParameters.Add("MaSP", txtmasp.Text.Trim());
                    SqlDataSourceCTSP.InsertParameters.Add("MaSize", ddlsize.SelectedValue.Trim());
                    SqlDataSourceCTSP.InsertParameters.Add("Phantren", txtphantren.Text);
                    SqlDataSourceCTSP.InsertParameters.Add("DeNgoai",  txtdengoai.Text);
                    

                    //2.Chạy lệnh Insert để lưu thông tin mặt hàng mới vào DB
                    SqlDataSourceCTSP.Insert();
                    //3. Lưu (copy) hình vửa được nsd Upload vào thư mục ~\\Images\\ của App
                    //OFFLINE
                    
                    //Khi App này được Copy đi nơi khác => thì Update lại path này 
                    //ONLINE (khi upload lên Host, VD: somee thì phải dùng path vật lý của somee - tuy nhiên: tùy thuộc vào bảo mật của Host có thể không SaveAs... được
                    //FileUploadHinh.SaveAs("D:\\DZHosts\\LocalUser\\gtwovxthe\\www.drunkshopG506vxthe.somee.com\\" + FileUploadHinh.FileName.Trim());
                }
                catch (System.Exception ex) { this.Title = "CÓ LỖI = " + ex.Message; }

                //Tải thông tin MH mới thêm lên GridView trên Web
                GridView1.DataBind();
                //Đối nhãn nút "Lưu.." -> "Thêm ..."
                btnthem.Text = "Thêm mới";
            }
        }

    }
}