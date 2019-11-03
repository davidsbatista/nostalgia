<html>

<head>
<title>CLIENTES</title>
</head>

<%@ LANGUAGE="JScript" %>

<body>

<p align="center"><big><big><big><strong>LISTA DE CLIENTES DA DBG</strong></big></big></big></p>
<div align="center">
<center>

<% 
	strDSN = "DBG_Clientes"
		
	cn = Server.CreateObject("ADODB.Connection")
	cn.Open(strDSN)
	
	rsClientes = Server.CreateObject("ADODB.Recordset")
	
	strSQL = "SELECT * FROM cliente"
	
	rsClientes.Open(strSQL, cn)
%>

<TABLE COLSPAN=8 CELLPADDING=5 BORDER=0>

<TR>

<TD ALIGN=CENTER BGCOLOR="#008080">
<FONT STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE=2>SIGLA</FONT>
</TD>
<TD ALIGN=Left BGCOLOR="#008080">
<FONT STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE=2>NOME</FONT>
</TD>
<TD ALIGN=CENTER  BGCOLOR="#008080">
<FONT STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE=2>E-MAIL</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#008080">
<FONT STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE=2>WWW</FONT>
</TD>


</TR>

<% while (!rsClientes.EOF) {%>

<tr>
  <td align=left bgcolor="f7efde" align=center>
    <%= rsClientes("sigla")%>  
  </td>
  <td align=left bgcolor="f7efde" align=center>
    <%= rsClientes("designacao_escola")%>  
  </td>
  <td align=left bgcolor="f7efde" align=center>    
    <a href="mailto: <%= rsClientes("e_mail")%>">
    <%= rsClientes("e_mail")%>	</a>
  </td>
  <td align=left bgcolor="f7efde" align=center>
    <a href=" <%= rsClientes("www")%>">
    <%= rsClientes("www")%>  </a>
</tr> 

<% 
rsClientes.MoveNext()
} 
%>

</TABLE>
</center>
</div>
</body>
</html>
