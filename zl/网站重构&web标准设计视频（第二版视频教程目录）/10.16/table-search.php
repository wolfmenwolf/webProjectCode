<?php include ('connect/constans.php');?>
<?php include ('connect/connect03.php');?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>PHP &amp; MySQL</title>
<script type="text/javascript" src="JQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="JQuery/table.js"></script>
<link type="text/css" rel="stylesheet" href="css/style.css" />
</head>

<body>
<table summary="website">
	<thead>
		<tr>
			<th></th>
			<th></th>
			<th></th>
			<th>User ID</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Password</th>
			<th>Email</th>
			<th>Registration Date</th>
		</tr>
	</thead>
	<tbody>
	<?php
	$search = $_POST['search'];
	if($search){
		$sql = "SELECT *
				FROM website.users
				WHERE first_name
				LIKE '%$search%'";
	}else{
		$sql = "SELECT *
				FROM website.users
				ORDER BY user_id
				ASC";
	}
			
	$query = mysql_query($sql);
	
	while($row = mysql_fetch_array ($query)){
	?>
			<tr>
				<td><input type="checkbox" name="choice" /></td>
				<td><a href="#" class="delete_btn"></a></td>
				<td><a href="#" class="edit_btn"></a></td>
				<td><?php echo $row['user_id']?></td>
				<td><?php echo $row['first_name']?></td>
				<td><?php echo $row['last_name']?></td>
				<td><?php echo $row['password']?></td>
				<td><?php echo $row['email']?></td>
				<td><?php echo $row['registration_date']?></td>
			</tr>
	<?php };?>
	</tbody>
</table>
<form action="table-search.php" method="post">
<p class="search-box">
	<input type="text" name="search" class="search"	id="search" />
	<input class="search-btn" type="submit" value="Search"/>
</p>
</form>
</body>
</html>


