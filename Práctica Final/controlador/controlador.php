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
            array_push($categorias, ['id'=>$categoria[id],
            'nombre'=>$categoria[nombre]]);
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
    public function listarRecetas($titulo='', $contenido='', $numeroxPag=1, $pag=1, $categoria=[]){
        //Obtenemos lista de recetas
        $result=$this->mrecetas->getListaRecetas($titulo,$contenido,$categoria);

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

    public function listarRecetasByUser($titulo,$contenido,$idAutor, $numeroxPag=1, $pag){
        //Obtenemos lista de recetas
        $result=$this->mrecetas->getListaRecetasUsuario($titulo,$contenido,$idAutor);
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

    public function anadirReceta($datos=[], $envio=false, $confirmado=false){
        $hayerror=[];
        $cats=[];
        
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

        else if($datos!=[]){
            //Establecemos una variable de categorias
            $cats=$datos['categorias'];

            //Ordenamos la informacion
            $datos=[
                $datos['autor'], 
                $datos['titulo'],
                $datos['descripcion'],
                $datos['ingredientes'],
                $datos['preparacion']
            ];

            $rec=$this->mrecetas->insertReceta($datos);

            //Si existe, añadimos las categorias correspondientes
            $modeloCategorias=new ModeloCategorias();

            if($cats!=[]){
                foreach($cats as $cat){
                    $modeloCategorias->insertCategoria($rec,$cat);
                }
            }
        }

        $this->params+=['envio'=>$envio];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['datos'=>$datos];
        $this->params+=['confirmado'=>$confirmado];

        $this->vrecetas->render($this->params);

        return $datos;
    }

    public function editarReceta($id, $entrada=[], $envio=false, $confirmado=false){
        $hayerror=[];
        $cats=[];
        $datos=[];

        $modeloCategorias=new ModeloCategorias();

        if($confirmado==false){
            if(empty($entrada['titulo'])){
                $hayerror+=[ 'titulo' => "Debe introducir un título" ];
            }

            if(!strlen(trim($entrada['descripcion']))){
                $hayerror+=[ 'descripcion' => "Debe introducir una descripción" ];
            }
            
            
            if(!strlen(trim($entrada['ingredientes']))){
                $hayerror+=['ingredientes' => "Debe introducir uno o más ingredientes"];
            }
            
            
            if(!strlen(trim($entrada['preparacion']))){
                $hayerror+=[ 'preparacion' => "Debe introducir uno o más pasos de preparación" ];
            }
    
            $hayerror+=[ 'numeroelementos' => count($hayerror) ];

            if($hayerror['numeroelementos'] > 0){
                //Obtener la receta
                $result=$this->mrecetas->getRecetaById($id);
                $datos=mysqli_fetch_array($result);
    
                //Obtenemos las categorias
                $result2=$modeloCategorias->getCategoriasByIdReceta($id);
                $categoria=mysqli_fetch_array($result2);
    
                do{
                    array_push($cats, $categoria[idCategoria]);
                }while($categoria=mysqli_fetch_array($result2));
            }
            
            else{
                $datos=$entrada;

                //NO DETECTA LOS TIPOS CORRECTAMENTE
                foreach($entrada as $tipo){
                    if(strpos($tipo,"categoria") !== false){
                        $tipo=explode("#", $tipo);
                        array_push($categoria,$tipo[1]);
                    }
                }
                
                if($categoria[0]!=null){
                    $datos+=['categorias'=>$categoria];
                }
            }
                
        }
        else{
            $params=[
                $entrada['titulo'], 
                $entrada['descripcion'],
                $entrada['ingredientes'],
                $entrada['preparacion'],
                $id
            ];

            //Llamamos a editarReceta
            $this->mrecetas->editarRecetaById($params);

            //Obtenemos las categorias
            foreach($entrada as $tipo){
                if(strpos($tipo,"categoria") !== false){
                    $tipo=explode("#", $tipo);
                    array_push($cats,$tipo[1]);
                }
            }

            //Si existe, añadimos las categorias correspondientes
            $modeloCategorias=new ModeloCategorias();

            //Eliminamos las categorias antiguas
            $modeloCategorias->deleteCategorias($id);

            //Añadimos las nuevas
            if($cats!=[]){
                foreach($cats as $cat){
                    $modeloCategorias->insertCategoria($id,$cat);
                }
            }
        }

        $this->params+=['envio'=>$envio];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['datos'=>$datos];
        $this->params+=['confirmado'=>$confirmado];
        $this->params+=['categorias'=>$cats];

        $this->vrecetas->render($this->params);

        return $datos;
    }

}

class ControladorUsuario extends AbstractController{
    public function __construct($webpage){
        parent::__construct();
        $this->musuario=new ModeloUsuario();
        $this->vrecetas=new VistaAdministrador($webpage);
    }

    public function editarUsuario($datos){

    }
}

?>