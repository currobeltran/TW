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
        //Obtenemos los modelos necesarios
        $modelo=new ModeloRecetas();
        $listacat=new ModeloListaCategorias();

        //Obtenemos lista de recetas
        $result=$modelo->getListaRecetas();
        
        $params=[];
        $recetas=[];
        while(($receta=mysqli_fetch_array($result))){
            array_push($recetas, $receta[nombre]);
        }

        //Obtenemos lista de categorias
        $result2=$listacat->getListaCategorias();
        $categorias=[];
        while(($categoria=mysqli_fetch_array($result2))){
            array_push($categorias, $categoria[nombre]);
        }

        //Obtenemos el numero de recetas
        $result3=$modelo->countRecetas();

        //Añadimos todo al vector de parametros
        $params+=['recetas'=>$recetas];
        $params+=['tipos'=>$categorias];
        $params+=['nrecetas'=>$result3];

        //Generamos la pagina
        $this->$vrecetas->render($params);
    }

    public function countRecetas(){

    }
}

?>