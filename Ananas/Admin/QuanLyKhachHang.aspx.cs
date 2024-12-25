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


            txtmakh.Visible = !txtmakh.Visible;
            txthoten.Visible = !txthoten.Visible;
            txtgioitinh.Visible = !txtgioitinh.Visible;
            txtsdt.Visible = !txtsdt.Visible;
            txtemail.Visible = !txtemail.Visible;
            txtdiachi.Visible = !txtdiachi.Visible;


            if (btnthem.Text.Trim() == "Thêm khách hàng mới")// Chuẩn bị thêm MH mới
            {//Xóa trống tất cả các TextBox để chuẩn bị cho nsd nhập thông tin món ăn mới
                txtmakh.Text = "000"; txtmakh.ToolTip = "KHÔNG ĐỂ TRỐNG MÃ KHÁCH HÀNG, KHÔNG NHẬP TRÙNG MÃ KHÁCH HÀNG ĐÃ CÓ !";
                //SV sau này phải cho mã mh này tự tăng (theo măn, quý, stt); không nên để NSD tự nhập. 
                txtmakh.Text = "";
                txthoten.Text = "";
                txtgioitinh.Text = "";
                txtsdt.Text = "";
                txtemail.Text = "";
                txtdiachi.Text = "";

                //Đổi nhãn btnThem : Thêm => Lưu
                btnthem.Text = "Lưu khách hàng mới";
            }
            else // Lưu món ăn vào DataBase 
            {
                try
                {
                    SqlDataSourceQLKH.InsertParameters.Clear();
                    SqlDataSourceQLKH.InsertParameters.Add("MaKH", txtmakh.Text.Trim());
                    SqlDataSourceQLKH.InsertParameters.Add("HoTen", txthoten.Text);
                    SqlDataSourceQLKH.InsertParameters.Add("GioiTinh", txtgioitinh.Text);
                    SqlDataSourceQLKH.InsertParameters.Add("SDT", txtsdt.Text);
                    SqlDataSourceQLKH.InsertParameters.Add("Email", txtemail.Text);
                    SqlDataSourceQLKH.InsertParameters.Add("DiaChi", txtdiachi.Text);


                    //2.Chạy lệnh Insert để lưu thông tin mặt hàng mới vào DB
                    SqlDataSourceQLKH.Insert();
                    //3. Lưu (copy) hình vửa được nsd Upload vào thư mục ~\\Images\\ của App
                    //OFFLINE

                    //Khi App này được Copy đi nơi khác => thì Update lại path này 
                    //ONLINE (khi upload lên Host, VD: somee thì phải dùng path vật lý của somee - tuy nhiên: tùy thuộc vào bảo mật của Host có thể không SaveAs... được
                    //FileUploadHinh.SaveAs("D:\\DZHosts\\LocalUser\\gtwovxthe\\www.drunkshopG506vxthe.somee.com\\" + FileUploadHinh.FileName.Trim());
                }
                catch (System.Exception ex) { this.Title = "CÓ LỖI THÊM KHÁCH HÀNG MỚI = " + ex.Message; }

                //Tải thông tin MH mới thêm lên GridView trên Web
                GridViewKhachHang.DataBind();
                //Đối nhãn nút "Lưu.." -> "Thêm ..."
                btnthem.Text = "Thêm khách hàng mới";
            }
        }

    }
}