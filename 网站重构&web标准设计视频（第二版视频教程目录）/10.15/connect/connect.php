<?php
//Create a database connect		����һ�����ݿ�����
$connect = @mysql_connect('localhost','root','mysql');

if($connect){
	echo "<p>Could connected MySQL.</p>";	//���ӵ�MySQL
}else{
	echo "<p>Could not connected MySQL.".mysql_error().'</p>';	//���Ӳ���MySQL
}

//Select a database to use		ѡ��һ�����ݿ�ʹ��
$db = @mysql_select_db('website',$connect);
if(!$db){
	echo "<p>Could not select the database.".mysql_error().'</p>';	//ѡ�񲻵����ݿ�
}else{
	echo "<p>Could select the database.</p>";	//ѡ�����ݿ�
}
?>