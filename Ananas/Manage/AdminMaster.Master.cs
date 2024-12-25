using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas.Manage
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string GetActiveClass(string pageName)
        {
            string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            return currentPage.Equals(pageName, StringComparison.OrdinalIgnoreCase) ? "active" : "";
        }
        //protected void btnSearch_Click(object sender, EventArgs e)
        //{
        //    string keyword = txtSearch.Text.Trim();

        //    // Kiểm tra từ trang hiện tại và thực hiện tìm kiếm tương ứng
        //    string currentPage = Path.GetFileName(Request.Path);
        //    switch (currentPage)
        //    {
        //        case "User.aspx":
        //            ((User)Page).Search(keyword); // Gọi hàm tìm kiếm trong User.aspx
        //            break;
        //        case "Product.aspx":
        //            ((Product)Page).Search(keyword); // Gọi hàm tìm kiếm trong Product.aspx
        //            break;
        //        case "Promotions.aspx":
        //            ((Promotions)this.Page).Search(keyword);
        //            break;

        //        case "Order.aspx":
        //            ((Order)this.Page).Search(keyword);
        //            break;
        //        // Thêm các trang khác nếu cần
        //        default:
        //            ScriptManager.RegisterStartupScript(this, this.GetType(), "showAlert", "alert('Tìm kiếm không khả dụng trên trang này.');", true);
        //            break;
        //    }
        //}

    }
}