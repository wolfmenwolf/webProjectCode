<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<%
var name = Request.QueryString("name");
var pass = Request.QueryString("pass");
var age = Request.QueryString("age");

Response.Write("name = " + name);
Response.Write("pass = " + pass);
Response.Write("age = " + age);
%>
