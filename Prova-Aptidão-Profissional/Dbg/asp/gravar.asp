<html>

<%@ LANGUAGE="JScript" %>

<% tipo = Request.Form("input_type") %>

<head>
<title>Alteração de <%=tipo%></title>
</head>

<body background="back.jpg">

<%
	strDSN = "DBG_Clientes"
		
	cn = Server.CreateObject("ADODB.Connection")
	cn.Open(strDSN)
	
	if (tipo=="password")
	
		{
			strSQL = "UPDATE cliente SET password = " + "'" + Request.Form("dados_novos") + "'" + " WHERE sigla = " + "'" + Request.Form("hold_login_value") + "'"
	
			cn.Execute(strSQL)
			
		}
		
	else
		
		if (tipo=="e-mail")
		
			{
			
				strSQL = "UPDATE cliente SET e_mail = " + "'" + Request.Form("dados_novos") + "'" + " WHERE sigla = " + "'" + Request.Form("hold_login_value") + "'"

				cn.Execute(strSQL)
				
			}
			
		else
		
			if (tipo=="www")
			
				{
				
					strSQL = "UPDATE cliente SET www = " + "' http://" + Request.Form("dados_novos") + "'" + " WHERE sigla = " + "'" + Request.Form("hold_login_value") + "'"

					cn.Execute(strSQL)
					
				}

%>
			
	<center>
	Dados alterados			
	<form method="POST" action="dados.asp">
	<input type="submit" value="Pagina Principal">
	<input type="hidden" name="hold_login_value" value="<% Response.Write(Request.Form("hold_login_value")) %>" size="20">
	</form>
	</center>
	
<% cn.Close() %>

</body>
</html>