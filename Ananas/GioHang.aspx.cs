using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.Map.WebForms.BingMaps;
using System.Data.SqlClient;
using System.Configuration;
using System.Diagnostics;
using System.Web.Configuration;

namespace Ananas
{
    public partial class GioHang : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Hiển thị giỏ hàng
                LoadData();
            }
        }

        private void LoadData()
        {
            DataTable dt = (DataTable)Session["GioHang"];
            if (dt != null)
            {
                GridViewCart.DataSource = dt;
                GridViewCart.DataBind();

                // Tính tổng tiền
                decimal tongTien = 0;
                foreach (DataRow row in dt.Rows)
                {
                    decimal thanhTien = Convert.ToDecimal(row["ThanhTien"]);
                    tongTien += thanhTien;
                    var giaKM = Convert.ToDecimal(row["GiaKM"]).ToString("#,##0");
                    row["GiaKM"] = giaKM;
                    row["ThanhTien"] = thanhTien.ToString("#,##0");
                }
                Session["TongTien"] = tongTien;
                lbSUM.Text = tongTien.ToString("#,##0"); // Hiển thị tổng tiền
            }
        }

        protected void GridViewCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Lấy DropDownList trong mỗi dòng
                DropDownList ddlSize = (DropDownList)e.Row.FindControl("ddlSize");

                // Kiểm tra nếu ddlSize không phải null
                if (ddlSize != null)
                {
                    // Lấy giá trị SizeID từ DataRow
                    int sizeID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "MaSize"));

                    // Chọn giá trị của DropDownList nếu nó tồn tại
                    ddlSize.SelectedValue = sizeID.ToString();
                }

                // Lấy giá trị của cột GiaSP và ThanhTien
                Label lblGiaSP = (Label)e.Row.FindControl("lblGiaSP");
                Label lblThanhTien = (Label)e.Row.FindControl("lblThanhTien");

                if (lblGiaSP != null)
                {
                    decimal giaSP = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "GiaSP"));
                    lblGiaSP.Text = string.Format("{0:N0}", giaSP);  // Định dạng giá sản phẩm với dấu phẩy
                }

                if (lblThanhTien != null)
                {
                    decimal thanhTien = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ThanhTien"));
                    lblThanhTien.Text = string.Format("{0:N0}", thanhTien);  // Định dạng thành tiền với dấu phẩy
                }
            }
        }
        protected void GridViewCart_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewCart.EditIndex = e.NewEditIndex;

            // Cập nhật lại GridView
            GridViewCart.DataSource = (DataTable)Session["GioHang"];
            GridViewCart.DataBind();
        }

        protected void GridViewCart_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridViewCart.Rows[e.RowIndex];

            var newSL = e.NewValues["SoLuong"];

            // Lấy giá trị từ DropDownList và TextBox trong chế độ chỉnh sửa
            DropDownList ddlSize = (DropDownList)row.FindControl("ddlSize");

            if (ddlSize != null && newSL != null)
            {
                // Kiểm tra các giá trị lấy từ người dùng
                int sizeID = Convert.ToInt32(ddlSize.SelectedValue);
                int soLuong = int.Parse(newSL.ToString());

                // Lấy giá từ giỏ hàng (kiểm tra xem có giá khuyến mãi không)
                decimal giaKM = Convert.ToDecimal(((DataTable)Session["GioHang"]).Rows[e.RowIndex]["GiaKM"]);

                // Kiểm tra nếu giá sản phẩm là khuyến mãi
                //decimal giaKhuyenMai = giaSP; // Giá mặc định là giá gốc
                //if (Session["GiaKhuyenMai"] != null)
                //{
                //    giaKhuyenMai = Convert.ToDecimal(Session["GiaKhuyenMai"]);
                //}

                // Tính lại thành tiền
                decimal thanhTien = giaKM * soLuong;

                // Cập nhật lại các giá trị trong DataTable
                DataTable dt = (DataTable)Session["GioHang"];
                dt.Rows[e.RowIndex]["MaSize"] = sizeID;
                dt.Rows[e.RowIndex]["SoLuong"] = soLuong;
                dt.Rows[e.RowIndex]["ThanhTien"] = thanhTien;

                // Lưu lại giỏ hàng vào Session
                Session["GioHang"] = dt;

                // Cập nhật GridView và thoát khỏi chế độ chỉnh sửa
                GridViewCart.EditIndex = -1;
                GridViewCart.DataSource = dt;
                GridViewCart.DataBind();

                // Tính lại tổng tiền và cập nhật label lbSUM
                decimal totalSum = 0;
                foreach (DataRow dr in dt.Rows)
                {
                    totalSum += Convert.ToDecimal(dr["ThanhTien"]);
                }
                Session["TongTien"] = totalSum;
                lbSUM.Text = totalSum.ToString("#,##0");
            }
        }

        // Hàm tính tổng tiền và cập nhật giỏ hàng
        private void UpdateTotalPrice(DataTable dt)
        {
            decimal totalPrice = 0;
            foreach (DataRow row in dt.Rows)
            {
                totalPrice += Convert.ToDecimal(row["ThanhTien"]);
            }
            Session["TongTien"] = totalPrice;
            // Cập nhật lại tổng tiền hiển thị trong giao diện (nếu có label lbSUM trên giao diện)
            lbSUM.Text = totalPrice.ToString("C"); // Hiển thị tổng tiền
        }

        protected void GridViewCart_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // Hủy bỏ chế độ chỉnh sửa
            GridViewCart.EditIndex = -1;

            // Cập nhật lại GridView
            GridViewCart.DataSource = (DataTable)Session["GioHang"];
            GridViewCart.DataBind();
        }

        protected void GridViewCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int rowIndex = e.RowIndex;

            // Lấy DataTable từ Session (giả sử giỏ hàng được lưu trong Session)
            DataTable dt = (DataTable)Session["GioHang"];

            // Kiểm tra nếu DataTable không null và chỉ số dòng hợp lệ
            if (dt != null && rowIndex >= 0)
            {
                // Lấy giá trị số lượng và giá sản phẩm từ dòng cần xóa (có thể lấy từ GridView hoặc DataTable)
                decimal price = Convert.ToDecimal(dt.Rows[rowIndex]["GiaSP"]);  // Giả sử có trường 'Price'
                int quantity = Convert.ToInt32(dt.Rows[rowIndex]["SoLuong"]);  // Giả sử có trường 'Quantity'

                // Xóa dòng từ DataTable
                dt.Rows.RemoveAt(rowIndex);

                // Lưu lại giỏ hàng cập nhật vào Session
                Session["GioHang"] = dt;

                // Tính lại tổng tiền
                decimal totalAmount = 0;
                foreach (DataRow row in dt.Rows)
                {
                    decimal itemPrice = Convert.ToDecimal(row["GiaSP"]);
                    int itemQuantity = Convert.ToInt32(row["SoLuong"]);
                    totalAmount += itemPrice * itemQuantity;
                }

                // Lưu tổng tiền vào Session (hoặc bạn có thể sử dụng một Label để hiển thị trên trang)
                Session["TongTien"] = totalAmount;

                // Cập nhật GridView
                GridViewCart.DataSource = dt;
                GridViewCart.DataBind();

                // Cập nhật giao diện (hiển thị tổng tiền)
                lbSUM.Text = totalAmount.ToString("#,##0");
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            // Lấy giỏ hàng từ session
            DataTable dtCart = Session["GioHang"] as DataTable;

            // Kiểm tra nếu giỏ hàng có sản phẩm
            if (dtCart != null && dtCart.Rows.Count > 0)
            {
                // Lưu giỏ hàng vào session
                Session["GioHang"] = dtCart;

                // Chuyển hướng sang trang thanh toán
                Response.Redirect("ThanhToan.aspx");
            }
            else
            {
                // Thông báo nếu giỏ hàng trống
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Giỏ hàng của bạn đang trống!');", true);
            }

        }
    }

}