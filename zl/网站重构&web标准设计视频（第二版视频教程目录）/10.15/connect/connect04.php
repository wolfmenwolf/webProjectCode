<?php
//Create a database connect		����һ�����ݿ�����
$connect = @mysql_connect( DB_HOST, DB_USER,DB_PASS) or die("Could not connected MySQL.".mysql_error());

//Select a database to use		ѡ��һ�����ݿ�ʹ��
$db = @mysql_select_db( DB_NAME,$connect) or die("Could not select the database.".mysql_error());
?>