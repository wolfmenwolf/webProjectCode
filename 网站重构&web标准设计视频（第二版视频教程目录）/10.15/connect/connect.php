<?php
//Create a database connect		创建一个数据库连接
$connect = @mysql_connect('localhost','root','mysql');

if($connect){
	echo "<p>Could connected MySQL.</p>";	//连接到MySQL
}else{
	echo "<p>Could not connected MySQL.".mysql_error().'</p>';	//连接不到MySQL
}

//Select a database to use		选择一个数据库使用
$db = @mysql_select_db('website',$connect);
if(!$db){
	echo "<p>Could not select the database.".mysql_error().'</p>';	//选择不到数据库
}else{
	echo "<p>Could select the database.</p>";	//选择到数据库
}
?>