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

class ControladorRecetas extends AbstractController{
    protected $mrecetas;

    public function __construct($permisos=0,$webpage='',$user=[]){
        parent::__construct($permisos,$webpage,$user);
        $this->mrecetas=new ModeloRecetas();
    }

    public function listarRecetas($titulo='', $contenido='', $numeroxPag=1, $pag=1, $categoria=[], $orden){
        $modeloValoracion=new ModeloValoracion();
        $modeloComentarios=new ModeloComentarios();
        
        //Obtenemos lista de recetas
        $result=$this->mrecetas->getListaRecetas($titulo,$contenido,$categoria, $orden);
        if(!empty($result->error)){
            return false;
        }
        $recetas=[];

        //Nos quedamos con las recetas necesarias
        for($i=0; $i<($pag*$numeroxPag); $i++){
            $receta=mysqli_fetch_array($result);
        }

        //Procesamos las recetas seleccionadas
        $j=0;
        while(($receta=mysqli_fetch_array($result)) && (isset($numeroxPag) && $j<$numeroxPag)){
            $visurl="index.php?p=visualizar&id=".$receta[id];
            $edurl="index.php?p=editareceta&id=".$receta[id];
            $elurl="index.php?p=eliminareceta&id=".$receta[id];

            //Obtenemos valoracion media de las recetas
            $result2=$modeloValoracion->getValoracionesByIdReceta($receta[id]);
            if(!empty($result2->error)){
                return false;
            }
            $valoracion=mysqli_fetch_array($result2);
            $valoracionMedia=$valoracion[0];

            while($valoracion=mysqli_fetch_array($result2)){
                $valoracionMedia=($valoracionMedia+$valoracion[0])/2;
            }

            //Obtenemos el numero de comentarios
            $result3=$modeloComentarios->getComentariosByIdReceta($receta[id]);
            if(!empty($result3->error)){
                return false;
            }
            $ncomentarios=$result3->num_rows;

            //Generamos un vector de datos clave-valor correspondiente a una receta
            array_push($recetas, ['nombre'=>$receta[nombre], 'visurl'=>$visurl,
            'edurl'=>$edurl,'elurl'=>$elurl, 'valoracion'=>$valoracionMedia,
            'ncomentarios'=>$ncomentarios, 'autor'=>$receta[idAutor]]);
            $j++;
        }

        //Si ordenamos por comentarios o valoraciones:
        if($orden=="MASVAL"){
            array_multisort(array_column($recetas,'valoracion'), SORT_DESC, $recetas);
        }
        else if($orden=="MASCOM"){
            array_multisort(array_column($recetas,'ncomentarios'), SORT_DESC, $recetas);
        }

        //Añadimos todo al vector de parametros
        $this->params+=['recetas'=>$recetas];
        $this->params+=['pagina'=>$pag];
        $this->params+=['nombre'=>$titulo];
        $this->params+=['contenido'=>$contenido];
        $this->params+=['categorias'=>$categoria];
        $this->params+=['orden'=>$orden];
        $this->params+=['numerorecetas'=>$numeroxPag];

        //Generamos la pagina
        $this->vista->render($this->params);
    }

    public function listarRecetasByUser($titulo,$contenido,$idAutor, $numeroxPag=1, $pag=0, $categoria=[], $orden){
        $modeloValoracion=new ModeloValoracion();
        $modeloComentarios=new ModeloComentarios();
        
        //Obtenemos lista de recetas
        $result=$this->mrecetas->getListaRecetasUsuario($titulo,$contenido,$idAutor,$categoria, $orden);
        $recetas=[];

        for($i=0; $i<($pag*$numeroxPag); $i++){
            $receta=mysqli_fetch_array($result);
        }

        //Procesamos las recetas seleccionadas
        $j=0;
        while(($receta=mysqli_fetch_array($result)) && (isset($numeroxPag) && $j<$numeroxPag)){
            $visurl="index.php?p=visualizar&id=".$receta[id];
            $edurl="index.php?p=editareceta&id=".$receta[id];
            $elurl="index.php?p=eliminareceta&id=".$receta[id];

            //Obtenemos valoracion media de las recetas
            $result2=$modeloValoracion->getValoracionesByIdReceta($receta[id]);
            $valoracion=mysqli_fetch_array($result2);
            $valoracionMedia=$valoracion[0];

            while($valoracion=mysqli_fetch_array($result2)){
                $valoracionMedia=($valoracionMedia+$valoracion[0])/2;
            }

            //Obtenemos el numero de comentarios
            $result3=$modeloComentarios->getComentariosByIdReceta($receta[id]);
            $ncomentarios=$result3->num_rows;

            //Generamos un vector de datos clave-valor correspondiente a una receta
            array_push($recetas, ['nombre'=>$receta[nombre], 'visurl'=>$visurl,
            'edurl'=>$edurl,'elurl'=>$elurl, 'valoracion'=>$valoracionMedia,
            'ncomentarios'=>$ncomentarios, 'autor'=>$receta[idAutor]]);
            $j++;
        }

        //Si ordenamos por comentarios o valoraciones:
        if($orden=="MASVAL"){
            array_multisort(array_column($recetas,'valoracion'), SORT_DESC, $recetas);
        }
        else if($orden=="MASCOM"){
            array_multisort(array_column($recetas,'ncomentarios'), SORT_DESC, $recetas);
        }

        //Añadimos todo al vector de parametros
        $this->params+=['recetas'=>$recetas];
        $this->params+=['pagina'=>$pag];
        $this->params+=['nombre'=>$titulo];
        $this->params+=['contenido'=>$contenido];
        $this->params+=['categorias'=>$categoria];
        $this->params+=['orden'=>$orden];
        $this->params+=['numerorecetas'=>$numeroxPag];

        //Generamos la pagina
        $this->vista->render($this->params);
    }

    public function verReceta($id, $usuario=[]){
        //Crear los modelos necesarios
        $modelo2=new ModeloUsuario();
        $modelo3=new ModeloFotos();
        $modeloComentarios=new ModeloComentarios();
        $modeloValoraciones=new ModeloValoracion();

        //Obtener la receta
        $result=$this->mrecetas->getRecetaById($id);
        $receta=mysqli_fetch_array($result);
        
        //Obtener el nombre del autor a través de su id
        $result2=$modelo2->getUsuarioById($receta['idAutor']);
        $autor=mysqli_fetch_array($result2);

        //Obtener la imagen a traves del id de la receta
        $result3=$modelo3->getFotoByIdReceta($receta['id']);
        $foto=mysqli_fetch_array($result3);

        //Obtener demas fotos si existen
        $fotos=[];
        while($paso=mysqli_fetch_array($result3)){
            array_push($fotos, $paso['fichero']);
        }

        //Generar datos para ser procesados correctamente
        $ingredientes=explode("#",$receta['ingredientes']);
        $preparacion=explode("#",$receta['preparacion']);
        $recetaedurl="index.php?p=editareceta&id=".$receta['id'];
        $recetaelurl="index.php?p=eliminareceta&id=".$receta['id'];
        $recetacomurl="index.php?p=comentar&id=".$receta['id'];
        $recetavalurl="index.php?p=valoracion&id=".$receta['id'];

        //Obtener el vector de comentarios de la receta
        $result=$modeloComentarios->getComentariosByIdReceta($id);

        $comentarios=[];

        while($comentario=mysqli_fetch_array($result)){
            
            $user=$modelo2->getUsuarioById($comentario['idUsuario']);
            $tuplaUsuario=mysqli_fetch_array($user);

            $comentario+=['nombreUsuario'=>$tuplaUsuario['nombre']];
            $comentario+=['eliminaurl'=>"index.php?p=eliminacomentario&id=".$comentario['id']];

            array_push($comentarios,$comentario);
        }

        //Obtener las valoraciones y hacer la media
        $result=$modeloValoraciones->getValoracionesByIdReceta($id);
        $valoracion=mysqli_fetch_array($result);
        $media=$valoracion[0];

        while($valoracion=mysqli_fetch_array($result)){
            $media=($media+$valoracion[0])/2;
        }
        
        //Si el usuario es autor de la receta, dar el acceso a la edicion
        if($this->comprobarRecetaUsuario($id, $usuario['id']) || $usuario['tipo']=='Administrador'){
            $botonesEdicion=true;
        }
        else{
            $botonesEdicion=false;
        }

        //Introducir datos en el mismo vector
        $this->params+=['nombre'=>$receta['nombre']];
        $this->params+=['autor'=>$autor['nombre']];
        $this->params+=['imagen'=>$foto['fichero']];
        $this->params+=['descripcion'=>$receta['descripcion']];
        $this->params+=['ingredientes'=>$ingredientes];
        $this->params+=['pasos'=>$preparacion];
        $this->params+=['recetaedurl'=>$recetaedurl];
        $this->params+=['recetaelurl'=>$recetaelurl];
        $this->params+=['recetacomurl'=>$recetacomurl];
        $this->params+=['recetavalurl'=>$recetavalurl];
        $this->params+=['comentarios'=>$comentarios];
        $this->params+=['valoracion'=>$media];
        $this->params+=['botonesEdicion'=>$botonesEdicion];
        $this->params+=['imagenPaso'=>$fotos];

        $this->vista->render($this->params);
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

            if(!$this->mrecetas->exists($rec)){
                $this->params+=['errorEnvio'=>true];
            }
            else{
                $controladorLog=new ControladorLog();

                $controladorLog->nuevaReceta($datos[1]);
            }
        }

        $this->params+=['envio'=>$envio];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['datos'=>$datos];
        $this->params+=['confirmacion'=>$confirmado];
        $this->params+=['tipoDato'=>"Añada una nueva receta"];

        $this->vista->render($this->params);

        return $datos;
    }

    public function editarReceta($id, $entrada=[], $envio=false, $confirmado=false){
        $hayerror=[];
        $cats=[];
        $datos=[];
        $fot=[];

        $modeloCategorias=new ModeloCategorias();
        $modeloFotos=new ModeloFotos();

        if($confirmado==false){
            if(empty($entrada['nombre'])){
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

            if($hayerror['numeroelementos'] > 0 || $entrada==[]){
                //Obtener la receta
                $result=$this->mrecetas->getRecetaById($id);
                $datos=mysqli_fetch_array($result);
    
                //Obtenemos las categorias
                $result2=$modeloCategorias->getCategoriasByIdReceta($id);
                $categoria=mysqli_fetch_array($result2);

                do{
                    array_push($cats, $categoria[idCategoria]);
                }while($categoria=mysqli_fetch_array($result2));
                
                $this->params+=['categorias'=>$cats];

                if(isset($entrada['fotos'])){
                    if($entrada['fotos']!=0){
                        //Obtenemos la foto para eliminarla del sistema
                        $foto=$modeloFotos->getFotoById($entrada['fotos']);
                        $foto=mysqli_fetch_array($foto);
                        unlink($foto['fichero']);

                        $modeloFotos->eliminaFotoById($entrada['fotos']);
                    }
                }

                //Si se ha añadido alguna, la introducimos
                if(isset($entrada['rutanuevafoto'])){
                    $modeloFotos->insertFotoInReceta($id,$entrada['rutanuevafoto']);
                }

                //Obtenemos las fotos
                $result3=$modeloFotos->getFotoByIdReceta($id);

                while($fotos=mysqli_fetch_array($result3)){
                    array_push($fot, ['id'=>$fotos[id], 'fichero'=>$fotos[fichero]]);
                }
                
            }
            
            else{
                $datos=$entrada;
                $this->params+=['categorias'=>$datos['categorias']];
            }
                
        }
        else{
            //Guardamos las categorias
            $categorias=$entrada['categorias'];
            $this->params+=['categorias'=>$categorias];

            $datos=[
                $entrada['nombre'], 
                $entrada['descripcion'],
                $entrada['ingredientes'],
                $entrada['preparacion'],
                $id
            ];

            //Llamamos a editarReceta
            if(!$this->mrecetas->editarRecetaById($datos)){
                $this->params+=['errorEnvio'=>true];
            }

            //Si existe, añadimos las categorias correspondientes
            $modeloCategorias=new ModeloCategorias();

            //Eliminamos las categorias antiguas
            $modeloCategorias->deleteCategoria($id);

            //Añadimos las nuevas
            if($categorias!=null){
                foreach($categorias as $cat){
                    $idCat=$modeloCategorias->insertCategoria($id,$cat);
                }
            }
        }

        $this->params+=['envio'=>$envio];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['datos'=>$datos];
        $this->params+=['confirmacion'=>$confirmado];
        $this->params+=['fotos'=>$fot];
        $this->params+=['tipoDato'=>"Edite la siguiente receta"];

        $this->vista->render($this->params);

        return $datos;
    }

    public function eliminarReceta($id, $confirmado=false){
        if($confirmado){

            $result=$this->mrecetas->getRecetaById($id);
            $recetaAux=mysqli_fetch_array($result);

            //Eliminar comentarios
            $modeloComentarios=new ModeloComentarios();
            $modeloComentarios->deleteComentariosReceta($id);

            //Eliminar valoraciones
            $modeloValoraciones=new ModeloValoracion();
            $modeloValoraciones->deleteValoracionesReceta($id);

            //Eliminar categorias
            $modeloCategorias=new ModeloCategorias();
            $modeloCategorias->deleteCategoria($id);

            //Eliminar fotos tanto de la base de datos como del sistema
            $modeloFotos=new ModeloFotos();
            
            $fotos=$modeloFotos->getFotoByIdReceta($id);
            while($foto=mysqli_fetch_array($fotos)){
                unlink($foto['fichero']);
            }

            $modeloFotos->eliminaFotoByIdReceta($id);

            //Por último, eliminamos la receta
            /**
             * Solo es necesario comprobar aquí, ya que si hay algún error anterior 
             * en alguna de las eliminaciones saltaría una excepción de clave externa al
             * intentar eliminar la receta
             */
            $this->mrecetas->eliminaReceta($id);

            if($this->mrecetas->exists($id)){
                $this->params+=['errorEnvio'=>true];
            }
            else{
                $ml=new ControladorLog();
                $ml->nuevaRecetaEliminada($recetaAux['nombre']);
            }
        }
        else{
            $result=$this->mrecetas->getRecetaById($id);
            $datos=mysqli_fetch_array($result);

            $this->params+=['nombre'=>$datos['nombre']];
        }

        $this->params+=['confirmacion'=>$confirmado];

        $this->vista->render($this->params);
    }

    public function getRecetaAleatoria(){
        $result=$this->mrecetas->getAllRecetas();

        $recetas=[];
        while($receta=mysqli_fetch_array($result)){
            array_push($recetas,$receta[id]);
        }

        $selec=rand(0, count($recetas)-1);

        return $recetas[$selec];
    }

    public function enviarComentario($comentario, $idReceta, $idUsuario, $confirmar, $envio){
        // Creamos el modelo de comentarios
        $modeloComentarios=new ModeloComentarios();
        
        //Si el comentario esta vacio, lo notificamos
        if(!strlen(trim($comentario))){
            $this->params+=['nocomentario'=>"Debe introducir un comentario"];
        }
        
        if($confirmar){
            $datos=[
                $idUsuario,
                $idReceta,
                $comentario,
                date('Y-m-d H:i:s')
            ];
    
            $idComent=$modeloComentarios->insertComentario($datos);

            if(!$modeloComentarios->exists($idComent)){
                $this->params+=['errorEnvio'=>true];
            }
        }

        $this->params+=['confirmar'=>$confirmar];
        $this->params+=['comentario'=>$comentario];
        $this->params+=['envio'=>$envio];

        if($comentario!='')
            return $comentario;
    }

    public function enviarValoracion($idReceta, $idUsuario, $valoracion, $confirmar, $envio){
        //Creamos el modelo de valoracion
        $modeloValoracion=new ModeloValoracion();

        //Si la valoracion es vacia o es menor que 0 o mayor que 10 lo notificamos
        if(empty($valoracion)){
            $this->params+=['novaloracion'=>"Debe introducir una valoracion"];
        }
        elseif($valoracion < 0 || $valoracion >10){
            $this->params+=['novaloracion'=>"El valor debe estar entre 0 y 10"];
        }

        if($confirmar){

            $ident=[$idReceta, $idUsuario];

            //Comprobamos que el usuario no haya valorado
            $result=$modeloValoracion->getValoracionByIdUsuarioReceta($ident);

            if($valoracionAnterior=mysqli_fetch_array($result)){
                $datos=[
                    $valoracion,
                    $valoracionAnterior['id']
                ];

                $modeloValoracion->editarValoracion($datos);
            }
            else{
                $datos=[
                    $idReceta,
                    $idUsuario,
                    $valoracion
                ];
                
                $idValor=$modeloValoracion->insertValoracion($datos);

                if(!$modeloValoracion->exists($idValor)){
                    $this->params+=['errorEnvio'=>true];
                }
            }
        }

        $this->params+=['confirmar'=>$confirmar];
        $this->params+=['valor'=>$valoracion];
        $this->params+=['envio'=>$envio];

        return $valoracion;
    }

    public function comprobarRecetaUsuario($idReceta, $idUsuario){
        $result=$this->mrecetas->getRecetaById($idReceta);
        
        if($receta=mysqli_fetch_array($result)){
            if($idUsuario == $receta['idAutor']){
                return true;
            }
        }

        return false;
    }

    public function anadirNuevaCategoria($datos, $envio, $confirmacion){
        $hayerror=[];

        if($confirmacion){
            $modeloListaCat=new ModeloListaCategorias();
            $idCat=$modeloListaCat->insertCategoria($datos['nombreCategoria']);

            if(!$modeloListaCat->exists($idCat)){
                $this->params+=['errorEnvio'=>true];
            }
        }

        if(empty($datos['nombreCategoria'])){
            $hayerror+=['nombreCategoria'=>"Debe introducir un nombre para la categoria"];
        }

        $hayerror+=['numeroelementos'=>count($hayerror)];

        $this->params+=['datos'=>$datos];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['envio'=>$envio];
        $this->params+=['tipoDato'=>"Añade una nueva categoría"];
        $this->params+=['confirmacion'=>$confirmacion];

        $this->vista->render($this->params);

        return $datos;
    }

    public function eliminaComentario($id, $usuario, $elimina){
        $modeloComentarios=new ModeloComentarios();

        $comentario=$modeloComentarios->getComentarioById($id);
        $tupla=mysqli_fetch_array($comentario);

        $this->params+=['comentario'=>$tupla['comentario']];
        
        if($elimina){
            $idComent=$modeloComentarios->deleteComentarioById($id);

            if($modeloComentarios->exists($idComent)){
                $this->params+=['errorEnvio'=>true];
            }

            $this->params+=['elimina'=>$elimina];
        }

        $this->verReceta($tupla['idReceta'], $usuario);
    }
}

?>