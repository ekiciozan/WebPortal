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
<%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>--%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
<title>Görevlerim</title>
<!-- Custom CSS -->
<%-- <link rel="stylesheet" type="text/css" href="../../assets/extra-libs/multicheck/multicheck.css">
    <link href="../../assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">
    <link href="../../dist/css/style.min.css" rel="stylesheet">--%>


<link rel="stylesheet" type="text/css" href="../../assets/libs/select2/dist/css/select2.min.css">
<link rel="stylesheet" type="text/css" href="../../assets/libs/jquery-minicolors/jquery.minicolors.css">
<link rel="stylesheet" type="text/css" href="../../assets/libs/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
<link rel="stylesheet" type="text/css" href="../../assets/libs/quill/dist/quill.snow.css">
<link href="../../dist/css/style.min.css" rel="stylesheet">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        
<![endif]-->
<body>

    <div class="card">
        <%System.Data.DataTable dt = new Function().DataTable("select id,gorevADi,gorevAciklamasi,gorevDosyasi,bTarihi,tTarihi from gorevler where id=" + Request.QueryString["gorevId"]); %>
        <%--          <%System.Data.DataTable dtd = new Function().DataTable("select * from gorevler where id=" + kullaniciid); %>--%>
    </div>


    <div class="col-md-4" >
        <div class="card" style="background-color: whitesmoke">
            <div class="card-body">

                <div>
                    <h5 style="text-decoration:underline;">Görev Adı</h5>
                    <%=dt.Rows[0]["gorevAdi"].ToString() %>
                </div>
                <div style="margin-top: 20px;">
                    <h5 style="text-decoration:underline;">Görevlendirilen Kişiler</h5>
                    <%System.Data.DataTable ktb = new Function().DataTable("select uid from gorevler where gorevKimligi='" + new Function().DataTable("select gorevKimligi from gorevler where id=" + Request.QueryString["gorevId"]).Rows[0][0] + "'"); %>
                    <% for (int i = 0; i < ktb.Rows.Count; i++)
                        { %>
                    <p><% =new Function().DataTable("select ad_soyad from kullanicilar where id="+ktb.Rows[i][0]).Rows[0][0]%></p>
                    <%  }%>
                </div>
                <div>
                    <h5 style="text-decoration:underline;">Görev Başlangıç Tarihi</h5>
                </div>
                <div>
                    <p><%=dt.Rows[0]["bTarihi"].ToString() %></p>
                </div>
                <div>
                    <h5 style="text-decoration:underline;">Görev Teslim Tarihi</h5>
                </div>
                <div>
                       <p><%=dt.Rows[0]["tTarihi"].ToString() %> </p> 
                </div>
                <div>
                    <%if (!string.IsNullOrWhiteSpace(dt.Rows[0]["gorevDosyasi"].ToString()))
                        { %>
                    <h5 style="text-decoration:underline;">Görev Dosyası</h5>
                    <span><p><a href="<%=dt.Rows[0]["gorevDosyasi"].ToString() %>" target="_blank" style="text-decoration: underline;">Dosyayı Görüntüle</a></p></span>
                    <%} %>
                </div>
                <h5 style="text-decoration:underline;">Görev Açıklaması</h5>
            </div>
            <div id="editor2" style="height: 300px;">
                <%=dt.Rows[0]["gorevAciklamasi"].ToString() %>
            </div>


        </div>
    </div>


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
    <!-- This Page JS -->
    <script src="../../assets/libs/inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
    <script src="../../dist/js/pages/mask/mask.init.js"></script>
    <script src="../../assets/libs/select2/dist/js/select2.full.min.js"></script>
    <script src="../../assets/libs/select2/dist/js/select2.min.js"></script>
    <script src="../../assets/libs/jquery-asColor/dist/jquery-asColor.min.js"></script>
    <script src="../../assets/libs/jquery-asGradient/dist/jquery-asGradient.js"></script>
    <script src="../../assets/libs/jquery-asColorPicker/dist/jquery-asColorPicker.min.js"></script>
    <script src="../../assets/libs/jquery-minicolors/jquery.minicolors.min.js"></script>
    <script src="../../assets/libs/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <script src="../../assets/libs/quill/dist/quill.min.js"></script>
    <script>

        // jQuery('.mydatepicker').datepicker();
        jQuery('#datepicker-autoclose').datepicker({
            autoclose: true,
            todayHighlight: true,
            //  dateFormat: 'FULL-DD, d MM,yy',
        });

        jQuery('#datepicker-autoclose2').datepicker({
            autoclose: true,
            todayHighlight: true
        });
        $(".select2").select2();
        var quill = new Quill('#editor', {
            theme: 'snow'
        });
        $(".select2").select2();
        var quill = new Quill('#editor2', {
            theme: 'snow'
        });
             
    </script>
</body>
</html>
