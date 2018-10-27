        <div id='solapasNew' style="width:798px; z-index:2">
			<div id='solapa1' class='<%if slp=1 then response.write "laSolapaOverNew" else response.write "laSolapaNew"%>'>
			<a href="estadisticaGAnyoPelas.asp?todos=<%=todos & masquery%>" class='tituSolapa'><%=objIdioma.getTraduccionHTML("i_porimporte")%></a></div>
			<div id='solapa2' class='<%if slp=2 then response.write "laSolapaOverNew" else response.write "laSolapaNew"%>'>
			<a href="estadisticaGAnyoRes.asp?todos=<%=todos & masquery%>" class='tituSolapa'><%=objIdioma.getTraduccionHTML("i_porreserva")%></a></div>
			<div id='solapa3' class='<%if slp=3 then response.write "laSolapaOverNew" else response.write "laSolapaNew"%>'>
			<a href="estadisticaGAnyoEstancia.asp?todos=<%=todos & masquery%>" class='tituSolapa'><%=objIdioma.getTraduccionHTML("i_porestanciamedia")%></a></div>
			<div id='solapa4' class='<%if slp=4 then response.write "laSolapaOverNew" else response.write "laSolapaNew"%>'>
			<a href="estadisticaGAnyoMediaRes.asp?todos=<%=todos & masquery%>" class='tituSolapa'><%=objIdioma.getTraduccionHTML("i_porimportemedio")%></a></div>
			<div id='solapa5' class='<%if slp=5 then response.write "laSolapaOverNew" else response.write "laSolapaNew"%>'>
			<a href="estadisticaGAnyoIdioma.asp?todos=<%=todos & masquery%>" class='tituSolapa'><%=objIdioma.getTraduccionHTML("i_poridioma")%></a></div>
		</div>