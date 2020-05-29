<?php

require "modelo/conexion.php";

abstract class AbstractModel{ // Clase abstracta
    protected $db;    // Recurso asociado a la BBDD
    
    public function __construct() {
        $this->db = Conexion::getInstance();// Conexión a la BBDD usando singleton
    }
    
    public function query($select,$params=[],$type='') {  // Consulta que debe devolver 1 tupla
        
        if (empty($params)){// Si no lleva parámetros -> consulta normal
            $result = $this->db->query($select);
        }
        
        else {// Si lleva parámetros -> consulta preparada
            $pq = $this->db->prepare($select);

            
            if(count($params)>1){
                echo implode(",", $params);
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
    public function getListaRecetas($titulo='',$contenido='',$categoria=[]){
        if($titulo==''){
            $titulo="%";
        }

        if($contenido==''){
            $contenido="%";
        }
        
        if($categoria==[]){
            $select="SELECT id, nombre FROM recetas WHERE nombre LIKE '%".$titulo."%' AND 
            (descripcion LIKE '%".$contenido."%' OR 
            ingredientes LIKE '%".$contenido."%' OR
            preparacion LIKE '%".$contenido."%')";
        }
        else{
            $select="SELECT recetas.id, recetas.nombre FROM recetas LEFT JOIN categorias
            ON recetas.id = categorias.idReceta WHERE recetas.nombre LIKE '%".$titulo."%' AND 
            (recetas.descripcion LIKE '%".$contenido."%' OR 
            recetas.ingredientes LIKE '%".$contenido."%' OR
            recetas.preparacion LIKE '%".$contenido."%') AND categorias.idCategoria IN 
            (".implode(",", $categoria).")";
        }

        $result=$this->query($select);
        return $result;
    }

    //Genera la lista de recetas de un usuario
    public function getListaRecetasUsuario($titulo='',$contenido='', $idAutor){
        if($titulo==''){
            $titulo="%";
        }

        if($contenido==''){
            $contenido="%";
        }

        $select="SELECT * FROM recetas WHERE nombre LIKE '%".$titulo."%' AND 
        (descripcion LIKE '%".$contenido."%' OR 
        ingredientes LIKE '%".$contenido."%' OR
        preparacion LIKE '%".$contenido."%') AND idAutor LIKE ".$idAutor."";

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

    //Añadir nueva receta
    public function insertReceta($params){
        $select="INSERT INTO recetas (idAutor, nombre, descripcion, 
        ingredientes, preparacion) VALUES (?,?,?,?,?)";
        $this->query($select,$params,'issss'); 
        $result=$this->db->insert_id;
        return $result;
    }

    //Editar receta
    public function editarRecetaById($params){
        $select="UPDATE recetas SET titulo = ?, descripcion = ?, 
        ingredientes = ?, preparacion = ? WHERE id = ?";
        $this->query($select,$params,'ssssi');
        $result=$this->db->insert_id;
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

class ModeloCategorias extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function insertCategoria($idRec, $idCat){
        $select="INSERT INTO categorias (idReceta, idCategoria) VALUES (?,?)";
        $params=[$idRec,$idCat];
        $result=$this->query($select,$params,'ii'); 
        return $result;
    }

    public function getCategoriasByIdReceta($idRec){
        $select="SELECT * FROM categorias WHERE idReceta LIKE ?";
        $result=$this->query($select,$idRec,'i');
        return $result; 
    }

    public function deleteCategoria($idReceta){
        $select="DELETE FROM categorias WHERE idReceta LIKE ?";
        $result=$this->query($select,$idReceta,'i');
        return $result; 
    }
}
?>