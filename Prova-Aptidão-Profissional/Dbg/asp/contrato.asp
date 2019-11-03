<html>

<head>
<title>Contrato de Cliente</title>
</head>

<body background="back.jpg">

<% @LANGUAGE="Jscript" %> 

<%
	strDSN = "DBG_Clientes"
	
	cn = Server.CreateObject("ADODB.Connection")  
	cn.Open(strDSN)

	login_form = Request.Form("hold_login_value")
		
	strSQL_cliente = " SELECT sigla,num_contrato FROM cliente WHERE sigla='" + login_form +"'";
			
	rs_cliente = cn.Execute(strSQL_cliente)
			
	v_num_contrato = rs_cliente("num_contrato")
	
	strSQL_contrato = " SELECT * FROM contrato WHERE numero = " + v_num_contrato	
	rs_contrato = cn.Execute(strSQL_contrato) 
	
%>

<p><img src="dbg_logo.jpg" width="127" height="127"></p>

Dados contratuais para o cliente : <b><%=rs_cliente("sigla")%><b></strong><b>

<br>

<%if (!(rs_contrato.EOF))

	{%>

		<center><strong>DADOS DO CONTRATO</strong></center>
		<br>
		<div align="center"><center>

		<table COLSPAN="8" CELLPADDING="5" BORDER="0">
  		<tr>
    		<td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">NÚMERO</font></td>
    		<td ALIGN="LEFT" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">DATA DE VALIDADE</font></td>
    		<td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">TIPO DE CONTRATO</font></td>
  		</tr>
		<tr>
   			<td bgcolor="f7efde" align="center"><%Response.Write(rs_contrato("numero"))%></td>
   			<td bgcolor="f7efde" align="center"><%Response.Write(rs_contrato("data_validade"))%></td>
   			<td bgcolor="f7efde" align="center"><%Response.Write(rs_contrato("tipo"))%></td>
		</tr>
		</table>

		<br><hr width="99%" align="center" size="5"><br>

		<center><strong>FACTURAS REFERENTES AO CONTRATO</strong></center>
		<br>
		<div align="center"><center>

		<table COLSPAN="8" CELLPADDING="5" BORDER="0">
  		<tr>
    		<td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">NÚMERO</font></td>
    		<td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">VALOR COM IVA</font></td>
    		<td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">VALOR SEM IVA</font></td>
    		<td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">DATA EMISSÃO</font></td>
    		<td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">DATA VENCIMENTO</font></td>
    		<td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">FACTURA PAGA</font></td>
    		<td ALIGN="CENTER" BGCOLOR="#008080"><font STYLE="ARIAL NARROW" COLOR="#FFFFFF" SIZE="2">RECIBO CORRESPONDENTE</font></td>
  		</tr>

		<%
			strSQL_facturas = " SELECT * FROM factura WHERE num_contrato = " + v_num_contrato
			rs_facturas = cn.Execute(strSQL_facturas)
			while (!rs_facturas.EOF)
				{%>  
  					<tr>
    				<td bgcolor="f7efde" align="center"><%Response.Write(rs_facturas("numero_factura"))%></td>
    				<td bgcolor="f7efde" align="center"><%Response.Write(rs_facturas("valor_c_iva"))%></td>
    				<td bgcolor="f7efde" align="center"><%Response.Write(rs_facturas("valor_s_iva"))%></td>
    				<td bgcolor="f7efde" align="center"><%Response.Write(rs_facturas("data_emissao"))%></td>
    				<td bgcolor="f7efde" align="center"><%Response.Write(rs_facturas("data_venc"))%></td>
				
					<%if (!(rs_facturas("factura_paga")==0))
						{%>
    						<td bgcolor="f7efde" align="center">SIM</td>
    						<td bgcolor="f7efde" align="center"><a href="recibos.asp?numero_factura=<%Response.Write(rs_facturas("numero_factura"))%>">Recibo Correspondente</a></td>
    					<%}
    				else
    					{%>
    						<td bgcolor="f7efde" align="center"><b>NÃO</b></td>
    						<td bgcolor="f7efde" align="center"><b>Factura ainda não está paga</b></td>
    					<%}
  					rs_facturas.MoveNext()%>
   					</tr>

				<%}%>
		</table>
		<br><hr width="99%" align="center" size="5"><br>
	<%}
	
	else
		
		{%>
			<p>&nbsp;</p>
			<center>
			<font size="5">Este cliente não tem contrato</font>
			</center>
			<p>&nbsp;</p>
		<%}%>
	 

<br>

<table width="100%" border="0" height="30">
  <tr> 
    <td width="28%" height="37"> 
      	<center>
      	<form method="POST" action="dados.asp">
        <input type="submit" value="VER DADOS">
        <input type="hidden" name="hold_login_value" value="<% Response.Write(login_form) %>" size="20">
        </form>
        </center>
    </td>
    <td width="46%" height="37"> 
        <center>
      	<form method="POST" action="apps.asp">
        <input type="submit" value="VER APLICAÇÕES">
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
