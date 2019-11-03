<html>

<head>
<title>Dados do Cliente</title>
</head>

<body background="back.jpg">

<% @LANGUAGE="Jscript" %> 

<% 
	strDSN = "DBG_Clientes"
	
	cn = Server.CreateObject("ADODB.Connection")  
	cn.Open(strDSN)

	login_form = Request.Form("hold_login_value")
		
	strSQL_cliente = " SELECT num_cliente,sigla,e_mail,www FROM cliente WHERE sigla='" + login_form +"'";
			
	rs_cliente = cn.Execute(strSQL_cliente)
			
%>

<p><img src="dbg_logo.jpg" width="127" height="127"></p>
<p align="center"><b>Alterar Dados Pessoais </b> </p>

<form method="POST" action="alterar.asp">
  <div align="center"> 
    
    <!-- ************* FORM ONDE ESTAO CONTIDOS OS BUTOES PARA ALTERACAO DE DADOS PESSOAIS ***************** -->
    <input type="submit" value="E-MAIL" name="Button">
    <input type="submit" value="WWW" name="Button">
    <input type="submit" value="PASSWORD" name="Button">
    <input type="hidden" name="hold_login_value" value="<% Response.Write(login_form) %>" size="20">
 	<!-- *************************************************************************************************** --> 
  
  </div>
</form>

<hr width="80%" align="center" size="5">

<table width="50%" border="0" align="center">
  <tr> 
    <td width="25%"><b>N&ordm; CLIENTE</b></td>
    <td width="75%"><%Response.Write(rs_cliente("num_cliente"))%></td>
  </tr>
  <tr> 
    <td width="25%"><b>SIGLA</b></td>
    <td width="75%"><%Response.Write(rs_cliente("sigla"))%></td>
  </tr>
  <tr> 
    <td width="25%"><b>E-MAIL</b></td>
    <td width="75%"><a href="mailto:<%=rs_cliente("e_mail")%>"><%=rs_cliente("e_mail")%></a></td>
  </tr>
  <tr> 
    <td width="25%"><b>WWW</b></td>
    <td width="75%"><a href="<%=(rs_cliente("www"))%>"><%=rs_cliente("www")%></a></td>
  </tr>
</table>

<hr width="80%" align="center" size="5">


<!-- ***************************** TABELA QUE CONTEM OS BUTOES ******************************************* -->

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

<!-- ***************************************************************************************************** -->

<% cn.Close() %>

</body>
</html>