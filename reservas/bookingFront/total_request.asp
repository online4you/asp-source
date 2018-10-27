            <tr>
                <td align="right" class="colu1" valign="top"><b><%=objIdioma.getTraduccionHTML("i_totalpresu")%>:</b></td>
                <td align="left">
                <input name="totalres" type="text" value="<%=formatnumber(totalreserva+totalservi,2)%>" size="10" maxlength="8" readonly class="combo5" style="width: 70px;">&nbsp;<%=monedaHotel%>
                <%if monedaHotel<>coin then 'poner el cambio
					response.write "<br>Aprox. <b>" & formatnumber((totalreserva+totalservi)*elCambio,2) & sufijoMoneda & "</b>"
					response.write " (1 " & monedaHotel & " = " & elCambio & " " & coin & ")"
				end if 'modenahotel<>coin%>
                
                <br/>*&nbsp;<%=objIdioma.getTraduccionHTML("i_impuestos")%>
              <input name="prepago" type="hidden" value="<%=formatnumber(totalreserva+totalservi,2)%>">
              </td>
             </tr>
             <tr><td colspan="2" height="10"></td></tr>
             <tr>
                <td class="colu1">&nbsp;</td>
                <td><%=objIdioma.getTraduccionHTML("i_textopresu")%></td>
            </tr>    
