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
    if (!string.IsNullOrWhiteSpace(Request.Form["sure"]))
    {
        DateTime eddt = Convert.ToDateTime(Request.Form["enddate"]);
        string enddate = eddt.Year + "-" + eddt.Month + "-" + eddt.Day;
        DateTime sddt = Convert.ToDateTime(Request.Form["startdate"]);
        string startdate = sddt.Year + "-" + sddt.Month + "-" + sddt.Day;
        string kimlikid = Function.CreateRandomIdenty();
        new Function().ExecuteSqlCommand($"INSERT INTO izinTalepler (id,uId,iTKimligi,iTBasTarihi,iTBitTarihi,iTSuresi,iTAciklama) VALUES (NULL, '{kullaniciid}','{kimlikid}', '{startdate}', '{enddate}','{Request.Form["sure"]}','{Request.Form["aciklama"]}');");

        mesaj = "İzin Talebi Başarı İle Gönderildi.";
      
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
    <title>İzin Talep</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    <link href="../../assets/libs/toastr/build/toastr.min.css" rel="stylesheet" />

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
    <div class="page-breadcrumb">
        <div class="ro">
            <div class="col-12 d-flex no-block align-items-center">

                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><span>Anasayfa</span></li>
                            <li class="breadcrumb-item"><span>İzin Talep</span></li>
                            <li class="breadcrumb-item active"><a href="#" onclick="yazdir();">Sayfayı Yazdır  </a></li>

                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="card" style="margin-left: 10%; margin-right: 10%">
        <form class="form-horizontal" id="insertform" method="post" onsubmit="document.getElementById('descr').value=document.getElementsByClassName('ql-editor')[0].innerHTML;">

            <h3>
                <label class="col-sm-6 text-left control-label col-form-label" style="margin-left: 32%; margin-right: 20%">İzin Talebi</label>
            </h3>

            <%-- onchange="var res = this.value.split('/'); this.value=res[1]+'/'+res[0]+'/'+res[2]; setTimeout(function() {this.value=res[1]+'/'+res[0]+'/'+res[2];}, delayInMilliseconds);" oncancel="var res = this.value.split('/'); this.value=res[1]+'/'+res[0]+'/'+res[2]; setTimeout(function() {this.value=res[1]+'/'+res[0]+'/'+res[2];}, delayInMilliseconds);" id="datepicker-autoclose"--%>
            <div class="form-group row" style="margin-top: 20px;">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 25px;">İzin Başlangıç Tarihi</label>
                <div class="col-sm-7">
                    <input type="text" name="startdate" class="form-control" id="datepicker-autoclose" placeholder="gg.aa.yyyy" autocomplete="off" required="required" />
                </div>
            </div>

            <div class="form-group row" style="margin-top: 20px;">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 57px;">İzin Bitiş Tarihi</label>
                <div class="col-sm-7">
                    <input type="text" name="enddate" class="form-control" onchange="calcDiff();" style="" id="datepicker-autoclose2" placeholder="gg.aa.yyyy" autocomplete="off" required="required" />
                </div>
            </div>

            <div class="form-group row" style="margin-top: 20px;">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 84px;">İzin Süresi </label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="sure" name="sure" placeholder="" autocomplete="off" required="required" />
                </div>
            </div>
            <div class="form-group row" style="margin-top: 20px;">
                <label class="col-sm-2.5 text-left control-label col-form-label" style="margin-right: 17px;">İzin Talep Açıklaması </label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="aciklama" name="aciklama" placeholder="" autocomplete="off" required="required" />
                </div>
            </div>

            <div style="clear: both">
            </div>

            <div class="form-group">
                <div class="card-body">
                    <label class="col-sm-5 text-left control-label col-form-label" style="margin-left: 32%; margin-right: 10%;">
                        <span class="aa">
                            <div>
                                <button type="submit" class="btn btn-success btn-lg waves-effect" style="margin-top: 20px;" >Kaydet</button></div>
                        </span>
                        <%--   <button type="submit" class="btn btn-lg btn-block btn-outline-success" id="ts-success">Kaydet</button>--%>
                    </label>
                </div>

            </div>

            <div style="clear: both">
            </div>
            <span class="alert alert-success" role="alert" style="display: none" id="succ"><%=mesaj %>
            </span>
            <%--     <span style="color: darkgreen; font-size: 15px; margin-left: 30%; border: hidden;"><%=mesaj %></span>--%>
        </form>
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
    <script src="../../assets/libs/bootstrap-datepicker/dist/locales/bootstrap-datepicker.tr.min.js"></script>
    <script src="assets/libs/toastr/toastr.js"></script>
    <script src="../../assets/libs/toastr/build/toastr.min.js"></script>



    <script>
        // jQuery('.mydatepicker').datepicker();
        jQuery('#datepicker-autoclose').datepicker({
            language: 'tr',
            autoclose: true,
            todayHighlight: true,
            timepicker: false,
            //  dateFormat: 'FULL-DD, d MM,yy',
        });
        jQuery('#datepicker-autoclose2').datepicker({
            language: 'tr',
            autoclose: true,
            todayHighlight: true,
            timepicker: false,
        });
        $(".select2").select2();
        var quill = new Quill('#editor', {
            theme: 'snow'
        });
        function calcDiff() {
            var start = $("#datepicker-autoclose").datepicker("getDate");
            var end = $("#datepicker-autoclose2").datepicker("getDate");
            days = ((end - start) / (1000 * 60 * 60 * 24)) + 1;
            $("#sure").val(Math.round(days));
            //$("#sure").text(Math.round(days));

        }
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
        var da = (document.all) ? 1 : 0;
        var pr = (window.print) ? 1 : 0;
        var mac = (navigator.userAgent.indexOf("Mac") != -1);

        function yazdir() {
            if (pr) // NS4, IE5
                window.print()
            else if (da && !mac) // IE4 (Windows)
                vbPrintPage()
            else // other browsers
                alert("Tarayıcınız bu özelliği desteklememektedir.");
            return false;
        }
    </script>
    <script>
        $(function () {
            // Success Type
            $('#ts-success').on('click', function (event) {
                if ($.trim($('#sure').val()) != '' &&
                    $.trim($('#aciklama').val()) != '' &&
                    $.trim($('#datepicker-autoclose').val()) != '' &&
                    $.trim($('#datepicker-autoclose2').val()) != '') {

                    toastr.success('Görev Başarı İle Atandı!', '<%=new Function().DataTable("select kullanici_adi from kullanicilar where id="+kullaniciid).Rows[0][0].ToString() %>')
                }

            });

            // Success Type
            $('#ts-info').on('click', function () {
                toastr.info('We do have the Kapua suite available.', 'Turtle Bay Resort');
            });
        });
    </script>

    <script>       

             $(document).ready(function () {
            $("#insertform").submit(function () {
                if ($("#datepicker-autoclose").val() == "") {

                    return false;
                }
                if ($("#datepicker-autoclose").val() == "") {
                    return false;
                }
                if ($("#sure").val() == "") {
                    return false;
                }
                if ($("#aciklama").val() == "") {
                    return false;
                }
                else {
                    $("#succ").show();
                }

            });

        });

       
       
    </script>


</body>

</html>
