<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="Ananas.Manage.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Báo Cáo Thống Kê
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <style>

        </style>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <div class="container mt-5">
    <!-- Tiêu đề -->
    <h1 class="text-center my-4">Báo Cáo Thống Kê</h1>
        <!-- Tổng quan -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-info text-white">
                    <div class="card-body">
                        <h5 class="card-title">Tổng Doanh Thu</h5>
                        <h3>
                            <asp:Label ID="lblTotalRevenue" runat="server"></asp:Label>
                            VND</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <h5 class="card-title">Tổng Đơn Hàng</h5>
                        <h3>
                            <asp:Label ID="lblTotalOrders" runat="server"></asp:Label></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <h5 class="card-title">Sản Phẩm Còn Hàng</h5>
                        <h3>
                            <asp:Label ID="lblInStockProducts" runat="server"></asp:Label></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-danger text-white">
                    <div class="card-body">
                        <h5 class="card-title">Đơn Hàng Đã Hủy</h5>
                        <h3>
                            <asp:Label ID="lblCanceledOrders" runat="server"></asp:Label></h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Biểu đồ Doanh Thu Theo Tháng -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Doanh Thu Theo Tháng</h5>
                        <canvas id="chartRevenue"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Top Sản Phẩm Bán Chạy -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Top Sản Phẩm Bán Chạy</h5>
                        <asp:Button ID="btnExportTopProducts" runat="server" Text="Xuất Báo Cáo PDF" CssClass="btn btn-primary mb-3" OnClick="ExportTopProductsToPDF" />
                        <asp:GridView ID="GridViewTopProducts" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="TenSanPham" HeaderText="Tên Sản Phẩm" />
                                <asp:BoundField DataField="TongSoLuong" HeaderText="Số Lượng Bán" />
                                <asp:BoundField DataField="TongDoanhThu" HeaderText="Doanh Thu (VND)" DataFormatString="{0:N0}" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnViewDetails" runat="server" Text="Xem Chi Tiết" CommandName="ViewDetails" CommandArgument='<%# Eval("TenSanPham") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </div>
                </div>
            </div>
        </div>


        <!-- Doanh Thu Theo Sản Phẩm -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h5>Doanh Thu Theo Sản Phẩm</h5>
                        <asp:Button ID="btnExportRevenueByProduct" runat="server" Text="Xuất Báo Cáo PDF" CssClass="btn btn-primary mb-3" OnClick="ExportRevenueByProductToPDF" />
                        <asp:GridView ID="GridViewRevenueByProduct" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="TenSanPham" HeaderText="Tên Sản Phẩm" />
                                <asp:BoundField DataField="TongSoLuongBan" HeaderText="Số Lượng Bán" />
                                <asp:BoundField DataField="TongDoanhThu" HeaderText="Doanh Thu (VND)" DataFormatString="{0:N0}" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
        <!-- Tỷ Lệ Tăng Trưởng Doanh Thu -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h5>Tỷ Lệ Tăng Trưởng Doanh Thu</h5>
                        <asp:Button ID="btnExportRevenueGrowth" runat="server" Text="Xuất Báo Cáo PDF" CssClass="btn btn-primary mb-3" OnClick="ExportRevenueGrowthToPDF" />
                        <asp:GridView ID="GridViewRevenueGrowth" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Nam" HeaderText="Năm" />
                                <asp:BoundField DataField="Thang" HeaderText="Tháng" />
                                <asp:BoundField DataField="DoanhThu" HeaderText="Doanh Thu (VND)" DataFormatString="{0:N0}" />
                                <asp:BoundField DataField="DoanhThuThangTruoc" HeaderText="Doanh Thu Tháng Trước (VND)" DataFormatString="{0:N0}" />
                                <asp:BoundField DataField="TyLeTangTruong" HeaderText="Tỷ Lệ Tăng Trưởng (%)" DataFormatString="{0:N2}" />
                            </Columns>
                        </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <script>
                // JavaScript code to render Chart.js chart
                const ctx = document.getElementById('chartRevenue').getContext('2d');
                const chartRevenue = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: <%= ChartLabels %>, // Example: ['Tháng 1', 'Tháng 2', 'Tháng 3']
                    datasets: [{
                        label: 'Doanh Thu (VND)',
                        data: <%= ChartData %>, // Example: [1000000, 2000000, 3000000]
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </form>
</asp:Content>
