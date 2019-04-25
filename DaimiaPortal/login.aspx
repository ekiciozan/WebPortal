<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<%string hata = "";
    if (!string.IsNullOrWhiteSpace(Request.Form["user_name"]))
    {
        // new Function().ExecuteSqlCommand($"insert into kullanicilar (kullanici_adi,sifre) values ('{Request.Form["user_name"]}','{Request.Form["password"]}')");
        if (new Function().DataTable("select * from kullanicilar where (kullanici_adi='" + Request.Form["user_name"] + "' or email='" + Request.Form["user_name"] + "') and sifre='" + Request.Form["password"] + "'").Rows.Count != 0)
        {
            {
                HttpCookie aCookie;
                string cookieName;
                int limit = Request.Cookies.Count;
                for (int i = 0; i < limit; i++)
                {
                    cookieName = Request.Cookies[i].Name;
                    aCookie = new HttpCookie(cookieName);
                    aCookie.Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies.Add(aCookie);
                }
            }
            {
                HttpCookie kullaniciCookie;
                kullaniciCookie = Request.Cookies["id"];
                kullaniciCookie = new HttpCookie("id", new Function().DataTable("select id from kullanicilar where kullanici_adi='" + Request.Form["user_name"].Trim() + "' or email='" + Request.Form["user_name"] + "'").Rows[0][0].ToString());
                kullaniciCookie.Expires = DateTime.Now.AddMonths(6);
                Response.Cookies.Add(kullaniciCookie);
            }
            Response.Redirect("default.aspx");
        }
        else
        {
            hata = "Kullanıcı Adınızı ve Şifrenizi Kontrol Ediniz!";
        }
    } %>
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
    <title>DAIMIA PORTAL LOGIN</title>
    <!-- Custom CSS -->
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

   
</head>

<body>
       <div class="main-wrapper" >
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Login box.scss -->
        <!-- ============================================================== -->
        <div class="auth-wrapper d-flex no-block justify-content-center align-items-center bg-white">
            <div class="auth-box bg-white "  style="border-top:none;">
                <div >
                    <div style="margin:29px;" class="text-center p-t-20 p-b-20">
                        <span class="db"><img src="../../assets/images/daimia.png" style="width:200px;height:35px;" alt="logo" /></span>
                    </div>
                    <!-- Form -->
                    <form class="form-horizontal m-t-20" id="loginform" method="post">
                        <div class="row p-b-30">
                            <div class="col-12">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text bg-dark text-white" id="basic-addon1"><i class="ti-user"></i></span>
                                    </div>
                                    <input name ="user_name" type="text" class="form-control form-control-lg" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1" required="" style="background-color:aliceblue;" autocomplete="off"/>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text bg-dark text-white" id="basic-addon2"><i class="ti-pencil"></i></span>
                                    </div>
                                    <input name ="password" type="password" class="form-control form-control-lg" placeholder="Password" aria-label="Password" aria-describedby="basic-addon1" required="" style="background-color:aliceblue;" autocomplete="off"/>
                                </div>
                            </div>
                        </div>
                        <div class="row ">
                            <div class="col-12">
                                <div class="form-group">
                                    <div class="p-t-20">
                                       <!-- <button class="btn btn-info" id="to-recover" type="button"><i class="fa fa-lock m-r-5"></i> Lost password?</button>-->
                                       
                                        <span style="color:red; font-size:15px;"> <% =hata %></span>
                                        <button class="btn btn-dark float-right bg-dark waves-effect" type="submit">Login</button>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div id="recoverform">
                    <div class="text-center">
                        <span class="text-white">Enter your e-mail address below and we will send you instructions how to recover a password.</span>
                    </div>
                    <div class="row m-t-20">
                        <!-- Form -->
                        <form class="col-12" action="index.html">
                            <!-- email -->
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-danger text-white"><i class="ti-email"></i></span>
                                </div>
                                <input type="text" class="form-control form-control-lg bg-dark"  style ="background-color:black;" placeholder="Email Address" aria-label="Username" aria-describedby="basic-addon1">
                            </div>
                            <!-- pwd -->
                            <div class="row m-t-20 p-t-20 border-top border-secondary">
                                <div class="col-12">
                                    <a class="btn btn-success" href="#" id="to-login" name="action">Back To Login</a>
                                    <button class="btn btn-info float-right" type="button" name="action">Recover</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Login box.scss -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper scss in scafholding.scss -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper scss in scafholding.scss -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Right Sidebar -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Right Sidebar -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- All Required js -->
    <!-- ============================================================== -->
    <script src="../../assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../../assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="../../assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- ============================================================== -->
    <!-- This page plugin js -->
    <!-- ============================================================== -->
    <script>

    $('[data-toggle="tooltip"]').tooltip();
    $(".preloader").fadeOut();
    // ============================================================== 
    // Login and Recover Password 
    // ============================================================== 
    $('#to-recover').on("click", function() {
        $("#loginform").slideUp();
        $("#recoverform").fadeIn();
    });
    $('#to-login').click(function(){
        
        $("#recoverform").hide();
        $("#loginform").fadeIn();
    });
    </script>
</body>
</html>
