<html>

<head>
<title>Alteração de dados</title>
</head>

<body background=back.jpg>

<%@ LANGUAGE="JScript" %>

<%
	strDSN = "DBG_Clientes"
	
	cn = Server.CreateObject("ADODB.Connection")
	cn.Open(strDSN)
	
	opcao = Request.Form("Button")
	
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
function validar_password(objForm)

{
	input=document.form_input.dados_novos.value;    
			
		if (input=="") alert("O campo não pode ser nulo!");

		if (input!="") objForm.submit();
}

function checkEMail(objForm) {
	var locAt;
	var okEmail;
	inEmail = document.form_input.dados_novos.value;

	locAt = inEmail.indexOf("@");
	okEmail = ((locAt != -1) && 
			   (locAt != 0) &&
			   (locAt != (inEmail.length - 1)) &&
			   (inEmail.indexOf("@", locAt + 1) == -1)
			  );
	return okEmail;
}

function alertUser_Mail(objForm) {
	if (checkEMail(objForm)) {
		objForm.submit();
	} else {
		alert("Endereço de e-mail inválido");
	}
}

function checkHttp(objForm) {
	var locDot1;
	var locDot2;
	var okHttp;
	inHttp = document.form_input.dados_novos.value;

	locDot1 = inHttp.indexOf(".");
	okHttp = ((locDot1 != -1) && (locDot1 != (inHttp.length)-1) && (locDot1 != 0));
	return okHttp;
			
}


function alertUser_Http(objForm) {
	if (checkHttp(objForm)) {
		objForm.submit();
	} else {
		alert("Endereço de Web inválido");
	}
}


// -->
</SCRIPT>

<p><img src="dbg_logo.jpg" width="127" height="127"></p>

<form name="form_input" method="POST" action="gravar.asp">

<% 

	if (opcao=="E-MAIL") 

	{
		strSQL = "SELECT e_mail FROM cliente WHERE sigla = " + "'" + Request.Form("hold_login_value") + "'"
		rs_cliente_email = cn.Execute(strSQL)%>
		
		O seu actual endereço de e-mail é : <b><%Response.Write(rs_cliente_email("e_mail"))%></b>
		<br><br>
		Indique o seu novo e-mail :
		<input type="hidden" name="input_type" value="e-mail">
	
	<%}
	
	else
	
	if (opcao=="WWW")
	
	{
		strSQL = "SELECT www FROM cliente WHERE sigla = " + "'" + Request.Form("hold_login_value") + "'"
		rs_cliente_www = cn.Execute(strSQL)%>

		O seu actual endereço de Web é : <b><%Response.Write(rs_cliente_www("www"))%></b>
		<br><br>
		Indique o seu novo endereço de Web :
  		<input type="hidden" name="input_type" value="www">
  		
  	<%}
  	
  	else
  	
  	if (opcao=="PASSWORD")
  	
  	{
  		strSQL = "SELECT password FROM cliente WHERE sigla = " + "'" + Request.Form("hold_login_value") + "'"
		rs_cliente_password = cn.Execute(strSQL)%>
		Indique a nova password para o login : <b><%Response.Write(Request.Form("hold_login_value"))%></b>
		<input type="hidden" name="input_type" value="password">

	<%}%>

<br><br>

<% if (opcao=="PASSWORD")%> <input type="password" name="dados_novos" size="20"> 
		
   	<% else 
   
   		if (opcao=="WWW")%> http://<input type="text" name="dados_novos" size="20"> 
		
			<% else %> <input type="text" name="dados_novos" size="20">
		
		
	
<% if (opcao=="E-MAIL") {%>
		
		<input type="button" value="Enviar" onClick="alertUser_Mail(form_input)">
	
   		<%}%>
   
   <% else 
	
		if (opcao=="WWW") {%>
		
			<input type="button" value="Enviar" onClick="alertUser_Http(form_input)">
		
		<%}%>

		<input type="button" name="Cancelar" value="Cancelar" onclick=history.back()>
		<input type="hidden" name="hold_login_value" value="<% Response.Write(Request.Form("hold_login_value")) %>" size="20">
		

</form>

</center>

<% cn.Close() %>

</body>
</html>
