<?php

require_once "modelo/modeloAbstracto.php";

class ModeloValoracion extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function exists($id){
        $result=parent::exists("valoraciones", $id);
        return $result;
    }

    public function getValoracionesByIdReceta($id){
        $select="SELECT valoracion FROM valoraciones WHERE idReceta = ?";
        $result=$this->query($select, $id, 'i');
        return $result;
    }

    public function insertValoracion($params){
        $select="INSERT INTO valoraciones (idReceta, idUsuario, valoracion) VALUES (?,?,?)";
        $this->query($select, $params, 'iii');
        $result=$this->db->insert_id;
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

    public function deleteValoracionesByIdUsuario($idUser){
        $select="DELETE FROM valoraciones WHERE idUsuario = ?";
        $result=$this->query($select, $idUser, 'i');
        return $result;
    }
}

?>