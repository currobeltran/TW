<?php

require_once "controlador/controlador.php";
require_once "modelo/modeloAbstracto.php";
require_once "modelo/modeloUsuario.php";
require_once "modelo/modeloBBDD.php";
require_once "modelo/modeloCategorias.php";
require_once "modelo/modeloComentarios.php";
require_once "modelo/modeloFotos.php";
require_once "modelo/modeloListaCategorias.php";
require_once "modelo/modeloLog.php";
require_once "modelo/modeloRecetas.php";
require_once "modelo/modeloValoracion.php";
require_once "vista/vista.php";

class ControladorLog extends AbstractController{
    protected $mlog;
    
    public function __construct($permisos=0,$webpage='',$user=[]){
        parent::__construct($permisos,$webpage,$user);
        $this->mlog=new ModeloLog();
    }

    public function listarLog(){
        $log=[];

        $result=$this->mlog->getLog();

        while($incidencia=mysqli_fetch_array($result)){
            array_push($log, $incidencia);
        }

        $this->params+=['log'=>$log];

        $this->vista->render($this->params);
    }

    public function nuevaIdentificacion($usuario){
        $descripcion="El usuario ".$usuario." se ha logueado";
        $fecha=date('Y-m-d H:i:s');

        $datos=[$fecha,$descripcion];
        $this->mlog->anadirIncidencia($datos);
    }

    public function nuevoErrorLogueo(){
        $descripcion="Un usuario ha intentado loguearse sin éxito";
        $fecha=date('Y-m-d H:i:s');

        $params=[$fecha,$descripcion];
        $this->mlog->anadirIncidencia($params);
    }

    public function nuevaReceta($datos){
        $descripcion="Se ha añadido la receta ".$datos;
        $fecha=date('Y-m-d H:i:s');

        $params=[$fecha,$descripcion];
        $this->mlog->anadirIncidencia($params);
    }

    public function nuevaRecetaEliminada($datos){
        $descripcion="Se ha eliminado la receta ".$datos;
        $fecha=date('Y-m-d H:i:s');

        $params=[$fecha,$descripcion];
        $this->mlog->anadirIncidencia($params);
    }

    public function nuevoUsuario($datos){
        $descripcion="Se ha añadido el usuario ".$datos;
        $fecha=date('Y-m-d H:i:s');

        $params=[$fecha,$descripcion];
        $this->mlog->anadirIncidencia($params);
    }

    public function nuevoUsuarioEliminado($datos){
        $descripcion="Se ha eliminado el usuario ".$datos;
        $fecha=date('Y-m-d H:i:s');

        $params=[$fecha,$descripcion];
        $this->mlog->anadirIncidencia($params);
    }
}

?>