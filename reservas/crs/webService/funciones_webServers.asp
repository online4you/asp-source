<%
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'FUNCTIONS WEB SERVICES '

'TYPE_STATE()
'HOTEL_TYPE_ACCOMMODATION()
'HOTEL_CURRENCY()
'HOTEL_TYPE_DESTINATION()  
'HOTEL_TYPE_FILTER()
'DATOS_HOTEL(establecimiento) 
'HOTEL_SEARCH_FILTER()
'GET_INFO_HOTEL()
 
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'CADENA DE CONEXION SEGUN EL DOMINIO DE DONDE PROVENGA
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
Const urlWebServers="http://services.kubikcrs.com/"
Const urlWebServersAdminKubikcrs="http://admin.kubikcrs.com/webservice/"
Const FotoHotel="http://admin.kubikcrs.com/fotos/babelooESP/"


'///////////////////////////////////////////////////////////////////////////////////////////////////////////
if (request.QueryString("lang")<>"")then
    webLang=request.QueryString("lang")
 else
	webLang="es"
end if	
webCompany=id_clientes

	SELECT CASE DominioWeb 
		 
		CASE "esp.babeloo.com"
			userCRS="babelooESP"
			pwdCRS="babe2009"
			webLogin="?user=" & userCRS & "&pwd=" & pwdCRS & "&company=" & webCompany & "&amp;lang="&webLang 
					
		CASE "marruecos.babeloo.com"
			userCRS="babelooMAR"
			pwdCRS="babe2009"
			webLogin="?user=" & userCRS & "&pwd=" & pwdCRS & "&company=" & webCompany & "&amp;lang="&webLang 
		
		CASE ELSE
			userCRS="babelooESP"
			pwdCRS="babe2009"
			webLogin="?user=" & userCRS & "&lang="&webLang& "&pwd=" & pwdCRS & "&company=" & webCompany
			'webLoginAdminKubik="?ide=83&lang="&webLang
			webLoginAdminKubik="?ide=73&lang="&webLang
	
	END SELECT 

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
Set objDom = Server.CreateObject("Microsoft.XMLDOM")
objDom.async = false
objDom.validateOnParse = false
objDom.setProperty "ServerHTTPRequest", true
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

FUNCTION TYPE_STATE(TYPE_)
		SELECT CASE TYPE_
			   CASE "OL"
			      TYPE_STATE="On Line"
			   CASE "OR"
			      TYPE_STATE="On Request"
 			   CASE ELSE
			      TYPE_STATE="Indefinido"
		END SELECT 
END FUNCTION

'/////////////////////////////////////////////////////////////////////////////////////////////////////////// 
FUNCTION HOTEL_TYPE_ACCOMMODATION() 
laurl=urlWebServers&"MasterTables.aspx"& webLogin & "&service=100"
IF objDom.Load(laurl) THEN

 		DIM TipoAcco()
			ntipo=-1
			A_Id=0
			A_Name=1	

		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/ArrayOfAccomodationType/AccomodationType")
				ntipo=ntipo+1
				redim preserve TipoAcco(2,ntipo)				
				TipoAcco(A_Id,ntipo)   =  paClng(objNodo.SelectSingleNode("Id").text)
				TipoAcco(A_Name,ntipo)  =  objNodo.SelectSingleNode("Name").text
   		NEXT  'objItem
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------
 		if ntipo>-1 then
 	    	   HOTEL_TYPE_ACCOMMODATION=TipoAcco
		  else
 			   HOTEL_TYPE_ACCOMMODATION=NULL
		end if
		'-------------------------------------------------------------------------------	
		'-------------------------------------------------------------------------------				
ELSE
       envioError=sendEmailToControl("martin@planeta-web.com","HOTEL_TYPE_ACCOMMODATION","pruebas@planeta-web.com",laurl,"")
       HOTEL_TYPE_ACCOMMODATION=NULL
	   					
End If
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION TYPE_ACOMODATION(idprod)

sql="SELECT codigo FROM productos WHERE idproducto="&idprod&" "
rs.open sql , base
IF NOT(rs.eof) THEN
   TYPE_ACOMODATION=rs("codigo")
  ELSE
   TYPE_ACOMODATION="1"
END IF
rs.close

END FUNCTION
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION TYPE_CATEGORY(TC)
'PINTA LAS ESTRELLAS 
   	SELECT CASE TC
		CASE 1
		 TYPE_CATEGORY="stars stars-"&TC&""
		CASE 2
		  TYPE_CATEGORY="stars stars-"&TC&""	
		CASE 3
		  TYPE_CATEGORY="stars stars-"&TC&""	
		CASE 4
		  TYPE_CATEGORY="stars stars-"&TC&""		
		CASE 5
		  TYPE_CATEGORY="stars stars-"&TC&""	
		CASE 6
		 TYPE_CATEGORY=""		
		CASE 7
		 TYPE_CATEGORY=""		
		CASE 8
		 TYPE_CATEGORY=""
	END SELECT      

END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION HOTEL_TYPE_DESTINATION(tipo,idZona)

SELECT CASE tipo

 	CASE "zona"
                laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=100&AccomodationZoneIds="&idZona&""
	CASE "tipoAcc"
                laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=100&accomodationtypeids="&TYPE_ACOMODATION(idprod)&""
 	CASE ELSE
                laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=100&AccomodationZoneIds="&idZona&""
END SELECT 

'response.Write laurl
 
IF objDom.Load(laurl) THEN
 
 
 		DIM TipoDest()
			ntipo=-1			
			A_Id=0:A_Name=1:A_TypeName=2:A_RatingName=3:A_Email=4:A_Address=5:A_ID=6:A_ZipCode=7:A_TownName=8:A_TownId=9:A_Telephone=10:A_Fax=11:
			A_WebPage=12:A_DefaultCurrencyId=13:A_ZoneId=14:A_Order=15:A_AnulationDays=16:A_PrepayPercentage=17:A_Coordinates=18:A_Extras=19:A_Status=20
			A_MainPhoto=21:A_Observations=22:A_Conditions=23:A_ZoneName=24:A_TypeId=25:A_RatingId=26:A_Balloon=27:A_GmapIcon=28:A_Distance=29:A_Description=30					
			A_MinimumPrice=31:A_MinimumPriceType=32
 			
 			
		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/ArrayOfAccomodation/Accomodation")
				ntipo=ntipo+1
				redim preserve TipoDest(34,ntipo) 
				TipoDest(A_Id,ntipo)   =  paClng(objNodo.SelectSingleNode("Id").text)
				TipoDest(A_Name,ntipo)  =  objNodo.SelectSingleNode("Name").text
  
				TipoDest(A_TypeName,ntipo)  =  objNodo.SelectSingleNode("TypeName").text
				TipoDest(A_RatingName,ntipo)  =  objNodo.SelectSingleNode("RatingName").text
				TipoDest(A_Email,ntipo)  =  objNodo.SelectSingleNode("Email").text
				TipoDest(A_Address,ntipo)  =  objNodo.SelectSingleNode("Address").text
				TipoDest(A_ZipCode,ntipo)  =  objNodo.SelectSingleNode("ZipCode").text
				TipoDest(A_TownName,ntipo)  =  objNodo.SelectSingleNode("TownName").text
				
				TipoDest(A_TownId,ntipo)  =  objNodo.SelectSingleNode("TownId").text
				TipoDest(A_Telephone,ntipo)  =  objNodo.SelectSingleNode("Telephone").text
				TipoDest(A_Fax,ntipo)  =  objNodo.SelectSingleNode("Fax").text
				TipoDest(A_WebPage,ntipo)  =  objNodo.SelectSingleNode("WebPage").text
				TipoDest(A_DefaultCurrencyId,ntipo)  =  objNodo.SelectSingleNode("DefaultCurrencyId").text
				
				TipoDest(A_ZoneId,ntipo)  =  objNodo.SelectSingleNode("ZoneId").text
				TipoDest(A_Order,ntipo)  =  objNodo.SelectSingleNode("Order").text
				TipoDest(A_AnulationDays,ntipo)  =  objNodo.SelectSingleNode("AnulationDays").text
				TipoDest(A_PrepayPercentage,ntipo)  =  objNodo.SelectSingleNode("PrepayPercentage").text
				TipoDest(A_Coordinates,ntipo)  =  objNodo.SelectSingleNode("Coordinates").text
				
				TipoDest(A_Extras,ntipo)  =  objNodo.SelectSingleNode("Extras").text
				TipoDest(A_Status,ntipo)  =  objNodo.SelectSingleNode("Status").text
				TipoDest(A_MainPhoto,ntipo)  =  objNodo.SelectSingleNode("MainPhoto").text
				TipoDest(A_Observations,ntipo)  =  objNodo.SelectSingleNode("Observations").text
				TipoDest(A_Conditions,ntipo)  =  objNodo.SelectSingleNode("Conditions").text
				
				TipoDest(A_ZoneName,ntipo)  =  objNodo.SelectSingleNode("ZoneName").text
				TipoDest(A_TypeId,ntipo)  =  objNodo.SelectSingleNode("TypeId").text
				TipoDest(A_RatingId,ntipo)  =  objNodo.SelectSingleNode("RatingId").text
				TipoDest(A_Balloon,ntipo)  =  objNodo.SelectSingleNode("Balloon").text
				TipoDest(A_GmapIcon,ntipo)  =  objNodo.SelectSingleNode("GmapIcon").text
				TipoDest(A_Distance,ntipo)  =  objNodo.SelectSingleNode("Distance").text

				TipoDest(A_Description,ntipo)  =  objNodo.SelectSingleNode("Description").text				
				TipoDest(A_MinimumPrice,ntipo)  =  objNodo.SelectSingleNode("MinimumPrice").text
				TipoDest(A_MinimumPriceType,ntipo)  =  objNodo.SelectSingleNode("MinimumPriceType").text
								
								 
   		NEXT  'objItem
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------
 		if ntipo>-1 then
 	    	   HOTEL_TYPE_DESTINATION=TipoDest
		  else
 			   HOTEL_TYPE_DESTINATION=NULL
		end if
		'-------------------------------------------------------------------------------				
ELSE
       envioError=sendEmailToControl("martin@planeta-web.com","HOTEL_TYPE_DESTINATION","pruebas@planeta-web.com",laurl,"")
       HOTEL_TYPE_DESTINATION=NULL
End If 
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION HOTEL_TYPE_FILTER(tipo,accomodationid,accomodationzoneids,accomodationtypeids,accomodationratingids,referencepointx,referencepointy,distance,accomodationstates,withrooms,roomtypeids,start,end_,adults,children,features)


SELECT CASE tipo
 	CASE "zona"
                laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=100&AccomodationZoneIds="&idprod&""
	CASE "typeAccSearch"
                laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=100"
   ' CASE "typeAccList"
    '            laurl=urlWebServers&"MasterTables.aspx"& webLogin & "&service=101&accomodationtypeids="&TYPE_ACOMODATION(idprod)&""						
 	CASE ELSE
               laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=100"
END SELECT  

		IF (accomodationid <> "")        THEN laurl=laurl+ "&accomodationid="&accomodationid&""
		IF (accomodationzoneids <> "")   THEN laurl=laurl+ "&accomodationzoneids="&accomodationzoneids&""
		IF (accomodationtypeids <> "")   THEN laurl=laurl+ "&accomodationtypeids="&accomodationtypeids&""
		IF (accomodationratingids <> "") THEN laurl=laurl+ "&accomodationratingids="&accomodationratingids&""
		IF (accomodationstates <> "")    THEN laurl=laurl+ "&accomodationstates="&accomodationstates&""
		IF (referencepointx <> "") 		 THEN laurl=laurl+ "&referencepointx="&referencepointx&""
		IF (referencepointy <> "") 	THEN laurl=laurl+ "&referencepointy="&referencepointy&""
		IF (distance <> "") 		THEN laurl=laurl+ "&distance="&distance&""
		IF (roomtypeids <> "") 		THEN laurl=laurl+ "&roomtypeids="&roomtypeids&""
		IF (withrooms <> "")  THEN laurl=laurl+ "&withrooms="&withrooms&""
		IF (start <> "") 	  THEN laurl=laurl+ "&start="&start&""
		IF (end_ <> "") 	  THEN laurl=laurl+ "&end="&end_&""
		IF (adults <> "") 	  THEN laurl=laurl+ "&adults="&adults&""
		IF (children <> "")   THEN laurl=laurl+ "&children="&children&""
		IF (features <> "")   THEN laurl=laurl+ "&features="&features&""
 
IF objDom.Load(laurl) THEN
 
 
 		DIM TipoDest()
			ntipo=-1			
					A_Id=0:A_Name=1:A_TypeName=2:A_RatingName=3:A_Email=4:A_Address=5:A_ID=6:A_ZipCode=7:A_TownName=8:A_TownId=9:A_Telephone=10
					A_Fax=11:A_WebPage=12:A_DefaultCurrencyId=13:A_ZoneId=14:A_Order=15:A_AnulationDays=16:A_PrepayPercentage=17:A_Coordinates=18				
					A_Extras=19:A_Status=20:A_MainPhoto=21:A_Observations=22:A_Conditions=23:A_ZoneName=24:A_TypeId=25:A_RatingId=26:A_Balloon=27
					A_GmapIcon=28:A_Distance=29:A_Description=30:A_MinimumPrice=31:A_MinimumPriceType=32
					 			
 			
		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/ArrayOfAccomodation/Accomodation")
				ntipo=ntipo+1
				redim preserve TipoDest(34,ntipo) 
				TipoDest(A_Id,ntipo)   =  paClng(objNodo.SelectSingleNode("Id").text)
				TipoDest(A_Name,ntipo)  =  objNodo.SelectSingleNode("Name").text
  
				TipoDest(A_TypeName,ntipo)  =  objNodo.SelectSingleNode("TypeName").text
				TipoDest(A_RatingName,ntipo)  =  objNodo.SelectSingleNode("RatingName").text
				TipoDest(A_Email,ntipo)  =  objNodo.SelectSingleNode("Email").text
				TipoDest(A_Address,ntipo)  =  objNodo.SelectSingleNode("Address").text
				TipoDest(A_ZipCode,ntipo)  =  objNodo.SelectSingleNode("ZipCode").text
				TipoDest(A_TownName,ntipo)  =  objNodo.SelectSingleNode("TownName").text
				
				TipoDest(A_TownId,ntipo)  =  objNodo.SelectSingleNode("TownId").text
				TipoDest(A_Telephone,ntipo)  =  objNodo.SelectSingleNode("Telephone").text
				TipoDest(A_Fax,ntipo)  =  objNodo.SelectSingleNode("Fax").text
				TipoDest(A_WebPage,ntipo)  =  objNodo.SelectSingleNode("WebPage").text
				TipoDest(A_DefaultCurrencyId,ntipo)  =  objNodo.SelectSingleNode("DefaultCurrencyId").text
				
				TipoDest(A_ZoneId,ntipo)  =  objNodo.SelectSingleNode("ZoneId").text
				TipoDest(A_Order,ntipo)  =  objNodo.SelectSingleNode("Order").text
				TipoDest(A_AnulationDays,ntipo)  =  objNodo.SelectSingleNode("AnulationDays").text
				TipoDest(A_PrepayPercentage,ntipo)  =  objNodo.SelectSingleNode("PrepayPercentage").text
				TipoDest(A_Coordinates,ntipo)  =  objNodo.SelectSingleNode("Coordinates").text
				
				TipoDest(A_Extras,ntipo)  =  objNodo.SelectSingleNode("Extras").text
				TipoDest(A_Status,ntipo)  =  objNodo.SelectSingleNode("Status").text
				TipoDest(A_MainPhoto,ntipo)  =  objNodo.SelectSingleNode("MainPhoto").text
				TipoDest(A_Observations,ntipo)  =  objNodo.SelectSingleNode("Observations").text
				TipoDest(A_Conditions,ntipo)  =  objNodo.SelectSingleNode("Conditions").text
				
				TipoDest(A_ZoneName,ntipo)  =  objNodo.SelectSingleNode("ZoneName").text
				TipoDest(A_TypeId,ntipo)  =  objNodo.SelectSingleNode("TypeId").text
				TipoDest(A_RatingId,ntipo)  =  objNodo.SelectSingleNode("RatingId").text
				TipoDest(A_Balloon,ntipo)  =  objNodo.SelectSingleNode("Balloon").text
				TipoDest(A_GmapIcon,ntipo)  =  objNodo.SelectSingleNode("GmapIcon").text
				TipoDest(A_Distance,ntipo)  =  objNodo.SelectSingleNode("Distance").text

				TipoDest(A_Description,ntipo)  =  objNodo.SelectSingleNode("Description").text				
				TipoDest(A_MinimumPrice,ntipo)  =  objNodo.SelectSingleNode("MinimumPrice").text
				TipoDest(A_MinimumPriceType,ntipo)  =  objNodo.SelectSingleNode("MinimumPriceType").text
								
								 
   		NEXT  'objItem
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------
 		if ntipo>-1 then
 	    	   HOTEL_TYPE_FILTER=TipoDest
		  else
 			   HOTEL_TYPE_FILTER=NULL
		end if
		'-------------------------------------------------------------------------------				
ELSE
       envioError=sendEmailToControl("martin@planeta-web.com","HOTEL_TYPE_FILTER","pruebas@planeta-web.com",laurl,"")
       HOTEL_TYPE_FILTER=NULL
End If 
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION HOTEL_TYPE_FILTER_STEP2 (accomodationid,idAcc,accomodationzoneids,start,end_,adults,children)

        laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=100"
         
 	    IF (idAcc <> "")                 THEN laurl=laurl+ "&id="&idAcc&""
		IF (accomodationid <> "")        THEN laurl=laurl+ "&accomodationid="&accomodationid&""
		IF (accomodationzoneids <> "")   THEN laurl=laurl+ "&accomodationzoneids="&accomodationzoneids&""
	    IF (accomodationtypeids <> "")   THEN laurl=laurl+ "&accomodationtypeids="&accomodationtypeids&""
		IF (accomodationratingids <> "") THEN laurl=laurl+ "&accomodationratingids="&accomodationratingids&""
		IF (accomodationstates <> "") THEN laurl=laurl+ "&accomodationstates="&accomodationstates&""
		IF (referencepointx <> "") 		 THEN laurl=laurl+ "&referencepointx="&referencepointx&""
		IF (referencepointy <> "") 	THEN laurl=laurl+ "&referencepointy="&referencepointy&""
		IF (distance <> "") 		THEN laurl=laurl+ "&distance="&distance&""
		IF (roomtypeids <> "") 		THEN laurl=laurl+ "&roomtypeids="&roomtypeids&""
		IF (withrooms <> "")  THEN laurl=laurl+ "&withrooms="&withrooms&""
		IF (start <> "") 	  THEN laurl=laurl+ "&start="&start&""
		IF (end_ <> "") 	  THEN laurl=laurl+ "&end="&end_&""
		IF (adults <> "") 	  THEN laurl=laurl+ "&adults="&adults&""
		IF (children <> "")   THEN laurl=laurl+ "&children="&children&""
		IF (features <> "")   THEN laurl=laurl+ "&features="&features&""
  
  'response.Write laurl
IF objDom.Load(laurl) THEN
 
 
 		DIM TipoStep()
			ntipo=-1			
			A_Id=0:A_Name=1:A_TypeName=2:A_RatingName=3:A_Email=4:A_Address=5:A_ID=6:A_ZipCode=7:A_TownName=8:A_TownId=9:A_Telephone=10
			A_Fax=11:A_WebPage=12:A_DefaultCurrencyId=13:A_ZoneId=14:A_Order=15:A_AnulationDays=16:A_PrepayPercentage=17:A_Coordinates=18				
			A_Extras=19:A_Status=20:A_MainPhoto=21:A_Observations=22:A_Conditions=23:A_ZoneName=24:A_TypeId=25:A_RatingId=26:A_Balloon=27
			A_GmapIcon=28:A_Distance=29:A_Description=30:A_MinimumPrice=31:A_MinimumPriceType=32
					 			
 			
		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/ArrayOfAccomodation/Accomodation")
				ntipo=ntipo+1
				redim preserve TipoStep(34,ntipo) 
				TipoStep(A_Id,ntipo)   =  paClng(objNodo.SelectSingleNode("Id").text)
				TipoStep(A_Name,ntipo)  =  objNodo.SelectSingleNode("Name").text
  
				TipoStep(A_TypeName,ntipo)  =  objNodo.SelectSingleNode("TypeName").text
				TipoStep(A_RatingName,ntipo)  =  objNodo.SelectSingleNode("RatingName").text
				TipoStep(A_Email,ntipo)  =  objNodo.SelectSingleNode("Email").text
				TipoStep(A_Address,ntipo)  =  objNodo.SelectSingleNode("Address").text
				TipoStep(A_ZipCode,ntipo)  =  objNodo.SelectSingleNode("ZipCode").text
				TipoStep(A_TownName,ntipo)  =  objNodo.SelectSingleNode("TownName").text
				
				TipoStep(A_TownId,ntipo)  =  objNodo.SelectSingleNode("TownId").text
				TipoStep(A_Telephone,ntipo)  =  objNodo.SelectSingleNode("Telephone").text
				TipoStep(A_Fax,ntipo)  =  objNodo.SelectSingleNode("Fax").text
				TipoStep(A_WebPage,ntipo)  =  objNodo.SelectSingleNode("WebPage").text
				TipoStep(A_DefaultCurrencyId,ntipo)  =  objNodo.SelectSingleNode("DefaultCurrencyId").text
				
				TipoStep(A_ZoneId,ntipo)  =  objNodo.SelectSingleNode("ZoneId").text
				TipoStep(A_Order,ntipo)  =  objNodo.SelectSingleNode("Order").text
				TipoStep(A_AnulationDays,ntipo)  =  objNodo.SelectSingleNode("AnulationDays").text
				TipoStep(A_PrepayPercentage,ntipo)  =  objNodo.SelectSingleNode("PrepayPercentage").text
				TipoStep(A_Coordinates,ntipo)  =  objNodo.SelectSingleNode("Coordinates").text
				
				TipoStep(A_Extras,ntipo)  =  objNodo.SelectSingleNode("Extras").text
				TipoStep(A_Status,ntipo)  =  objNodo.SelectSingleNode("Status").text
				TipoStep(A_MainPhoto,ntipo)  =  objNodo.SelectSingleNode("MainPhoto").text
				TipoStep(A_Observations,ntipo)  =  objNodo.SelectSingleNode("Observations").text
				TipoStep(A_Conditions,ntipo)  =  objNodo.SelectSingleNode("Conditions").text
				
				TipoStep(A_ZoneName,ntipo)  =  objNodo.SelectSingleNode("ZoneName").text
				TipoStep(A_TypeId,ntipo)  =  objNodo.SelectSingleNode("TypeId").text
				TipoStep(A_RatingId,ntipo)  =  objNodo.SelectSingleNode("RatingId").text
				TipoStep(A_Balloon,ntipo)  =  objNodo.SelectSingleNode("Balloon").text
				TipoStep(A_GmapIcon,ntipo)  =  objNodo.SelectSingleNode("GmapIcon").text
				TipoStep(A_Distance,ntipo)  =  objNodo.SelectSingleNode("Distance").text

				TipoStep(A_Description,ntipo)  =  objNodo.SelectSingleNode("Description").text				
				TipoStep(A_MinimumPrice,ntipo)  =  objNodo.SelectSingleNode("MinimumPrice").text
				TipoStep(A_MinimumPriceType,ntipo)  =  objNodo.SelectSingleNode("MinimumPriceType").text
								
								 
   		NEXT  'objItem
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------
 		if ntipo>-1 then
 	    	   HOTEL_TYPE_FILTER_STEP2=TipoStep
		  else
 			   HOTEL_TYPE_FILTER_STEP2=NULL
		end if
		'-------------------------------------------------------------------------------				
ELSE
       envioError=sendEmailToControl("martin@planeta-web.com","HOTEL_TYPE_FILTER_STEP2","pruebas@planeta-web.com",laurl,"")
       HOTEL_TYPE_FILTER_STEP2=NULL
End If 
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION HOTEL_TYPE_FILTER_ROOMS(accomodationid,start,end_,adults,children)

        laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=100"
 
		IF (accomodationid <> "")    THEN laurl=laurl+ "&accomodationid="&accomodationid&""
		IF (start <> "") 	  		 THEN laurl=laurl+ "&start="&start&""
		IF (end_ <> "") 	         THEN laurl=laurl+ "&end="&end_&""
		IF (adults <> "") 	         THEN laurl=laurl+ "&adults="&adults&""
		IF (children <> "")          THEN laurl=laurl+ "&children="&children&""

  'response.Write laurl
 
IF objDom.Load(laurl) THEN
 
  		DIM TipoRooms()
			ntipo=-1			
			A_Id=0:A_AccomodationId=1:A_Name=2:A_Order=3:A_MaxCapacity=4:A_MinCapacity=5:A_RegularCapacity=6
			A_MaxAdults=7:A_MinAdults=8:A_MaxChildren=9:A_Price=10:A_CradleAccountable=11 
  			
		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/ArrayOfAccomodation/Accomodation/RoomList")
  		
 				ntipo=ntipo+1
				redim preserve TipoRooms(11,ntipo) 
						TipoRooms(A_Id,ntipo)   =  paClng(objNodo.SelectSingleNode("Id").text)
						TipoRooms(A_AccomodationId,ntipo)  =  objNodo.SelectSingleNode("AccomodationId").text
						TipoRooms(A_Name,ntipo)  =  objNodo.SelectSingleNode("Name").text
						TipoRooms(A_Order,ntipo)  =  objNodo.SelectSingleNode("Order").text
						TipoRooms(A_MaxCapacity,ntipo)  =  objNodo.SelectSingleNode("MaxCapacity").text
						TipoRooms(A_MinCapacity,ntipo)  =  objNodo.SelectSingleNode("MinCapacity").text
						TipoRooms(A_MaxAdults,ntipo)  =  objNodo.SelectSingleNode("MaxAdults").text
						TipoRooms(A_MinAdults,ntipo)  =  objNodo.SelectSingleNode("MinAdults").text
						TipoRooms(A_MaxChildren,ntipo)  =  objNodo.SelectSingleNode("MaxChildren").text
						TipoRooms(A_Price,ntipo)  =  objNodo.SelectSingleNode("Price").text
						TipoRooms(A_CradleAccountable,ntipo)  =  objNodo.SelectSingleNode("CradleAccountable").text
 								 
   		NEXT  'objItem
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------
 		if ntipo>-1 then
 	    	   HOTEL_TYPE_FILTER_ROOMS=TipoRooms
		  else
 			   HOTEL_TYPE_FILTER_ROOMS=NULL
		end if
		'-------------------------------------------------------------------------------				
ELSE
       envioError=sendEmailToControl("martin@planeta-web.com","HOTEL_TYPE_FILTER_ROOMS","pruebas@planeta-web.com",laurl,"")
       HOTEL_TYPE_FILTER_ROOMS=NULL
End If 
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////

FUNCTION HOTEL_TYPE_CURRENCY() 
laurl=urlWebServers&"MasterTables.aspx"& webLogin & "&service=101"
IF objDom.Load(laurl) THEN

 		DIM TipoCurre()
			ntipo=-1
			A_Id=0
			A_Name=1
			A_CodigoISO=2	

		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/ArrayOfCurrencyType/CurrencyType")
				ntipo=ntipo+1
				redim preserve TipoCurre(2,ntipo)				
				TipoCurre(A_Id,ntipo)   =  paClng(objNodo.SelectSingleNode("Id").text)
				TipoCurre(A_Name,ntipo)  =  objNodo.SelectSingleNode("Name").text
				TipoCurre(A_CodigoISO,ntipo)  =  objNodo.SelectSingleNode("CodigoISO").text
   		NEXT  'objItem
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------
 		if ntipo>-1 then
 	    	   HOTEL_TYPE_CURRENCY=TipoCurre
		  else
 			   HOTEL_TYPE_CURRENCY=NULL
		end if
		'-------------------------------------------------------------------------------	
		'-------------------------------------------------------------------------------				
ELSE
       envioError=sendEmailToControl("pbauza@bizzit.es","HOTEL_TYPE_CURRENCY","pruebas@planeta-web.com",laurl,"")
       HOTEL_TYPE_CURRENCY=NULL
	   					
End If
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
 
FUNCTION DATOS_HOTEL(establecimiento) 
laurl=urlWebServersAdminKubikcrs&"datosHotel.asp"& webLoginAdminKubik & "&est=" & establecimiento
IF objDom.Load(laurl) THEN

 		DIM InfoHotel()
			ntipo=-1
			A_Codigo=0
			A_Hotel=1
			A_Prepago=2
			A_Email=3
			A_Direccion=4
			A_Cp=5
			A_Poblacion=6
			A_Telefono=7
			A_Fax=8
			A_Categoria=9
			A_Zona=10
			A_TipoAloja=11	
			A_Estado=12	
			A_Moneda=13	
			A_Foto=14		
			A_GMValorX=15
			A_GMValorY=16
			A_GMZoom=17
			A_GMTexto=18
			A_GMIcono=19

		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/data")
				ntipo=ntipo+1
				redim preserve InfoHotel(21,ntipo)				
				InfoHotel(A_Codigo,ntipo)   =  paClng(objNodo.SelectSingleNode("codigo").text)
				InfoHotel(A_Hotel,ntipo)  =  objNodo.SelectSingleNode("hotel").text
				InfoHotel(A_Prepago,ntipo)  =  objNodo.SelectSingleNode("prepago").text
				InfoHotel(A_Email,ntipo)  =  objNodo.SelectSingleNode("email").text
				InfoHotel(A_Direccion,ntipo)  =  objNodo.SelectSingleNode("direccion").text
				InfoHotel(A_Cp,ntipo)  =  objNodo.SelectSingleNode("cp").text
				InfoHotel(A_Poblacion,ntipo)  =  objNodo.SelectSingleNode("poblacion").text
				InfoHotel(A_Telefono,ntipo)  =  objNodo.SelectSingleNode("telefono").text
				InfoHotel(A_Fax,ntipo)  =  objNodo.SelectSingleNode("fax").text
				InfoHotel(A_Categoria,ntipo)  =  objNodo.SelectSingleNode("categoria").text
				InfoHotel(A_Zona,ntipo)  =  objNodo.SelectSingleNode("zona").text
				InfoHotel(A_TipoAloja,ntipo)  =  objNodo.SelectSingleNode("tipoaloja").text
				InfoHotel(A_Estado,ntipo)  =  objNodo.SelectSingleNode("estado").text
				InfoHotel(A_Moneda,ntipo)  =  objNodo.SelectSingleNode("moneda").text
				InfoHotel(A_Foto,ntipo)  =  objNodo.SelectSingleNode("foto").text		
						
				FOR EACH objGoogleMap IN objDom.documentElement.SelectNodes("/data/googlemap") 
					InfoHotel(A_GMValorX,ntipo)  =  objGoogleMap.SelectSingleNode("valor_X").text
					InfoHotel(A_GMValorY,ntipo)  =  objGoogleMap.SelectSingleNode("valor_Y").text
					InfoHotel(A_GMZoom,ntipo)  =  objGoogleMap.SelectSingleNode("zoom").text
					InfoHotel(A_GMTexto,ntipo)  =  objGoogleMap.SelectSingleNode("texto").text
					InfoHotel(A_GMIcono,ntipo)  =  objGoogleMap.SelectSingleNode("icono").text
				NEXT				
				
   		NEXT  
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------
 		if ntipo>-1 then
 	    	   DATOS_HOTEL=InfoHotel
		  else
 			   DATOS_HOTEL=NULL
		end if
		'-------------------------------------------------------------------------------	
		'-------------------------------------------------------------------------------				
ELSE
       envioError=sendEmailToControl("pbauza@bizzit.es","DATOS_HOTEL","pruebas@planeta-web.com",laurl,"")
       DATOS_HOTEL=NULL
	   					
End If
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION HOTEL_SEARCH_FILTER(tipo,accomodationid,accomodationzoneids,accomodationtypeids,accomodationratingids,referencepointx,referencepointy,distance,accomodationstates,withrooms,roomtypeids,start,end_,adults,children,features)

'laurl=urlWebServersAdminKubikcrs&"buscadorPrecios.asp"& webLoginAdminKubik

laurl=urlWebServersAdminKubikcrs&"BuscadorPreciosAvanzado.asp"& webLoginAdminKubik



'Fecha Inicial
IF (start <> "")   					THEN laurl=laurl+ "&fini="&start&""
'Fecha Final
IF (end_ <> "")   					THEN laurl=laurl+ "&ffin="&end_&""
'Numero de adultos
IF (adults <> "")   				THEN laurl=laurl+ "&ad="&adults&""
'Numero de niños
IF (children <> "")   				THEN laurl=laurl+ "&ni="&children&""
'Codigo Tipo alojamiento TA
IF (accomodationid <> "")   		THEN laurl=laurl+ "&ta="&accomodationid&""
'Codigo Destino ZONA
IF (accomodationzoneids <> "")   	THEN laurl=laurl+ "&zona="&accomodationzoneids&""
 
'Variables adicionales para filtrar
'Codigo Hotel EST
'Nombre Hotel NH
'Codigo Caracteristica TS
'Codigo habitacion estandar TH
'Codigo Categoria CA
'Codigo regimen TR

		'IF (accomodationid <> "")        	THEN laurl=laurl+ "&accomodationid="&accomodationid&""
		'IF (accomodationzoneids <> "")   	THEN laurl=laurl+ "&accomodationzoneids="&accomodationzoneids&""
		'IF (accomodationtypeids <> "")   	THEN laurl=laurl+ "&accomodationtypeids="&accomodationtypeids&""
		'IF (accomodationratingids <> "") 	THEN laurl=laurl+ "&accomodationratingids="&accomodationratingids&""
		'IF (accomodationstates <> "")    	THEN laurl=laurl+ "&accomodationstates="&accomodationstates&""
		'IF (referencepointx <> "") 		 	THEN laurl=laurl+ "&referencepointx="&referencepointx&""
		'IF (referencepointy <> "") 			THEN laurl=laurl+ "&referencepointy="&referencepointy&""
		'IF (distance <> "") 				THEN laurl=laurl+ "&distance="&distance&""
		'IF (roomtypeids <> "") 				THEN laurl=laurl+ "&roomtypeids="&roomtypeids&""
		'IF (withrooms <> "")  				THEN laurl=laurl+ "&withrooms="&withrooms&""
		'IF (start <> "") 	  				THEN laurl=laurl+ "&start="&start&""
		'IF (end_ <> "") 	  				THEN laurl=laurl+ "&end="&end_&""
		'IF (adults <> "") 	  				THEN laurl=laurl+ "&adults="&adults&""
		'IF (children <> "")   				THEN laurl=laurl+ "&children="&children&""
		'IF (features <> "")   				THEN laurl=laurl+ "&features="&features&""
		
		
'response.Write(laurl)
			
IF objDom.Load(laurl) THEN
 
 
 		DIM InfoHotel()
			ntipo=-1		
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
			
			FOR EACH objNodo IN objDom.documentElement.SelectNodes("/data/hotel")
				ntipo=ntipo+1
				redim preserve InfoHotel(13,ntipo)	
				
				InfoHotel(A_IdEstablecimiento,ntipo)   =  paClng(objNodo.SelectSingleNode("codigo").text)
				InfoHotel(A_NombreEstablecimiento,ntipo)  =  objNodo.SelectSingleNode("nombre").text
				InfoHotel(A_IdZona,ntipo)  =  paClng(objNodo.SelectSingleNode("zona").text)
				InfoHotel(A_NombreZona,ntipo)  =  GET_ZONE_NAME(objNodo.SelectSingleNode("zona").text,webLang)  
				InfoHotel(A_IdTipoAlojaminto,ntipo)  =  paClng(objNodo.SelectSingleNode("tipo").text)
				InfoHotel(A_NombreTipoAlojamiento,ntipo)  =  objNodo.SelectSingleNode("nombreTipo").text
				InfoHotel(A_IdCategoria,ntipo)  =  paClng(objNodo.SelectSingleNode("categoria").text)
				InfoHotel(A_NombreCategoria,ntipo)  =  "" 
				InfoHotel(A_Descripcion,ntipo)  =  objNodo.SelectSingleNode("descripcion").text
				InfoHotel(A_Foto,ntipo)  =  objNodo.SelectSingleNode("urlfoto").text
				InfoHotel(A_Estado,ntipo)  =  objNodo.SelectSingleNode("estado").text
				InfoHotel(A_PrecioMinimo,ntipo)  =  GET_MINIMUM_PRICE(objNodo.SelectSingleNode("codigo").text, start, end_)
					
			NEXT  'objItem
		
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------
 		if ntipo>-1 then
 	    	   HOTEL_SEARCH_FILTER=InfoHotel
		  else
 			   HOTEL_SEARCH_FILTER=NULL
		end if
		'-------------------------------------------------------------------------------				
ELSE
       'envioError=sendEmailToControl("pbauza@bizzit.es","HOTEL_SEARCH_FILTER","pruebas@planeta-web.com",laurl,"")
       HOTEL_SEARCH_FILTER=NULL
End If 
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION GET_ZONE_NAME(accomodationzoneids,lang)

laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=102&AccomodationZoneIds="&accomodationzoneids&"&lang="&lang

IF objDom.Load(laurl) THEN

 		DIM TipoValor()
			ntipo=-1			
			A_Valor=0
							 			
		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/ArrayOfValor/Valor")
				ntipo=ntipo+1
				redim preserve TipoValor(2,ntipo) 
				TipoValor(A_Valor,ntipo)   =  objNodo.SelectSingleNode("ValorDato").text				
								 
   		NEXT  
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------
 		if ntipo>-1 then
 	    	   GET_ZONE_NAME=TipoValor(A_Valor,0)
		  else
 			   GET_ZONE_NAME=""
		end if
		'-------------------------------------------------------------------------------	
					
ELSE
       envioError=sendEmailToControl("pbauza@bizzit.es","GET_ZONE_NAME","pruebas@planeta-web.com",laurl,"")
       GET_ZONE_NAME=NULL
End If 
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION GET_MINIMUM_PRICE(accomodationId, start, end_)

laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=103&accomodationid="&accomodationId&"&start="&start&"&end="&end_


IF objDom.Load(laurl) THEN

 		DIM TipoValor()
			ntipo=-1			
			A_Valor=0
							 			
		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/ArrayOfValor/Valor")
				ntipo=ntipo+1
				redim preserve TipoValor(2,ntipo) 
				TipoValor(A_Valor,ntipo)   =  objNodo.SelectSingleNode("ValorDato").text				
								 
   		NEXT  
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------	
 		if ntipo>-1 then
			if  TipoValor(A_Valor,0) = "" then
				GET_MINIMUM_PRICE=0
			else
				GET_MINIMUM_PRICE=TipoValor(A_Valor,0)
			end if    	   
		else
 			   GET_MINIMUM_PRICE=0
		end if
		'-------------------------------------------------------------------------------	
					
ELSE
       envioError=sendEmailToControl("pbauza@bizzit.es","GET_MINIMUM_PRICE","pruebas@planeta-web.com",laurl,"")
       GET_MINIMUM_PRICE=NULL
End If 
END FUNCTION

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
FUNCTION GET_INFO_HOTEL(accomodationid)

laurl=urlWebServers&"Booking.aspx"& webLogin & "&service=104&accomodationid="&accomodationId&"&lang="&webLang

'response.Write("URL: " & laurl & "<br>")

IF objDom.Load(laurl) THEN

 		DIM InfoHotelPlus()
			ntipo=-1			
			A_codigoEsta = 0
			A_nombre = 1
			A_estado = 2
			A_idZona = 3
			A_zona = 4
			A_idTipoAlojamiento = 5
			A_n_TipoAlojamiento = 6
			A_id_Categoria = 7
			A_n_Categoria = 8
			A_foto = 9
			A_direccion = 10
			A_descripcion = 11
			A_valoracion = 12
			A_descripcion2 = 13
			A_servicios = 14
			A_restauracion = 15
			A_situacion = 16
			
		FOR EACH objNodo IN objDom.documentElement.SelectNodes("/ArrayOfAccomodationDetails/AccomodationDetails")
				ntipo=ntipo+1
				redim preserve InfoHotelPlus(18,ntipo)
				'response.Write(objNodo.SelectSingleNode("CodigoEsta").text) 
				'response.Write(objNodo.SelectSingleNode("Nombre").text) 
				'response.Write(objNodo.SelectSingleNode("Estado").text) 
				
				InfoHotelPlus(A_codigoEsta, ntipo)			=	objNodo.SelectSingleNode("CodigoEsta").text
				InfoHotelPlus(A_nombre, ntipo)				=	objNodo.SelectSingleNode("Nombre").text
				InfoHotelPlus(A_estado, ntipo)				=	objNodo.SelectSingleNode("Estado").text
				InfoHotelPlus(A_idZona, ntipo)				=	objNodo.SelectSingleNode("IdZona").text
				InfoHotelPlus(A_zona, ntipo)				=	objNodo.SelectSingleNode("Zona").text
				InfoHotelPlus(A_idTipoAlojamiento, ntipo)	=	objNodo.SelectSingleNode("IdTipoAlojamiento").text
				InfoHotelPlus(A_n_TipoAlojamiento, ntipo)	=	objNodo.SelectSingleNode("N_TipoAlojamiento").text
				InfoHotelPlus(A_id_Categoria, ntipo)		=	objNodo.SelectSingleNode("Id_Categoria").text
				InfoHotelPlus(A_n_Categoria, ntipo)			=	objNodo.SelectSingleNode("N_Categoria").text
				InfoHotelPlus(A_foto, ntipo)				=	objNodo.SelectSingleNode("Foto").text
				InfoHotelPlus(A_direccion, ntipo)			=	objNodo.SelectSingleNode("Direccion").text
				InfoHotelPlus(A_descripcion, ntipo)			=	objNodo.SelectSingleNode("Descripcion").text
				InfoHotelPlus(A_valoracion, ntipo)			=	objNodo.SelectSingleNode("Valoracion").text
				InfoHotelPlus(A_descripcion2, ntipo)		=	objNodo.SelectSingleNode("Descripcion2").text
				InfoHotelPlus(A_servicios, ntipo)			=	objNodo.SelectSingleNode("Servicios").text
				InfoHotelPlus(A_restauracion, ntipo)		=	objNodo.SelectSingleNode("Restauracion").text
				InfoHotelPlus(A_situacion, ntipo)			=	objNodo.SelectSingleNode("Situacion").text			 
   		NEXT  
		SET objNodo=nothing		
		'-------------------------------------------------------------------------------	
 		if ntipo>-1 then
 	    	   GET_INFO_HOTEL=InfoHotelPlus
		  else
 			   GET_INFO_HOTEL=NULL
		end if
		'-------------------------------------------------------------------------------	
					
ELSE
       envioError=sendEmailToControl("pbauza@bizzit.es","GET_INFO_HOTEL","pruebas@planeta-web.com",laurl,"")
       GET_INFO_HOTEL=NULL
End If 
END FUNCTION
 
%>
