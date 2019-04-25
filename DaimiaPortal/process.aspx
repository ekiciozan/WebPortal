<%@ Page Language="C#" %>

<% var kullaniciid = Request.Cookies["id"].Value;%>
<%if (Request.QueryString["p"] == "delete")
    {
        new Function().ExecuteSqlCommand($"Delete from {Request.QueryString["table"]} where id ={Request.QueryString["id"]}");
        Response.Write("<body onload=\"window.location=document.referrer;\"></body>");
        //  new Function().DataTable("update kullanicilar set bildirim =0 where id=" + {Request.QueryString["id"]});
    } %>

<%else if (Request.QueryString["p"] == "deletegorev")
    {
        new Function().ExecuteSqlCommand($"Delete from {Request.QueryString["table"]} where id ={Request.QueryString["id"]}");
        Response.Write("<body onload=\"window.location=document.referrer;\"></body>");
        // new Function().DataTable("update kullanicilar set bildirim =0 where id="  + Request.QueryString["id"] + "'");
    }
           %>

<%else if (Request.QueryString["p"] == "deleteizin")
    {
        new Function().ExecuteSqlCommand($"Delete from {Request.QueryString["table"]} where id ={Request.QueryString["Id"]}");
        Response.Write("<body onload=\"window.location=document.referrer;\"></body>");
    }
           %>
<%else if (Request.QueryString["p"] == "deleteizintalep")
    {
        new Function().ExecuteSqlCommand($"Delete from izintalepler where id ={Request.QueryString["Id"]}");
        Response.Write("<body onload=\"window.location=document.referrer;\"></body>");
    }
           %>
<%else if (Request.QueryString["p"] == "logout")
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
        Response.Write("<body onload=\"window.location=document.referrer;\"></body>");
    }
    else if (Request.QueryString["p"] == "saveeventdate")
    {
        string eventTitle = Request.Form["title"];
        string eventStartTime = Request.Form["starttime"];
        string eventEndTime = Request.Form["endtime"];
        string eventId = Request.Form["id"];
        new Function().ExecuteSqlCommand($"UPDATE gorevler SET basTarihi ='{eventStartTime}',bitTarihi='{eventEndTime}' where id =" + eventId + ";");
        new Function().DataTable("UPDATE gorevler SET teslimDurumu = 0 where id=" + eventId + ";"); // 0 olark update diyor
        Response.Write("<body onload=\"window.location=document.referrer;\"></body>");
    }
    else if (Request.QueryString["p"] == "geteventdate")
    {  
        string eventTitle = Request.Form["title"];
        string eventStartTime = Request.Form["starttime"];
        string eventEndTime = Request.Form["endtime"];
        string eventId = Request.Form["id"];
        new Function().ExecuteSqlCommand($"select basTarihi,bitTarihi from gorevler where id =" + kullaniciid + ";");
        Response.Write("<body onload=\"window.location=document.referrer;\"></body>");
    }%>
}