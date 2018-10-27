<%
	function logger (archivo, mensaje)
		mensaje = vbcrlf & date() & " " & time() & vbtab & mensaje
		
		set fs = createObject("scripting.filesystemobject")
		
		archivo = request.serverVariables("APPL_PHYSICAL_PATH") & archivo & ".logger"
		
		set f = fs.OpenTextFile(archivo, 8, true, -1)
		f.WriteLine(mensaje)
		f.Close
		
		logger = archivo
	end function
%>