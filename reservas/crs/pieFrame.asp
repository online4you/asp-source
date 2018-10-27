<script language="javascript" type="text/javascript">
	//alert(document.getElementById('iframeConte').offsetHeight);
	//mialto=parseInt(document.getElementById('iframePrincipal').offsetHeight,10);
	if (document.getElementById('iframeConte')!=null) {
		mialto=parseInt(document.getElementById('iframeConte').offsetHeight,10);
		//alert(self.name);
		//alert(mialto);
		if (es_IE) mialto=mialto+2;
		if (mialto>513) {
			document.getElementById('iframePrincipal').style.height=(mialto+50)+"px";
			top.document.getElementById(self.name).style.height=(mialto+52)+"px";
		}else{
			top.document.getElementById(self.name).style.height="555px";
		}
	}
	//enfoca();
</script>
<%
'clase de idiomas
set objIdioma_es=nothing
set objIdioma_en=nothing
set objIdioma_de=nothing
set objIdioma_fr=nothing
set objIdioma_it=nothing

'la clase de cookies
set objCookies=nothing
%>
