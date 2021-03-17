<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"pl-PL\">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"> 
    <title>Rezultat zapytania</title>
</head>
    
<body>
    
    <table width="1000" align="center" border="1" bordercolor="#d5d5d5"  cellpadding="0" cellspacing="0">
        <tr>
        <?php
            ini_set("display_errors", 0);
            require_once "dbconnect.php";
            $polaczenie = mysqli_connect($host, $user, $password);
			mysqli_query($polaczenie, "SET CHARSET utf8");
			mysqli_query($polaczenie, "SET NAMES 'utf8' COLLATE 'utf8_polish_ci'");
            mysqli_select_db($polaczenie, $database);
            
            $zapytanietxt = file_get_contents("zapytanie.txt");
            
            $rezultat = mysqli_query($polaczenie, $zapytanietxt);
            $ile = mysqli_num_rows($rezultat);
            
            echo "znaleziono: ".$ile;
if ($ile>=1) 
{
echo<<<END
<td width="50" align="center" bgcolor="salmon"><strong>Id Towaru</td>
<td width="100" align="center" bgcolor="salmon"><strong>Nazwa Towaru</strong></td>
<td width="100" align="center" bgcolor="salmon"><strong>Data Obrotu</strong></td>
<td width="100" align="center" bgcolor="salmon"><strong>Typ</strong></td>
<td width="50" align="center" bgcolor="salmon"><strong>Ilosc</strong></td>
<td width="100" align="center" bgcolor="salmon"><strong>Jednostka Miary</strong></td>
<td width="100" align="center" bgcolor="salmon"><strong>Cena</strong></td>
<td width="100" align="center" bgcolor="salmon"><strong>Data Od</strong></td>
<td width="100" align="center" bgcolor="salmon"><strong>Data Do</strong></td>
<td width="50" align="center" bgcolor="salmon"><strong>Przychody Razem</strong></td>
<td width="100" align="center" bgcolor="salmon"><strong>Wartosc Przychodu</strong></td>


</tr><tr>
END;
}

	for ($i = 1; $i <= $ile; $i++) 
	{
		
		$row = mysqli_fetch_assoc($rezultat);
		$a1 = $row['IdTowaru'];
		$a2 = $row['NazwaTowaru'];
		$a3 = $row['DataObrotu'];
		$a4 = $row['Typ'];
		$a5 = $row['Ilosc'];
		$a6 = $row['JednostkaMiary'];
		$a7 = $row['Cena'];
		$a8 = $row['DataOd'];
		$a9 = $row['DataDo'];
		$a10 = $row['PrzychodyRazem'];
		$a11 = $row['WartoscPrzychodu'];
		
        
		
echo<<<END
<td width="50" align="center"><h4 style="color: #e98c81">$a1</h1></td>
<td width="100" align="center">$a2</td>
<td width="100" align="center">$a3</td>
<td width="100" align="center">$a4</td>
<td width="100" align="center">$a5</td>
<td width="100" align="center">$a6</td>
<td width="100" align="center">$a7</td>
<td width="100" align="center">$a8</td>
<td width="100" align="center">$a9</td>
<td width="50" align="center">$a10</td>
<td width="100" align="center">$a11</td>

</tr><tr>
END;
			
	}
	

?>


</tr></table>



</body>
</html>

