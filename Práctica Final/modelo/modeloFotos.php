<?php

require_once "modelo/modeloAbstracto.php";

class ModeloFotos extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    //Peticion
    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function getFotoById($id){
        $select="SELECT * FROM fotos WHERE id LIKE ?";
        $result=$this->query($select,$id,'i');
        return $result; 
    }

    //Coger foto a traves de la id de la receta
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
        $select="DELETE FROM fotos WHERE id = ?";
        $result=$this->query($select,$id,'i');
        return $result;
    }

    //Eliminar foto a traves del id de la receta
    public function eliminaFotoByIdReceta($id){
        $select="DELETE FROM fotos WHERE idReceta = ?";
        $result=$this->query($select,$id,'i');
        return $result;
    }
}

?>