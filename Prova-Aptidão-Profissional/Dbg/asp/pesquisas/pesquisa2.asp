<html>

<head>
<title>TESTE</title>
</head>

<%@ LANGUAGE="JScript" %>

<body>

<% 
	strDSN = "DBG_Clientes"
		
	cn = Server.CreateObject("ADODB.Connection")
	cn.Open(strDSN)
	
	rsClientes = Server.CreateObject("ADODB.Recordset")
	
	rsClientes.ActiveConnection = cn;
	rsClientes.Source = "SELECT * FROM cliente WHERE e_mail = " + "'" + Request.Form("mail") + "'"
		
	rsClientes.Open()
%>

<div align="center">

<p align="center"><big><big><big><strong>LISTA DE CLIENTES DA DBG</strong></big></big></big></p>

<p align="center"><big>Indique e-mail da escola : </big></p>

<form method="POST" action="pesquisa1.asp">
  <p>
  <input type="text" name="mail" size="20"> 
  <input type="submit" value="Submit" name="B1">
  <input type="reset" value="Reset" name="B2">
  </p>
</form>

<div align="center"><center>

<table COLSPAN="8" CELLPADDING="5" BORDER="0">
  <tr>
    <td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">SIGLA</font>
    </td>
    <td ALIGN="Left" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">NOME</font>
    </td>
    <td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">E-MAIL</font>
    </td>
    <td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">WWW</font>
    </td>
  </tr>

<% while (!rsClientes.EOF) {%>
  
  <tr>
    <td align="left" bgcolor="f7efde" align="center">
    <%= rsClientes("sigla")%>
    </td>
    <td align="left" bgcolor="f7efde" align="center">
    <%= rsClientes("designacao_escola")%>
    </td>
    <td align="left" bgcolor="f7efde" align="center">
    <a href="mailto:%20<%= rsClientes("e_mail")%>">
    <%= rsClientes("e_mail")%></a> 
    </td>
    <td align="left" bgcolor="f7efde" align="center">
    <a href="<%= rsClientes("www")%>">
    <%= rsClientes("www")%></a> 
    </td>
  </tr>
<% 

rsClientes.MoveNext()
} 

%>
 
</table>
</center></div></div></div>
</body>
</html>
