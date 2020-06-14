<?php

require "modelo/conexion.php";

abstract class AbstractModel{ // Clase abstracta
    protected $db;    
    
    public function __construct() {
        $this->db = Conexion::getInstance();// Conexión a la BBDD usando singleton
        $this->db->set_charset("utf16");
    }
    
    public function query($select,$params=[],$type='') { //Peticion a la base de datos  
        
        if (empty($params)){// Si no lleva parámetros -> consulta normal
            $result = $this->db->query($select);
        }
        
        else {// Si lleva parámetros -> consulta preparada
            $pq = $this->db->prepare($select);
            
            if(count($params)>1){
                $pq->bind_param($type,...$params);
            }
            else{
                $pq->bind_param($type,$params);
            }
            
            $pq->execute();
            echo $pq->error;
            $result=$pq->get_result();
        }

        return $result;
    }

    public function exists($tabla, $id){ //Comprueba la existencia de una entrada devolviendo bool
        $select="SELECT * FROM ".$tabla." WHERE id = ?";
        $result=$this->query($select, $id, 'i');

        if(mysqli_fetch_array($result)){
            return true;
        }

        else{
            return false;
        }
    }

}

?>