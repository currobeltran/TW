<?php

require_once "modelo/modeloAbstracto.php";
require_once "vista/vista.php";

abstract class AbstractController{

    protected $params;

    public function __construct(){
        $modeloRecetas=new ModeloRecetas(); 
        $modeloListaCategorias=new ModeloListaCategorias();
        $this->params=[];

        //Obtenemos el numero de recetas
        $conteoReceta=$modeloRecetas->countRecetas();

        //Obtenemos lista de categorias
        $result2=$modeloListaCategorias->getListaCategorias();
        $categorias=[];
        while(($categoria=mysqli_fetch_array($result2))){
            array_push($categorias, $categoria[nombre]);
        }

        $this->params+=['nrecetas'=>$conteoReceta];
        $this->params+=['tipos'=>$categorias];
    }
}

class ControladorRecetas extends AbstractController{
    protected $mrecetas;
    protected $vrecetas;

    public function __construct($webpage){
        parent::__construct();
        $this->mrecetas=new ModeloRecetas();
        $this->vrecetas=new VistaAdministrador($webpage);
    }

    //**************QUEDA HACER LO DE LAS PAGINAS
    public function listarRecetas($titulo='', $contenido='', $numeroxPag=1, $pag){
        //Obtenemos los modelos necesarios

        //Obtenemos lista de recetas
        $result=$this->mrecetas->getListaRecetas($titulo,$contenido);

        $recetas=[];
        $i=0;
        while(($receta=mysqli_fetch_array($result)) && (isset($numeroxPag) && $i<$numeroxPag)){
            $visurl="index.php?p=visualizar&id=".$receta[id];
            $edurl="index.php?p=editareceta&id=".$receta[id];
            $elurl="index.php?p=eliminareceta&id=".$receta[id];

            array_push($recetas, ['nombre'=>$receta[nombre], 
            'visurl'=>$visurl,'edurl'=>$edurl,'elurl'=>$elurl]);
            $i++;
        }

        //Añadimos todo al vector de parametros
        $this->params+=['recetas'=>$recetas];
        $this->params+=['pagina'=>$pag];

        //Generamos la pagina
        $this->vrecetas->render($this->params);
    }

    public function verReceta($id){
        //Crear los modelos necesarios
        $modelo2=new ModeloUsuario();
        $modelo3=new ModeloFotos();

        //Obtener la receta
        $result=$this->mrecetas->getRecetaById($id);
        $receta=mysqli_fetch_array($result);
        
        //Obtener el nombre del autor a través de su id
        $result2=$modelo2->getUsuarioById($receta[idAutor]);
        $autor=mysqli_fetch_array($result2);

        //Obtener la imagen a traves del id de la receta
        $result3=$modelo3->getFotoByIdReceta($receta[id]);
        $foto=mysqli_fetch_array($result3);

        //Generar datos para ser procesados correctamente
        $ingredientes=explode("#",$receta[ingredientes]);
        $preparacion=explode("#",$receta[preparacion]);
        $recetaedurl="index.php?p=editareceta&id".$receta[id];
        $recetaelurl="index.php?p=eliminareceta&id".$receta[id];

        //Introducir datos en el mismo vector
        $this->params+=['nombre'=>$receta[nombre]];
        $this->params+=['autor'=>$autor[nombre]];
        $this->params+=['imagen'=>$foto[fichero]];
        $this->params+=['descripcion'=>$receta[descripcion]];
        $this->params+=['ingredientes'=>$ingredientes];
        $this->params+=['pasos'=>$preparacion];
        $this->params+=['recetaedurl'=>$recetaedurl];
        $this->params+=['recetaelurl'=>$recetaelurl];

        $this->vrecetas->render($this->params);
    }

    public function anadirReceta($datos, $envio=false, $confirmado=false){
        $hayerror=[];
        
        if($confirmado==false){
            if(empty($datos['titulo'])){
                $hayerror+=[ 'titulo' => "Debe introducir un título" ];
            }
    
            if(!strlen(trim($datos['descripcion']))){
                $hayerror+=[ 'descripcion' => "Debe introducir una descripción" ];
            }
            
            
            if(!strlen(trim($datos['ingredientes']))){
                $hayerror+=['ingredientes' => "Debe introducir uno o más ingredientes"];
            }
            
            
            if(!strlen(trim($datos['preparacion']))){
                $hayerror+=[ 'preparacion' => "Debe introducir uno o más pasos de preparación" ];
            }
    
            $hayerror+=[ 'numeroelementos' => count($hayerror) ];
        }

        else{
            //INTRODUCIR DATOS EN BBDD
            //BUCLE PARA OBTENER DATOS DE CATEGORIAS ¿COMO DETECTAR PALABRAS?
        }

        $this->params+=['envio'=>$envio];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['datos'=>$datos];
        $this->params+=['confirmado'=>$confirmado];

        $this->vrecetas->render($this->params);
    }
}

?>