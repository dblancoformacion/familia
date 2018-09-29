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
$grado=1;
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
for($i=0;$i<$grado;$i++) $txt.='</ol>';
echo utf8_encode($txt);
// factoriales
echo '<br/><br/>';
echo factorial(5);
echo '<br/><br/>';
echo factorial_iterativo(5);
// funciones
function factorial($n){
	$r=1;
	if($n>1) $r=$n*factorial($n-1);
	return $r;
}
function factorial_iterativo($n){
	$r=1;
	for($i=1;$i<=$n;$i++) $r*=$i;
	return $r;
}
?>