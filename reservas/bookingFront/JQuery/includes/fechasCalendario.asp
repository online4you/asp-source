<%
'Para poner la fecha en cada idioma
lcid_es=3082
lcid_en=1033
lcid_de=1031
lcid_ca=1027
lcid_fr=1036
lcid_it=1040
lcid_bg=1026

select case lcase(lang)
	case "es"
		session.LCID=lcid_es
	case "en"
		session.LCID=lcid_en
	case "de"
		session.LCID=lcid_de
	case "ca"
		session.LCID=lcid_ca
	case "fr"
		session.LCID=lcid_fr
	case "it"
		session.LCID=lcid_it
	case "bg"
		session.LCID=lcid_bg
	case else
		session.lcid=lcid_en
end select

dim NombreMes(12)
dim NombreMesAbrev(12)
arraymeses="new Array("
for m=1 to 12
	NombreMes(m)=server.HTMLEncode(MonthName(m))
	NombreMesAbrev(m)=server.HTMLEncode(left(MonthName(m),3))
	arraymeses=arraymeses & chr(34) & MonthName(m) & chr(34) & ","
next
'Quitar la ultima coma
arraymeses=left(arraymeses,len(arraymeses)-1)
arraymeses=arraymeses & ")"
'diascortos="new Array("
'diaslargos="new Array("
'for d=1 to 7
'	if lang="de" then 'en aleman se abrev. con 2 letras
'		diascortos=diascortos & chr(34) & mid(WeekDayName(d,0,vbmonday),1,2) & chr(34) & ","
'	else
'		diascortos=diascortos & chr(34) & mid(WeekDayName(d,0,vbmonday),1,3) & chr(34) & ","
'	end if
'	diaslargos=diaslargos & chr(34) & WeekDayName(d,0,vbmonday) & chr(34) & ","
'next
'diascortos=left(diascortos,len(diascortos)-1)
'diascortos=diascortos & ")"
'diaslargos=left(diaslargos,len(diaslargos)-1)
'diaslargos=diaslargos & ")"

dim diascortos(7)
dim diasmascortos(7)
dim diaslargos(7)
for d=1 to 7
	diascortos(d)=server.HTMLEncode(mid(WeekDayName(d,0,vbmonday),1,3))
	diasmascortos(d)=server.HTMLEncode(ucase1(mid(WeekDayName(d,0,vbmonday),1,2)))
	diaslargos(d)=server.HTMLEncode(WeekDayName(d,0,vbmonday))
next

dim nomdia(7)
nomdia(1)=server.HTMLEncode(WeekdayName(1, true, 2))
nomdia(2)=server.HTMLEncode(WeekdayName(2, true, 2))
nomdia(3)=server.HTMLEncode(WeekdayName(3, true, 2))
nomdia(4)=server.HTMLEncode(WeekdayName(4, true, 2))
nomdia(5)=server.HTMLEncode(WeekdayName(5, true, 2))
nomdia(6)=server.HTMLEncode(WeekdayName(6, true, 2))
nomdia(7)=server.HTMLEncode(WeekdayName(7, true, 2))

session.LCID=lcid_es 'Sesion en formato español
%>
