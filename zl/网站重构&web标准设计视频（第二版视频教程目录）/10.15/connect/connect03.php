<?php
//Create a database connection variables	����һ�����ݿ����ӱ���
$db_host = 'localhost';
$db_user = 'root';
$db_pass = 'mysql';
$db_name = 'website';

//Create a database connect		����һ�����ݿ�����
$connect = @mysql_connect( $db_host, $db_user, $db_pass) or die("Could not connected MySQL.".mysql_error());

//Select a database to use		ѡ��һ�����ݿ�ʹ��
$db = @mysql_select_db( $db_name, $connect) or die("Could not select the database.".mysql_error());
?>