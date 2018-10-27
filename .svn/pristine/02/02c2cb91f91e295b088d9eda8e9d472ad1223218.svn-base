<div align="center" style="width:100%;">
<%if pag=1 or pag="" then%>
<%=FlechaLeft%>
<%else%>
<a href="<%=MiPag%>?P=<%=Pag-1%><%=masurl%>" class='lineaTabla'><%=FlechaLeft%></a> 
<%end if%>
&nbsp;&nbsp;
<%for yy=1 to Maxp%>
	&nbsp;<a href="<%=MiPag%>?P=<%=yy%><%=masurl%>" class='lineaTabla'><%=yy%></a>&nbsp;
<%next%>
&nbsp;&nbsp;
<%if pag=MaxP or MaxP=1 then%>
<%=FlechaRight%>
<%else%>
<a href="<%=MiPag%>?P=<%=Pag+1%><%=masurl%>" class='lineaTabla'><%=FlechaRight%></a> 
<%end if%>
</div>