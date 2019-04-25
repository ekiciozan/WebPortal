<%@ Page Language="C#" %>

<%
    HttpCookie kullaniciCookie;
    kullaniciCookie = Request.Cookies["id"];
    if (kullaniciCookie == null)
    {
        Response.Redirect("login.aspx");
    }
    var kullaniciid = Request.Cookies["id"].Value;
%>
<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>--%>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    <title>Matrix Template - The Ultimate Multipurpose admin template</title>
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="../../assets/extra-libs/multicheck/multicheck.css">
    <link href="../../assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

</head>
<body>
    <div class="page-breadcrumb">
        <div class="row">
            <div class="col-12 d-flex no-block align-items-center">

                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">Anasayfa</li>
                            <li class="breadcrumb-item active" aria-current="page"><%=Function.SifreyiCoz(Request.QueryString["title"]) %></li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="main-wrapper" style="margin-left:20px; margin-right:20px;" >
        <div class="main-wrapper">
            <div class="col-12">
                <%System.Data.DataTable dt = new Function().DataTable(Function.SifreyiCoz(Request.QueryString["sq"])); %>
                <%System.Data.DataTable dtM = new Function().DataTable("Select yetki from kullanicilar where id=" + kullaniciid); %>
                <%--<%System.Data.DataTable dtE = new Function().DataTable("Select * from kullanicilar where id=" + Request.QueryString[]); %>--%>
                <div class="main-wrapper">
                    <div class="main-wrapper">
                        <div style="margin-left: 10px;">
                            <h3 class="card-title"><%=Function.SifreyiCoz(Request.QueryString["title"]) %></h3>
                        </div>
                        <div class="table-responsive">
                            <table id="zero_config" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <%for (int i = 0; i < dt.Columns.Count; i++)
                                            {%>
                                        <th><%=dt.Columns[i] %></th>
                                        <% } %>
                                        <%if (dtM.Rows[0][0].ToString() == "1")
                                            { %>

                                        <th>İşlemler</th>

                                        <%}%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < dt.Rows.Count; i++)
                                        {%>
                                    <tr>
                                        <%for (int j = 0; j < dt.Columns.Count; j++)
                                            {%>
                                        <td><%=dt.Rows[i][j] %></td>
                                        <%} %>
                                        <%if (dtM.Rows[0][0].ToString() == "1")
                                            {  %>

                                        <td>
                                            <button onclick="if (confirm('Veriyi Silmek istiyor musunuz?')) {location.href = 'process.aspx?p=delete&table=<%=Function.SifreyiCoz(Request.QueryString["tb"]) %>&id=<%=dt.Rows[i][0] %>';  } else { }       " class=" btn btn-danger"><span class="fas fa-trash"></span></button>
                                            <a href="CalisanDuzenle.aspx?id=<%=dt.Rows[i][0] %>">
                                                <button class=" btn btn-primary"><span class="fas fa-edit"></span></button>
                                            </a>
                                        </td>
                                        <%} %>
                                    </tr>
                                    <%} %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<%--      <footer class="footer text-center">
                All Rights Reserved by Matrix-admin. Designed and Developed by <a href="https://wrappixel.com">WrapPixel</a>.
            </footer>--%>
    <script src="../../assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../../assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="../../assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="../../assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="../../assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="../../dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="../../dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="../../dist/js/custom.min.js"></script>
    <!-- this page js -->
    <script src="../../assets/extra-libs/multicheck/datatable-checkbox-init.js"></script>
    <script src="../../assets/extra-libs/multicheck/jquery.multicheck.js"></script>
    <script src="../../assets/extra-libs/DataTables/datatables.min.js"></script>

    <script>
        /****************************************
         *       Basic Table                   *
         ****************************************/
        $('#zero_config').DataTable({
            responsive: true,
 
        });
        </script>

</body>
</html>
