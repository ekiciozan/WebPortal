<%@ Page Language="C#" %>

<%
    HttpCookie kullaniciCookie;
    kullaniciCookie = Request.Cookies["id"];
    if (kullaniciCookie == null)
    {
        Response.Redirect("login.aspx");
    }
    var kullaniciid = Request.Cookies["id"].Value;
    new Function().DataTable("update kullanicilar set bildirim =0 where id=" + kullaniciid);
%>
<!DOCTYPE html>

<%string hata = "";
    string mesaj = "";
    if (!string.IsNullOrWhiteSpace(Request.Form["sta"]))
    {
        new Function().ExecuteSqlCommand($"insert into kullanicilar (kullanici_adi,sifre,ad_soyad,email,ekip,pozisyon,yetki) values ('{Request.Form["user_name"].Trim()}','{Request.Form["password"].Trim()}','{Request.Form["name"].Trim()}','{Request.Form["email"].Trim()}','{Request.Form["ekip"].Trim()}','{Request.Form["position"].Trim()}','{Request.Form["yetki"].Trim()}')");
        mesaj = "Kayıt Başarı ile Gerçekleşmiştir.";
    } %>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    <title>Etkinlikler</title>
    <!-- Custom CSS -->
    <link href="../../assets/libs/fullcalendar/dist/fullcalendar.min.css" rel="stylesheet" />
    <link href="../assets/fullCalendar/fullcalendar.print.css" rel="stylesheet" media="print" />

    <link href="../../assets/extra-libs/calendar/calendar.css" rel="stylesheet" />
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->




</head>
<body>

    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="page-breadcrumb">
            <div class="row">
                <div class="col-12 d-flex no-block align-items-center">
                    <h4 style="margin-left: 10px;" class="page-title">Görevler

                    </h4>
                    <div class="ml-auto text-right">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><span>Anasayfa</span></a></li>
                                <li class="breadcrumb-item active" aria-current="page">Etkinlikler</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <form class="form-horizontal" method="post">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="">
                                <div class="row">
                                    <div class="col-lg-4 border-right p-r-0">
                                        <div class="card-body border-bottom">
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div id="calendar-events" class="" style="width: 250px;">
                                                        <%System.Data.DataTable dataTable = new Function().DataTable("select id, gorevadi,gorevKimligi from gorevler where teslimDurumu=0 and uid=" + kullaniciid);%>
                                                        <% int a = dataTable.Rows.Count;%>
                                                        <%for (int i = 0; i < a; i++)
                                                            {%>
                                                        <a href="Gorevlerim.Aspx?gorevId=<%=dataTable.Rows[i][0] %>" target="task_iframe">
                                                            <div class="calendar-events m-b-20" data-class="bg-info" data-id ="<%=dataTable.Rows[i][0] %>" style="color: black; text-decoration: underline;"><i class="fa fa-circle text- m-r-10" style="color: black; margin-right: 10px;"></i><%=dataTable.Rows[i][1] %></div>
                                                        </a>

                                                        <% } %>
                                                    </div>

                                                    <!-- checkbox -->
                                                    <div class="custom-control custom-checkbox" style="margin-top: 10px;">
                                                        <input type="checkbox" class="custom-control-input" id="drop-remove" />
                                                        <label class="custom-control-label" for="drop-remove">Remove after drop</label>
                                                    </div>

                                                    <div style="margin-top: 20px;">
                                                        <button type="submit" class="btn m-t-20 btn-info btn-block waves-effect waves-light">Görev Tamamlandı</button>
                                                    </div>

                                                    <%--<a href="javascript:void(0)" data-toggle="modal" data-target="#add-new-event" class="btn m-t-20 btn-info btn-block waves-effect waves-light" style="margin-top:10px;">
                                                    <i class="ti-plus"></i>Add New Event
                                                </a>--%>
                                                    <div class="card-body border-bottom">
                                                    </div>
                                                    <div class="calander-events">
                                                        <iframe class="iframe-full-height" frameborder="0" scrolling="auto" style="width: 100%; overflow: hidden; border: hidden; margin-top: 40px;" name="task_iframe"></iframe>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-8">
                                        <div class="card-body b-l calender-sidebar">
                                            <div id="calendar"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- BEGIN MODAL -->
                <div class="modal none-border" id="my-event">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><strong>Başlık Değiş</strong></h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body"></div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Çıkış</button>
                                <button type="button" class="btn btn-success save-event waves-effect waves-light">Create event</button>
                                <button type="button" class="btn btn-danger delete-event waves-effect waves-light" data-dismiss="modal">Sil</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal Add Category -->
                <div class="modal fade none-border" id="add-new-event">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><strong>Add</strong> a category</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="control-label">Category Name</label>
                                            <input class="form-control form-white" placeholder="Enter name" type="text" name="category-name" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="control-label">Choose Category Color</label>
                                            <select class="form-control form-white" data-placeholder="Choose a color..." name="category-color">
                                                <option value="success">Success</option>
                                                <option value="danger">Danger</option>
                                                <option value="info">Info</option>
                                                <option value="primary">Primary</option>
                                                <option value="warning">Warning</option>
                                                <option value="inverse">Inverse</option>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger waves-effect waves-light save-category" data-dismiss="modal">Kaydet</button>
                                <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Çıkış</button>
                            </div>
                            <% %>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script src="../../assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="../../dist/js/jquery.ui.touch-punch-improved.js"></script>
    <script src="../../dist/js/jquery-ui.min.js"></script>
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

    <script src="../../dist/js/pages/calendar/cal-init.js"></script>
    <script src="../../assets/libs/moment/min/moment.min.js"></script>
    <script src='lib/jquery-ui.custom-datepicker.js'></script>
    <script src="../../assets/libs/fullcalendar/dist/fullcalendar.min.js"></script>
    <script src="../../assets/libs/fullcalendar/dist/locale/tr.js"></script>

    <%--    <script>

       jQuery('#calendar').fullCalendar({
          
                lang: 'tr'
            });
        });
    </script>--%>
    <script>
        $('.iframe-full-height').on('load', function () {
            this.style.height = this.contentDocument.body.scrollHeight + 'px';
        });
        $('.iframe-full-height').on('load', function () {
            this.style.height = this.contentDocument.body.scrollHeight + 'px';
        });
    </script>
</body>
</html>
