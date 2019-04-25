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

<%
    string hata = "";
    string mesaj = "";
    if (!string.IsNullOrWhiteSpace(Request.Form["taskname"]))
    {
        string gorevid = Function.CreateRandomIdenty();
        string file = Function.SaveFile(Request.Files["dosya"]);
        foreach (var item in Request.Form["users"].Split(','))
        {
            DateTime eddt = Convert.ToDateTime(Request.Form["enddate"]);
            string enddate = eddt.Year + "-" + eddt.Month + "-" + eddt.Day;
            DateTime sddt = Convert.ToDateTime(Request.Form["startdate"]);
            string startdate = sddt.Year + "-" + sddt.Month + "-" + sddt.Day;
            new Function().ExecuteSqlCommand($"INSERT INTO `gorevler` ( `uId`,`gorevKimligi`,  `gorevAdi`, `gorevAciklamasi`,`gorevDosyasi`,`bTarihi`, `tTarihi`) VALUES ( '{item}','{gorevid}', '{Request.Form["taskname"]}', '{Request.Form["description"]}','{file}','{startdate}','{enddate}');");
        }
        mesaj = "Görev Başarı İle Gönderildi.";
    }
%>

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


    <link rel="stylesheet" type="text/css" href="../../assets/libs/select2/dist/css/select2.min.css" />
    <link rel="stylesheet" type="text/css" href="../../assets/libs/jquery-minicolors/jquery.minicolors.css" />
    <link rel="stylesheet" type="text/css" href="../../assets/libs/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css" />
    <link rel="stylesheet" type="text/css" href="../../assets/libs/quill/dist/quill.snow.css" />
    <link href="../../dist/css/style.min.css" rel="stylesheet" />
    <link href="../../assets/libs/toastr/build/toastr.min.css" rel="stylesheet" />

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
                            <li class="breadcrumb-item active" aria-current="page">Görev Ata</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="card" style="margin-left: 10%; margin-right: 10%">
        <form class="form-horizontal" id="insertform" method="post" onsubmit="document.getElementById('descr').value=document.getElementsByClassName('ql-editor')[0].innerHTML;" enctype="multipart/form-data">
            <div class="card-body">
                <h3>
                    <label class="col-sm-6 text-left control-label col-form-label" style="margin-left: 32%; margin-right: 20%">Görev Ata</label>
                </h3>
            </div>
            <div class="form-group row">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 113px;">Görev Adı</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="taskName" name="taskname" placeholder="" autocomplete="off" required="required" />
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 25px;">Görevlendirilecek Kişiler</label>
                <div class="col-sm-7">
                    <select class="select2 form-control m-t-15" multiple="multiple" name="users" id="Users" required="required" <%--style="height: 36px; width: 100%;"--%>>
                        <%System.Data.DataTable unDtGrp = new Function().DataTable("select distinct ekip from kullanicilar"); %>
                        <%for (int j = 0; j < unDtGrp.Rows.Count; j++)
                            { %>
                        <optgroup label="<%=unDtGrp.Rows[j][0] %>">
                            <%System.Data.DataTable unDt = new Function().DataTable("select id,ad_soyad from kullanicilar where ekip='" + unDtGrp.Rows[j][0] + "'"); %>
                            <% for (int i = 0; i < unDt.Rows.Count; i++)
                                {%>
                            <option value="<%=unDt.Rows[i]["id"] %>"><%=unDt.Rows[i]["ad_soyad"] %></option>
                            <% } %>
                        </optgroup>
                        <%} %>
                    </select>
                </div>
            </div>
            <%-- onchange="var res = this.value.split('/'); this.value=res[1]+'/'+res[0]+'/'+res[2]; setTimeout(function() {this.value=res[1]+'/'+res[0]+'/'+res[2];}, delayInMilliseconds);" oncancel="var res = this.value.split('/'); this.value=res[1]+'/'+res[0]+'/'+res[2]; setTimeout(function() {this.value=res[1]+'/'+res[0]+'/'+res[2];}, delayInMilliseconds);" id="datepicker-autoclose"--%>
            <div class="form-group row">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 35px;">Görev Başlangıç Tarihi</label>
                <div class="col-sm-7">
                    <input type="text" name="startdate" class="form-control datepicker" id="datepicker-autoclose" placeholder="gg.aa.yyyy" autocomplete="off" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 55px;">Görev Teslim Tarihi</label>
                <div class="col-sm-7">
                    <input type="text" name="enddate" class="form-control" id="datepicker-autoclose2" placeholder="gg.aa.yyyy" autocomplete="off" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 47px;">Görev İçerik Dosyası</label>
                <div class="col-sm-7">
                    <div class="custom-file">
                        <input type="file" id="gorevD" name="dosya" class="custom-file-input" />
                        <label class="custom-file-label" for="fotoInput">Dosya Seç</label>
                        <div class="invalid-feedback">Example invalid custom file feedback</div>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 66px;">Görev Açıklaması</label>
                <input id="descr" type="hidden" name="description" />
                <div class="col-md-7">
                    <div id="editor" style="height: 300px;">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="card-body">
                    <label class="col-sm-5 text-left control-label col-form-label" style="margin-left: 32%; margin-right: 10%;">
                        <%-- <button type="submit" class="btn btn-success btn-lg waves-effect" onclick="basarili();" style="margin-right: 33px;">Kaydet</button>--%>
                        <%--         <button type="submit" class="btn btn-lg btn-block btn-outline-success" id="ts-success">Kaydet</button>--%>
                        <button type="submit" class="btn btn-success margin-5" data-toggle="modal" data-target="#Modal1" id="ts-success">
                            Kaydet
                        </button>
                    </label>
                </div>
            </div>
            <div style="clear: both">
            </div>
            <div class="modal fade" id="Modal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true ">
                <div class="modal-dialog" role="document ">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Görev Ata</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true ">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Görev Başarı İle Gönderildi.!
                        </div>
                    </div>
                </div>
            </div>

            <%--  <span class="alert alert-success" role="alert"><%=mesaj %> </span>--%>
            <%-- <span style="color: darkgreen; font-size: 15px;  margin-left:31%;"><%=mesaj %></span>--%>
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
    <script src="assets/libs/toastr/toastr.js"></script>
    <script src="../../assets/libs/toastr/build/toastr.min.js"></script>
    <script>

        // jQuery('.mydatepicker').datepicker();
        jQuery('#datepicker-autoclose').datepicker({
            language: 'tr',
            autoclose: true,
            todayHighlight: true,
        });
        jQuery('#datepicker-autoclose2').datepicker({
            language: 'tr',
            autoclose: true,
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
     
    <script>
        $(function () {
            // Success Type
            $('#ts-success').on('click', function (event) {
                if ($.trim($('#taskName').val()) != '' &&
                    $.trim($('#Users').val()) != '' &&
                    $.trim($('#datepicker-autoclose').val()) != '' &&
                    $.trim($('#datepicker-autoclose2').val()) != '') {

                    <%--toastr.success('Görev Başarı İle Atandı!', '<%=new Function().DataTable("select kullanici_adi from kullanicilar where id="+kullaniciid).Rows[0][0].ToString() %>');--%>
                }

            });

            // Success Type
            $('#ts-info').on('click', function () {
                toastr.info('We do have the Kapua suite available.', 'Turtle Bay Resort');
            });
        });
    </script>
</body>

</html>
