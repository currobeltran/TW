<?php

require_once "modelo/modeloAbstracto.php";

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