<?php

require_once "modelo/modeloAbstracto.php";

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
        $this->query($select,$params,'ii'); 
    }

    public function getCategoriasByIdReceta($idRec){
        $select="SELECT * FROM categorias WHERE idReceta = ?";
        $result=$this->query($select,$idRec,'i');
        return $result; 
    }

    public function deleteCategoria($idReceta){
        $select="DELETE FROM categorias WHERE idReceta = ?";
        $result=$this->query($select,$idReceta,'i');
        return $result; 
    }
}

?>