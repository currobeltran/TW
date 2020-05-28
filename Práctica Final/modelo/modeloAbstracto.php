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

            if(count($params)>1)
                $pq->bind_param($type,...$params);
            else{
                $pq->bind_param($type,$params);
            }
            
            $pq->execute();
            echo $pq->error;
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

    public function getUsuarioById($id){
        $select="SELECT * FROM usuarios WHERE id LIKE ?";
        $result=$this->query($select,$id,'i'); 
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

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    //Genera la lista de recetas
    public function getListaRecetas($titulo='',$contenido=''){
        if($titulo==''){
            $titulo="%";
        }

        if($contenido==''){
            $contenido="%";
        }

        $select="SELECT * FROM recetas WHERE nombre LIKE '%".$titulo."%' AND 
        (descripcion LIKE '%".$contenido."%' OR 
        ingredientes LIKE '%".$contenido."%' OR
        preparacion LIKE '%".$contenido."%')";

        $result=$this->query($select);
        return $result;
    }

    //Cuenta las recetas (Se puede mejorar)
    public function countRecetas(){
        $result=$this->getListaRecetas();
        $recetas=[];
        while(($receta=mysqli_fetch_array($result))){
            array_push($recetas, $receta[nombre]);
        }
        return count($recetas);
    }

    //Selecciona una receta por su id
    public function getRecetaById($id){
        $select="SELECT * FROM recetas WHERE id LIKE ?";
        $result=$this->query($select,$id,'i');
        return $result;
    }
}

class ModeloListaCategorias extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function getListaCategorias(){
        $select="SELECT * FROM listacategorias";
        $result=$this->query($select);
        return $result;
    }
}

class ModeloFotos extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    //Coger foto a traves de la id
    public function getFotoByIdReceta($id){
        $select="SELECT * FROM fotos WHERE idReceta LIKE ?";
        $result=$this->query($select,$id,'i');
        return $result;
    }
}
?>