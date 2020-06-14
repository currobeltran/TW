<?php

require_once "modelo/modeloAbstracto.php";

class ModeloListaCategorias extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
    }

    public function exists($id){
        $result=parent::exists("listacategorias", $id);
        return $result;
    }

    public function getListaCategorias(){
        $select="SELECT * FROM listacategorias";
        $result=$this->query($select);
        return $result;
    }

    public function insertCategoria($nombre){
        $select="INSERT INTO listacategorias (nombre) VALUES (?)";
        $this->query($select, $nombre, 's');
        $result=$this->db->insert_id;
        return $result;
    }
}

?>