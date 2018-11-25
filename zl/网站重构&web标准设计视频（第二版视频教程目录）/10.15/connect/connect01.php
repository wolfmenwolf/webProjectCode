<?php
//Create a database connect		创建一个数据库连接
$connect = @mysql_connect('localhost','root','mysql');
if(!$connect){
	echo "Could not connected MySQL.".mysql_error();	//连接不到MySQL
}

//Select a database to use		选择一个数据库使用
$db = @mysql_select_db('website',$connect);
if(!$db){
	echo "Could not select the database.".mysql_error();	//选择不到数据库
}
?>