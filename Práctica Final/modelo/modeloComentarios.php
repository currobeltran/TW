<?php

require_once "modelo/modeloAbstracto.php";

class ModeloComentarios extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function exists($id){
        $result=parent::exists("comentarios", $id);
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
        $this->query($select,$params,'iiss');  
        $result=$this->db->insert_id;  
        return $result;    
    }

    public function deleteComentariosReceta($idReceta){
        $select="DELETE FROM comentarios WHERE idReceta = ?";
        $result=$this->query($select,$idReceta,'i');
        return $result;
    }

    public function deleteComentarioById($id){
        $select="DELETE FROM comentarios WHERE id = ?";
        $this->query($select,$id,'i');
        $result=$this->db->insert_id;
        return $result;
    }

    public function deleteComentariosByIdUsuario($idUser){
        $select="DELETE FROM comentarios WHERE idUsuario = ?";
        $result=$this->query($select,$idUser,'i');
        return $result;
    }
}

?>