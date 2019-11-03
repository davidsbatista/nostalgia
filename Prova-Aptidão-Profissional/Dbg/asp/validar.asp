<html>

<head>
<title>Validação de Cliente</title>
</head>

<body background="back.jpg"><center>

<p><img src="dbg_logo.jpg" width="127" height="127"></p>

<% @LANGUAGE="Jscript" %>

<% 
	
	strDSN = "DBG_Clientes"
	
	cn = Server.CreateObject("ADODB.Connection")  
	cn.Open(strDSN)
	
	strSQL = " SELECT sigla, password FROM cliente WHERE sigla='" + Request.Form("username_value") + "'" + " AND password='" + Request.Form("password_value") + "'";
		
	rs_login = cn.Execute(strSQL)
	
	if (rs_login.EOF) 
		
		{%>

		<p><font size="+1">login inv&aacute;lido</font><br>
		<form>
		<input type="button" name="Cancelar" value="Voltar" onclick=history.back()>
  		</form>
  		</p>
		<%}
		
	else 
	
		{%>

		<p><font size="+1">login v&aacute;lido</font> 
		
		<!-- ********* FORM QUE PASSA PARA A ASP SEGUINTE O VALOR DA SIGLA SOB A FORM DE CAMPO ESCONDIDO ****** -->
		<form method="POST" action="dados.asp">
		<input type="hidden" name="hold_login_value" value="<%= (rs_login("sigla"))%>" size="20">
		<input type="submit" value="Continuar">
		</form>
		<!-- ************************************************************************************************** -->
		
		</p>

		<%}

cn.Close() %>

</body>
</html>
