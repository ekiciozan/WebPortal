<%@ Page Language="C#" ValidateRequest="false" %>

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


<%  string hata = "";
    string mesaj = "";

    if (!string.IsNullOrWhiteSpace(Request.Form["taskname"]))
    {
        new Function().ExecuteSqlCommand("DELETE from gorevler where gorevKimligi='" + Request.QueryString["Id"] + "'");
        foreach (var item in Request.Form["users"].Split(','))
        {
            //string gorevid = Function.CreateRandomIdenty();
            string file = Function.SaveFile(Request.Files["dosya"]);
            DateTime eddt = Convert.ToDateTime(Request.Form["enddate"]);
            string enddate = eddt.Year + "-" + eddt.Month + "-" + eddt.Day;
            DateTime sddt = Convert.ToDateTime(Request.Form["startdate"]);
            string startdate = sddt.Year + "-" + sddt.Month + "-" + sddt.Day;
            new Function().ExecuteSqlCommand($"INSERT INTO `gorevler` (`id`, `uId`,`gorevKimligi`,  `gorevAdi`, `gorevAciklamasi`,`gorevDosyasi`,`bTarihi`, `tTarihi`) VALUES (NULL, '{item}','{Request.QueryString["Id"]}', '{Request.Form["taskname"]}', '{Request.Form["description"]}','{file}','{startdate}','{enddate}');");

            // new Function().ExecuteSqlCommand($"UPDATE gorevler SET uId ='',gorevAdi = '{Request.Form["taskname"].Trim()}', bTarihi= '{Convert.ToDateTime(Request.Form["startdate"].ToString().Split('/')[1] + "/" + Request.Form["startdate"].ToString().Split('/')[0] + "/" + Request.Form["startdate"].ToString().Split('/')[2]).ToString("yyyy-MM-dd")}',gorevDosyasi='{file}',  tTarihi= '{Convert.ToDateTime(Request.Form["enddate"].ToString().Split('/')[1] + "/" + Request.Form["enddate"].ToString().Split('/')[0] + "/" + Request.Form["enddate"].ToString().Split('/')[2]).ToString("yyyy-MM-dd")}', gorevAciklamasi='{Request.Form["description"].Trim()}'where gorevKimligi='" + gorevid + "';");
        }

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
    <title>Aktiviteler</title>
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
</head>
<body>
    <%if (new Function().DataTable("Select yetki from kullanicilar where id=" + kullaniciid).Rows[0][0].ToString() == "1")
        {  %>
    <div class="page-breadcrumb">
        <div class="ro">
            <div class="col-12 d-flex no-block align-items-center">
                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><span>Anasayfa</span></li>
                            <li class="breadcrumb-item active" aria-current="page">Görev Düzenle</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <%System.Data.DataTable dt = new Function().DataTable("select id,gorevAdi,gorevAciklamasi,gorevDosyasi,bTarihi,tTarihi from gorevler where gorevKimligi='" + Request.QueryString["Id"] + "'"); %>
        <form class="form-horizontal" id="insertform" action="?id=<%= Request.QueryString["Id"]%>" method="post" onsubmit="document.getElementById('descr').value=document.getElementsByClassName('ql-editor')[0].innerHTML;" enctype="multipart/form-data">
            <div class="card-body">
                <h3 style="margin-right: 49px;">
                    <label class="col-sm-6 text-right control-label col-form-label">Görev Düzenle</label></h3>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 text-right control-label col-form-label">Görev Adı</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" value=" <%=dt.Rows[0]["gorevAdi"] %>" id="user" name="taskname" placeholder="" autocomplete="off" required="required" />
                </div>
            </div>


            <div class="form-group row">
                <label class="col-sm-2 text-right control-label col-form-label">Görevlendirilecek Kişiler</label>
                <div class="col-sm-7">
                    <%-- <%System.Data.DataTable ktb = new Function().DataTable("select uid from gorevler where gorevKimligi='" + new Function().DataTable("select gorevKimligi from gorevler where id=" + Request.QueryString["Id"]).Rows[0][0] + "'"); %>
                        <% for (int i = 0; i < ktb.Rows.Count; i++)
                            { %>
                            -<% =new Function().DataTable("select ad_soyad from kullanicilar where id="+ktb.Rows[i][0]).Rows[0][0]%>-
                            <%}%>--%>
                    <select class="select2 form-control m-t-15" multiple="multiple" name="users" required="required">
                        <%--style="height: 36px; width: 100%;"--%>>       
                        <%System.Data.DataTable unDtGrp = new Function().DataTable("select distinct ekip from kullanicilar"); %>
                        <%for (int j = 0; j < unDtGrp.Rows.Count; j++)
                            { %>
                        <optgroup label="<%=unDtGrp.Rows[j][0] %>">
                            <%System.Data.DataTable unDt = new Function().DataTable("select id,ad_soyad from kullanicilar where ekip='" + unDtGrp.Rows[j][0] + "'"); %>
                            <% for (int i = 0; i < unDt.Rows.Count; i++)
                                {%>
                            <option value="<%=unDt.Rows[i]["id"] %>" <%=(new Function().DataTable("select id from gorevler where gorevKimligi ='"+Request.QueryString["Id"]+"' and uId ='"+ unDt.Rows[i]["id"]+"'").Rows.Count!=0 ? "selected=\"selected\"":"") %>><%=unDt.Rows[i]["ad_soyad"] %></option>
                            <% } %>
                        </optgroup>
                        <%} %>
                    </select>
                </div>
            </div>
            <%-- onchange="var res = this.value.split('/'); this.value=res[1]+'/'+res[0]+'/'+res[2]; setTimeout(function() {this.value=res[1]+'/'+res[0]+'/'+res[2];}, delayInMilliseconds);" oncancel="var res = this.value.split('/'); this.value=res[1]+'/'+res[0]+'/'+res[2]; setTimeout(function() {this.value=res[1]+'/'+res[0]+'/'+res[2];}, delayInMilliseconds);" id="datepicker-autoclose"--%>
            <div class="form-group row">
                <label class="col-sm-2 text-right control-label col-form-label">Görev Başlangıç Tarihi</label>
                <div class="col-md-7">
                    <input type="text" value="" name="startdate" class="form-control" id="datepicker-autoclose" placeholder="mm/dd/yyyy" autocomplete="off" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 text-right control-label col-form-label">Görev Teslim Tarihi</label>
                <div class="col-md-7">
                    <input type="text" value="" name="enddate" class="form-control" id="datepicker-autoclose2" placeholder="mm/dd/yyyy" autocomplete="off" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 text-right control-label col-form-label">Görev İçerik Dosyası</label>
                <div class="col-sm-7">
                    <div class="custom-file">
                        <input type="file" id="gorevD" name="dosya" class="custom-file-input" />
                        <label class="custom-file-label" for="fotoInput"><%=dt.Rows[0]["gorevDosyasi"] %></label>
                        <div class="invalid-feedback">Example invalid custom file feedback</div>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 text-right control-label col-form-label">Görev Açıklaması</label>
                <input id="descr" type="hidden" name="description" />
                <div class="col-md-7">
                    <div id="editor" style="height: 300px;">
                        <%=dt.Rows[0]["gorevAciklamasi"].ToString() %>
                    </div>
                </div>
            </div>
            <label class="col-sm-6 text-right control-label col-form-label">
                <button type="submit" class="btn btn-primary btn-lg waves-effect" style="margin-right: 33px;">Güncelle</button></label>
            <div style="clear: both">
            </div>
            <span style="color: darkgreen; font-size: 15px; margin-left: 450px;"><%=mesaj %></span>
        </form>
    </div>
    <%} %>
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
    <script src="../../assets/libs/bootstrap-datepicker/dist/locales/bootstrap-datepicker.tr.min.js"></script>
   
    <script>

        // jQuery('.mydatepicker').datepicker();

        jQuery('#datepicker-autoclose').datepicker({
           
            autoclose: true,
            language: 'tr',
            todayHighlight: true,
            //  dateFormat: 'FULL-DD, d MM,yy',
        });
        jQuery('#datepicker-autoclose2').datepicker({
            autoclose: true,
            language: 'tr',
            todayHighlight: true
        });
        $(".select2").select2();
        var quill = new Quill('#editor', {
            theme: 'snow'
        });
    </script>
    <script>
        $("#gorevD").on('change', function (e) {
            var $label = $("#gorevD").next('label')
            var fileName = '';

            if (e.target.value) {
                fileName = '' + e.target.value.split('\\').pop();
            }
            if (fileName) {
                $label.html(fileName);
                //$label.attr('for' , 'subButton');
            }
            else {
                $label.html("Dosya Seç");
                //$label.attr('for' , 'fileInput');
            }
        });
    </script>

</body>

</html>
