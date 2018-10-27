		<div style="float:right; height:25px; margin-right:10px">
			<%=objIdioma.getTraduccionHTML("i_estadisticapor")%>
            <select name="tipofecha" onchange="javascript:cambiaTipoF(this);">
            <option value="fr"<%if tipof="fr" then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_fechareserva")%></option>
            <option value="fe"<%if tipof="fe" then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_fechaentrada")%></option>
            </select>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_todosloshoteles")%>' onclick="javascript:todosLosHoteles();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%=objIdioma.getTraduccionHTML("i_comparaconanyo")%>: 
            <select name='compara' onchange="Javascript:comparaD(this);">
            <%
            for aa=year(date)-4 to year(date)
                marca=""
                if compara=aa then marca=" selected"%>
                <option value="<%=aa%>"<%=marca%>><%=aa%></option>
            <%next%>
            </select>
		</div>
