 <div class="rightcontent">
      <div id="breadcrumb" class="breadcrumb">
		<a href="?lang=<%=lang%>">Inicio</a> &raquo;
 		<span>Proceso de busqueda</span>
	</div>    
 	<div id="promotions-list" class="promotions-list">
		<div class="title-bold title-rightcontent">
			<h4>LISTADO DE BUSCADOR </h4>
		</div>
		<ul>     

<%
 
DIM TYPE_LIST_HOTEL_SEARCH
    TYPE_LIST_HOTEL_SEARCH=HOTEL_SEARCH_FILTER("typeAccSearch",accomodationid,accomodationzoneids,accomodationtypeids,accomodationratingids,referencepointx,referencepointy,distance,accomodationstates,withrooms,roomtypeids,fini,ffin,adults,children,features)
	
			A_IdEstablecimiento=0
			A_NombreEstablecimiento=1
			A_IdZona=2
			A_NombreZona=3
			A_IdTipoAlojaminto=4
			A_NombreTipoAlojamiento=5
			A_IdCategoria=6
			A_NombreCategoria=7
			A_Descripcion=8
			A_Foto=9
			A_Estado=10
			A_PrecioMinimo=11

 	IF NOT(ISNULL(TYPE_LIST_HOTEL_SEARCH)) THEN 
	
		'////////////////////////////////////////////////////////////////////////////////////////////////////////////
		pag=0
		Pag=paClng(request.querystring("p"))	
 		porpag=5
		totreg=UBOUND(TYPE_LIST_HOTEL_SEARCH,2)+1
		if (totreg/porpag)=int(totreg/porpag) then
			MaxP=int(totreg/porpag)
		else
			MaxP=int(totreg/porpag)+1
		end if
				
		if Pag="" then Pag=1
		Pag=clng(Pag)
		if Pag<1 then Pag=1
		if Pag>MaxP then Pag=MaxP
		IReg=(Pag*PorPag)-PorPag						
		'//////////////////////////////////////////////////////////////////////////////////////////////////////////// 
	
	
		'FOR A=0 TO UBOUND(TYPE_LIST_HOTEL_SEARCH,2)
		FOR A=IReg TO IReg+PorPag-1
				if A > UBOUND(TYPE_LIST_HOTEL_SEARCH,2) THEN EXIT FOR 
		%>
			   <li>      
                <div class="thumb">
                	<a href="?hotel=paso2&idh=<%=TYPE_LIST_HOTEL_SEARCH(A_IdEstablecimiento,A)%>&accomodationid=<%=TYPE_LIST_HOTEL_SEARCH(A_IdTipoAlojaminto,A)%>&lang=<%=lang%>&fini=<%=fini%>&ffin=<%=ffin%>&ad=<%=adults%>&ni=<%=children%>">
                    <img src="<%=TYPE_LIST_HOTEL_SEARCH(A_Foto,A)%>" alt="" title="" class="panscan"/></a></div>
                <div class="content1">
                    <div class="description"><a href="?hotel=paso2&idh=<%=TYPE_LIST_HOTEL_SEARCH(A_IdEstablecimiento,A)%>&accomodationid=<%=TYPE_LIST_HOTEL_SEARCH(A_IdTipoAlojaminto,A)%>&lang=<%=lang%>"><%=TYPE_LIST_HOTEL_SEARCH(A_NombreEstablecimiento,A)%> : <%=TYPE_LIST_HOTEL_SEARCH(A_NombreZona,A)%></a> 
                    <span class="<%=TYPE_CATEGORY(TYPE_LIST_HOTEL_SEARCH(A_IdCategoria,A))%>">&nbsp;</span>
                    </div> 
                    <div class="text1">
                        <p><a href="?hotel=paso2&idh=<%=TYPE_LIST_HOTEL_SEARCH(A_IdEstablecimiento,A)%>&accomodationid=<%=TYPE_LIST_HOTEL_SEARCH(A_IdTipoAlojaminto,A)%>&lang=<%=lang%>"><%=TYPE_LIST_HOTEL_SEARCH(A_NombreTipoAlojamiento,A)%><br/><%=MaxLengthText(TYPE_LIST_HOTEL_SEARCH(A_Descripcion,A),80)%></a></p>  
                    </div>
                    <div class="links">
                        <div class="links-left">
                            <div class="caption-left"><%=TYPE_STATE(TYPE_LIST_HOTEL_SEARCH(A_Estado,A))%></div>
                            <a href="?hotel=paso2&idh=<%=TYPE_LIST_HOTEL_SEARCH(A_IdEstablecimiento,A)%>&accomodationid=<%=TYPE_LIST_HOTEL_SEARCH(A_IdTipoAlojaminto,A)%>&lang=<%=lang%>" class="link">[ <%=objIdioma.getTraduccionHTML("f_info")%> ]</a>   
                        </div>            
                        <div class="links-right">
                        <% MinimumPrice=TYPE_LIST_HOTEL_SEARCH(A_PrecioMinimo,A)
                          if (MinimumPrice > 0 )then %>
                             <div class="caption-right" style="width: 440px;"><%=objIdioma.getTraduccionHTML("f_leyendaPrecio")%>&nbsp;<%=MinimumPrice%> € </div>
                        <% end if %>    
                            <div class="button"><a href="?hotel=paso2&idh=<%=TYPE_LIST_HOTEL_SEARCH(A_IdEstablecimiento,A)%>&accomodationid=<%=TYPE_LIST_HOTEL_SEARCH(A_IdTipoAlojaminto,A)%>&lang=<%=lang%>"><%=objIdioma.getTraduccionHTML("f_selecionar")%></a></div>   
                            <br class="clear"/>
                        </div>
                        <br class="clear"/>
                    </div>
                </div>
                <br class="clear"/>
            </li>   	
		<%
  		NEXT
	ELSE %> 
   
              <li>
				<div class="thumb"> </div>
				<div class="content1">
					<div class="description">  <span class="stars stars-0">&nbsp;</span></div>
					<div class="text1">
						<p>No se encuentra disponibilidad con esos paremetros intente en otros </a></p>
					</div>
					<div class="links">
						<div class="links-left">
							<div class="caption-left"> </div>
							<a href="#" class="link"> </a>
						</div>
						<div class="links-right">
							<div class="caption-right"> </div>
							<div class="button"><a href="javascript:history.back();"><%=objIdioma.getTraduccionHTML("f_Volver")%></a></div>   
							<br class="clear"/>
						</div>
						<br class="clear"/>
					</div>
				</div>
				<br class="clear"/>
			</li>
                                                 
<% END IF
TYPE_LIST_ACCSEARCH=NULL	
%>
		</ul>
	</div>
</div>
<br class="clear"/>

<ul class="footer-main2 footer-main3">
	<li><%=objIdioma.getTraduccionHTML("f_Babeloo2009")%></li>     
	<li class="navigation">
 <%IF NOT(ISNULL(TYPE_LIST_HOTEL_SEARCH)) THEN %>
	<li class="navigation">
        <a href="#" class="navlink">&laquo;</a>
        <%for yy=1 to Maxp 
          estaAqui=false       
          if yy=paClng(Pag)then estaAqui=true end if   
              if estaAqui then %>
                     <span><%=yy%></span>
                <%else%>
                    <a href="?hotel=bc&lang=<%=lang%>&p=<%=yy%>&accomodationid=<%=accomodationid%>&accomodationzoneids=<%=accomodationzoneids%>&fini=<%=fini%>&ffin=<%=ffin%>&ad=<%=adults%>&ni=<%=children%>#_top"><%=yy%></a>
             <%end if%> 
         <%next%>  
        <a href="#" class="navlink">&raquo;</a>  
 	</li>
   <%END IF %> 
 	</li>
</ul>
<br class="clear"/>



