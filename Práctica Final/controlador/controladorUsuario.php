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
            if(!$this->musuario->editarUsuario($datosUser)){
                $this->params+=['errorEnvio'=>true];
            }
        }
        
        $this->params+=['envio'=>$envio];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['datos'=>$datosUser];
        $this->params+=['confirmacion'=>$confirmado];
        $this->params+=['tipoDato'=>"Edite el siguiente usuario"];
        
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

    public function eliminaUsuario($id, $confirmado){ 
        if($confirmado){
            //Eliminamos sus recetas 
            $mrecetasaux=new ModeloRecetas();
            $mvaloraciones=new ModeloValoracion();
            $mcomentarios=new ModeloComentarios();
            $mfotos=new ModeloFotos();
            $mcategorias=new ModeloCategorias();
            
            $resulteliminar=$mrecetasaux->getRecetasFromUser($id);
            while($receta=mysqli_fetch_array($resulteliminar)){
                //Eliminamos comentarios
                $mcomentarios->deleteComentariosReceta($receta['id']);

                //Eliminamos valoraciones
                $mvaloraciones->deleteValoracionesReceta($receta['id']);

                //Eliminamos categorias
                $mcategorias->deleteCategoria($receta['id']);

                //Eliminamos imágenes
                $fotos=$mfotos->getFotoByIdReceta($receta['id']);
                while($foto=mysqli_fetch_array($fotos)){
                    unlink($foto['fichero']);
                }

                $mfotos->eliminaFotoByIdReceta($receta['id']);

                $mrecetasaux->eliminaReceta($receta['id']);

                if($mrecetasaux->exists($receta['id'])){
                    $this->params+=['errorEnvio'=>true];
                }
                else{
                    $ml=new ControladorLog();
                    $ml->nuevaRecetaEliminada($receta['nombre']);
                }
            }
            
            $result=$this->musuario->getUsuarioById($id);
            $usuarioAux=mysqli_fetch_array($result);
            
            //Eliminamos sus valoraciones
            $mvaloraciones->deleteValoracionesByIdUsuario($id);
            
            //Eliminamos sus comentarios
            $mcomentarios->deleteComentariosByIdUsuario($id);
            
            //Eliminamos el usuario en cuestion
            $this->musuario->eliminarUsuarioById($id);

            if($this->musuario->existsUser($id)){
                $this->params+=['errorEnvio'=>true];
            }
            else{
                $ml=new ControladorLog();    
                $ml->nuevoUsuarioEliminado($usuarioAux['nombre']);
            }

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
            $entrada['clave']=crypt($entrada['clave'], '$5%rounds=5000$oniasSUbdhaIUABakf$');
            $entrada=[
                $entrada['nombre'],
                $entrada['apellidos'],
                $entrada['email'],
                base64_decode($entrada['foto']),
                $entrada['clave'],
                $entrada['tipo']
            ];

            $nuevaId=$this->musuario->insertUsuario($entrada);

            if($this->musuario->existsUser($nuevaId)){
                $ml=new ControladorLog();
                $ml->nuevoUsuario($entrada[0]);
            }
            else{
                $this->params+=['errorEnvio'=>true];
            }
        }

        $this->params+=['envio'=>$anadir];
        $this->params+=['confirmacion'=>$confirmar];
        $this->params+=['datos'=>$entrada];
        $this->params+=['hayerror'=>$hayerror];
        $this->params+=['tipoDato'=>"Añade un usuario"];

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

?>