<!--#include virtual="/includes/FunGestion.asp"-->
<%
fichero=request.QueryString("file")

miFiche=SoloElFichero(fichero)
miFiche=transformaURL(miFiche)

%>
<script language="javascript" type="text/javascript">
parent.document.getElementById("up_archivo").value="<%=miFiche%>";
</script>