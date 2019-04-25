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
        string file = Function.SaveFile(Request.Files["cv"]);
        string foto = Function.SaveFile(Request.Files["foto"]);
        if (string.IsNullOrWhiteSpace(file)) { file = new Function().DataTable("select ozgecmis from kullanicilar where id=" + kullaniciid).Rows[0][0].ToString(); }
        if (string.IsNullOrWhiteSpace(foto)) { foto = new Function().DataTable("select pfoto from kullanicilar where id=" + kullaniciid).Rows[0][0].ToString(); }

        new Function().ExecuteSqlCommand($"UPDATE kullanicilar SET kullanici_adi = '{Request.Form["user_name"].Trim()}',sifre = '{Request.Form["password"].Trim()}', ad_soyad = '{Request.Form["name"].Trim()}', email='{Request.Form["email"].Trim()}', ozgecmis='{file}',pfoto='{foto}' where id= " + kullaniciid + ";");
        mesaj = ("Hesabınız Güncellenmiştir!");
        //Response.Redirect("AccountSettings.aspx");
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
        <div class="ro">
            <div class="col-12 d-flex no-block align-items-center">
                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">Anasayfa</li>
                            <li class="breadcrumb-item active" aria-current="page">Hesap Ayarlarım</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <%System.Data.DataTable dt = new Function().DataTable("select * from kullanicilar where id=" + kullaniciid); %>
        <form class="form-horizontal" method="post" enctype="multipart/form-data">
            <div class="card-body" style="margin-left:10%;margin-right:10%">
                
                 <h3>   <label class="col-md-5 text-left control-label col-form-label" style="margin-left:27%;margin-right:40%">Hesap Ayarlarım</label></h3>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label" style="margin-right:25px;">Kullanıcı Adı</label>
                    <div class="col-sm-7">
                        <input type="text" name="user" style="opacity: 0; position: absolute; z-index: -100;" />
                        <input type="password" style="opacity: 0; position: absolute; z-index: -100;" />
                        <input type="text" class="form-control" value="<%=dt.Rows[0]["kullanici_adi"].ToString() %>" name="user_name" placeholder="" autocomplete="off" required="required" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label" style="margin-right:73px;">Şifre</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" value="<%=dt.Rows[0]["sifre"].ToString() %>" name="password" placeholder="" autocomplete="off" required="required" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label"style="margin-right:40px;">Ad Soyad </label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" value="<%=dt.Rows[0]["ad_soyad"].ToString() %>" name="name" placeholder="" required="required" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label"style="margin-right:67px;">Email </label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" value="<%=dt.Rows[0]["email"].ToString() %>" name="email" placeholder="" required="required" autocomplete="off"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label"style="margin-right:83px;">CV</label>
                    <div class="col-sm-7">
                        <div class="custom-file">
                            <input type="file" name="cv" class="custom-file-input" id="cvInput" />
                            <label class="custom-file-label" for="cvInput">Dosya Seç</label>
                            <div class="invalid-feedback">Example invalid custom file feedback</div>
                        </div>
                    </div>
                    <div style="margin-top: 7px; color: darkviolet">
                        <%if (!string.IsNullOrWhiteSpace(dt.Rows[0]["ozgecmis"].ToString()))
                            { %>
                        <span><a href="<%=dt.Rows[0]["ozgecmis"].ToString() %>">Cv'yi İndir</a></span>
                        <%} %>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-1.7 text-left control-label col-form-label"style="margin-right:8px;">Profil Fotoğrafı</label>
                    <div class="col-sm-7">
                        <div class="custom-file">
                            <input type="file" id="fotoInput" name="foto" class="custom-file-input" />
                            <label class="custom-file-label" for="fotoInput">Fotoğrafı Seç</label>
                            <div class="invalid-feedback">Example invalid custom file feedback</div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="card-body">
                        <label class="col-sm-6 text-left control-label col-form-label"style="margin-left:32%;margin-right:10%;">
                            <button type="submit" class="btn btn-primary btn-lg">Güncelle</button></label>
                         <div style="clear:both">
                        </div>
                        <span style="color: darkgreen; font-size: 15px; margin-left:29%;border:hidden;"><% =mesaj %></span>
                    </div>
                </div>
                </div>
        </form>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    <script>
        $("#fotoInput").on('change', function (e)
        {
            var $label = $("#fotoInput").next('label')
            var fileName = '';

            if (e.target.value)
            {
                fileName = '' + e.target.value.split('\\').pop();
            }
            if (fileName)
            {
                $label.html(fileName);
                //$label.attr('for' , 'subButton');
            }
            else {
                $label.html("Fotoğraf Seç");
                //$label.attr('for' , 'fileInput');
            }
        });
        $("#cvInput").on('change', function (e) {
            var $label = $("#cvInput").next('label')
            var fileName = '';

            if (e.target.value) {
                fileName = '' + e.target.value.split('\\').pop();
            }
            if (fileName) {
                $label.html(fileName);
                //$label.attr('for' , 'subButton');
            }
            else {
                $label.html("CV Seç");
                //$label.attr('for' , 'fileInput');
            }
        });
    </script>
</body>
</html>
