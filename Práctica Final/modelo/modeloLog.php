<?php

require_once "modelo/modeloAbstracto.php";

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

?>