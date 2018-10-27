<div id='capaPaginas'>
	<p style="margin-top:3px; text-align:center;">
	<%if pag=1 or pag="" then%>
		<%'=FlechaLeft%>
	<%else%>
	<a href="<%=MiPag%>?p=<%=Pag-1%><%=masurl%>" class='enlacePagina'><%=FlechaLeft%></a> 
	<%end if%>
	&nbsp;
	<%for yy=1 to Maxp
		estilo="enlacePagina"
		if yy=Pag then estilo="enlacePaginaEsta"%>
		<a href="<%=MiPag%>?p=<%=yy%><%=masurl%>" class='<%=estilo%>'><%=yy%></a>
		<%if yy<Maxp then response.write "&ndash;"%>
	<%next%>
	&nbsp;
	<%if pag=MaxP or MaxP=1 then%>
		<%'=FlechaRight%>
	<%else%>
	<a href="<%=MiPag%>?p=<%=Pag+1%><%=masurl%>" class='enlacePagina'><%=FlechaRight%></a> 
	<%end if%>
	</p>
</div>