using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using Microsoft.SqlServer.Types;
namespace Ananas
{
    public partial class BaoCaoDoanhThu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Lấy dữ liệu từ SqlDataSource
                DataView dv = (DataView)DoanhThuDataSource.Select(DataSourceSelectArguments.Empty);
                DataTable dt = dv.ToTable();

                // In dữ liệu ra Console để kiểm tra
                foreach (DataRow row in dt.Rows)
                {
                    Console.WriteLine($"{row["MAHD"]}, {row["TENSP"]}, {row["NGAYTAOHD"]}, {row["SOLUONG"]}, {row["DONGIA"]}, {row["ThanhTien"]}");
                }

                // Cấu hình ReportViewer
                ReportViewer1.ProcessingMode = ProcessingMode.Local;
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/BaoCao/BaoCaoDoanhThu.rdlc");
                ReportViewer1.LocalReport.DataSources.Clear();

                // Lấy dữ liệu từ SqlDataSource và thêm vào LocalReport
                ReportDataSource rds = new ReportDataSource("DataSet2", dt);
                ReportViewer1.LocalReport.DataSources.Add(rds);

                // Cập nhật báo cáo
                ReportViewer1.LocalReport.Refresh();
            }
        }
    }
    }
