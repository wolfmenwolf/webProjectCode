// JavaScript Document
	
window.addEvent('domready', function(){


if($('i-telefono')){
	$('i-telefono').setStyle('opacity', '0');
	var campo = $('i-telefono').effects({duration: 600});
	$('e-telefono').addEvent('click', function(e) {
		$('e-telefono').setStyle('display', 'none');
		$('i-telefono').setStyle('opacity', '1');
		$('i-telefono').setStyle('display', 'block');
		
		// Quitar
		$('quitar').addEvent('click', function(e) {									   
		$('i-telefono').setStyle('display', 'none');
		$('e-telefono').setStyle('display', 'inline');
		})	
		// fin quitar
		})	
	
	
// Validar formulario
		$('formConsulta').addEvent('submit', function(e) {
			new Event(e).stop();
			
			var nombre = $('nombref').getValue();
			var email = $('emailf').getValue();
			var consulta = $('consultaf').getValue();

			if (nombre == 'Indícanos tu nombre'){
			$('nombref').setStyle('color', '#CC3300');
			} else if(email == 'y tu email'){
			$('emailf').setStyle('color', '#CC3300');
			} else if(consulta == 'Indícanos aquí tu consulta'){
			$('consultaf').setStyle('color', '#CC3300');
			}else{
				//envio el formulario
				this.send({
				update: $('nota'),
				onComplete: function() {
					$('nota').setStyle('opacity', '0');
					$('nota').setStyle('display', 'block');
					var alerta = $('nota');
					var nota = alerta.effects({duration: 800});	
					nota.start({'opacity': .7}).chain(function(){
					nota.start.delay(6000, this, {'opacity': 0});
					})
					$('nombref').value = "Indícanos tu nombre";
					$('emailf').value = "y tu email";
					$('telefonof').value = "Indícanos aquí tu número de teléfono por favor";
					$('consultaf').value = "Indícanos aquí tu consulta";
					}
				});
				//fin del formulario
				}
		})
		
		
		$('nombref').addEvent('blur', function() {
		var nombre = $('nombref');
  		if (nombre.value == ''){
			$('nombref').value = "Indícanos tu nombre";
			$('nombref').setStyle('color', '#878787');
			} 
		});
		
		$('emailf').addEvent('blur', function() {
		var nombre = $('emailf');
  		if (nombre.value == ''){
			$('emailf').value = "y tu email";
			$('emailf').setStyle('color', '#878787');
			} 
		});
		
		$('consultaf').addEvent('blur', function() {
		var nombre = $('consultaf');
  		if (nombre.value == ''){
			$('consultaf').value = "Indícanos aquí tu consulta";
			$('consultaf').setStyle('color', '#878787');
			} 
		});
		
		$('telefonof').addEvent('blur', function() {
		var nombre = $('telefonof');
  		if (nombre.value == ''){
			$('telefonof').value = "Indícanos aquí tu número de teléfono por favor";
			$('telefonof').setStyle('color', '#878787');
			} 
		});
		
		$('nombref').addEvent('focus', function() {
			if($('nombref').value == "Indícanos tu nombre"){
			$('nombref').value = "";	}
		});
		
		$('emailf').addEvent('focus', function() {
			if($('emailf').value == "y tu email"){
			$('emailf').value = "";	}
		});
		
		$('consultaf').addEvent('focus', function() {
			if($('consultaf').value == "Indícanos aquí tu consulta"){
			$('consultaf').value = "";}	
		});
		
		$('telefonof').addEvent('focus', function() {
			if($('telefonof').value == "Indícanos aquí tu número de teléfono por favor"){
			$('telefonof').value = "";}	
		});
}




if($('nota')){
$('nota').setStyle('opacity', '0');
$('nota').setStyle('display', 'block');
var alerta = $('nota');
var nota = alerta.effects({duration: 800});	
nota.start({'opacity': .7}).chain(function(){
nota.start.delay(5000, this, {'opacity': 0});
})
}

var box = $('formulario-trabaja');
var fx = box.effects({duration: 800});
$('formulario-trabaja').setStyle('opacity', '0');
var formulariotrabaja = new Fx.Slide('formulario-trabaja', {duration: 600,  wait:false});
var textotrabaja = new Fx.Slide('texto-trabaja', {duration: 600,  wait:false});
$('file').setStyle('display', 'none');
$('formulario-trabaja').setStyle('display', 'none');

$('mostrar-formulario').addEvent('click', function(e) {
textotrabaja.hide();
$('mostrar-formulario').setStyle('display', 'none');
fx.start({'opacity': 1}).chain(function(){
$('file').setStyle('display', 'block');});
$('formulario-trabaja').setStyle('display', 'block');
})


}) //window domready

function comprobar()
{
	if (document.myForm.nombre.value == 'Indicanos tu Nombre' || document.myForm.nombre.value == '' ) {
	document.getElementById('nombre').style.backgroundColor = "#EBEBEB";
	document.getElementById('nombre').style.color = "#CC3300";
	document.myForm.nombre.value == 'Indicanos tu Nombre';
	//alert('nombre');
	return false;
}
	else if (document.myForm.email.value == 'y tu email' || document.myForm.email.value == '' ) {
	document.getElementById('email').style.backgroundColor = "#EBEBEB";
	document.getElementById('email').style.color = "#CC3300";
	document.myForm.email.value == 'y tu email';
	//alert('email');
	return false;
}
	else if (document.myForm.archivo.value == '') {
	document.getElementById('archivo').style.backgroundColor = "#EBEBEB";
	document.getElementById('archivo').style.color = "#CC3300";
	//alert('email');
	return false;
}
	// If the script gets this far through all of your fields
	// without problems, it's ok and you can submit the form

	return true;
}


function load() {
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(40.544004367152596, -3.6491239070892334), 16);
		map.addControl(new GSmallMapControl());

		var point = new GLatLng(40.544004367152596, -3.6491239070892334);
		var baseIcon = new GIcon();
		baseIcon.image = "http://okb.es/images/icon-map.png";
		baseIcon.iconSize = new GSize(91, 61);
		baseIcon.iconAnchor = new GPoint(85, 61);
		map.addOverlay(new GMarker(point, baseIcon));
		
      }
    }


