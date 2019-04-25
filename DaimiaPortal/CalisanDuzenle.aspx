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
<%System.Data.DataTable dt = new Function().DataTable("select * from kullanicilar where id=" + Request.QueryString["id"]); %>
<%string hata = "";
    string mesaj = "";

    if (!string.IsNullOrWhiteSpace(Request.Form["name"]))
    {
        new Function().ExecuteSqlCommand($"UPDATE kullanicilar SET  ad_soyad = '{Request.Form["name"].Trim()}', email='{Request.Form["email"].Trim()}', ekip='{Request.Form["ekip"].Trim()}', pozisyon='{Request.Form["position"].Trim()}', yetki='{Request.Form["yetki"].Trim()}'where id= " + Request.QueryString["id"] + ";");
        mesaj = "Güncelleme Gerçekleşmiştir!";

    } %>


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
    <title>Çalışan Bilgilerini Düzenle</title>
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
        <div class="ro">
            <div class="col-12 d-flex no-block align-items-center">

                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><span>Anasayfa</span></li>
                            <li class="breadcrumb-item active" aria-current="page">Çalışan Bilgilerini Düzenle</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <form class="form-horizontal" method="post">
            <div class="card-body">
                <h3>
                    <label class="col-sm-6 text-right control-label col-form-label" style="margin-left: 80px;">Çalışan Bilgilerini Düzenle</label></h3>
                <div class="form-group row">
                    <label class="col-sm-2 text-right control-label col-form-label">Ad Soyad </label>
                    <div class="col-sm-7">
                        <input type="text" value="<%=dt.Rows[0]["ad_soyad"] %>" class="form-control" name="name" placeholder="" id="as" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 text-right control-label col-form-label">Email</label>
                    <div class="col-sm-7">
                        <input type="text" value="<%=dt.Rows[0]["email"] %>" class="form-control" name="email" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 text-right control-label col-form-label">Ekip</label>
                    <div class="col-sm-7">
                        <input type="text" value="<%=dt.Rows[0]["ekip"] %>" class="form-control" name="ekip" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 text-right control-label col-form-label">Pozisyon</label>
                    <div class="col-sm-7">
                        <input type="text" value="<%=dt.Rows[0]["pozisyon"] %>" class="form-control" name="position" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 text-right control-label col-form-label">Yetki</label>
                    <div class="col-sm-7">
                        <input type="text" value="<%=dt.Rows[0]["yetki"] %>" class="form-control" name="yetki" placeholder="" required="required" />
                    </div>
                </div>
                <div class="form-group row">
                    <div class="card-body">
                        <label class="col-sm-6 text-right control-label col-form-label">
                            <button type="submit" class="btn btn-primary btn-lg waves-effect">Güncelle</button></label>
                        <div style="clear: both">
                        </div>
                        <span style="color: darkgreen; font-size: 15px; margin-left: 452px;"><% =mesaj %></span>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
