<?php
//Create a database connect		创建一个数据库连接
$connect = @mysql_connect('localhost','root','mysql') or die("Could not connected MySQL.".mysql_error());

//Select a database to use		选择一个数据库使用
$db = @mysql_select_db('website',$connect) or die("Could not select the database.".mysql_error());
?>