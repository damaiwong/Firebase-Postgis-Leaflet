<%-- 
    Document   : index
    Created on : Feb 11, 2017, 3:19:35 PM
    Author     : luisangelparada
--%>
<%@page import="BaseDatos.ModeloDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=utf-8 />
<title>Facultades UAH</title>
<meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src='js/mapbox.js'></script>
<link href='css/mapbox.css' rel='stylesheet' />
<script src='js/mapbox.directions.js'></script>
<link rel='stylesheet' href='css/mapbox.directions.css' type='text/css' />
<script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js'></script>
<link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css' rel='stylesheet' />
<style>
  body { margin:0; padding:0; }
  #map { position:absolute; top:0; bottom:0; width:100%; }
  #inputs,
#errors,
#directions {
    position: absolute;
    width: 33.3333%;
    max-width: 300px;
    min-width: 200px;
}
.leaflet-control-zoomslider-knob { width:14px; height:6px; }
.leaflet-container .leaflet-control-zoomslider-body {
  -webkit-box-sizing:content-box;
     -moz-box-sizing:content-box;
          box-sizing:content-box;
  }

#inputs {
    z-index: 10;
    top: 10px;
    left: 10px;
}

#directions {
    z-index: 99;
    background: rgba(0,0,0,.8);
    top: 0;
    right: 0;
    bottom: 0;
    overflow: auto;
}

#errors {
    z-index: 8;
    opacity: 0;
    padding: 10px;
    border-radius: 0 0 3px 3px;
    background: rgba(0,0,0,.25);
    top: 90px;
    left: 10px;
}  
</style>
</head>
<body>
    <% ModeloDatos bbdd = new  ModeloDatos();
       bbdd.abrirConexion();
       String GeoJson = bbdd.getGeoJson();
       bbdd.cerrarConexion();
       
    %>
<div id='map'></div>
<div id='inputs'></div>
<div id='errors'></div>
<div id='directions'>
  <div id='routes'></div>
  <div id='instructions'></div>
</div>

<script>
L.mapbox.accessToken = 'pk.eyJ1IjoibHVpc2E5MSIsImEiOiJjaXl2YmhnMXkwMDBwMnFscXplYjFkbTFuIn0.rDsYGnW_GnxzPhRms0GXGg';
var map = L.mapbox.map('map', 'mapbox.streets',{zoomControl: false})
    .setView([40.4939,-3.3548 ], 14);
  new L.Control.Zoom({ position: 'bottomleft'}).addTo(map);
  L.control.fullscreen().setPosition('bottomleft').addTo(map);

// create the initial directions object, from which the layer
// and inputs will pull data.
var directions = L.mapbox.directions({units: 'metric'});

var directionsLayer = L.mapbox.directions.layer(directions)
    .addTo(map);

var directionsInputControl = L.mapbox.directions.inputControl('inputs', directions)
    .addTo(map);

var directionsErrorsControl = L.mapbox.directions.errorsControl('errors', directions)
    .addTo(map);

var directionsRoutesControl = L.mapbox.directions.routesControl('routes', directions)
    .addTo(map);

var directionsInstructionsControl = L.mapbox.directions.instructionsControl('instructions', directions)
    .addTo(map);


function onEachFeature(feature, layer) {
    if (feature.properties && feature.properties.name) {
        layer.setStyle({fillColor :'black',color:'black'}) 
        var source ="";
        var link = "";
        
        switch(feature.properties.name!=null ||feature.properties.name!=null ) {
            case feature.properties.name.includes('Medicina' ) : 
                source = "pics/medicina.jpg";
                link="http://medicinaycienciasdelasalud.uah.es";
                break;
            case feature.properties.name.includes('Derecho' ) :
                source = "pics/derecho.jpg";
                link="http://derecho.uah.es";
                break;
            case feature.properties.name.includes('Letras' ) :
                source = "pics/Letras.jpg";
                link="http://filosofiayletras.uah.es";
                break;
            case feature.properties.name.includes('Documentación' ) :
                source = "pics/Letras.jpg";
                link="http://filosofiayletras.uah.es";
                break;
            case feature.properties.name.includes('Empresariales' ) :
                source = "pics/empresariales.jpg";
                link="http://economicasempresarialesyturismo.uah.es";
                break;
            case feature.properties.name.includes('Arquitectura' ) :
                source = "pics/arquitectura.jpg";
                link="http://economicasempresarialesyturismo.uah.es";
                break; 
            case feature.properties.name.includes('Arquitectura' ) :
                source = "pics/empresariales.jpg";
                link="http://economicasempresarialesyturismo.uah.es";
                break;
            case feature.properties.name.includes('Henares' ) :
                source = "pics/uah.png";
                link="http://uah.es";
                break;
            case feature.properties.name.includes('Politécnica' ) :
                source = "pics/inge.jpg";
                link="http://escuelapolitecnica.uah.es";
                break; 
            case feature.properties.name.includes('Ambientales' ) :
                source = "pics/ciencias.jpg";
                link="http://biologiacienciasambientalesyquimica.uah.es";
                break;
            
            case feature.properties.name.includes('Ciencias' ) :
                source = "pics/cbk.jpg";
                link="http://biologiacienciasambientalesyquimica.uah.es";
                break;
                
            case feature.properties.name.includes('Farmacia' ) :
                source = "pics/farmacia.jpg";
                link="http://farmacia.uah.es";
                break;   
            case feature.properties.name.includes('Enfermería' ) :
                source = "pics/farmacia.jpg";
                link="http://medicinaycienciasdelasalud.uah.es/estudios/grado-int.asp?cd=205&plan=G209";
                break;
            case feature.properties.name.includes('Educacion' ) :
                source = "pics/magisterio.jpg";
                link="http://educacion.uah.es";
                break;
                
            
}
        
        layer.bindPopup('<div class="card" style=""><img class="card-img-top" src='+source+' alt="Card image cap" width="140" height="140"><div class="card-block"><h4 class="card-title">'+feature.properties.name+'</h4><a href='+link+' class=" active">Página Oficial</a></div></div> ') ;
      
        layer.on('mouseover', function() { layer.openPopup(); });
        layer.on('mouseout', function() { setTimeout(function(){layer.closePopup();}, 5000);
        }); 
        
        layer.off('click');             
    }
}

L.geoJSON( <%=GeoJson%>, {
    onEachFeature: onEachFeature    
}).addTo(map);
</script>

</body>
</html>


