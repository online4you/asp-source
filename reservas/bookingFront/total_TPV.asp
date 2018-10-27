           <%if mostrarTotal then%>
		    <tr>
              <td align="left" class="colu1" valign="top"><b><%=objIdioma.getTraduccionHTML("i_totalres")%>:</b></td>
              <td align="left" valign="top">
			  <input name="totalres" type="hidden" value="<%=formatnumber(totalreserva+totalservi,2)%>" size="10" maxlength="8" readonly class="combo5" style="width: 70px;">
			  <%=formatnumber(totalreserva+totalservi,2)%>&nbsp;<%=monedaHotel%>
              &nbsp;&nbsp;*&nbsp;<%=objIdioma.getTraduccionHTML("i_impuestos")%>
              <%if monedaHotel<>coin then 'poner el cambio
					response.write "<br>Aprox. <b>" & formatnumber((totalreserva+totalservi)*elCambio,2) & sufijoMoneda & "</b>"
					response.write " (1 " & monedaHotel & " = " & elCambio & " " & coin & ")"
				end if 'modenahotel<>coin
				%>
              </td>
             </tr>
			<%if prepago <> 100 then %>
            <!--<tr style="visibility: hidden; height: 0px;">
                <td height="0px" class="colu1"  style="height: 0px; line-height: 0px;"></td>
                <td height="0px" align="left" style="height: 0px; line-height: 0px;">
                <input id="cuanto_1" class="styled"  title="elPrepago(document.getElementById('cuanto_1'))" type="radio" name="cuanto" value="min" onclick="javascript:elPrepago(this);" checked>
                &nbsp;<b><%=objIdioma.getTraduccionHTML("i_pagoprepago1") & " " & prepago & objIdioma.getTraduccionHTML("i_pagoprepago2")%></b><br/>
                <input id="cuanto_2" class="styled"  title="elPrepago(document.getElementById('cuanto_2'))" type="radio" name="cuanto" value="max" onclick="javascript:elPrepago(this);">
                &nbsp;<b><%=objIdioma.getTraduccionHTML("i_pagototal")%></b>
                </td>
            </tr>-->
            <tr>
              <td align="left" class="colu1" valign="top"><b><%=objIdioma.getTraduccionHTML("i_prepago")%>:</b></td>
              <td align="left" valign="top"><input name="prepago" type="hidden" value="<%=formatnumber(pelasprepago,2)%>" size="10" maxlength="8" readonly class="combo5" style="width: 70px;">
			  <%=formatnumber(pelasprepago,2)%>&nbsp;<%=monedaHotel%>
              <%if monedaHotel<>coin then 'poner el cambio
					response.write "<br>Aprox. <b>" & formatnumber(pelasprepago*elCambio,2) & sufijoMoneda & "</b>"
					response.write " (1 " & monedaHotel & " = " & elCambio & " " & coin & ")"
				end if 'modenahotel<>coin%>
              </td>
             </tr>
             
			 <%else 'se paga todo %>
             
			 <tr>
                <td class="colu1"></td>
                <td align="left">
             	<input name="prepago" type="hidden" value="<%=formatnumber(pelasprepago,2)%>" size="10" maxlength="8" readonly class="combo5">
             </td></tr>
             <%end if 'prepago%>
             <tr><td colspan="2" height="10"></td></tr>
             <tr>
                <td colspan="2">
                <%=objIdioma.getTraduccionHTML("i_textoreserva") & " " & prepago & objIdioma.getTraduccionHTML("i_textoreserva2")%></td>
            </tr>
         
		 
		 
		   <%else%>
		   
		   
		   
		   
		    <tr>
              <td colspan="2">
			  <input name="totalres" type="hidden" value="<%=formatnumber(totalreserva+totalservi,2)%>" size="10" maxlength="8" readonly class="combo5" style="width: 70px;">
              <input name="prepago" type="hidden" value="<%=formatnumber(pelasprepago,2)%>" size="10" maxlength="8" readonly class="combo5" style="width: 70px;">
			  </td>
             </tr>

           <%end if%>
