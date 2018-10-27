<!-- #include file = "hex_sha1_js.asp" -->
<%
	Dim strPassWord, strHash
	strPassWord = "11439044111950028000055405200000003221__0.6753030012614888330000000000019782120035304709122214340106007000"
	strHash = hex_sha1(strPassWord)

	Response.Write("<p><b>strPassWord:</b> " & strPassWord & "</p>")
	Response.Write("<p><b>strHash:</b> " & strHash & "</p>")
%>