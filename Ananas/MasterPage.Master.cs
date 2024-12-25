using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Ananas
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        //Trong này truy vẫn tên người dùng
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserName"] != null)
            {
                string userName = Session["UserName"].ToString();

                // Display the welcome message and show the logout link
                welcomeMessage.InnerText = $"Xin chào {userName}!";
                welcomeSection.Visible = true;  // Show welcome section

                // Optionally, hide the login link if the user is logged in
                loginLink.Visible = false;
            }
            else
            {
                welcomeSection.Visible = false;  // Hide welcome section
                loginLink.Visible = true;        // Show login link if not logged in
            }
        }
       
    }
}