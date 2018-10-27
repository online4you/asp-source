<div id='capaPP'>
	<script language="javascript" type="text/javascript">
	function cambiaPP(ese){
		top.document.getElementById('paCookies').src="/includes/grabaCookie.asp?valor="+ese.value+"&eti=<%=miPag%>&if="+self.name;
	}
	function recarga(){
		window.location.reload();
	}
	</script>
	<select name="pp" onChange="cambiaPP(this);">
	<option value="999999"<%if PorPag=999999 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_todos")%></option>
	<option value="15"<%if PorPag=15 then response.write " selected"%>>15</option>
	<option value="25"<%if PorPag=25 then response.write " selected"%>>25</option>
	<option value="50"<%if PorPag=50 then response.write " selected"%>>50</option>
	<option value="100"<%if PorPag=100 then response.write " selected"%>>100</option>
	</select>
	&nbsp;<%=objIdioma.getTraduccionHTML("i_regporpagina")%>
</div>