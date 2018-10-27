<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="ISO-8859-1" strict=true aspcompat=true%>

<script language="VB" runat="server">
	sub creaPagina(original as string)
		Dim objResponse As System.Net.WebResponse
		Dim objRequest As System.Net.WebRequest
		DIM theurlresult as string
		objRequest = System.Net.HttpWebRequest.Create(original)
		objResponse = objRequest.GetResponse()
		response.write(objResponse.CharacterSet & "<br>")
		Dim sr As new system.io.StreamReader(objResponse.GetResponseStream())
		theURLresult=sr.ReadToEnd()
		'creaPagina=theURLresult
		response.write(theURLresult)
	End sub

	'response.write(creaPagina("http://www.come2mallorca.com/paginaHotel.asp?est=102&lang=es"))
	'creaPagina "http://www.come2mallorca.com/paginaHotel.asp?est=102&lang=es"
</script>
<%
creaPagina("http://www.come2mallorca.com/?var=mallorca_familia&tservi=6&lang=es")
%>

