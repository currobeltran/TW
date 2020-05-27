<?php

require_once "modelo/modeloAbstracto.php";
require_once "vista/vista.php";

abstract class AbstractController{
    protected $request;
    protected $page;

    public function __construct($req, $met=null, $par=null, $webpage=null){
        $this->$request=$req;
        if($webpage!==null){
            $this->$page=$webpage;
        }

        if(is_string($met) and $met!==''){
            if($par){
                $this->$met($par);
            }
            else{
                $this->$met();
            }
        }
    }
}

class ControladorRecetas extends AbstractController{
    protected $mrecetas;
    protected $vrecetas;

    public function __construct($req=null, $met=null, $par=null, $webpage=null){
        parent::__construct($req, $met, $par, $webpage);
        $this->$mrecetas=new ModeloRecetas();
        $this->$vrecetas=new VistaAdministrador('listado.html');
    }

    public function listarRecetas(){
        $result=$this->$mrecetas->getListaRecetas("nombre");
        $recetas=[];
        for($i=0; $i<count($result); $i++){
            $receta=mysqli_fetch_array($result);
            $receta=['nombre'=>$receta];
            array_push($recetas,$receta);
        }
        $vrecetas->render($recetas);
    }


}

?>