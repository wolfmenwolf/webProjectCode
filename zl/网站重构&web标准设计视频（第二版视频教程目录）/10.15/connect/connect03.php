<?php
//Create a database connection variables	创建一个数据库连接变量
$db_host = 'localhost';
$db_user = 'root';
$db_pass = 'mysql';
$db_name = 'website';

//Create a database connect		创建一个数据库连接
$connect = @mysql_connect( $db_host, $db_user, $db_pass) or die("Could not connected MySQL.".mysql_error());

//Select a database to use		选择一个数据库使用
$db = @mysql_select_db( $db_name, $connect) or die("Could not select the database.".mysql_error());
?>