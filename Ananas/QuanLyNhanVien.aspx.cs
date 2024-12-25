using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLyNhanVien : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceNhanVien.SelectCommand = "SELECT * FROM [NhanVien]";//viết lại lệnh Select
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            lblmanv.Visible = !lblmanv.Visible;
            lblhoten.Visible = !lblhoten.Visible;
            lblgioitinh.Visible = !lblgioitinh.Visible;
            lblngaysinh.Visible = !lblngaysinh.Visible;
            lblsdt.Visible = !lblsdt.Visible;
            lblemail.Visible = !lblemail.Visible;
            lbldiachi.Visible = !lbldiachi.Visible;


            txtmanv.Visible = !txtmanv.Visible;
            txthoten.Visible = !txthoten.Visible;
            txtgioitinh.Visible = !txtgioitinh.Visible;
            txtngaysinh.Visible = !txtngaysinh.Visible;
            txtsdt.Visible = !txtsdt.Visible;
            txtemail.Visible = !txtemail.Visible;
            txtdiachi.Visible = !txtdiachi.Visible;


            if (btnthem.Text.Trim() == "Thêm nhân viên mới")// Chuẩn bị thêm MH mới
            {//Xóa trống tất cả các TextBox để chuẩn bị cho nsd nhập thông tin món ăn mới
                txtmanv.Text = "000"; txtmanv.ToolTip = "KHÔNG ĐỂ TRỐNG!";
                //SV sau này phải cho mã mh này tự tăng (theo măn, quý, stt); không nên để NSD tự nhập. 
                txtmanv.Text = "";
                txthoten.Text = "";
                txtgioitinh.Text = "";
                txtsdt.Text = "";
                txtemail.Text = "";
                txtdiachi.Text = "";

                //Đổi nhãn btnThem : Thêm => Lưu
                btnthem.Text = "Lưu mới";
            }
            else // Lưu món ăn vào DataBase 
            {
                try
                {
                    SqlDataSourceNhanVien.InsertParameters.Clear();
                    SqlDataSourceNhanVien.InsertParameters.Add("MaNV", txtmanv.Text.Trim());
                    SqlDataSourceNhanVien.InsertParameters.Add("TenNV", txthoten.Text);
                    SqlDataSourceNhanVien.InsertParameters.Add("GioiTinhNV", txtgioitinh.Text);
                    SqlDataSourceNhanVien.InsertParameters.Add("NgaySinhNV", txtngaysinh.Text);
                    SqlDataSourceNhanVien.InsertParameters.Add("SDTNV", txtsdt.Text);
                    SqlDataSourceNhanVien.InsertParameters.Add("EmailNV", txtemail.Text);
                    SqlDataSourceNhanVien.InsertParameters.Add("DiaChiNV", txtdiachi.Text);


                    //2.Chạy lệnh Insert để lưu thông tin mặt hàng mới vào DB
                    SqlDataSourceNhanVien.Insert();
                    //3. Lưu (copy) hình vửa được nsd Upload vào thư mục ~\\Images\\ của App
                    //OFFLINE

                    //Khi App này được Copy đi nơi khác => thì Update lại path này 
                    //ONLINE (khi upload lên Host, VD: somee thì phải dùng path vật lý của somee - tuy nhiên: tùy thuộc vào bảo mật của Host có thể không SaveAs... được
                    //FileUploadHinh.SaveAs("D:\\DZHosts\\LocalUser\\gtwovxthe\\www.drunkshopG506vxthe.somee.com\\" + FileUploadHinh.FileName.Trim());
                }
                catch (System.Exception ex) { this.Title = "CÓ LỖI " + ex.Message; }

                //Tải thông tin MH mới thêm lên GridView trên Web
                GridViewNhanVien.DataBind();
                //Đối nhãn nút "Lưu.." -> "Thêm ..."
            }
        }

       
    }
}