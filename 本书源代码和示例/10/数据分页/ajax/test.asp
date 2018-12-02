<?xml version="1.0" encoding="gb2312"?>
<%
Response.CacheControl="no-cache"
Response.AddHeader "pragma","no-cache"
'Response.AddHeader "Content-Type","text/html;charset=gb2312"
Response.Expires = -1
Response.ExpiresAbsolute = now - 1
Response.ContentType = "text/xml"

set conn = Server.CreateObject("adodb.connection")
data = Server.mappath("data.mdb")
conn.Open "driver={microsoft access driver (*.mdb)};"&"dbq="&data
coun=CInt(Request("coun"))
if coun<1 then coun = 1
if coun>14 then coun =14
%>
<% 
set rs = Server.CreateObject("adodb.recordset")
sql ="select * from xmlhttp"
rs.CursorType=3 
rs.CursorLocation = 3 
rs.open sql,conn,2,1
rs.AbsolutePosition = coun
%>
<data count="<%=coun%>" >
<%
n=0
while (not rs.eof) and (n<5)
%>
    <item id="<%=rs("id")%>">
         <who><%=trim(rs("who")) %></who>
		 <class><%=trim(rs("class")) %></class>
		 <what><%=trim(rs("what")) %></what>
    </item>
<%
	n = n + 1
	rs.movenext
wend
%>
</data>
