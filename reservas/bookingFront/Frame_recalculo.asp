<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="includes/conversorMoneda.asp"-->

<%
	set objIdioma = new clsIdioma 'carga la clase con el idioma segun variable lang

	idh = paClng(request.QueryString("est"))
	laspelas = 0
	th = request.QueryString("th")
	tr = request.QueryString("tr")
	fini = request.QueryString("fini")
	ffin = request.QueryString("ffin")
	adultos = paClng(request.QueryString("ad"))
	ninos1 = paClng(request.QueryString("ni1"))
	ninos2 = paClng(request.QueryString("ni2"))
	noches = cdate(ffin) - cdate(fini)

	parametros = "precioHabitacion.asp?ide=" & IdEmpresa & "&est=" & idh & "&lang=es&fini=" & fini & "&ffin=" & ffin
	parametros = parametros & "&codhab=" & th & "&ad=" & adultos & "&ni1=" & ninos1
	parametros = parametros & "&ni2=" & ninos2 & "&codsup=" & tr

	response.write "<!-- webservice Recalculo: " & xmlURL & parametros & "-->" & vbcrlf

	Set objDom = Server.CreateObject("Microsoft.XMLDOM")
	objDom.async = false
	objDom.validateOnParse = false
	objDom.setProperty "ServerHTTPRequest", true
	if objDom.Load(xmlURL & parametros) then
	
		For Each objItem in objDom.documentElement.SelectNodes("/data")
			monedaHotel = objItem.SelectSingleNode("moneda").text
			total = objItem.SelectSingleNode("totalbruto").text

			if isnumeric(total) then
				laspelas = cdbl(total)
			end if

			estado = objItem.SelectSingleNode("estadohabitacion").text
			release = paClng(objItem.SelectSingleNode("release").text)
			diasminimos = paClng(objItem.SelectSingleNode("diasminimos").text)

			'mirar oferta
			on error resume next
			For Each ojete in objDom.documentElement.SelectNodes("/data/oferta")
				totalOfer = ojete.SelectSingleNode("totaloferta").text

				if err.number = 0 then
					if isnumeric(totalOfer) then
						laspelas = laspelas - cdbl(totalOfer)
					end if
				end if

			next 'las ofertas
			on error goto 0
		next 'each
	end if	
	
	Set objDom = Nothing
	Set objItem = Nothing
	
	elCambio = 1
	if monedaHotel <> coin then elCambio = CambioGoogle(monedaHotel, coin)
	enlacenuevo = "paso2.asp?ide=" & idempresa & "&idh=" & idh & "&lang=" & lang & "&fini=" & fini
	enlacenuevo = enlacenuevo & "&ffin=" & ffin & "&ad=" & adultos & "&ni=" & ninos1 & "&th=" & th
	enlacenuevo = enlacenuevo & "&tr=" & tr
%>

<script language="javascript" type="text/javascript">
	<%
		if laspelas=0 then 
	%>
			$('#enlace_<%= idh %>_<%= th %>').css("display",'none');
			$('#precio_<%= idh %>_<%= th %>').html('<b><%= objIdioma.getTraduccionHTML("i_nodisponibles") %></b>');
			$('#precio_<%= idh %>_<%= th %>').attr("href",'#');
	<%
		else
	%>
			$('#enlace_<%= idh %>_<%= th %>').css("display",'block');
			$('#enlace_<%= idh %>_<%= th %>').attr("href",'<%= enlacenuevo %>');
			$('#precio_<%= idh %>_<%= th %>').html('<b><%= formatnumber(laspelas * elCambio, 2) & sufijoMoneda %></b>');
			$('#precio_<%= idh %>_<%= th %>').attr("href",'<%= enlacenuevo %>');
	<%
		end if
	%>
	
	//parent.$('#espera_<%= idh %>_<%= th %>').css("display",'none'); //quitar grafico espera

	// WEBSERVICE:
	//<%= xmlURL & parametros %>
</script>