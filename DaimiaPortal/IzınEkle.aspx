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
    if (!string.IsNullOrWhiteSpace(Request.Form["users"]))
    {
        DateTime eddt = Convert.ToDateTime(Request.Form["enddate"]);
        string enddate = eddt.Year + "-" + eddt.Month + "-" + eddt.Day;
        DateTime sddt = Convert.ToDateTime(Request.Form["startdate"]);
        string startdate = sddt.Year + "-" + sddt.Month + "-" + sddt.Day;
        string kimlikid = Function.CreateRandomIdenty();
        foreach (var item in Request.Form["users"].Split(','))
        {
            new Function().ExecuteSqlCommand($"INSERT INTO `izinler` (id,uId,iKimligi,ibasTarihi,ibitTarihi,iSuresi) VALUES (NULL, '{item}','{kimlikid}', '{startdate}', '{enddate}','{Request.Form["sure"]}');");
        }
        mesaj = "İzin Başarı İle Eklendi.";
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
    <title>İzin Ekle</title>
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
                            <li class="breadcrumb-item active" aria-current="page">İzin Ata</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="card"style="margin-left:10%;margin-right:10%">
        <div class="form-group row">
            <%--            <div class="card-body">
                <button onclick="calcDiff()">diff </button>
            </div>--%>
        </div>
        <form class="form-horizontal" id="insertform" method="post" onsubmit="document.getElementById('descr').value=document.getElementsByClassName('ql-editor')[0].innerHTML;">
            <div class="card-body">
                     <h3> <label class="col-sm-6 text-left control-label col-form-label"  style="margin-left:32%;margin-right:20%">İzin Ata</label> </h3>  
            </div>
            <div class="form-group row">
                <label class="col-sm-2.5 text-left control-label col-form-label"  style="margin-right:25px;">İzine Ayrılacak Kişiler</label>
                <div class="col-sm-7">
                    <select class="select2 form-control m-t-15" multiple="multiple" name="users" required="required" <%--style="height: 36px; width: 100%;"--%>>
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
                <label class="col-sm-2.5 text-left control-label col-form-label"  style="margin-right:32px;margin-top: 10px;">İzin Başlangıç Tarihi</label>
                <div class="col-md-7" style="margin-top: 10px;">
                    <input type="text" name="startdate" class="form-control" id="datepicker-autoclose" placeholder="gg.aa.yyyy" autocomplete="off" required="required" />
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2.5 text-left control-label col-form-label"  style="margin-right:65px;margin-top: 10px;">İzin Bitiş Tarihi</label>
                <div class="col-md-7" style="margin-top: 10px;">
                    <input type="text" name="enddate" class="form-control" onchange="calcDiff();" style="" id="datepicker-autoclose2" placeholder="gg.aa.yyyy" autocomplete="off" required="required" />
                </div>
            </div>
            <%
   

            %>
            <div class="form-group row">
                <label class="col-sm-2.5 text-left control-label col-form-label"  style="margin-right:91px;margin-top: 10px;">İzin Süresi </label>
                <div class="col-sm-7" style="margin-top: 10px;">
                    <input type="text" class="form-control" id="sure" name="sure" placeholder="" autocomplete="off" required="required" />
                </div>
            </div>

            <div style="clear: both">
            </div>
           <div class="form-group">
                <div class="card-body">
                    <label  class="col-sm-5 text-left control-label col-form-label" style="margin-left:32%;margin-right:10%; ">
                         <button type="submit" class="btn btn-success btn-lg waves-effect" style="margin-top: 20px;">Kaydet</button>
                    </label>
                </div>
            </div>
            <div style="clear: both">
            </div>
            <span style="color: darkgreen; font-size: 15px;margin-left:31%;"><%=mesaj %></span>

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
            var start= $("#datepicker-autoclose").datepicker("getDate");
            var end= $("#datepicker-autoclose2").datepicker("getDate");
            days = ((end - start) / (1000 * 60 * 60 * 24)) +1;
            $("#sure").val(Math.round(days));
            //$("#sure").text(Math.round(days));
        }
    </script>
    <script>


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
