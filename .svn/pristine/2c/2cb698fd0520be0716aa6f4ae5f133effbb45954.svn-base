<!--#include file="vwd_imgbounds.asp"-->
<html>
<head>
  <title>Insertar Imagen</title>

<script type="text/javascript" src="popup.js"></script>

<script type="text/javascript">


function Init() {
	window.resizeTo(550,450);
  __dlg_init();
  var param = window.dialogArguments;
  if (param) {
      document.getElementById("f_url").value = param["f_url"];
      document.getElementById("f_alt").value = param["f_alt"];
      document.getElementById("f_border").value = param["f_border"];
      document.getElementById("f_align").value = param["f_align"];
      document.getElementById("f_vert").value = param["f_vert"];
      document.getElementById("f_horiz").value = param["f_horiz"];
      document.getElementById('ipreview').src=param.f_url;
  }
  document.getElementById("f_url").focus();
};

function onOK() {
  var required = {
    "f_url": "Poner una URL válida"
  };
  for (var i in required) {
    var el = document.getElementById(i);
    if (!el.value) {
      alert(required[i]);
      el.focus();
      return false;
    }
  }
  // pass data back to the calling window
  var fields = ["f_url", "f_alt", "f_align", "f_border",
                "f_horiz", "f_vert"];
  var param = new Object();
  for (var i in fields) {
    var id = fields[i];
    var el = document.getElementById(id);
    param[id] = el.value;
  }
  __dlg_close(param);
  return false;
};

function onCancel() {
  __dlg_close(null);
  return false;
};

function onPreview() {
  var f_url = document.getElementById("f_url");
  var url = f_url.value;
  if (!url) {
    alert("Primero hay que poner una URL");
    f_url.focus();
    return false;
  }
  //window.ipreview.location.replace(url);
  document.getElementById('ipreview').src=url;
  return false;
};

function reCarga(vteurl) {
  document.getElementById('ipreview').src=vteurl;
  return false;
}
</script>

<style type="text/css">
html, body {
  background: ButtonFace;
  color: ButtonText;
  font: 11px Tahoma,Verdana,sans-serif;
  margin: 0px;
  padding: 0px;
}
body { padding: 5px; }
table {
  font: 11px Tahoma,Verdana,sans-serif;
}
form p {
  margin-top: 5px;
  margin-bottom: 5px;
}
.fl { width: 9em; float: left; padding: 2px 5px; text-align: right; }
.fr { width: 6em; float: left; padding: 2px 5px; text-align: right; }
fieldset { padding: 0px 10px 5px 5px; }
select, input, button { font: 11px Tahoma,Verdana,sans-serif; }
button { width: 70px; }
.space { padding: 2px; }

.title { background: #ddf; color: #000; font-weight: bold; font-size: 120%; padding: 3px 10px; margin-bottom: 10px;
border-bottom: 1px solid black; letter-spacing: 2px;
}
form { padding: 0px; margin: 0px; }
</style>

</head>

<body onload="Init()">

<div class="title">Insertar Imagen</div>
<!-- cosas del vte-->
<iframe width="440" height="120" frameborder="0" scrolling="no" src="cargaimg.asp"></iframe>

<!--- new stuff --->
<form action="" method="get">
<table border="0" width="500" style="padding: 0px; margin: 0px">
  <tr>
    <td style="width: 7em; text-align: right">Imagen URL:</td>
    <td><input type="text" name="url" id="f_url" style="width:300px"
      title="Poner la URL de la imagen" />
      <button name="preview" onclick="return onPreview();"
      title="Previsualizar la imagen">Previsualizar</button>
    </td>
  </tr>
  <tr>
    <td style="width: 7em; text-align: right">Texto ALTernativo:</td>
    <td><input type="text" name="alt" id="f_alt" style="width:250px"
      title="Para navegadores que no soportan gráficos" /></td>
  </tr>
</table>

<table width="500">
<tr><td align="left">
		<fieldset style="margin-left: 5px;">
		<legend>Capa</legend>
		
		<div class="space"></div>
		
		<div class="fl">Alinear:</div>
		<select size="1" name="align" id="f_align"
		  title="Colocacion de esta imagen">
		  <option value=""                             >Sin Alinear</option>
		  <option value="left"                         >Izquierda</option>
		  <option value="right"                        >Derecha</option>
		  <option value="texttop"                      >Texto Arriba</option>
		  <option value="absmiddle"                    >Enmedio</option>
		  <option value="baseline" selected="1"        >Baseline</option>
		  <option value="absbottom"                    >Abajo</option>
		  <option value="bottom"                       >Abajo del texto</option>
		  <option value="middle"                       >Enmedio del Texto</option>
		  <option value="top"                          >Arriba</option>
		</select>
		
		<p />&nbsp;&nbsp;&nbsp;&nbsp;
		
		<div class="fl">Grosor Borde:</div>
		<input type="text" name="border" id="f_border" size="5"
		title="Dejar vacio para no poner borde" />
		
		<div class="space"></div>
		
		</fieldset>
	</td>
	<td align="left">
		<fieldset style="margin-right: 5px;">
		<legend>Separación</legend>
		
		<div class="space"></div>
		
		<div class="fr">Horizontal:</div>
		<input type="text" name="horiz" id="f_horiz" size="5"
		title="Horizontal padding" />
		
		<p />&nbsp;&nbsp;&nbsp;&nbsp;
		
		<div class="fr">Vertical:</div>
		<input type="text" name="vert" id="f_vert" size="5"
		title="Vertical padding" />
		</fieldset>
	</td>
</tr>
</table>
<table width="100%" style="margin-bottom: 0.2em">
 <tr>
  <td valign="top">
    Previsualización<br>
	<img name="ipreview" id="ipreview" style="border : 1px solid gray;" height="150" width="300" src="" />
  </td>
  <td valign="bottom" style="text-align: right">
    <button type="button" name="ok" onclick="return onOK();">OK</button><br>
    <button type="button" name="cancel" onclick="return onCancel();">Cancelar</button>
  </td>
 </tr>
</table>
</form>
</body>
</html>
