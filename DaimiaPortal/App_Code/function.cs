using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Xml.Linq;
public class Function
{
    public static string hash = "AkfedComTr123456789";
    static public string conString = @"Server=188.125.160.130; Database=portal; Uid=ozanozan; Pwd=ozanozan;";
    public DataTable DataTable(string komut)
    {
        
        //try
        //{
            using (MySqlConnection con = new MySqlConnection(conString))
            {
                using (MySqlCommand cmd = new MySqlCommand(komut, con))
                {
                    cmd.CommandType = CommandType.Text;
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            dt.TableName = "table";
                            return dt;
                        }
                    }
                }
            }
        //}catch(Exception e)
        //{
        //    ExecuteSqlCommand("INSERT INTO `hata` (`id`, `tarih`, `kimde`, `islem`, `hatailetisi`,ayrinti) VALUES (NULL, CURRENT_TIMESTAMP, '', 'Çekilen Veriden Tablo Oluştururken!', '"+e.Message+ "', '" + e.ToString() + "');");
        //    return new System.Data.DataTable();
        //}

    }
    public static string GeoCodeService(string konum)
    {
        try
        {
            string address = konum;
            string requestUri = string.Format("https://maps.googleapis.com/maps/api/geocode/xml?address={0}&sensor=false&key=AIzaSyCHaMbxb8eqbWqtmEtDfgR-WJ4b9WRetcE", Uri.EscapeDataString(address));
            WebRequest request = WebRequest.Create(requestUri);
            WebResponse response = request.GetResponse();
            XDocument xdoc = XDocument.Load(response.GetResponseStream());
            XElement result = xdoc.Element("GeocodeResponse").Element("result");
            XElement locationElement = result.Element("geometry").Element("location");
            XElement lat = locationElement.Element("lat");
            XElement lng = locationElement.Element("lng");
            return lat.Value.ToString() + "," + lng.Value.ToString();
        }
        catch (Exception)
        {
            return "41.3606393,33.731558";
        }

    }
    public static string TarihOlusturucu(DateTime dt)
    {
        //TimeSpan Sonuc = dt - DateTime.Now;
        //if (Sonuc.TotalMinutes < 1d)
        //{
        //    return "Şimdi"+dt;
        //}
        //else if(Sonuc.TotalMinutes<5d)
        //{
        //    return "Bi kaç Dakika Önce"+dt;
        //}
        //else if (Sonuc.TotalHours<1d)
        //{
        //    return "Bu saatlerde"+dt;
        //}
        //else if (Sonuc.TotalDays<1d)
        //{
        //    return "Bugün"+dt;
        //}
        //else
        {
            return dt.ToLongDateString()+" "+dt.ToLongTimeString();
        }

    }
    public static string GetIPAddress()
    {
        try
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                string[] addresses = ipAddress.Split(',');
                if (addresses.Length != 0)
                {
                    return addresses[0];
                }
            }

            return context.Request.ServerVariables["REMOTE_ADDR"];
        }
        catch
        {
            return "000.000.000.000";
        }
    }
    static public DataTable ExcelToDS(string Path)
    {
        //Provider =Microsoft.ACE.OLEDB.12.0; Data Source =c:\myFolder\myExcel2007file.xlsx; Extended Properties ="Excel 12.0 Xml;HDR=YES"
        string strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source="+Path+"; Extended Properties =\"Excel 12.0 Xml; HDR = YES;IMEX=1;\"";
        //string strConn = "Provider=Microsoft.Jet.OLEDB.4.0; " +"Data Source = "+ Path +"; "+"Extended Properties = Excel 12.0; ";
        OleDbConnection conn = new OleDbConnection(strConn);
        conn.Open();
        System.Data.DataTable dt = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
        string strExcel = "";
        OleDbDataAdapter myCommand = null;
        DataSet ds = null;
        strExcel = "select * from ["+ dt.Rows[0]["TABLE_NAME"] + "]";
        myCommand = new OleDbDataAdapter(strExcel, strConn);
        ds = new DataSet();
        myCommand.Fill(ds);
        conn.Close();
        return ds.Tables[0];
    }
    public static void AddProc(string kullanici, int islemno, string aciklama)
    {
        try
        {
            new Function().InsertUpdateIntoTable("hareketdokumu", new Dictionary<string, string>() { { "KimeAitId", "'" + kullanici + "'" }, { "Unvan", "'" + new Function().DataTable("select Resmi_Unvan from rentacar_uye where id="+kullanici).Rows[0][0] + "'" }, { "IslemNo", "'" + islemno + "'" }, { "IslemAciklamasi", "'" + aciklama + "'" }, { "ip", "'" + GetIPAddress() + "'" } });
        }
        catch { }
    }
    public string HTMLTablosuOlustur(string komut, string tabloadi,List<string> sutunList)
    {
        DataTable dt = DataTable(komut);
        if (sutunList.Count != dt.Columns.Count) { throw new Exception("'sutunList' paremetresinin sayısıyla sorgunuzda kullanılan alanların eşit olması gerekir."); }
        if (dt == null)
        {
            return tabloadi + " tablosunda hiç veri yok,Yönlendirmeleri kullanarak hemen bir tane ekleyin.";
        }
        string tbl = "<thead><tr>";
        for (int i = 0; i < sutunList.Count; i++)
        {
            tbl += "<th>" + sutunList[i] + "</th>";
        }
        tbl += "</tr></thead><tbody>";

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tbl += "<tr>";
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                tbl += "<td>";
                tbl += dt.Rows[i][j];
                tbl += "</td>";
            }
          
            tbl += "</tr>";
        }


        tbl += "</tbody>";
        return tbl;
    }
    public string StringVeri(string komut)
    {
        DataTable dt = DataTable(komut);
        string tbl="";
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tbl += "";
            for (int j = 0; j < dt.Columns.Count; j++)
            {

                tbl  += "("+dt.Columns[j] + " : ";
                tbl += dt.Rows[i][j]+")";
                tbl += " - ";
            }

            tbl += "";
        }
        return tbl;
    }
    public string HTMLTablosuOlustur(string komut)
    {
        DataTable dt = DataTable(komut);
        if (dt == null)
        {
            return "Tabloda hiç veri yok,Yönlendirmeleri kullanarak hemen bir tane ekleyin.";
        }
        string tbl = "<thead><tr>";
        foreach (var item in dt.Columns)
        {
            tbl += "<th>" + item + "</th>";
        }
        tbl += "</tr></thead><tbody>";

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tbl += "<tr>";
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                tbl += "<td>";
                if (dt.Columns[j].ToString().ToLower().Contains("mail"))
                {
                    tbl += "<a href=\"mailto:" + dt.Rows[i][j] + "\">" + dt.Rows[i][j] + "</a>";
                }
                else if (dt.Columns[j].ToString().ToLower().Contains("telefon"))
                {
                    tbl += "<a href=\"tel:" + dt.Rows[i][j] + "\">" + dt.Rows[i][j] + "</a>";
                }
                else
                {
                    tbl += dt.Rows[i][j];
                }
                tbl += "</td>";
            }
            tbl += "</tr>";
        }
        tbl += "</tbody>";
        return tbl;
    }
    public string HTMLTablosuOlustur(string komut, string silmelinki, string duzenlemelinki,string kiralamalinki)
    {
        DataTable dt = DataTable(komut);
        if (dt == null)
        {
            return "Tabloda hiç veri yok,Yönlendirmeleri kullanarak hemen bir tane ekleyin.";
        }
        string tbl = "<thead><tr>";
        foreach (var item in dt.Columns)
        {
            tbl += "<th>" + item + "</th>";
        }
        tbl += "<th>" + "İşlemler" + "</th>";
        tbl += "</tr></thead><tbody>";

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tbl += "<tr class=\"demo4TableRow\"  data-row-id=\"" + dt.Rows[i][0] + "\">";
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                tbl += "<td>";
                if (dt.Columns[j].ToString().ToLower().Contains("mail"))
                {
                    tbl += "<a href=\"mailto:" + dt.Rows[i][j] + "\">" + dt.Rows[i][j] + "</a>";
                }
                else if (dt.Columns[j].ToString().ToLower().Contains("telefon"))
                {
                    tbl += "<a href=\"tel:" + dt.Rows[i][j] + "\">" + dt.Rows[i][j] + "</a>";
                }
                else
                {
                    tbl += dt.Rows[i][j];
                }
                tbl += "</td>";

            }

            tbl += "<td>" +
                //"pages/tables/showtable.aspx?sg="+Function.Encrypt("SELECT id as '#', AracTipi AS 'Arac Cinsi', CONCAT(Marka,' ',Model,' ',Versiyon,' ',Paket) AS Arac,Plaka,Renk,MotorNo,Yakit,SasiNo,Vites,Fiyat1 as '1 3 Gun Fiyati',Fiyat2 as '4 7 Gun Fiyati',Fiyat3 as '8 15 Gun Fiyati',Fiyat4 as '16 30 Gun Fiyati'  FROM araclar where KimeAitId="+kullaniciid)+"&tn="+Function.Encrypt("Araçlar Ayrıntı")
                "<button data-toggle=\"tooltip\" title=\"Aracı Kirala\" onclick=\"window.location.href = '" + kiralamalinki+ "'\" style=\"font-size: 1.5em\" type=\"button\" class=\"btn btn-info fa fa-calendar-check-o\"></button> " +
                //"<button data-toggle=\"tooltip\" title=\"Whatsapp ile Paylaş\" onclick=\"window.open('" + "https://api.whatsapp.com/send?phone=whatsappphonenumber&text=" + new Function().StringVeri(komut + " and id=" + dt.Rows[i][0]) + "','_blank');\" style=\"font-size: 1.5em\" type=\"button\" class=\"btn btn-success fa fa-whatsapp\"></button> " +
                "<button data-toggle=\"tooltip\" title=\"Değiştir\" onclick=\"window.location.href = '" + duzenlemelinki + dt.Rows[i][0] + "'\" style=\"font-size: 1.5em\" type=\"button\" class=\"btn btn-primary fa fa-edit\"></button>   " +
                                          "<button   title=\"Sil\"  type = \"button\" style = \"font-size: 1.5em\" class=\"btn btn-navy fa fa-trash\" data-toggle=\"modal\" data-target=\"#Sil" + dt.Rows[i][0] + "\"></button>" +
                                          "<div class=\"modal fade\" id=\"Sil" + dt.Rows[i][0] + "\" role=\"dialog\">" +
                                              "<div class=\"modal-dialog modal-lg\">" +
                                                "<div class=\"modal-content\">" +
                                                      "<div class=\"modal-header\">" +
                                                          "<button type = \"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>" +
                                                          "<h4 class=\"modal-title\">Silme İşlemini Onaylıyormusunuz?</h4>" +
                                                      "</div>" +
                                                      "<div class=\"modal-body\">" +
                                                          "<p>Bu Veriyi Silmek istediğinize Eminmisiniz?</p>" +
                                                      "</div>" +
                                                      "<div class=\"modal-footer\">" +
                                                          "<button onclick = \"window.location.href='" + silmelinki + dt.Rows[i][0] + "'\" type=\"button\" class=\"btn btn-danger\">Sil</button>" +
                                                          "<button type = \"button\" class=\"btn btn-default \" data-dismiss=\"modal\">Kapat</button>" +
                                                     "</div>" +
                                                  "</div>" +
                                              "</div>" +
                                          "</div>" +
                                          "</td>";
            tbl += "</tr>";
        }
        tbl += "</tbody>";
        return tbl;
    }
    public string HTMLTablosuOlustur(string komut,string silmelinki,string duzenlemelinki)
    {
        DataTable dt = DataTable(komut);
        if (dt == null)
        {
            return "Tabloda hiç veri yok,Yönlendirmeleri kullanarak hemen bir tane ekleyin.";
        }
        string tbl = "<thead><tr>";
        foreach (var item in dt.Columns)
        {
            tbl += "<th>" + item + "</th>";
        }
        tbl += "<th>" + "İşlemler" + "</th>";
        tbl += "</tr></thead><tbody>";

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tbl += "<tr class=\"demo4TableRow\"  data-row-id=\"" + dt.Rows[i][0] + "\">";
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                tbl += "<td>";
                if (dt.Columns[j].ToString().ToLower().Contains("mail"))
                {
                    tbl += "<a href=\"mailto:" + dt.Rows[i][j] + "\">" + dt.Rows[i][j] + "</a>";
                }
                else if (dt.Columns[j].ToString().ToLower().Contains("telefon"))
                {
                    tbl += "<a href=\"tel:" + dt.Rows[i][j] + "\">" + dt.Rows[i][j] + "</a>";
                }
                else
                {
                    tbl += dt.Rows[i][j];
                }
                tbl += "</td>";

            }

            tbl += "<td>" +
                //"pages/tables/showtable.aspx?sg="+Function.Encrypt("SELECT id as '#', AracTipi AS 'Arac Cinsi', CONCAT(Marka,' ',Model,' ',Versiyon,' ',Paket) AS Arac,Plaka,Renk,MotorNo,Yakit,SasiNo,Vites,Fiyat1 as '1 3 Gun Fiyati',Fiyat2 as '4 7 Gun Fiyati',Fiyat3 as '8 15 Gun Fiyati',Fiyat4 as '16 30 Gun Fiyati'  FROM araclar where KimeAitId="+kullaniciid)+"&tn="+Function.Encrypt("Araçlar Ayrıntı")
              //  "<button data-toggle=\"tooltip\" title=\"Whatsapp ile Paylaş\" onclick=\"window.open('" + "https://api.whatsapp.com/send?phone=whatsappphonenumber&text=" + new Function().StringVeri(komut+" and id="+ dt.Rows[i][0]) + "','_blank');\" style=\"font-size: 1.5em\" type=\"button\" class=\"btn btn-success fa fa-whatsapp\"></button> " +
                "<button data-toggle=\"tooltip\" title=\"Değiştir\" onclick=\"window.location.href = '" + duzenlemelinki+ dt.Rows[i][0] + "'\" style=\"font-size: 1.5em\" type=\"button\" class=\"btn btn-primary fa fa-edit\"></button>   " +
                                          "<button   title=\"Sil\"  type = \"button\" style = \"font-size: 1.5em\" class=\"btn btn-navy fa fa-trash\" data-toggle=\"modal\" data-target=\"#Sil" + dt.Rows[i][0]+"\"></button>" +
                                          "<div class=\"modal fade\" id=\"Sil" + dt.Rows[i][0] + "\" role=\"dialog\">" +
                                              "<div class=\"modal-dialog modal-lg\">" +
                                                "<div class=\"modal-content\">" +
                                                      "<div class=\"modal-header\">" +
                                                          "<button type = \"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>" +
                                                          "<h4 class=\"modal-title\">Silme İşlemini Onaylıyormusunuz?</h4>" +
                                                      "</div>" +
                                                      "<div class=\"modal-body\">" +
                                                          "<p>Bu Veriyi Silmek istediğinize Eminmisiniz?</p>" +
                                                      "</div>" +
                                                      "<div class=\"modal-footer\">" +
                                                          "<button onclick = \"window.location.href='" + silmelinki + dt.Rows[i][0] + "'\" type=\"button\" class=\"btn btn-danger\">Sil</button>" +
                                                          "<button type = \"button\" class=\"btn btn-default \" data-dismiss=\"modal\">Kapat</button>" +
                                                     "</div>" +
                                                  "</div>" +
                                              "</div>" +
                                          "</div>" +
                                          "</td>";
            tbl += "</tr>";
        }
        tbl += "</tbody>";
        return tbl;
    }
    public string HTMLTablosuOlustur(string komut, string silmelinki, string duzenlemelinki,string yazdirmalinki,string aracdonusbuton,string faturalinki)
    {
        DataTable dt = DataTable(komut);
        if (dt == null)
        {
            return "Tabloda hiç veri yok,Yönlendirmeleri kullanarak hemen bir tane ekleyin.";
        }
        string tbl = "<thead><tr>";
        foreach (var item in dt.Columns)
        {
            tbl += "<th>" + item + "</th>";
        }
        tbl += "<th>" + "İşlemler&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" + "</th>";
        tbl += "</tr></thead><tbody>";

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tbl += "<tr class=\"demo4TableRow\"  data-row-id=\"" + dt.Rows[i][0] + "\">";
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                tbl += "<td>";
                if (dt.Columns[j].ToString().ToLower().Contains("mail"))
                {
                    tbl += "<a href=\"mailto:" + dt.Rows[i][j] + "\">" + dt.Rows[i][j] + "</a>";
                }
                else if (dt.Columns[j].ToString().ToLower().Contains("telefon"))
                {
                    tbl += "<a href=\"tel:" + dt.Rows[i][j] + "\">" + dt.Rows[i][j] + "</a>";
                }
                else
                {
                    tbl += dt.Rows[i][j];
                }
                tbl += "</td>";

            }
            
            tbl += "<td>" +
                    "<button   title=\"Araç Dönüşü Gerçekleştir\"  type = \"button\" style = \"font-size: 1em\" class=\"btn btn-success fa fa-reply-all\" data-toggle=\"modal\" data-target=\"#aracdonus" + dt.Rows[i][0] + "\"></button> " +
                                          "<div class=\"modal fade\" id=\"aracdonus" + dt.Rows[i][0] + "\" role=\"dialog\">" +
                                              "<div class=\"modal-dialog modal-lg\">" +
                                                "<div class=\"modal-content\">" +
                                                      "<div class=\"modal-header\">" +
                                                          "<button type = \"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>" +
                                                          "<h4 class=\"modal-title\">Araç Dönüş İşlemi</h4>" +
                                                      "</div>" +
                                                      "<div class=\"modal-body\">" +
                                                          "<iframe style=\" width:100%; height: 721px; border:none;\" src=\"" + aracdonusbuton + dt.Rows[i][0] + "\"></iframe>" +
                                                      "</div>" +
                                                      "<div class=\"modal-footer\">" +
                                                          "<button type = \"button\" class=\"btn btn-default \" data-dismiss=\"modal\">Kapat</button>" +
                                                     "</div>" +
                                                  "</div>" +
                                              "</div>" +
                                          "</div>" +
                "<button data-toggle=\"tooltip\" title=\"Kontrat Yazdır\" onclick=\"" + "printPage"+ dt.Rows[i][0]+  "()" + "\" style=\"font-size: 1em\" type=\"button\" class=\"btn btn-primary fa fa fa-list-ol\"><br/></button> " +
                "<button data-toggle=\"tooltip\" title=\"Fatura Yazdır\" onclick=\"" + "printPageFatura" + dt.Rows[i][0] + "()" + "\" style=\"font-size: 1em\" type=\"button\" class=\"btn btn-primary fa fa fa-files-o\"></button> " +
                "<div id=\"printerDiv" + dt.Rows[i][0] + "\" style=\"display:inline-block; width:0px; height:0px;\"></div>" +
                 "<div id=\"printerDivFatura" + dt.Rows[i][0] + "\" style=\"display:inline-block; width:0px; height:0px;\"></div>" +
                "<script>" +
                "function printPage"+ dt.Rows[i][0] + "(){" +
                " var div = document.getElementById(\"printerDiv"+ dt.Rows[i][0] + "\");" +
                " div.innerHTML = '<iframe style=\"display:inline-block; width:0px; height:0px;\" src=\"" + yazdirmalinki + dt.Rows[i][0] + "\" onload=\"this.contentWindow.print();  \"></iframe>';" +
                "}</script>" +
                "<script>" +
                "function printPageFatura" + dt.Rows[i][0] + "(){" +
                " var div = document.getElementById(\"printerDivFatura" + dt.Rows[i][0] + "\");" +
                " div.innerHTML = '<iframe style=\"display:inline-block; width:0px; height:0px;\" src=\"" + faturalinki + dt.Rows[i][0] + "\" onload=\"this.contentWindow.print();  \"></iframe>';" +
                "}</script>" +
                "<button data-toggle=\"tooltip\" title=\"Değiştir\" onclick=\"window.location.href = '" + duzenlemelinki + dt.Rows[i][0] + "'\" style=\"font-size: 1em\" type=\"button\" class=\"btn btn-primary fa fa-edit\"></button>   " +
                                          "<button title=\"Sil\"  type = \"button\" style = \"font-size: 1em\" class=\"btn btn-navy fa fa-trash\" data-toggle=\"modal\" data-target=\"#sil" + dt.Rows[i][0] + "\"></button>" +
                                          "<div class=\"modal fade\" id=\"sil" + dt.Rows[i][0] + "\" role=\"dialog\">" +
                                              "<div class=\"modal-dialog modal-lg\">" +
                                                "<div class=\"modal-content\">" +
                                                      "<div class=\"modal-header\">" +
                                                          "<button type = \"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>" +
                                                          "<h4 class=\"modal-title\">Silme İşlemini Onaylıyormusunuz?</h4>" +
                                                      "</div>" +
                                                      "<div class=\"modal-body\">" +
                                                          "<p>Bu Veriyi Silmek istediğinize Eminmisiniz?</p>" +
                                                      "</div>" +
                                                      "<div class=\"modal-footer\">" +
                                                          "<button onclick = \"window.location.href='" + silmelinki + dt.Rows[i][0] + "'\" type=\"button\" class=\"btn btn-danger\">Sil</button>" +
                                                          "<button type = \"button\" class=\"btn btn-default \" data-dismiss=\"modal\">Kapat</button>" +
                                                     "</div>" +
                                                  "</div>" +
                                              "</div>" +
                                          "</div>" +
                                          "</td>";
            tbl += "</tr>";
        }
        tbl += "</tbody>";
        return tbl;
    }
    public void InsertUpdateIntoTable(string tabloAdi,Dictionary<string,string> dictionary)
    {
        string JoinedKeys = string.Join(",", dictionary.Keys);
        string joinedValues = string.Join(",", dictionary.Values);
        string sqlcmd = "INSERT INTO `" + tabloAdi+ "`(" + JoinedKeys + ") VALUES (" + joinedValues + ");";
        ExecuteSqlCommand(sqlcmd);
    }
    public void InsertUpdateIntoTable(string tabloAdi,  Dictionary<string, string> dictionary, Dictionary<string, string> where)
    {

        List<string> listid = new List<string>();
        foreach (var item in where.Keys)
        {
            listid.Add(item + "=" + where[item]);
        }
        string JoinedValuesid = string.Join(" AND ", listid);

        List<string> list = new List<string>();
        foreach (var item in dictionary.Keys)
        {
            list.Add(item+"="+dictionary[item]);
        }
        string JoinedValues = string.Join(",", list);

        string sqlcmd = "UPDATE " + tabloAdi + " SET " + JoinedValues + " WHERE " + JoinedValuesid + " ;";
        ExecuteSqlCommand(sqlcmd);
    }
    public void ExecuteSqlCommand(string komut)
    {
        MySqlConnection mySqlConnection = new MySqlConnection(conString);
        MySqlCommand myCommand = new MySqlCommand(komut, mySqlConnection);
        myCommand.Connection.Open();
        myCommand.ExecuteNonQuery();
        mySqlConnection.Close();
    }
    public static string GetImageFilePath(string FileName)
    {
        return HttpContext.Current.Server.MapPath("~/Upload/" + FileName).ToString();
    }
    public static string GetImageFilePathWithUrl(string FileName)
    {
        return HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Upload/" + FileName;
    }
    public static string UploadImage(string Image)
    {
      string s = SaveImage(Image);
      return new Function().DataTable("INSERT INTO `fotograflar` (`id`, `fotograf`) VALUES (NULL, '" + s + "'); select LAST_INSERT_ID();").Rows[0][0].ToString();
    }
    public static string UploadVideo(string video)
    {
        string s = SaveVideo(video);
        return new Function().DataTable("INSERT INTO `fotograflar` (`id`, `fotograf`) VALUES (NULL, '" + s + "'); select LAST_INSERT_ID();").Rows[0][0].ToString();
    }
    public static string DataTableToXml(string sorgu)
    {
        
        return ConvertDatatableToXML(new Function().DataTable(sorgu));
    }
    public static string ConvertDatatableToXML(DataTable dt)
    {
        MemoryStream str = new MemoryStream();
        dt.WriteXml(str, true);
        str.Seek(0, SeekOrigin.Begin);
        StreamReader sr = new StreamReader(str);
        string xmlstr;
        xmlstr = sr.ReadToEnd();
        return (xmlstr);
    }
    public static string SaveImage(string base64String)
    {
        string filename = Function.CreateFileName("-Photo.png");
        string fullfilename = Function.GetImageFilePath(filename);
        //GC.Collect();
        string base64 = base64String.Split(',')[1];
        byte[] imageBytes = Convert.FromBase64String(base64);
        File.WriteAllBytes(fullfilename, imageBytes);
        //string testfullpath = "C:\\" + filename;
        //Base64ToImage(base64String).Save(testfullpath);

        //File.WriteAllText(fullfilename, "testesdteywryhadsfhgadfhasdjhasdjsfgj");
        //File.WriteAllBytes(fullfilename,ImageToByteArray(Base64ToImage(base64String)));
        return GetImageFilePathWithUrl(filename);

    }
    public static string SaveVideo(string base64String)
    {
        string filename = Function.CreateFileName("-Video.mp4");
        string fullfilename = Function.GetImageFilePath(filename);
        string base64 = base64String.Split(',')[1];
        byte[] imageBytes = Convert.FromBase64String(base64);
        File.WriteAllBytes(fullfilename, imageBytes);
        return GetImageFilePathWithUrl(filename);

    }
    public static string SaveFile(HttpPostedFile file)
    {
        if (file != null && file.ContentLength > 0)
        {
            string extention = Path.GetExtension(file.FileName);
            string filename = Function.CreateFileName("-File"+extention);
            string fullfilename = Function.GetImageFilePath(filename);
            file.SaveAs(fullfilename);
            return GetImageFilePathWithUrl(filename);
        }
        return "";
    }
    public static string CreateRandomIdenty()
    {
        string temp = "";
        string chara = "abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ123456789";
        Random r = new Random();
        for (int i = 0; i < 25; i++)
        {
            temp += chara[r.Next(0, chara.Length - 1)];
        }
        temp += DateTime.Now.ToString("ddMMyyyyhhmmss");
        temp += new Random().Next(1000, 9999);
        return temp;
    }
    public static string CreateFileName(string dosyauzantisi)
    {
        string temp = "";
        string chara = "abcdefghijklmnoprstuvyzABCDEFGHIJKLMNOPRSTUVYZ123456789";
        Random r = new Random();
        for (int i = 0; i < 25; i++)
        {
            temp += chara[r.Next(0, chara.Length - 1)];
        }
        temp += DateTime.Now.ToString("ddMMyyyyhhmmss");
        temp += new Random().Next(1000, 9999);
        temp += dosyauzantisi;
        return temp;
    }
    public static string UrlDecrypt(string url)
    {
        string a = url;
        a = a.Replace(" ", "+");
        int mod4 = a.Length % 4;
        if (mod4 > 0)
        {
            a += new string('=', 4 - mod4);
        }
        return a;
    }
    public static string Encrypt(string sifre)
    {
        byte[] data = UTF8Encoding.UTF8.GetBytes(sifre);
        using (MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider())
        {
            byte[] keys = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(hash));
            using (TripleDESCryptoServiceProvider tripDes = new TripleDESCryptoServiceProvider() { Key = keys, Mode = CipherMode.ECB, Padding = PaddingMode.PKCS7 })
            {
                ICryptoTransform transform = tripDes.CreateEncryptor();
                byte[] results = transform.TransformFinalBlock(data, 0, data.Length);
                return Convert.ToBase64String(results, 0, results.Length);
            }
        }
    }
    public static string Decrypt(string SifrelenmisDeger)
    {
        byte[] data = Convert.FromBase64String(SifrelenmisDeger);
        using (MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider())
        {
            byte[] keys = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(hash));
            using (TripleDESCryptoServiceProvider tripDes = new TripleDESCryptoServiceProvider() { Key = keys, Mode = CipherMode.ECB, Padding = PaddingMode.PKCS7 })
            {
                ICryptoTransform transform = tripDes.CreateDecryptor();
                byte[] results = transform.TransformFinalBlock(data, 0, data.Length);
                return UTF8Encoding.UTF8.GetString(results);
            }
        }
    }
    public static string Sifrele(string value){
        return Encrypt(value);
    }
    public static string SifreyiCoz(string value)
    {
        return Function.Decrypt(Function.UrlDecrypt(value));
    }
    public static bool Sayimi(char karakter)
    {
        string ts = "0123456789";
        foreach (var item in ts)
        {
            if (karakter == item)
            {
                return true;
            }
        }


        return false;
    }
    public static bool HarfMi(char karakter)
    {
        string ts = "ZCVBNMÖÇİŞLKJHGFDSAERTYUIOPĞÜ";
        foreach (var item in ts)
        {
            if (karakter == item)
            {
                return true;
            }
        }

        return false;
    }
    public static bool MailKontrol(string mail)
    {
        try
        {
             System.Net.Mail.MailAddress mailAddress = new System.Net.Mail.MailAddress("testing@invalid@email.com");
            return true;
        }
        catch (Exception)
        {
            return false;
        }
    }
    public static string SayiToYazi(string sayi)
    {
        int max_basamak = 30;
        string[] birler = { "", "bir ", "iki ", "üç ", "dört ", "beş ", "altı ", "yedi ", "sekiz ", "dokuz "  };
        string[] onlar = { "", "on ", "yirmi ", "otuz ", "kırk ", "elli ", "altmış ", "yetmiş ", "seksen ", "doksan " };
        // daha büyük sayılar için: http://dalt.in/Kf49Z
        string[] binler = { "oktilyon ", "septilyon ", "seksilyon ", "kentilyon ", "katrilyon ", "trilyon ", "milyar ", "milyon ", "bin ", "" };
        int[] basamaklar = new int[3];
        string sonuc = "";
        //sayının kullanılmayan basamaklarını sıfırla doldur
        sayi = sayi.PadLeft(max_basamak, '0');
        //sayıyı üçerli basamaklara ayır
        for (int i = 0; i < max_basamak / 3; i++)
        {
            string temp = "";
            //yüzler basamağı
            basamaklar[0] = (int)(sayi[i * 3] - '0');
            //onlar basamağı
            basamaklar[1] = (int)(sayi[i * 3 + 1] - '0');
            //birler basamağı
            basamaklar[2] = (int)(sayi[i * 3 + 2] - '0');

            if (basamaklar[0] == 0)
                temp = ""; //yüzler basamağı boş
            else
                if (basamaklar[0] == 1)
                temp = "yüz "; //yüzler basamağında 1 varsa
            else
                temp = birler[basamaklar[0]] + "yüz ";  // birleştir

            //yüzler+onlar+birler basamağını birleştir
            temp += onlar[basamaklar[1]] + birler[basamaklar[2]];

            //basamak değeri oluşmadıysa yani 000 ise binler basamağını ekle
            if (!string.IsNullOrEmpty(temp)) temp += binler[i];
            //birbin olmaz
            if ((i > 1) && (temp.Equals("birbin"))) temp = "bin ";
            if (temp != "") sonuc += temp + " ";
        }
        if (string.IsNullOrEmpty(sonuc.Trim()))
            sonuc = "sıfır ";
        return sonuc.Trim();
    }
    public static string SayiToYazi(int sayi)
    {
        return SayiToYazi(sayi.ToString());
    }
}