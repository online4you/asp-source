<%
'response.Write("ubound(RegLOfertas,2)=" & ubound(RegLOfertas,2) & "<br>")
hayOfertaNoche=false
numDiasGratis=0
for o=0 to ubound(RegLOfertas,2)
	if RegLOfertas(OfNochesG,o)<>0 then 'hay noches gratis
		if RegLOfertas(OfFInicio,o)<=FLlegada AND RegLOfertas(OfFFin,o)>=cdate(FSalida)-1  then 'es del dia
			if clng(RegLOfertas(OfNoches,o))<=clng(noches) then 'si tiene noches
				'comprobar si es de esta habitacion y regimen
				if (RegLOfertas(OfHabi,o)=0 OR RegLOfertas(OfHabi,o)=clng(codhab)) AND (RegLOfertas(OfCodSuple,o)=0 OR RegLOfertas(OfCodSuple,o)=idRegimen) then 'calcular
				
					'Buscar precio de los ultimos dia
					for n=noches to (noches-RegLOfertas(OfNochesG,o)+1) step -1
						select case RegLOfertas(OfAplicar,o) 'calcular a que se aplica la oferta
							case atodo
							sumadia=(PrecioPlazas(n)-DtoHab(n))+(TotalSuples(n)-dtoSuples(n))
							case ahabi
							sumadia=PrecioPlazas(n)-DtoHab(n)
							case asuple
							sumadia=TotalSuples(n)-dtoSuples(n)
						end select
						'response.write sumaDia & "<br>"
						codiOferta(n)=RegLOfertas(OfId,o)
						totalOferta(n)=sumaDia
						'response.write totalOferta(dia) & "<br>"
						textoOferta(n)=RegLOfertas(OfTitulo,o)
						
						'registro ofertas
						for xx=0 to ubound(ListaOfertas,2)
							If listaOfertas(RIdOferta,xx)=RegLOfertas(OfId,o) then
								listaOfertas(RPelasOferta,o)=listaOfertas(RPelasOferta,o)+sumaDia
								hayOfertaNoche=true
								numDiasGratis=numDiasGratis + RegLOfertas(OfNochesG,o)
							end if
						next 'xx 	
				
					next 'noches
					
				end if 'esta habi y reg.
				
			end if 'suficientes noches
	
		end if 'es del dia
	end if 'nochesgratis
next 'o

%>