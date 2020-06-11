<?php

require_once "modelo/modeloAbstracto.php";
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

        }

        $this->params+=['envio'=>$envio];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['datos'=>$datos];
        $this->params+=['confirmado'=>$confirmado];

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
                
                //Si se ha eliminado alguna imagen, se procesa la orden
                $modeloFotos=new ModeloFotos();

                if(isset($entrada['fotos'])){
                    if($entrada['fotos']!=0){
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
            }
                
        }
        else{
            //Guardamos las categorias
            $categorias=$entrada['categorias'];

            $datos=[
                $entrada['titulo'], 
                $entrada['descripcion'],
                $entrada['ingredientes'],
                $entrada['preparacion'],
                $id
            ];

            //Llamamos a editarReceta
            $this->mrecetas->editarRecetaById($datos);

            //Si existe, añadimos las categorias correspondientes
            $modeloCategorias=new ModeloCategorias();

            //Eliminamos las categorias antiguas
            $modeloCategorias->deleteCategoria($id);

            //Añadimos las nuevas
            if($categorias!=null){
                foreach($categorias as $cat){
                    $modeloCategorias->insertCategoria($id,$cat);
                }
            }
        }

        $this->params+=['envio'=>$envio];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['datos'=>$datos];
        $this->params+=['confirmado'=>$confirmado];
        $this->params+=['categorias'=>$cats];
        if($fot!=[])
            $this->params+=['fotos'=>$fot];

        $this->vista->render($this->params);

        return $datos;
    }

    public function eliminarReceta($id, $confirmado=false){
        if($confirmado){
            $ml=new ControladorLog();

            $result=$this->mrecetas->getRecetaById($id);
            $recetaAux=mysqli_fetch_array($result);

            $ml->nuevaRecetaEliminada($recetaAux['nombre']);

            //Eliminar comentarios
            $modeloComentarios=new ModeloComentarios();
            $modeloComentarios->deleteComentariosReceta($id);

            //Eliminar valoraciones
            $modeloValoraciones=new ModeloValoracion();
            $modeloValoraciones->deleteValoracionesReceta($id);

            //Eliminar categorias
            $modeloCategorias=new ModeloCategorias();
            $modeloCategorias->deleteCategoria($id);

            //Eliminar fotos
            $modeloFotos=new ModeloFotos();
            $modeloFotos->eliminaFotoByIdReceta($id);

            //Por último, eliminamos la receta
            $this->mrecetas->eliminaReceta($id);
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
    
            $modeloComentarios->insertComentario($datos);
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
                
                $modeloValoracion->insertValoracion($datos);
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
            $modeloListaCat->insertCategoria($datos['nombreCategoria']);
        }

        if(empty($datos['nombreCategoria'])){
            $hayerror+=['nombreCategoria'=>"Debe introducir un nombre para la categoria"];
        }

        $hayerror+=['numeroElementos'=>count($hayerror)];

        $this->params+=['datos'=>$datos];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['envio'=>$envio];
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
            $modeloComentarios->deleteComentarioById($id);

            $this->params+=['elimina'=>$elimina];
        }

        $this->verReceta($tupla['idReceta'], $usuario);
    }
}

class ControladorUsuario extends AbstractController{
    protected $musuario;
    
    public function __construct($permisos=0,$webpage='',$user=[]){
        parent::__construct($permisos,$webpage,$user);
        $this->musuario=new ModeloUsuario();
    }

    public function editarUsuario($id, $entrada=[], $envio=false, $confirmado=false){
        $hayerror=[];
        $datosUser=[];

        if($confirmado==false){
            if(empty($entrada['nombre'])){
                $hayerror+=[ 'nombre' => "Debe introducir un nombre" ];
            }

            if(empty($entrada['apellidos'])){
                $hayerror+=[ 'apellidos' => "Debe introducir unos apellidos" ];
            }
            
            if(empty($entrada['email'])){
                $hayerror+=['email' => "Debe introducir un email"];
            }
            
            if(empty($entrada['clave']) && empty($entrada['clave2'])){
                $hayerror+=[ 'clave' => "Debe introducir su nueva contraseña" ];
            }
            elseif(strcmp($entrada['clave'], $entrada['clave2'])!==0){
                $hayerror+=[ 'clave' => "Las contraseñas deben coincidir" ];
            }

            $hayerror+=[ 'numeroelementos' => count($hayerror) ];

            if($hayerror['numeroelementos']>0){
                //Obtenemos datos del usuario
                $usuario=$this->musuario->getUsuarioById($id);
                $datosUser=mysqli_fetch_array($usuario);

                //Codificamos la foto para que pueda ser visualizada
                if(isset($datosUser['foto'])){
                    $datosUser['foto']=base64_encode($datosUser['foto']);
                }
            }
            else{
                $datosUser=$entrada;
                if(!preg_match('/^[a-zA-Z0-9\/\r\n+]*={0,2}$/',$datosUser['foto'])){
                    $datosUser['foto']=base64_encode($datosUser['foto']);
                }
                $datosUser['clave']=crypt($datosUser['clave'], '$5%rounds=5000$oniasSUbdhaIUABakf$');
            }
        }
        else{
            $datosUser=[
                $entrada['nombre'],
                $entrada['apellidos'],
                $entrada['email'],
                $entrada['clave'],
                base64_decode($entrada['foto'],true),
                $entrada['tipo'],
                $id
            ];

            //Modificamos el usuario
            $this->musuario->editarUsuario($datosUser);
        }
        
        $this->params+=['envio'=>$envio];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['datos'=>$datosUser];
        $this->params+=['confirmado'=>$confirmado];
        
        $this->vista->render($this->params);

        return $datosUser;
    }

    public function listarUsuarios(){
        $usuarios=[];

        //Obtener la lista completa de usuarios
        $result=$this->musuario->getListaUsuarios();
        
        while($usuario=mysqli_fetch_array($result)){
            array_push($usuarios,[
                'nombre'=>$usuario[nombre],
                'editar'=>"index.php?p=Editar+Usuario&id=".$usuario[id],
                'eliminar'=>"index.php?p=eliminauser&id=".$usuario[id]
            ]);
        }

        $this->params+=['usuarios'=>$usuarios];

        $this->vista->render($this->params);
    }

    public function eliminaUsuario($id, $confirmado){ //Controlar las eliminaciones de administradores
        if($confirmado){
            //Eliminamos el usuario en cuestion
            $ml=new ControladorLog();

            $result=$this->musuario->getUsuarioById($id);
            $usuarioAux=mysqli_fetch_array($result);

            $ml->nuevoUsuarioEliminado($usuarioAux['nombre']);

            $this->musuario->eliminarUsuarioById($id);
        }

        else{
            //Obtenemos el nombre del usuario
            $result=$this->musuario->getUsuarioById($id);
            $tupla=mysqli_fetch_array($result);

            $this->params+=['nombre'=>$tupla['nombre']];
        }

        $this->params+=['confirmado'=>$confirmado];

        $this->vista->render($this->params);
    }

    public function anadirUsuario($entrada, $anadir, $confirmar){
        $hayerror=[];

        if($confirmar == false){
            if(empty($entrada['nombre'])){
                $hayerror+=['nombre'=>"Debe introducirse un nombre"];
            }
    
            if(empty($entrada['apellidos'])){
                $hayerror+=['apellidos'=>"Deben introducirse unos apellidos"];
            }
    
            if(empty($entrada['email'])){
                $hayerror+=['email'=>"Debe introducirse un email"];
            }
    
            if(empty($entrada['clave']) && empty($entrada['clave2'])){
                $hayerror+=['clave'=>"Debe introducirse una contraseña y su confirmación"];
            }
            elseif(strcmp($entrada['clave'], $entrada['clave2'])!==0){
                $hayerror+=['clave'=>"La contraseña y su confirmación deben coincidir"];
            }

            $hayerror+=['numeroelementos'=>count($hayerror)];

            $entrada['foto']=base64_encode($entrada['foto']);
            $entrada['clave']=crypt($entrada['clave'], '$5%rounds=5000$oniasSUbdhaIUABakf$');
        }

        else{
            //Insertamos el nuevo usuario
            $entrada=[
                $entrada['nombre'],
                $entrada['apellidos'],
                $entrada['email'],
                base64_decode($entrada['foto']),
                $entrada['clave'],
                $entrada['tipo']
            ];

            $this->musuario->insertUsuario($entrada);
        }

        $this->params+=['envio'=>$anadir];
        $this->params+=['confirmado'=>$confirmar];
        $this->params+=['datos'=>$entrada];
        $this->params+=['hayerror'=>$hayerror];

        $this->vista->render($this->params);

        return $entrada;
    }

    public function comprobarCredenciales($email, $clave){
        $params=[$email, crypt($clave, '$5%rounds=5000$oniasSUbdhaIUABakf$')];
        $result=$this->musuario->comprobarCredenciales($params);
        return $result;
    }

    public function getUsuarioById($id){
        $result=$this->musuario->getUsuarioById($id);
        return $result;
    }
}

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

class ControladorBBDD extends AbstractController{
    protected $modeloDB;

    public function __construct($permisos=0,$webpage='',$user=[]){
        parent::__construct($permisos,$webpage,$user);
        $this->modeloDB=new ModeloBBDD();
    }

    public function copyBBDD(){
        // Obtener listado de tablas
        $tablas = array();
        $result= $this->modeloDB->showTables();
        while($row = mysqli_fetch_row($result)){
            $tablas[] = $row[0];
        }

        //Salvar cada tabla
        $salida='';
        foreach($tablas as $tab){
            $result=$this->modeloDB->selectAllFromTable($tab);
            $num=mysqli_num_fields($result);
            $salida .= 'DROP TABLE '.$tab.';';
            $row2 = mysqli_fetch_row($this->modeloDB->showCreateTable($tab));
            $salida .= "\n\n".$row2[1].";\n\n";

            while($row=mysqli_fetch_row($result)){
                $salida .= 'INSERT INTO '.$tab.' VALUES(';
                for($j=0;$j<$num;$j++){
                    $row[$j]=addslashes($row[$j]);
                    $row[$j]=preg_replace("/\n/","\\n",$row[$j]);
                    
                    if(isset($row[$j])){
                        $salida .= '"'.$row[$j].'"';
                    }
                    else{
                        $salida .= '""';
                    }
                    if($j<($num-1)){
                        $salida .= ',';
                    }
                }
                $salida .= ");\n";
            }
            $salida .= "\n\n\n";
        }
        file_put_contents("./modelo/backup/backup.sql",$salida);
    }

    public function restoreBBDD($copia){
        $this->modeloDB->setForeignChecks(0);

        $result= $this->modeloDB->showTables();
        while($row = mysqli_fetch_row($result)){
            $this->modeloDB->deleteTable($row[0]);
        }

        $sql=file_get_contents($copia);
        $queries=explode(';',$sql);

        foreach($queries as $q){
            $this->modeloDB->query($q);
        }

        $this->modeloDB->setForeignChecks(1);
    }

    public function deleteBBDD($archivo){
        $this->modeloDB->setForeignChecks(0);

        $result= $this->modeloDB->showTables();
        while($row = mysqli_fetch_row($result)){
            $this->modeloDB->deleteTable($row[0]);
        }

        $this->modeloDB->setForeignChecks(1);
    }
}

?>