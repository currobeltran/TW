<?php

require "modelo/conexion.php";

abstract class AbstractModel{ // Clase abstracta
    protected $db;    // Recurso asociado a la BBDD
    
    public function __construct() {
        $this->$db = Conexion::getInstance();// Conexión a la BBDD usando singleton
    }
    
    public function query($select,$params=[],$type='') {  // Consulta que debe devolver 1 tupla
        
        if (empty($params)){// Si no lleva parámetros -> consulta normal
            $result = $this->$db->query($select);
        }
        
        else {// Si lleva parámetros -> consulta preparada
            $pq = $this->$db->prepare($select);
            $pq->bind_param($type,...$params);
            $pq->execute();
            $result=$pq->get_result();
        }

        return $result;
    }

}

class ModeloUsuario extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function getListaUsuarios(){
        $select="SELECT * FROM usuarios";
        $result=$this->query($select);
        return $result;
    }

    public function getUsuarioByEmail($email){
        $select="SELECT * FROM usuarios WHERE email LIKE ?";
        $result=$this->query($select,$email,'s'); 
        return $result;
    }

    public function insertUsuario($params){
        $select="INSERT INTO usuarios (nombre,apellidos,email,foto,passwd,tipo) VALUES (?,?,?,?,?,?)";
        $result=$this->query($select,$params,'ssssss'); 
        return $result;
    }
}

class ModeloRecetas extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function getListaRecetas($seleccion){
        $select="SELECT $seleccion FROM recetas";
        $result=$this->query($select);
        return $result;
    }
}
?>