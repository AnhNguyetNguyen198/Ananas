using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ananas
{
    public partial class TrangChuAdmin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        //    // Add the following line to register the JavaScript function
        //    ClientScript.RegisterStartupScript(this.GetType(), "AccessDeniedPopup",
        //        "function showAccessDeniedPopup() { alert('Bạn không có quyền truy cập trang này'); }", true);
        }

        protected void CheckUserAccess(object sender, EventArgs e)
        {
            var userRole = Session["UserRole"] as string;
            if (userRole == null || !(userRole.Equals("admin") || userRole.Equals("employee")))
            {
                // Display the pop-up if the user does not have access rights
                ClientScript.RegisterStartupScript(this.GetType(), "AccessDenied", "showAccessDeniedPopup();", true);
            }
            else
            {
                // Redirect to the target page if the user has access rights
                var linkButton = sender as LinkButton;
                if (linkButton != null)
                {
                    Response.Redirect(linkButton.CommandArgument);
                }
            }
        }
        
    }
}
