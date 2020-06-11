<?php

require "modelo/conexion.php";

abstract class AbstractModel{ // Clase abstracta
    protected $db;    // Recurso asociado a la BBDD
    
    public function __construct() {
        $this->db = Conexion::getInstance();// Conexión a la BBDD usando singleton
        $this->db->set_charset("utf16");
    }
    
    public function query($select,$params=[],$type='') {  
        
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

    public function editarUsuario($params){
        $select="UPDATE usuarios SET nombre = ?, apellidos = ?, 
        email = ?, passwd = ?, foto = ? ,tipo = ? WHERE id = ?";
        $result=$this->query($select,$params,'ssssssi'); 
        return $result;
    }

    public function eliminarUsuarioById($id){
        $select="DELETE FROM usuarios WHERE id = ?";
        $result=$this->query($select,$id,'i');
        return $result;
    }

    public function comprobarCredenciales($params){
        $select="SELECT * FROM usuarios WHERE email = ? AND passwd = ?";
        $result=$this->query($select,$params,'ss');
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

    //Devuelve todas las recetas
    public function getAllRecetas(){
        $select="SELECT * FROM recetas";
        $result=$this->query($select);
        return $result;
    }

    //Genera la lista de recetas
    public function getListaRecetas($titulo='',$contenido='',$categoria=[], $orden=''){
        if($titulo==''){
            $titulo="%";
        }

        if($contenido==''){
            $contenido="%";
        }

        if($orden=='ASC' || $orden=='DESC'){
            $parametroOrden="ORDER BY nombre ".$orden;
        }
        
        if($categoria==[]){
            $select="SELECT recetas.id, recetas.nombre, recetas.idAutor FROM recetas 
            WHERE recetas.nombre LIKE CONCAT('%',?,'%') AND 
            (recetas.descripcion LIKE CONCAT('%',?,'%') OR 
            recetas.ingredientes LIKE CONCAT('%',?,'%') OR
            recetas.preparacion LIKE CONCAT('%',?,'%')) ".$parametroOrden;
        }
        else{
            $select="SELECT recetas.id, recetas.nombre, recetas.idAutor FROM recetas 
            LEFT JOIN categorias
            ON recetas.id = categorias.idReceta WHERE recetas.nombre LIKE CONCAT('%',?,'%') AND 
            (recetas.descripcion LIKE CONCAT('%',?,'%') OR 
            recetas.ingredientes LIKE CONCAT('%',?,'%') OR
            recetas.preparacion LIKE CONCAT('%',?,'%')) AND categorias.idCategoria IN 
            (".implode(",", $categoria).") ".$parametroOrden;
        }

        $params=[$titulo, $contenido, $contenido, $contenido];

        $result=$this->query($select, $params, 'ssss');
        return $result;
    }

    //Genera la lista de recetas de un usuario
    public function getListaRecetasUsuario($titulo='',$contenido='', $idAutor='',$categoria=[], $orden=''){
        if($titulo==''){
            $titulo="%";
        }

        if($contenido==''){
            $contenido="%";
        }

        if($orden=='ASC' || $orden=='DESC'){
            $parametroOrden="ORDER BY nombre ".$orden;
        }
        else{ //Hay que cambiarlo para comentarios y valoraciones
            $parametroOrden="ORDER BY nombre";
        } 
        
        if($categoria==[]){
            $select="SELECT recetas.id, recetas.nombre, recetas.idAutor FROM recetas WHERE nombre 
            LIKE CONCAT('%',?,'%') AND 
            (descripcion LIKE CONCAT('%',?,'%') OR 
            ingredientes LIKE CONCAT('%',?,'%') OR
            preparacion LIKE CONCAT('%',?,'%')) AND idAutor = ? ".$parametroOrden;
        }
        else{
            $select="SELECT recetas.id, recetas.nombre, recetas.idAutor FROM recetas 
            LEFT JOIN categorias
            ON recetas.id = categorias.idReceta WHERE recetas.nombre LIKE CONCAT('%',?,'%') AND 
            (recetas.descripcion LIKE CONCAT('%',?,'%') OR 
            recetas.ingredientes LIKE CONCAT('%',?,'%') OR
            recetas.preparacion LIKE CONCAT('%',?,'%')) AND idAutor = ?
            AND categorias.idCategoria IN (".implode(",", $categoria).") ".$parametroOrden;
        }

        $params=[$titulo, $contenido, $contenido, $contenido, $idAutor];

        $result=$this->query($select, $params, 'ssssi');
        return $result;
    }

    //Cuenta las recetas (Se puede mejorar)
    public function countRecetas(){
        $result=$this->getAllRecetas();
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
        $select="UPDATE recetas SET nombre = ?, descripcion = ?, 
        ingredientes = ?, preparacion = ? WHERE id = ?";
        $this->query($select,$params,'ssssi');
        $result=$this->db->insert_id;
        return $result;
    }

    //Elimina una receta
    public function eliminaReceta($id){
        $select="DELETE FROM recetas WHERE id = ?";
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

    public function insertCategoria($nombre){
        $select="INSERT INTO listacategorias (nombre) VALUES (?)";
        $result=$this->query($select, $nombre, 's');
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

    //Insertar nueva foto en receta
    public function insertFotoInReceta($idReceta, $fichero){
        $select="INSERT INTO fotos (idReceta, fichero) VALUES (?,?)";
        $result=$this->query($select, [$idReceta,$fichero], 'is');
        return $result;
    }

    //Elimina una foto concreta de la tabla
    public function eliminaFotoById($id){
        $select="DELETE FROM fotos WHERE id LIKE ?";
        $result=$this->query($select,$id,'i');
        return $result;
    }

    //Eliminar foto a traves del id de la receta
    public function eliminaFotoByIdReceta($id){
        $select="DELETE FROM fotos WHERE idReceta LIKE ?";
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

class ModeloComentarios extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function getComentariosByIdReceta($idReceta){
        $select="SELECT * FROM comentarios WHERE idReceta = ?";
        $result=$this->query($select,$idReceta,'i');
        return $result;
    }

    public function getComentarioById($id){
        $select="SELECT * FROM comentarios WHERE id = ?";
        $result=$this->query($select,$id,'i');
        return $result;
    }

    public function insertComentario($params){
        $select="INSERT INTO comentarios (idUsuario, idReceta, comentario, fecha) VALUES 
        (?,?,?,?)";
        $result=$this->query($select,$params,'iiss');    
        return $result;    
    }

    public function deleteComentariosReceta($idReceta){
        $select="DELETE FROM comentarios WHERE idReceta = ?";
        $result=$this->query($select,$idReceta,'i');
        return $result;
    }

    public function deleteComentarioById($id){
        $select="DELETE FROM comentarios WHERE id = ?";
        $result=$this->query($select,$id,'i');
        return $result;
    }
}

class ModeloValoracion extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function getValoracionesByIdReceta($id){
        $select="SELECT valoracion FROM valoraciones WHERE idReceta = ?";
        $result=$this->query($select, $id, 'i');
        return $result;
    }

    public function insertValoracion($params){
        $select="INSERT INTO valoraciones (idReceta, idUsuario, valoracion) VALUES (?,?,?)";
        $result=$this->query($select, $params, 'iii');
        return $result;
    }

    public function getValoracionByIdUsuarioReceta($params){
        $select="SELECT * FROM valoraciones WHERE idReceta = ? AND idUsuario = ?";
        $result=$this->query($select, $params, 'ii');
        return $result; 
    }

    public function editarValoracion($params){
        $select="UPDATE valoraciones SET valoracion = ? WHERE id = ?";
        $result=$this->query($select, $params, 'ii');
        return $result;
    }

    public function deleteValoracionesReceta($idReceta){
        $select="DELETE FROM valoraciones WHERE idReceta = ?";
        $result=$this->query($select, $idReceta, 'i');
        return $result;
    }
}

class ModeloLog extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function getLog(){
        $select="SELECT * FROM log ORDER BY id DESC";
        $result=$this->query($select);
        return $result;
    }

    public function anadirIncidencia($params){
        $select="INSERT INTO log (fecha,descripcion) VALUES (?,?)";
        $result=$this->query($select,$params,'ss');
        return $result;
    }
}

class ModeloBBDD extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function showTables(){
        $select="SHOW TABLES";
        $result=$this->query($select);
        return $result;
    }

    public function showCreateTable($tabla){
        $select="SHOW CREATE TABLE ".$tabla;
        $result=$this->query($select);
        return $result;
    }

    public function selectAllFromTable($tabla){
        $select="SELECT * FROM ".$tabla;
        $result=$this->query($select);
        return $result;
    }

    public function setForeignChecks($val){
        $select="SET FOREIGN_KEY_CHECKS=?";
        $result=$this->query($select,$val,'i');
        return $result;
    }

    public function deleteTable($tabla){
        $select="DELETE * FROM ".$tabla;
    }
}

?>