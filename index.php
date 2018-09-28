<?php
$conn=new mysqli('localhost','root','','familia');
$rs=$conn->query("SELECT * FROM personas;");
// personas
$txt='<ol>';
while($r=$rs->fetch_assoc()){
	$txt.='<li>'.$r['persona'].' ('.$r['nacimiento'].')</li>';
}
$txt.='</ol>';
// arbol
$rs=$conn->query("CALL arbol(1);");
$grado=0;
$txt.='<ol>';
while($r=$rs->fetch_assoc()){
	if($grado<$r['grado']){
		$grado=$r['grado'];
		$txt.='<ol>';
	}
	if($grado>$r['grado']){
		for($i=$r['grado'];$i<$grado;$i++)
			$txt.='</ol>';
		$grado=$r['grado'];
	}
	$txt.='<li>'.$r['persona'].' ('.$r['nacimiento'].')</li>';
}
$txt.='</ol>';
echo utf8_encode($txt);
?>