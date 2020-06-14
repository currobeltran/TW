<?php

require_once "modelo/modeloAbstracto.php";

class ModeloUsuario extends AbstractModel{
    public function __construct(){
        parent::__construct();
    }

    public function query($select,$params=[],$type=''){
        $result=parent::query($select,$params,$type);
        return $result;
        
    }

    public function existsUser($id){
        $result=parent::exists("usuarios", $id);
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
        $this->query($select,$params,'ssssss'); 
        $result=$this->db->insert_id;
        return $result;
    }

    public function editarUsuario($params){
        $select="UPDATE usuarios SET nombre = ?, apellidos = ?, 
        email = ?, passwd = ?, foto = ? ,tipo = ? WHERE id = ?";
        $this->query($select,$params,'ssssssi'); 
        
        if(mysqli_affected_rows($this->db)){
            return true;
        }
        else{
            return false;
        }
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

?>