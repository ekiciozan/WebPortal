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
    <title>DAIMIA PORTAL</title>
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
    <script>
        function resizeIframe(obj) {
            obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
        }
    </script>
<%--    <style>
        p {
            position: relative;
            font-family: sans-serif;
            text-transform: uppercase;
            font-size: 1.5em;
            letter-spacing: 4px;
            overflow: hidden;
            background: linear-gradient(90deg, #000, #fff, #000);
            background-repeat: no-repeat;
            background-size: 80%;
            animation: animate 7s linear infinite;
            -webkit-background-clip: text;
            -webkit-text-fill-color: rgba(255, 255, 255, 0);
        }

        @keyframes animate {
            0% {
                background-position: -500%;
            }

            100% {
                background-position: 500%;
            }
        }
    </style>--%>
</head>
<body >
    <!-- Preloader - style you can find in spinners.css -->

    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>

    <!-- Main wrapper - style you can find in pages.scss -->

    <div id="main-wrapper">
        <!-- Topbar header - style you can find in pages.scss -->
        <header class="topbar" data-navbarbg="skin5">
            <nav class="navbar top-navbar navbar-expand-md navbar-dark fixed-top" style="margin-top:-3px;">
                <div class="navbar-header" data-logobg="skin5" style="background-color:white;">

                    <!-- This is for the sidebar toggle which is visible on mobile only -->
                    <a class="nav-toggler waves-effect waves-light d-block d-md-none" style="background-color:black" href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
                    <!-- Logo -->
                        <a class="navbar-brand" href="default.aspx" id="show" style="">
                          <span class="logo-text">
                             <!-- dark Logo text -->
                             <img src="../../assets/images/daimia.png" style="width: 200px; height: 35px; margin-left:17px; margin-bottom:1px;" alt="homepage" class="light-logo" />      
                          </span>
                        </a>
                  <%--  <a class="navbar-brand" href="default.aspx">
                        <!-- Logo icon -->

                        <!--End Logo icon -->
                        <!-- Logo text -->
                        <span class="logo-text">
                            <!-- dark Logo text -->

                            <img src="../../assets/images/daimia.png" alt="homepage" style="width: 200px; height: 35px; padding-left: 30px;" class="light-logo" />

                        </span>

                    </a>--%>
                    <a class="topbartoggler d-block d-md-none waves-effect waves-light" style="background-color:black"  href="javascript:void(0)" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><i class="ti-more"></i></a>
                </div>

                <%--       End Logo --%>

                <div class="navbar-collapse collapse" id="navbarSupportedContent" data-navbarbg="skin5">
                    <ul class="navbar-nav float-left mr-auto">
                        <li class="nav-item d-none d-md-block" style="margin-top:4px;"><a class="nav-link sidebartoggler waves-effect waves-light" href="javascript:void(0)" data-sidebartype="mini-sidebar"><i class="mdi mdi-menu font-24"></i></a></li>
                        <!-- Sosyal Medya-->
                        <div style="margin-top:26px;">
                            <a href="http://daimia.com/" target="_blank"><i class="mdi mdi-web" style=" color:burlywood"></i></a>
                            <a href="https://www.linkedin.com/company/daimia/about/" target="_blank"><i class="fab fa-linkedin-in" style="margin-left:10px; color:burlywood"></i></a>
                            <a href="https://twitter.com/daimiabilisim?ref_src=twsrc%5Etfw%7Ctwcamp%5Eembeddedtimeline%7Ctwterm%5Eprofile%3Adaimiabilisim&ref_url=http%3A%2F%2Fdaimia.com%2F" target="_blank"><i class="fab fa-twitter" style=" margin-left:10px;color:burlywood""></i></a>
                            <a href="https://www.facebook.com/daimiabilisim"target="_blank"><i class="fab fa-facebook-f" style="margin-left:10px;color:burlywood"></i></a>
                        </div>
                        <!-- Animasyonlu Text-->

                    </ul>
                    <!----------------------------------------------------------------------------> <!-- Right Header --> <!---------------------------------------------------------------------------->
                    <ul class="navbar-nav float-right">                      
                        <%  var data = new Function().DataTable("select gorevAdi from gorevler where teslimDurumu = 0 and uId=" + kullaniciid);%>
                        <%System.Data.DataTable dt = new Function().DataTable("Select yetki from kullanicilar where id=" + kullaniciid); %>
                        <span style="color: gainsboro; margin-top: 22px;"> <%=new Function().DataTable("select kullanici_adi from kullanicilar where id="+kullaniciid).Rows[0][0].ToString() %> </span>

                        <li class="nav-item dropdown">
                            <%
                                var bildirim = new Function().DataTable("select teslimDurumu from gorevler where uId=" +kullaniciid);
                                var taskCount = new Function().DataTable("select bildirim from kullanicilar where id=" + kullaniciid).Rows[0][0].ToString();
                                if (taskCount == "0")
                                { %>
                            <a class="nav-link dropdown-toggle waves-effect waves-dark" id="defaultbildirim" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="mdi mdi-bell font-24"></i>
                            </a>
                            <% }%>
                            <% else
                                {%>
                              <a class="nav-link dropdown-toggle waves-effect waves-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="mdi mdi-bell font-24" id="mdi mdi-bell font-24" style="color: darkorange; margin-left: 20px;"><span style="font-size: 10px;"></span>
                                </a>
                            <%} %>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownm">
                             <span class ="aa"> <a class="dropdown-item"  href="Etkinlikler.aspx" target="my_iframe">
                                      <%if (dt.Rows[0][0].ToString() == "2")
                                        {  %>
                                     <% =data.Rows.Count%> Adet Görevin Var!  
                                
                                    <%} %>
                              </a>
                                 </span>             
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark pro-pic" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="padding-left:0px;">
                                <div>
                                    <img src="<%=string.IsNullOrWhiteSpace(new Function().DataTable("select pfoto from kullanicilar where id="+kullaniciid).Rows[0][0].ToString())?@"/assets/images/user.jpg":new Function().DataTable("select pfoto from kullanicilar where id="+kullaniciid).Rows[0][0].ToString() %>" alt="user" class="rounded-circle" width="31" />
                                </div>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right user-dd animated">
                                <%if (dt.Rows[0][0].ToString() != "1")
                                    {  %>
                                <%} %>
                                <a class="dropdown-item" href="javascript:void(0)"><i class="ti-email m-r-5 m-l-5" style="margin-right: 5px;"></i>Mesaj Kutusu</a>
                                <div class="dropdown-divider"></div>

                                <span class ="aa"><a class="dropdown-item" href="AccountSettings.aspx" target="my_iframe"><i class="ti-settings m-r-5 m-l-5" style="margin-right: 5px;"></i>Hesap Ayarlarım</a></span>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="javascript:if (confirm('Çıkış Yapmak İstiyor musunuz?')) {location.href = 'process.aspx?p=logout';  } else { } "><i class="fa fa-power-off m-r-5 m-l-5" style="margin-right: 5px;"></i>Çıkış</a>
                            </div>
                        </li>
                    </ul>
                            <!----------------------------------------------------------------------------> <!-- END Right Header --> <!---------------------------------------------------------------------------->
                </div>
            </nav>
        </header> 
       <!----------------------------------------------------------------------------> <!-- Left Sidebar --> <!---------------------------------------------------------------------------->
        <aside class="left-sidebar" data-sidebarbg="skin5">
            <div class="scroll-sidebar" style="margin-top:7px;">
                <nav class="sidebar-nav" style="background-color:black">  
                    <ul id="sidebarnav" class="p-t-30">
                        <li class="sidebar-item">
                             <span class ="aa"><a class="sidebar-link waves-effect waves-light" href="AccountSettings.aspx" aria-expanded="false" target="my_iframe"><i class="fas fa-user-circle"></i><span class="hide-menu">Profilim</span></a></span>
                        </li>
                        <li class="sidebar-item"><a class="sidebar-link has-arrow " href="javascript:void(0)"   aria-expanded="false"><i class="fas fa-users"></i><span class="hide-menu">Ekipler </span></a>
                            <ul aria-expanded="false" class="collapse  first-level">

                                <li class="sidebar-item">
                                    <form action="TableViewer.aspx" method="get" target="my_iframe" id="frmYazilim">
                                        <input type="hidden" name="sq" value="<%=Function.Sifrele("select id as'ID', ad_soyad as 'Adı Soyadı', email as 'Email', ekip as 'Ekip',pozisyon as'Pozisyon'  from kullanicilar where ekip='Yazılım Ekibi'") %>" />
                                        <input type="hidden" name="tb" value="<%=Function.Sifrele("kullanicilar") %>" />
                                        <input type="hidden" name="title" value="<%=Function.Sifrele("Yazılım Ekibi") %>" />
                                    </form>
                                    <span class ="aa"><a href="javascript:document.getElementById('frmYazilim').submit();" class="sidebar-link waves-effect waves-light"><i class="fas fa-code"></i><span class="hide-menu">Yazılım</span></a></span>
                                </li>
                                <%if (dt.Rows[0][0].ToString() != "yazılım")
                                    {  %>
                                <li class="sidebar-item">
                                    <form action="TableViewer.aspx" method="get" target="my_iframe" id="frmTest">
                                        <input type="hidden" name="sq" value="<%=Function.Sifrele("select id as'ID', ad_soyad as 'Adı Soyadı', email as 'Email', ekip as 'Ekip',pozisyon as'Pozisyon'  from kullanicilar where ekip='Test Ekibi'") %>" />
                                        <input type="hidden" name="tb" value="<%=Function.Sifrele("kullanicilar") %>" />
                                        <input type="hidden" name="title" value="<%=Function.Sifrele("Test Ekibi") %>" />
                                    </form>
                                     <span class ="aa"><a href="javascript:document.getElementById('frmTest').submit();" class="sidebar-link waves-effect waves-light"><i class="fas fa-laptop"></i><span class="hide-menu">Test</span></a></span>
                                </li>
                                <%}%>
                            </ul>
                        </li>
                        <%if (dt.Rows[0][0].ToString() == "1")
                            {  %>
                          <li class="sidebar-item"><a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-chart-bar"></i><span class="hide-menu">Aktiviteler </span></a>
                             <ul aria-expanded="false" class="collapse  first-level">
                                 <li class="sidebar-item ">
                                    <span class ="aa"> <a href="Aktivite.aspx" class="sidebar-link waves-effect waves-light" target="my_iframe"><i class="fas fa-tasks"></i><span class="hide-menu">Görev Ata</span></a></span>
                                </li>
                          </li>
                           <li class="sidebar-item">
                                    <form action="TableViewerGorevler.aspx" method="get" target="my_iframe" id="frmGorevler">
                                         <%--"select gorevler.uId,kullanicilar.ad_soyad from gorevler INNER JOIN kullanicilar ON gorevler.uId=kullanicilar.id"--%>
                                        <input type="hidden" name="sq" value="<%=Function.Sifrele("select  gorevKimligi, gorevler.id ,gorevler.uId as'Kullanici ID' ,kullanicilar.ad_soyad as'Adı Soyadı',gorevAdi as 'Gorev Adı', gorevAciklamasi as 'Gorev Acıklaması', CONCAT('<a href=\"',gorevDosyasi,'\">Dosya</a>') as 'Gorev Dosyasi' ,bTarihi as'Baslangıc Tarihi',tTarihi as'Teslim Tarihi'  from gorevler  INNER JOIN kullanicilar ON  gorevler.uId=kullanicilar.id ORDER BY gorevler.id ASC") %>" />
                                        <input type="hidden" name="tb" value="<%=Function.Sifrele("gorevler") %>" />
                                        <input type="hidden" name="title" value="<%=Function.Sifrele("Görevler") %>" />
                                    </form>
                                    <span class ="aa"> <a href="javascript:document.getElementById('frmGorevler').submit();" class="sidebar-link waves-effect waves-light"><i class="fas fa-table"></i><span class="hide-menu">Görevler</span></a></span>
                                </li>
                             </ul>
                        <%} %>
                        <%if (dt.Rows[0][0].ToString() == "1")
                            {  %>

                            <li class="sidebar-item"><a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-playlist-check"></i><span class="hide-menu">İzin Bilgileri </span></a>
                             <ul aria-expanded="false" class="collapse  first-level">

                                <li class="sidebar-item">
                                    <form action="TableViewerIzinTalepleri.aspx" method="get" target="my_iframe" id="izinTalepleri">
                                        <input type="hidden" name="sq" value="<%=Function.Sifrele("select  iTKimligi,izinTalepler.id, izinTalepler.uId as 'Kullanici ID', kullanicilar.ad_soyad as 'Adi Soyadi', iTBasTarihi as 'İzin Baş. Tarihi', iTBitTarihi as 'İzin Bit. Tarihi',iTSuresi as 'İzin Suresi',iTAciklama as 'İzin Aciklamasi' from izinTalepler INNER JOIN kullanicilar ON izinTalepler.uId=kullanicilar.id") %>" />
                                        <input type="hidden" name="tb" value="<%=Function.Sifrele("izinTalepleri") %>" />
                                        <input type="hidden" name="title" value="<%=Function.Sifrele("İzin Talepleri")%>" />
                                    </form>
                                     <span class ="aa"><a href="javascript:document.getElementById('izinTalepleri').submit();" class="sidebar-link waves-effect waves-light"><i class="fas fa-clone"></i><span class="hide-menu">İzin Talepleri</span></a></span>
                                 </li>

                                 <li class="sidebar-item">
                                     <span class="aa"><a href="IzınEkle.aspx" class="sidebar-link waves-effect waves-light" target="my_iframe"><i class="fas fa-check-square"></i><span class="hide-menu">İzin Ata</span></a></span>
                                 </li>

                                 <li class="sidebar-item">
                                    <form action="TableViewerIzinler.aspx" method="get" target="my_iframe" id="izinBilgileri">
                                        <input type="hidden" name="sq" value="<%=Function.Sifrele(" select  iKimligi,izinler.id, izinler.uId as 'Kullanici ID', kullanicilar.ad_soyad as 'Adi Soyadi', ibasTarihi as 'İzin Baş. Tarihi', ibitTarihi as 'İzin Bit. Tarihi',iSuresi as 'İzin Suresi' from izinler INNER JOIN kullanicilar ON izinler.uId=kullanicilar.id ") %>" />
                                        <input type="hidden" name="tb" value="<%=Function.Sifrele("izinler") %>" />
                                        <input type="hidden" name="title" value="<%=Function.Sifrele("İzin Bilgileri")%>" />
                                    </form>
                                     <span class ="aa"><a href="javascript:document.getElementById('izinBilgileri').submit();" class="sidebar-link waves-effect waves-light"><i class="fas fa-table"></i><span class="hide-menu">İzinler</span></a></span>
                                 </li>
                            </ul>
                         </li>
                        <%} %>
                        <%if (dt.Rows[0][0].ToString() == "1")
                            {  %>
                           <li class="sidebar-item"><a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="fas fa-address-book""></i><span class="hide-menu">Çalışan Bilgileri </span></a>
                             <ul aria-expanded="false" class="collapse  first-level">
                                 <li class="sidebar-item">
                                     <span class ="aa"><a href="CalisanEkle.aspx" class="sidebar-link waves-effect waves-light" target="my_iframe"><i class="fas fa-check-square"></i><span class="hide-menu">Çalışan Ekle</span></a></span>
                                </li>
                            
                                <li class="sidebar-item">
                                   <%-- +(new Function().DataTable("select yetki from kullanicilar where id=" + kullaniciid).Rows[0][0].ToString() == "1" ? ",CONCAT(yetki) as'Yetki'" : "")+--%>
                                    <form action="TableViewer.aspx" method="get" target="my_iframe" id="calisanBilgileri">
                                        <input type="hidden" name="sq" value="<%=Function.Sifrele("select id as'ID', ad_soyad as 'Adı Soyadı', email as 'Email', ekip as 'Ekip',pozisyon as 'Pozisyon',yetki as 'Yetki'" + (new Function().DataTable("select yetki from kullanicilar where id=" + kullaniciid).Rows[0][0].ToString() == "1" ? ",CONCAT('<a href=\"',ozgecmis,'\" >CV</a>') as'CV'" : "")+ " from kullanicilar ") %>" />
                                        <input type="hidden" name="tb" value="<%=Function.Sifrele("kullanicilar") %>" />
                                        <input type="hidden" name="title" value="<%=Function.Sifrele("Çalışan Bilgileri")%>" />
                                    </form>
                                     <span class ="aa"><a href="javascript:document.getElementById('calisanBilgileri').submit();" class="sidebar-link waves-effect waves-light"><i class="fas fa-table"></i><span class="hide-menu">Çalışanlar</span></a></span>
                                </li>
                             </ul>
                           </li>
                        <%} %>
                      <%if (dt.Rows[0][0].ToString() == "2")
                          {  %>
                        <li class="sidebar-item"><a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-playlist-check"></i><span class="hide-menu">İzin Bilgileri </span></a>
                            <ul aria-expanded="false" class="collapse  first-level">          
                                 <li class="sidebar-item">
                                     <span class ="aa"><a class="sidebar-link waves-effect waves-light" href="IzınTalep.aspx" aria-expanded="false" target="my_iframe"><i class="far fa-edit"></i><span class="hide-menu">İzin Talep</span></a></span>
                                 </li>
                                 <li class="sidebar-item">
                                    <form action="TableViewerIzinDurumu.aspx" method="get" target="my_iframe" id="izinDurumu">
                                        <input type="hidden" name="sq" value="<%=Function.Sifrele(" select  iKimligi,izinler.id, izinler.uId as 'Kullanici ID', kullanicilar.ad_soyad as 'Adi Soyadi', ibasTarihi as 'İzin Baş. Tarihi', ibitTarihi as 'İzin Bit. Tarihi',iSuresi as 'İzin Suresi' from izinler  INNER JOIN kullanicilar ON izinler.uId=kullanicilar.id where uId=" +kullaniciid+ " ") %>" />
                                        <input type="hidden" name="tb" value="<%=Function.Sifrele("izinDurumu")%>" />
                                        <input type="hidden" name="title" value="<%=Function.Sifrele("İzin Durumu")%>" />
                                    </form>
                                     <span class ="aa"><a href="javascript:document.getElementById('izinDurumu').submit();" class="sidebar-link waves-effect waves-light"><i class="fas fa-table"></i><span class="hide-menu">İzin Durumu</span></a></span>
                                 </li>
                            </ul>
                        </li>
                    <%} %>
                      <li class="sidebar-item">
                             <span class ="aa"><a class="sidebar-link waves-effect waves-light" href="Etkinlikler.aspx" aria-expanded="false" target="my_iframe"><i class="far fa-calendar-alt"></i><span class="hide-menu">Etkinlikler</span></a></span>
                      </li>
             </nav>
          </div>
        </aside>
        <!----------------------------------------------------------------------------> <!-- END Left Sidebar --> <!---------------------------------------------------------------------------->
       
        <div class="page-wrapper">
        
            <iframe class="iframe-full-height" id="test1" style="width: 100%; height:680px; border:hidden; background:url(assets/images/test.jpg) no-repeat center; background-size:100% 100%  " >
            </iframe>
            <iframe class="iframe-full-height" id="test2" style="width: 100%; height: 980px;  overflow: hidden; border: hidden;display:none" frameborder="0" scrolling="yes"  name="my_iframe" >  
            </iframe>
        </div>
        <!-- End Page wrapper  -->
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
    <!-- this page js -->
    <script src="../../assets/extra-libs/multicheck/datatable-checkbox-init.js"></script>
    <script src="../../assets/extra-libs/multicheck/jquery.multicheck.js"></script>
    <script src="../../assets/extra-libs/DataTables/datatables.min.js"></script>


    <script>
        $('#zero_config').DataTable();
        $('.iframe-full-height').on('load', function () {
            this.style.height = this.contentDocument.body.scrollHeight + 'px';
        });
    </script>
  <script>       
      $(document).ready(function () {
          $(".aa").click(function ()
          {
              $("#test1").hide();
              $("#test2").show();
          });
      });
  </script>
  
      </body>
</html >
