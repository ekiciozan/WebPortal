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

<%string hata = "";
    string mesaj = "";
    if (!string.IsNullOrWhiteSpace(Request.Form["user_name"]))
    {
        new Function().ExecuteSqlCommand($"insert into kullanicilar (kullanici_adi,sifre,ad_soyad,email,ekip,pozisyon,yetki) values ('{Request.Form["user_name"].Trim()}','{Request.Form["password"].Trim()}','{Request.Form["name"].Trim()}','{Request.Form["email"].Trim()}','{Request.Form["ekip"].Trim()}','{Request.Form["position"].Trim()}','{Request.Form["yetki"].Trim()}')");
        mesaj = "Kayıt Başarı ile Gerçekleşmiştir.";
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
    <title>Çalışan Bilgileri</title>
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
                            <li class="breadcrumb-item"><span>Anasayfa</span></li>
                            <li class="breadcrumb-item active" aria-current="page">Çalışan Ekle</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="card"style="margin-left:10%;margin-right:10%">
        <form class="form-horizontal" method="post">
            <div class="card-body">                
                 <h3><label class="col-md-5 text-left control-label col-form-label" style="margin-left:27%;margin-right:40%">Çalışan Ekle</label></h3>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label" style="margin-right:25px;">Kullanıcı Adı</label>
                    <div class="col-sm-7">
                        <input type="text" name="user" style="opacity: 0; position: absolute; z-index: -100;" />
                        <input type="password" style="opacity: 0; position: absolute; z-index: -100;" />
                        <input type="text" class="form-control" value="" name="user_name" placeholder="" autocomplete="off" required="required" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label" style="margin-right:73px;">Şifre </label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" name="password" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label" style="margin-right:41px;">Ad Soyad </label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" name="name" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label" style="margin-right:68px;">Email</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" name="email" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label" style="margin-right:75px;">Ekip</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" name="ekip" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label" style="margin-right:45px;">Pozisyon</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" name="position" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label" style="margin-right:70px;">Yetki</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" name="yetki" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <div class="card-body">
                        <label class="col-sm-6 text-left control-label col-form-label">
                            <button type="submit" class="btn btn-success btn-lg waves-effect" style="margin-left:60%;margin-right:10%; ">Kaydet</button></label>
                        <div style="clear: both">
                        </div>
                        <span style="color: darkgreen; font-size: 15px;margin-left:24%; border:none;"><% =mesaj %></span>
                    </div>
                </div>
              </div>
        </form>

    </div>
</body>
</html>
