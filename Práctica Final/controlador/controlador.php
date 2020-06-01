<?php

require_once "modelo/modeloAbstracto.php";
require_once "vista/vista.php";

abstract class AbstractController{

    protected $params;
    protected $vista;

    public function __construct($permisos=0, $webpage='', $user=[]){
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

        if($webpage!=''){
            switch($permisos){
                case 0: $this->vista=new VistaVisitante($webpage); break;
                case 1: $this->vista=new VistaColaborador($webpage); break;
                case 2: $this->vista=new VistaAdministrador($webpage); break;
                default: $this->vista=new VistaVisitante($webpage); break;
            }
        }

        if($user!=[]){
            $this->params+=['usuario'=>$user['nombre']];
            $this->params+=['foto'=>$user['foto']];
        }
    }
}

class ControladorRecetas extends AbstractController{
    protected $mrecetas;

    public function __construct($permisos=0,$webpage='',$user=[]){
        parent::__construct($permisos,$webpage,$user);
        $this->mrecetas=new ModeloRecetas();
    }

    //**************QUEDA HACER LO DE LAS PAGINAS
    public function listarRecetas($titulo='', $contenido='', $numeroxPag=1, $pag=1, $categoria=[], $orden){
        //Obtenemos lista de recetas
        $result=$this->mrecetas->getListaRecetas($titulo,$contenido,$categoria, $orden);

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
        $this->vista->render($this->params);
    }

    public function listarRecetasByUser($titulo,$contenido,$idAutor, $numeroxPag=1, $pag=1, $categoria=[], $orden){
        //Obtenemos lista de recetas
        $result=$this->mrecetas->getListaRecetasUsuario($titulo,$contenido,$idAutor,$categoria, $orden);
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
        $this->vista->render($this->params);
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
        $recetaedurl="index.php?p=editareceta&id=".$receta[id];
        $recetaelurl="index.php?p=eliminareceta&id=".$receta[id];

        //Introducir datos en el mismo vector
        $this->params+=['nombre'=>$receta[nombre]];
        $this->params+=['autor'=>$autor[nombre]];
        $this->params+=['imagen'=>$foto[fichero]];
        $this->params+=['descripcion'=>$receta[descripcion]];
        $this->params+=['ingredientes'=>$ingredientes];
        $this->params+=['pasos'=>$preparacion];
        $this->params+=['recetaedurl'=>$recetaedurl];
        $this->params+=['recetaelurl'=>$recetaelurl];

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

    public function displayError(){
        $this->vista->render($this->params);
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

                $datosUser['foto']=base64_encode($datosUser['foto']);
            }
        }
        else{
            $datosUser=[
                $entrada['nombre'],
                $entrada['apellidos'],
                $entrada['email'],
                $entrada['clave'],
                base64_decode($entrada['foto']),
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
        $params=[$email, $clave];
        $result=$this->musuario->comprobarCredenciales($params);
        return $result;
    }
}

?>