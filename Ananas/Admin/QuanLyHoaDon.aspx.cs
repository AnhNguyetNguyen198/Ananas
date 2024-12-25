using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class QuanLyHoaDon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceQLHD.SelectCommand = "SELECT * FROM [HoaDon]";
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            lblmahd.Visible = !lblmahd.Visible;
            lbltongtien.Visible = !lbltongtien.Visible;
            lblngaytao.Visible = !lblngaytao.Visible;
            lblngaygiao.Visible = !lblngaygiao.Visible;
            lblpttt.Visible = !lblpttt.Visible;
            lblptgh.Visible = !lblptgh.Visible;


            txtmahd.Visible = !txtmahd.Visible;
            txttongtien.Visible = !txttongtien.Visible;
            txtngaytao.Visible = !txtngaytao.Visible;
            txtngaygiao.Visible = !txtngaygiao.Visible;
            txtpttt.Visible = !txtpttt.Visible;
            txtptgh.Visible = !txtptgh.Visible;


            if (btnthem.Text.Trim() == "Thêm sản phẩm mới")// Chuẩn bị thêm MH mới
            {//Xóa trống tất cả các TextBox để chuẩn bị cho nsd nhập thông tin món ăn mới
                txtmahd.Text = "000"; txtmahd.ToolTip = "KHÔNG ĐỂ TRỐNG MÃ HÓA ĐƠN, KHÔNG NHẬP TRÙNG MÃ HÓA ĐƠN ĐÃ CÓ !";
                //SV sau này phải cho mã mh này tự tăng (theo măn, quý, stt); không nên để NSD tự nhập. 
                txtmahd.Text = "";
                txttongtien.Text = "1"; txttongtien.ToolTip = "giá phải >0";
                txtngaytao.Text = "";
                txtngaygiao.Text = "";
                txtpttt.Text = "";
                txtptgh.Text = "";
                //Đổi nhãn btnThem : Thêm => Lưu
                btnthem.Text = "Lưu hóa đơn mới";
            }
            else // Lưu món ăn vào DataBase 
            {
                try
                {
                    //1.Đinh nghĩa các tham số parameters cho Insertcommnand : tham số cho field hinh có dạng ~\\Images\\Tên file hình được upload.filename
                    SqlDataSourceQLHD.InsertParameters.Clear();
                    SqlDataSourceQLHD.InsertParameters.Add("MaHD", txtmahd.Text.Trim());
                    SqlDataSourceQLHD.InsertParameters.Add("MaKH", txtmakh.Text.Trim());
                    SqlDataSourceQLHD.InsertParameters.Add("MaNV", txtmanv.Text.Trim());
                    SqlDataSourceQLHD.InsertParameters.Add("TongTien", System.Data.DbType.Double, txttongtien.Text.Trim());
                    SqlDataSourceQLHD.InsertParameters.Add("NgayTao", System.Data.DbType.Date, txtngaytao.Text.Trim());
                    SqlDataSourceQLHD.InsertParameters.Add("NgayGiaoHang", System.Data.DbType.Date, txtngaygiao.Text.Trim());
                    SqlDataSourceQLHD.InsertParameters.Add("PTTT", txtpttt.Text);
                    SqlDataSourceQLHD.InsertParameters.Add("PTGH", txtptgh.Text);


                    //2.Chạy lệnh Insert để lưu thông tin mặt hàng mới vào DB
                    SqlDataSourceQLHD.Insert();
                    //3. Lưu (copy) hình vửa được nsd Upload vào thư mục ~\\Images\\ của App
                    //OFFLINE

                    //Khi App này được Copy đi nơi khác => thì Update lại path này 
                    //ONLINE (khi upload lên Host, VD: somee thì phải dùng path vật lý của somee - tuy nhiên: tùy thuộc vào bảo mật của Host có thể không SaveAs... được
                    //FileUploadHinh.SaveAs("D:\\DZHosts\\LocalUser\\gtwovxthe\\www.drunkshopG506vxthe.somee.com\\" + FileUploadHinh.FileName.Trim());
                }
                catch (System.Exception ex) { this.Title = "CÓ LỖI THÊM MÓN ĂN MỚI = " + ex.Message; }

                //Tải thông tin MH mới thêm lên GridView trên Web
                GridViewHoaDon.DataBind();
                //Đối nhãn nút "Lưu.." -> "Thêm ..."
                btnthem.Text = "Thêm sản phẩm mới";
            }
        }
    }
}