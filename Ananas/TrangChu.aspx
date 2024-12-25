<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="Ananas.TrangChu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <head>
    <title></title>
    <style>
        .banner_form{
            display:flex;
            /*sắp xếp các items hàng ngang*/
            align-items:center;
            padding: 0 25px;
           
        }

        .banner_form > div{
            padding: 0 50px; 

        }

        .banner_form img{
            width:100%;
            height:70%;
        }
        .myFooter {
            display: flex;
            background-color: #4C4C4C;
            color: white;
            font-size: 13px;
            font-family: Arial;
            padding: 25px 0;
          
        }
        .myFooter img {
            width:100%
        }
        .myFooter > div{
            padding: 0 25px;
        }

    </style>
</head>
<body>
     <div> <img src="Hinh/Web1920-1.jpeg" alt="Banner chính" style="width: 100%; margin-top: 0px" /><br /> <br /> <br /></div>
 <section>
    <div class="banner_form">
        <div class="banner_form_left" style="width: 50%">
            <img src="Hinh/bannerPhu1.jpg" />
            <h2>ALL BLACK IN BLACK</h2>
            <p>Mặc dù được ứng dụng rất nhiều, nhưng sắc đen lúc nào cũng toát lên một vẻ huyền bí không nhàm chán</p>
        </div>
        <div class="banner_form_right" style="width: 50%">
            <img src="Hinh/BannerPhu2.jpg" />
            <h2>OUTLET SALE</h2>
            <p>Danh mục những  sản phẩm bán tại "giá tốt hơn" chỉ được bán kênh online - Online Only, chúng đã từng làm mưa làm gió một thời gian và hiện đang rơi vào tình trạng bể size, bể số.</p>
        </div>
        
    </div>
</section>


</body>
</asp:Content>

