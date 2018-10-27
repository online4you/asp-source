<%
filtro=request.QueryString("filtro")
if filtro="0" then 'quitar filtro
	'Quitar filtro anterior
	response.Cookies("cookieFiltroLCli")=""
	filtro="" 'pa que no filtre
end if

condicion=""
if request.form<>"" and filtro<>"" then 'Realizar el filtro de la página
	'Quitar filtro anterior
	response.Cookies("cookieFiltroLCli")=""
	
	nom=request.form("bnombre")
	if nom<>"" then nom="Nombre LIKE '%" & ControlAcentos(quitarApos(nom)) & "%' "
	bape=request.form("bape")
	if bape<>"" then bape="Apellidos LIKE '%" & ControlAcentos(quitarApos(bape)) & "%' "
	fadesde=request.Form("fadesde")
	fahasta=request.Form("fahasta")
	if isdate(fadesde) and not isdate(fahasta) then nfalta="(FechaAlta>=" & FechaMySQL(fadesde) & ") "
	if not isdate(fadesde) and isdate(fahasta) then nfalta="(FechaAlta<=" & FechaMySQL(fahasta) & ") "
	if isdate(fadesde) and isdate(fahasta) then nfalta="(FechaAlta BETWEEN " & FechaMySQL(fadesde) & " AND " & FechaMySQL(fahasta) & ") "

	bidioma=request.Form("bidioma")
	if bidioma<>"" then
		nidioma="IdiomaWeb='" & bidioma & "' "
	end if
	binfo=request.Form("info")
	if binfo="1" then nbinfo="Informacion<>0"
	if binfo="0" then nbinfo="Informacion=0"
	
	condicion="WHERE EMail<>'' AND "

	if nom<>"" then condicion=condicion & nom & "AND "
	if bape<>"" then condicion=condicion & bape & "AND "
	If nfalta<>"" then condicion=condicion & nfalta & " AND "
	If nidioma<>"" then condicion=condicion & nidioma & " AND "
	if nbinfo<>"" then condicion=condicion & nbinfo & " AND "
	
	if right(condicion,4)="AND " then 'Quitar el ultimo operador
		condicion=left(condicion,len(condicion)-4)
	end if
	if right(condicion,6)="WHERE " then 'Quitar la condicion
		condicion=""
	end if

	'guardar consulta fija
	response.Cookies("cookieFiltroLCli")=condicion

end if
%>