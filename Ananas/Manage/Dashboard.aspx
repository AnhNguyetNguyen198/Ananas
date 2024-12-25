<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Ananas.Manage.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <!-- Bootstrap and Custom CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <div class="container mt-5">
            <!-- Header -->
            <h1 class="text-center mb-4">Tổng Quan Hoạt Động</h1>

            <!-- Summary Cards -->
            <div class="row">
                <div class="col-md-3">
                    <div class="card bg-info text-white text-center">
                        <div class="card-body">
                            <h6>Tổng Doanh Thu</h6>
                            <h4><asp:Label ID="lblTotalRevenue" runat="server" Text="0"></asp:Label></h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-success text-white text-center">
                        <div class="card-body">
                            <h6>Tổng Đơn Hàng</h6>
                            <h4><asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label></h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-warning text-white text-center">
                        <div class="card-body">
                            <h6>Khách Hàng Đã Đăng Ký</h6>
                            <h4><asp:Label ID="lblTotalCustomers" runat="server" Text="0"></asp:Label></h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-danger text-white text-center">
                        <div class="card-body">
                            <h6>Sản Phẩm Còn Hàng</h6>
                            <h4><asp:Label ID="lblInStockProducts" runat="server" Text="0"></asp:Label></h4>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Revenue Chart -->
            <div class="row mt-5">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <h5>Biểu Đồ Doanh Thu Theo Tháng</h5>
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <h6>Danh Sách Sản Phẩm</h6>
                            <a href="Product.aspx" class="btn btn-primary btn-sm">Truy cập</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <h6>Danh Sách Đơn Hàng</h6>
                            <a href="Order.aspx" class="btn btn-primary btn-sm">Truy cập</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <h6>Danh Sách Khuyến Mãi</h6>
                            <a href="Promotions.aspx" class="btn btn-primary btn-sm">Truy cập</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Notifications -->
            <div class="row mt-5">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <h5>Thông Báo</h5>
                            <div class="alert alert-warning">
                                <strong>Thông Báo:</strong> Có <b>5 sản phẩm</b> sắp hết hàng.
                            </div>
                            <div class="alert alert-info">
                                <strong>Yêu Cầu Phê Duyệt:</strong> Có <b>3 tài khoản</b> chờ xử lý.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


<!-- Include Google Charts Script -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', { 'packages': ['corechart'] });
    google.charts.setOnLoadCallback(drawRevenueChart);

    function drawRevenueChart() {
        var labels = <%= Newtonsoft.Json.JsonConvert.SerializeObject(ChartLabels) %>;
        var dataPoints = <%= Newtonsoft.Json.JsonConvert.SerializeObject(ChartDataArray) %>;

        if (labels.length === 0 || dataPoints.length === 0 || labels[0] === "No Data") {
            document.getElementById("revenueChart").outerHTML = "<div class='text-center text-muted mt-4'>Không có dữ liệu doanh thu để hiển thị.</div>";
            return;
        }

        var data = google.visualization.arrayToDataTable([
            ['Tháng', 'Doanh Thu (VND)'],
            ...labels.map((label, i) => [label, dataPoints[i]])
        ]);

        var options = {
            title: 'Doanh Thu Theo Tháng',
            hAxis: { title: 'Tháng', titleTextStyle: { color: '#333' } },
            vAxis: { minValue: 0 },
            chartArea: { width: '80%', height: '70%' },
            colors: ['#76A7FA']
        };

        var chart = new google.visualization.AreaChart(document.getElementById('revenueChart'));
        chart.draw(data, options);
    }
</script>
        

    </form>
</asp:Content>
