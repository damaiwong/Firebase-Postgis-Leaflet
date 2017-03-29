package BaseDatos;

import java.sql.*;
import java.util.ArrayList;

public class ModeloDatos {
    private Connection con;
    private Statement set;
    private ResultSet rs;
    
    public void abrirConexion() {
    try{
        Class.forName("org.postgresql.Driver" );
        con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/Gps","postgres","admin"); 
        System.out.println("Se ha conectado");
    }catch(Exception e){
        System.out.println("No se ha conectado " + e.getMessage());}
    }
    
    public String getGeoJson(){
        String GeoJson ="";
        
        try{
            set = con.createStatement();
            rs = set.executeQuery("SELECT row_to_json(fc) \n" +
"FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features\n" +
"   FROM (SELECT 'Feature' As type\n" +
"    , ST_AsGeoJSON(lg.wkb_geometry, 4)::json As geometry\n" +
"    , row_to_json((SELECT l FROM (SELECT \"name\" ,\"building\") As l\n" +
"      )) As properties\n" +
"   FROM ogrgeojson As lg ) As f ) As  fc;") ;
            while (rs.next()){
                GeoJson =  rs.getString(1);
            }
            rs.close();
            set.close();
        }catch(Exception e){
            
            System.out.println(e);
        }
        return GeoJson;
    
    
    
    }
  
    
   
  
    public void cerrarConexion() {
        try {
            con.close();
        }catch (Exception e){}
    }
    
    
  
}

