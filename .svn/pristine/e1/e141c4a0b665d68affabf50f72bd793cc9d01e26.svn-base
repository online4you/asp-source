<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" %>
<script language="VB" runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
	Try
	Dim objResponse As System.Net.WebResponse
	Dim objRequest As System.Net.WebRequest
	DIM theurlresult as string
	DIM theurl as string = "http://www.come2mallorca.com"
	objRequest = System.Net.HttpWebRequest.Create(theurl)
	objResponse = objRequest.GetResponse()
	Dim sr As new system.io.StreamReader(objResponse.GetResponseStream())
	'theURLresult=server.HTMLencode(sr.ReadToEnd())
	theURLresult=sr.ReadToEnd()
	Page.Controls.Add(new LiteralControl(theURLresult))
	Catch ex As Exception
	Page.Controls.Add(new LiteralControl(ex.Message))
	End Try
End Sub
</script>
<html><head>
<title>Webresponse y Webrequest</title>
</head>
<body bgcolor="#FFFFFF">
<h3><font face="Verdana">Codigo de la pagina www.terra.es</font></h3>
</body></html>