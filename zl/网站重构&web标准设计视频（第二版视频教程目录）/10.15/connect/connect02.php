<?php
//Create a database connect		����һ�����ݿ�����
$connect = @mysql_connect('localhost','root','mysql') or die("Could not connected MySQL.".mysql_error());

//Select a database to use		ѡ��һ�����ݿ�ʹ��
$db = @mysql_select_db('website',$connect) or die("Could not select the database.".mysql_error());
?>