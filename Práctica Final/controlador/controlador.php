<?php

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

abstract class AbstractController{

    protected $params;
    protected $vista;

    public function __construct($permisos=0, $webpage='', $user=[]){
        $modeloRecetas=new ModeloRecetas(); 
        $modeloListaCategorias=new ModeloListaCategorias();
        $modeloValoracion=new ModeloValoracion();
        
        $this->params=[];

        //Obtenemos el numero de recetas
        $conteoReceta=$modeloRecetas->countRecetas();
        
        //Obtenemos lista de categorias (listado, añadir recetas...)
        $result2=$modeloListaCategorias->getListaCategorias();

        $categorias=[];
        while(($categoria=mysqli_fetch_array($result2))){
            array_push($categorias, ['id'=>$categoria[id],
            'nombre'=>$categoria[nombre]]);
        }

        $this->params+=['nrecetas'=>$conteoReceta];
        $this->params+=['tipos'=>$categorias];
        
        if($webpage!=''){
            switch($permisos){
                case 0: $this->vista=new VistaVisitante($webpage); break;
                case 1: $this->vista=new VistaColaborador($webpage); break;
                case 2: $this->vista=new VistaAdministrador($webpage); break;
                default: $this->vista=new VistaVisitante($webpage); break;
            }
        }

        //Nombre y foto del usuario si está logueado
        if($user!=[]){
            $this->params+=['usuario'=>$user['nombre']];
            $this->params+=['usuarioID'=>$user['id']];
            $this->params+=['foto'=>$user['foto']];
        }
        
        //Recetas mas valoradas
        $masValoradas=[];
        $recetas=$modeloRecetas->getAllRecetas();
        
        while($receta=mysqli_fetch_array($recetas)){
            //Obtenemos url para ver la receta 
            $visurl="index.php?p=visualizar&id=".$receta[id];
            
            //Obtenemos valoracion media de las recetas
            $result2=$modeloValoracion->getValoracionesByIdReceta($receta[id]);
            
            $valoracion=mysqli_fetch_array($result2);
            $valoracionMedia=$valoracion[0];

            while($valoracion=mysqli_fetch_array($result2)){
                $valoracionMedia=($valoracionMedia+$valoracion[0])/2;
            }
            
            array_push($masValoradas, ['nombre'=>$receta[nombre], 'ver'=>$visurl,
            'valoracion'=>$valoracionMedia]);
        }
        
        array_multisort(array_column($masValoradas,'valoracion'), SORT_DESC, $masValoradas);

        $this->params+=['masValoradas'=>[$masValoradas[0],$masValoradas[1],$masValoradas[2]]];
    }  
    
    public function displayStatic(){
        $this->vista->render($this->params);
    }
}

?>