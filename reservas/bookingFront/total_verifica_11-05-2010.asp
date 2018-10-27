            <tr>
              <td align="right" class="colu1" valign="top"><b><%=objIdioma.getTraduccionHTML("i_totalres")%>:</b></td>
              <td align="left" valign="top"><input name="totalres" type="text" value="<%=formatnumber(totalreserva+totalservi,2)%>" size="10" maxlength="8" readonly class="combo5" style="width: 70px;">&nbsp;<%=monedaHotel%>
              &nbsp;&nbsp;*&nbsp;<%=objIdioma.getTraduccionHTML("i_impuestos")%>
              <%if monedaHotel<>coin then 'poner el cambio
					response.write "<br>Aprox. <b>" & formatnumber((totalreserva+totalservi)*elCambio,2) & sufijoMoneda & "</b>"
					response.write " (1 " & monedaHotel & " = " & elCambio & " " & coin & ")"
				end if 'modenahotel<>coin%>
                <input name="prepago" type="hidden" value="<%=formatnumber(totalreserva+totalservi,2)%>">
              </td>
             </tr>
             <tr><td colspan="2" height="10"></td></tr>
             <tr>
                <td class="colu1">&nbsp;</td>
                <td>
                
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr><td align="left" colspan="2">
				<p style="line-height:16px;"><%=objIdioma.getTraduccionHTML("i_pagodiferido")%></p></td></tr>
                <tr><td colspan="2" height="10"></td></tr>
                <tr>
                <td><%=objIdioma.getTraduccionHTML("i_tipotarjeta")%>*:</td>
                <td align="left">
                  <select name="tipotarjeta">
                    <option value="...">...</option>
                    <option value="VISA">VISA</option>
                    <option value="VISAElectron">VISA Electron</option>
                    <option value="MasterCard">MasterCard</option>
                    <option value="AmericanExpress">American Express</option>
                    <option value="Tarjeta4B">4B</option>
                    <option value="Maestro">Maestro</option>
                    <option value="Servired">Servired</option>
                  </select>
                  </td>
                </tr>
                <tr>
                    <td><%=objIdioma.getTraduccionHTML("i_numerotarjeta")%>*:</td>
                    <td align="left"> 
                      <input type="text" style="width:200px;" name="numerotarjeta" class="combo5"/></td>
                </tr>
                <tr>
                    <td><%=objIdioma.getTraduccionHTML("i_codigoseguridad")%>*:</td>
                    <td align="left"> 
                    	<input type="text" style="width:40px;" name="codigoseguridad" class="combo5"/>
                    </td>
                </tr>																								
                <tr>
                    <td><%=objIdioma.getTraduccionHTML("i_fechacaducidad")%>*:</td>
                    <td align="left"> 
                      <select name="mescadu">
                        <%for m=1 to 12%>
                        <option value="<%=right("0"&m,2)%>"><%=right("0"&m,2)%></option>
                        <%next%>
                      </select>
                      <select name="anyocadu">
                        <%for m=year(date) to year(date)+11%>
                        <option value="<%=m%>"><%=m%></option>
                        <%next%>
                      </select></td>
                </tr>	
                </table>
                <script language="javascript" type="text/javascript" src="js/controlTarjeta.js"></script>
				<script language="javascript" type="text/javascript">
				/*************************************************************************\
				CheckCardNumber(form)
				function called when users click the "check" button.
				\*************************************************************************/
				function CheckCardNumber(form) {
					 //debugger;
					 hoy=new Date();
					 var tmpyear;
					 if (form.numerotarjeta.value.length == 0) {
							 alert("<%=objIdioma.getTraduccion("i_ponertarjeta")%>");
							 form.numerotarjeta.focus();
						return false;
					 }
					 if (parseInt(form.anyocadu.options[form.anyocadu.selectedIndex].value,10) >= hoy.getFullYear())
						 tmpyear = form.anyocadu.options[form.anyocadu.selectedIndex].value;
					 else {
						  alert("<%=objIdioma.getTraduccion("i_erroranyo")%>");
					 return false;
					 }
					 tmpmonth = form.mescadu.options[form.mescadu.selectedIndex].value;
					 // The following line doesn't work in IE3, you need to change it
					 // to something like "(new CardType())...".
					// if (!CardType().isExpiryDate(tmpyear, tmpmonth)) {
					 if (!(new CardType()).isExpiryDate(tmpyear, tmpmonth)) {
						 alert("<%=objIdioma.getTraduccion("i_expirado")%>");
						 return false;
					 }
					 card = form.tipotarjeta.options[form.tipotarjeta.selectedIndex].value;
					 var retval = eval(card + ".checkCardNumber(\"" + form.numerotarjeta.value + "\", " + tmpyear + ", " + tmpmonth + ");");
					 cardname = "";
					 //debugger;
					 //codigo seguridad
					 if (card=="AmericanExpress" && form.codigoseguridad.value.length!=4) {
					 alert("<%=objIdioma.getTraduccion("i_errorcvv4")%>");
					 form.codigoseguridad.focus();
					 return false;
				 }
					if (card!="AmericanExpress" && form.codigoseguridad.value.length!=3) {
					 alert("<%=objIdioma.getTraduccion("i_errorcvv3")%>");
					 form.codigoseguridad.focus();
					 return false;
					 }
					if (retval) {
						 // comment this out if used on an order form
						 //alert("This card number appears to be valid.");
					 	return true;
					 } else {
						 // The cardnumber has the valid luhn checksum, but we want to know which
						 // cardtype it belongs to.
						 for (var n = 0; n < Cards.size; n++) {
							 if (Cards[n].checkCardNumber(form.numerotarjeta.value, tmpyear, tmpmonth)) {
								 cardname = Cards[n].getCardType();
								 break;
							 }
						 }
						 
						 if (cardname.length > 0) {
							 alert("<%=objIdioma.getTraduccion("i_cambiotarjeta1")%> " + cardname + "<%=objIdioma.getTraduccion("i_cambiotarjeta2")%> " + card + " <%=objIdioma.getTraduccion("i_cambiotarjeta3")%>");
							 return false;
							 }
							else {
							 alert("<%=objIdioma.getTraduccion("i_errorntarjeta")%>");
							 return false;
							 }
					  }
					}
				</script>
				
				</td>
            </tr>
			<tr><td colspan="2" height="10"></td></tr>