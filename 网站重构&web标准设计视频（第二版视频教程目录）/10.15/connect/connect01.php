<?php
//Create a database connect		����һ�����ݿ�����
$connect = @mysql_connect('localhost','root','mysql');
if(!$connect){
	echo "Could not connected MySQL.".mysql_error();	//���Ӳ���MySQL
}

//Select a database to use		ѡ��һ�����ݿ�ʹ��
$db = @mysql_select_db('website',$connect);
if(!$db){
	echo "Could not select the database.".mysql_error();	//ѡ�񲻵����ݿ�
}
?>