<html>

<head>
<title>Aplicações do Cliente</title>
</head>

<body background="back.jpg">

<% @LANGUAGE="Jscript" %> 

<%
	strDSN = "DBG_Clientes"
	
	cn = Server.CreateObject("ADODB.Connection")  
	cn.Open(strDSN)

	login_form = Request.Form("hold_login_value")
			
	strSQL_applic = " SELECT sigla_aplicacao,designacao,tipo_rede FROM aplicacao INNER JOIN cliente_tem_aplicacao ON aplicacao.codigo_aplicacao = cliente_tem_aplicacao.codigo_aplicacao WHERE cliente_tem_aplicacao.sigla='" + login_form +"'";
			
	rs_applic = cn.Execute(strSQL_applic)
			
%>

<p><img src="dbg_logo.jpg" width="127" height="127"></p>
Cliente : <b><%=(login_form) %></b>


<table align="center" cellpadding="5" border="0" width="70%">
  <tr>
  	<td align="center" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">APLICAÇÕES DE QUE DISPOEM</font></td>
  	<td align="center" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">SIGLA DA APLICAÇÃO</font></td>
  	<td align="center" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">TIPO DE REDE</font></td>
  </tr>  
  <% while (!(rs_applic.EOF)) 
    		{%> 
  <tr> 
    <td bgcolor="f7efde" align="left"><b><%=(rs_applic("designacao"))%></b></td>
    <td bgcolor="f7efde" align="left"><%=(rs_applic("sigla_aplicacao"))%></td>
    <td bgcolor="f7efde" align="center"><%=(rs_applic("tipo_rede"))%></td>
  </tr>
  <% rs_applic.MoveNext();
    		}%> 
</table>

<br>

<table width="100%" border="0" height="30">
  <tr> 
    <td width="28%" height="37"> 
      	<center>
      	<form method="POST" action="contrato.asp">
        <input type="submit" value="VER CONTRATO">
        <input type="hidden" name="hold_login_value" value="<% Response.Write(login_form) %>" size="20">
        </form>
        </center>
    </td>
    <td width="46%" height="37"> 
        <center>
      	<form method="POST" action="dados.asp">
        <input type="submit" value="VER DADOS">
        <input type="hidden" name="hold_login_value" value="<% Response.Write(login_form) %>" size="20">
        </form>
        </center>
    </td>
    <td width="26%" height="37">
    	<center>
      	<form method="POST" action="login.asp">
        <input type="submit" value="PÁGINA LOGIN">
        </form>
        </center>
    </td>
  </tr>
</table>

<% cn.Close() %>

</body>
</html>
