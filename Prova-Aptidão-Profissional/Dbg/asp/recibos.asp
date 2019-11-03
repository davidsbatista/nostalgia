<html>

<head>
<title>Recibo da factura</title>
</head>

<body background="back.jpg"></body>

<% @LANGUAGE="Jscript" %>

<% 
	
	strDSN = "DBG_Clientes"
	
	cn = Server.CreateObject("ADODB.Connection")  
	cn.Open(strDSN)
	
	strSQL = " SELECT * FROM recibo WHERE numero_factura = " + Request.QueryString("numero_factura")
	
	rs_recibo_correspondente = cn.Execute(strSQL)
	
%>

<center><strong>RECIBO</strong></center>
<div align="center"><center>

<table COLSPAN="8" CELLPADDING="5" BORDER="0">
  <tr>
    <td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">NÚMERO DE RECIBO</font></td>
    <td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">REFERENTE À FACTURA Nº</font></td>
    <td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">VALOR</font></td>
    <td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">DATA</font></td>
  </tr>

  <tr>
    <td bgcolor="f7efde" align="center"><%Response.Write(rs_recibo_correspondente("numero_recibo"))%></td>
    <td bgcolor="f7efde" align="center"><%Response.Write(rs_recibo_correspondente("numero_factura"))%></td>
    <td bgcolor="f7efde" align="center"><%Response.Write(rs_recibo_correspondente("valor"))%></td>
    <td bgcolor="f7efde" align="center"><%Response.Write(rs_recibo_correspondente("data"))%></td>
  </tr>
</table>

<p>&nbsp;</p>

<input type="button"  value="Voltar" onclick=history.back()>

<% cn.Close() %>

</body>
</html>
