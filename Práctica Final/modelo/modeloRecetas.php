<?php

require_once "modelo/modeloAbstracto.php";

class ModeloRecetas extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function exists($id){
        $result=parent::exists("recetas", $id);
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
        else{
            $parametroOrden="";
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
        
        if(mysqli_affected_rows($this->db)){
            return true;
        }
        else{
            return false;
        }
    }

    //Elimina una receta
    public function eliminaReceta($id){
        $select="DELETE FROM recetas WHERE id = ?";
        $result=$this->query($select,$id,'i');
        return $result;
    }

    //Obtiene las recetas de un usuario
    public function getRecetasFromUser($idUser){
        $select="SELECT * FROM recetas WHERE idAutor = ?";
        $result=$this->query($select,$idUser,'i');
        return $result;
    }
}

?>