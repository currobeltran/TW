<?php

error_reporting(0);

require_once "vista/vista.php";
require_once "modelo/modeloAbstracto.php";
require_once "controlador/controlador.php";

if(!isset($_COOKIE["ultimaPagina"]) && !isset($_GET['p'])){
    $aux=new ControladorRecetas();
    // Establecemos esta variable como global para la primera vez que
    // el usuario se meta en la página si no tiene cookies
    global $idRecetaInicio;
    $idRecetaInicio=$aux->getRecetaAleatoria();
    setcookie("ultimaPagina", $idRecetaInicio, time()+2592000);
}

//Establecemos el valor de la última receta visitada
if(isset($_COOKIE["ultimaPagina"]) && isset($_GET['p']) && strcmp($_GET['p'], "visualizar")===0){
    setcookie("ultimaPagina", $_GET['id'], time()+2592000);
}

//Si la ultima página visitada se eliminó, generamos otra receta aleatoria
if(isset($_COOKIE["ultimaPagina"]) && strcmp($_GET['p'], "eliminareceta")===0 && 
    $_GET['id']==$_COOKIE["ultimaPagina"]){
    $aux=new ControladorRecetas();
    $idRecetaInicio=$aux->getRecetaAleatoria();
    setcookie("ultimaPagina", $idRecetaInicio, time()+2592000);
}

if(isset($_POST["Logout"])){ 
    if($_POST["Logout"]==true){
        session_unset(); 

        $param= session_get_cookie_params(); 

        setcookie(session_name(), $_COOKIE[session_name()], time()-2592000,
                  $param['path'], $param['domain'], $param['secure'], $param['httponly']);
        
        session_destroy();
    } 
}
else{
    //Iniciamos sesion
    session_start();
    $_SESSION['opc']="inicio";
}

//Iniciamos variables de sesion si no estan aun establecidas
if(isset($_GET['p'])){
    $_SESSION['opc']=$_GET['p'];
}

if(!isset($_SESSION['pagina'])){
    $_SESSION['pagina']=0;
}

if(!isset($_SESSION['permisos'])){
    $_SESSION['permisos']=0;
}

//Comprobamos si el usuario ha intentado loguearse
//Si es todo correcto, se guardan las credenciales en $_SESSION
if(isset($_POST['Login'])){
    $mu=new ControladorUsuario();
    $ml=new ControladorLog();

    $resultado=$mu->comprobarCredenciales($_POST['email'], $_POST['clave']);
    
    if($tupla=mysqli_fetch_array($resultado)){
        $_SESSION['usuario']=$tupla;
        $_SESSION['usuario']['foto']=base64_encode($tupla['foto']);

        $ml->nuevaIdentificacion($_SESSION['usuario']['nombre']);

        switch($tupla['tipo']){
            case 'Administrador': $_SESSION['permisos']=2; break;
            case 'Colaborador': $_SESSION['permisos']=1; break;
        }
    }

    else{
        $ml->nuevoErrorLogueo();
    }
}
else{//Si no ha habido logueo, cargamos de nuevo los datos por si ha habido algun cambio

    $mu=new ControladorUsuario();
    $resultado=$mu->getUsuarioById($_SESSION['usuario']['id']);

    if($tupla=mysqli_fetch_array($resultado)){
        $_SESSION['usuario']=$tupla;
        $_SESSION['usuario']['foto']=base64_encode($tupla['foto']);

        switch($tupla['tipo']){
            case 'Administrador': $_SESSION['permisos']=2; break;
            case 'Colaborador': $_SESSION['permisos']=1; break;
        }
    }
}

switch($_SESSION['opc']){
    
    // case 'inicio': 
    //     $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"visualizareceta.html",
    //     $_SESSION['usuario']);

    //     if(isset($_COOKIE["ultimaPagina"])){
    //         $idRecetaInicio=$_COOKIE["ultimaPagina"];
    //     }

    //     $controladorReceta->verReceta($idRecetaInicio, $_SESSION['usuario']);
    // break; 
    
    case 'listado': 
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"listado.html",
        $_SESSION['usuario']);

        $categoria=[];

        foreach($_POST as $entrada){
            if(strpos($entrada,"categoria") !== false){
                $entrada=explode("#", $entrada);
                array_push($categoria,$entrada[1]);
            }
        }

        if(isset($_POST['tituloBusqueda'])){
            $_SESSION['tituloBusqueda']=$_POST['tituloBusqueda'];
        }

        if(isset($_POST['contenidoBusqueda'])){
            $_SESSION['contenidoBusqueda']=$_POST['contenidoBusqueda'];
        }

        if(isset($_POST['recetasxpagina'])){
            $_SESSION['recetasxpagina']=$_POST['recetasxpagina'];
        }

        if(isset($_POST['orden'])){
            $_SESSION['orden']=$_POST['orden'];
        }

        $controladorReceta->listarRecetas($_SESSION['tituloBusqueda'], 
        $_SESSION['contenidoBusqueda'], $_SESSION['recetasxpagina'], 
        $_GET['pag'], $categoria, $_SESSION['orden']); 
    break;

    case 'visualizar': 
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"visualizareceta.html",
        $_SESSION['usuario']);
        $controladorReceta->verReceta($_GET['id'], $_SESSION['usuario']); 
    break;
    
    case 'milistado': 
        if($_SESSION['permisos']==0){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }

        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"listado.html",
        $_SESSION['usuario']);

        $categoria=[];

        foreach($_POST as $entrada){
            if(strpos($entrada,"categoria") !== false){
                $entrada=explode("#", $entrada);
                array_push($categoria,$entrada[1]);
            }
        }
        
        if(isset($_POST['tituloBusqueda'])){
            $_SESSION['tituloBusqueda']=$_POST['tituloBusqueda'];
        }

        if(isset($_POST['contenidoBusqueda'])){
            $_SESSION['contenidoBusqueda']=$_POST['contenidoBusqueda'];
        }

        if(isset($_POST['recetasxpagina'])){
            $_SESSION['recetasxpagina']=$_POST['recetasxpagina'];
        }

        if(isset($_POST['orden'])){
            $_SESSION['orden']=$_POST['orden'];
        }

        $controladorReceta->listarRecetasByUser($_SESSION['tituloBusqueda'], 
        $_SESSION['contenidoBusqueda'], $_SESSION['usuario']['id'], $_SESSION['recetasxpagina'], 
        $_GET['pag'], $categoria, $_SESSION['orden']);  
    break;
    
    case 'anadir': 
        if($_SESSION['permisos']==0){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }

        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"anadir.html",
        $_SESSION['usuario']);
        if(isset($_POST['confirmar'])){
            $datos=$_SESSION['datos'];

            $ml=new ControladorLog();
            $ml->nuevaReceta($datos['titulo']);
        }
        else{
            $datos=[];
        }
        $categoria=[];

        if(isset($_POST['titulo'])){ 
            $datos+=['titulo'=>$_POST['titulo']];
        }

        if(isset($_POST['descripcion'])){ 
            $datos+=['descripcion'=>$_POST['descripcion']];
        }

        if(isset($_POST['ingredientes'])){
            $datos+=['ingredientes'=>$_POST['ingredientes']];
        }

        if(isset($_POST['preparacion'])){
            $datos+=['preparacion'=>$_POST['preparacion']];
        }

        if(isset($_SESSION['usuario'])){
            $datos+=['autor'=>$_SESSION['usuario']['id']];
        }

        foreach($_POST as $entrada){
            if(strpos($entrada,"categoria") !== false){
                $entrada=explode("#", $entrada);
                array_push($categoria,$entrada[1]);
            }
        }
        
        if($categoria[0]!=null){
            $datos+=['categorias'=>$categoria];
        }

        $_SESSION['datos']=$controladorReceta->anadirReceta($datos, isset($_POST['anadir']), 
        isset($_POST['confirmar']));

    break;

    case 'editareceta': 
        if($_SESSION['permisos']==0){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }
        elseif($_SESSION['permisos']==1){ //Comprobamos si el usuario es propietario de la receta
            $aux=new ControladorRecetas();

            if($aux->comprobarRecetaUsuario($_GET['id'],$_SESSION['usuario']['id']) == false){
                $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
                $_SESSION['usuario']);
                
                $controladorReceta->displayStatic();

                break; 
            }
        }
        
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"editareceta.html",
        $_SESSION['usuario']);

        if(isset($_POST['confirmar'])){
            $datos=$_SESSION['datos'];
        }
        else{
            $datos=[];
            $categoria=[];
            $fotos=null;
            
            foreach($_POST as $tipo){
                if(strpos($tipo,"categoria") !== false){
                    $tipo=explode("#", $tipo);
                    array_push($categoria,$tipo[1]);
                }
            }
    
            for($i=0; $i<count(key($_POST)); $i++){
                if(strpos(key($_POST),"eliminafoto") !== false){
                    $idFoto=explode("#", key($_POST));
                    $fotos=$idFoto[1];
                }
            }

            if($categoria[0]!=null){
                $datos+=['categorias'=>$categoria];
            }

            if($fotos!=null){
                $datos+=['fotos'=>$fotos];
            }

        }

        if(isset($_POST['titulo'])){ 
            $datos+=['titulo'=>$_POST['titulo']];
        }

        if(isset($_POST['descripcion'])){ 
            $datos+=['descripcion'=>$_POST['descripcion']];
        }

        if(isset($_POST['ingredientes'])){
            $datos+=['ingredientes'=>$_POST['ingredientes']];
        }

        if(isset($_POST['preparacion'])){
            $datos+=['preparacion'=>$_POST['preparacion']];
        }

        if(isset($_POST['anadirfoto']) && in_array($_FILES['foto']['type'], 
        ["image/jpeg","image/gif","image/png"])){ 
            $_FILES['foto']['name']="img_".rand().".jpg"; 

            if(move_uploaded_file($_FILES['foto']['tmp_name'], 
            "./tmp/".$_FILES['foto']['name'])){
                $datos+=['rutanuevafoto'=>"./tmp/".$_FILES['foto']['name']];
            }
            else{
                echo $_FILES['foto']['error'];
            }
        }

        $_SESSION['datos']=$controladorReceta->editarReceta($_GET['id'],$datos,
        isset($_POST['anadir']), isset($_POST['confirmar']));
    break;

    case 'eliminareceta': 
        if($_SESSION['permisos']==0){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }
        
        elseif($_SESSION['permisos']==1){ //Comprobamos si el usuario es propietario de la receta
            $aux=new ControladorRecetas();

            if($aux->comprobarRecetaUsuario($_GET['id'],$_SESSION['usuario']['id']) == false){
                $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
                $_SESSION['usuario']);
                
                $controladorReceta->displayStatic();

                break; 
            }
        }

        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"eliminareceta.html",
        $_SESSION['usuario']);

        $confirmado=isset($_POST['Confirmar']);

        $controladorReceta->eliminarReceta($_GET['id'],$confirmado);
    break;

    case 'Editar Usuario': 
        if($_SESSION['permisos']==0){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }
        
        elseif($_SESSION['permisos']==1){ //Comprobamos si el usuario es propietario de la receta
            $aux=new ControladorRecetas();

            if($_GET['id'] == $_SESSION['usuario']['id']){
                $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
                $_SESSION['usuario']);
                
                $controladorReceta->displayStatic();

                break; 
            }
        }
        
        $controladorUsuario=new ControladorUsuario($_SESSION['permisos'],"editaruser.html",
        $_SESSION['usuario']);

        if(isset($_POST['confirmado'])){
            $datos=$_SESSION['datos'];
        }
        else{
            $datos=$_SESSION['usuario'];
        }

        if(!isset($_GET['id'])){ 
            $idUsuario=$_SESSION['usuario']['id'];
        }
        else{
            $idUsuario=$_GET['id'];
        }
        
        if(isset($_POST['nombre'])){ 
            $datos['nombre']=$_POST['nombre'];
        }

        if(isset($_POST['apellidos'])){ 
            $datos['apellidos']=$_POST['apellidos'];
        }

        if(isset($_POST['email'])){
            $datos['email']=$_POST['email'];
        }

        if(isset($_POST['clave'])){
            $datos['clave']=$_POST['clave'];
        }

        if(isset($_POST['clave2'])){
            $datos+=['clave2'=>$_POST['clave2']];
        }

        if(isset($_POST['tipo'])){
            $datos['tipo']=$_POST['tipo'];
        }

        if(isset($_FILES['foto']) && in_array($_FILES['foto']['type'], 
            ["image/jpeg","image/gif","image/png"])){
            move_uploaded_file($_FILES['foto']['tmp_name'],"./tmp/".$_FILES['foto']['name']);
            $datos['foto']=file_get_contents("./tmp/".$_FILES['foto']['name']);
        }

        $_SESSION['datos']=$controladorUsuario->editarUsuario($idUsuario, $datos, 
        isset($_POST['envio']), isset($_POST['confirmado']));
    break;

    case 'gestionar':  
        if($_SESSION['permisos']<=1){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }

        $controladorUsuario=new ControladorUsuario($_SESSION['permisos'],'gestion.html',
        $_SESSION['usuario']);
        $controladorUsuario->displayStatic();
    break;

    case 'listauser':   
        if($_SESSION['permisos']<=1){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }

        $controladorUsuario=new ControladorUsuario($_SESSION['permisos'],'listauser.html',
        $_SESSION['usuario']);
        $controladorUsuario->listarUsuarios(); 
    break;
    
    case 'anadiruser': 
        if($_SESSION['permisos']<=1){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }

        $controladorUsuario=new ControladorUsuario($_SESSION['permisos'],'anadiruser.html',
        $_SESSION['usuario']);

        if(isset($_POST['confirmar'])){
            $datos=$_SESSION['datos'];

            $ml=new ControladorLog();
            $ml->nuevoUsuario($datos['nombre']);
        }
        else{
            $datos=[];
        }

        if(isset($_POST['nombre'])){
            $datos+=['nombre'=>$_POST['nombre']];
        }

        if(isset($_POST['apellidos'])){
            $datos+=['apellidos'=>$_POST['apellidos']];
        }

        if(isset($_POST['email'])){
            $datos+=['email'=>$_POST['email']];
        }

        if(isset($_POST['clave'])){
            $datos+=['clave'=>$_POST['clave']];
        }

        if(isset($_POST['clave2'])){
            $datos+=['clave2'=>$_POST['clave2']];
        }

        if(isset($_FILES['foto']) && in_array($_FILES['foto']['type'], 
            ["image/jpeg","image/gif","image/png"])){
            $datos+=['foto'=>file_get_contents($_FILES['foto']['tmp_name'])];
        }

        $datos+=['tipo'=>$_POST['tipo']];

        $_SESSION['datos']=$controladorUsuario->anadirUsuario($datos, 
        isset($_POST['anadir']), isset($_POST['confirmar']));

    break;

    case 'basedatos': //Tiene algunos problemas aun
        if($_SESSION['permisos']<=1){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }

        $controladorBBDD=new ControladorBBDD($_SESSION['permisos'],'backupBBDD.html',
        $_SESSION['usuario']);

        if(isset($_POST['copia'])){
            $controladorBBDD->copyBBDD();
        }

        else if(isset($_POST['restaurar'])){
            $controladorBBDD->restoreBBDD("./modelo/backup/backup.sql");
        }

        else if(isset($_POST['eliminar'])){
            // $controladorBBDD->deleteBBDD("./modelo/backup/drop.sql");
        }

        $controladorBBDD->displayStatic();

    break; 

    case 'log': 
        if($_SESSION['permisos']<=1){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }

        $controladorLog=new ControladorLog($_SESSION['permisos'],"log.html",
        $_SESSION['usuario']);

        $controladorLog->listarLog();
    break;
    
    case 'eliminauser': //Log
        if($_SESSION['permisos']<=1 || $_GET['id']==$_SESSION['usuario']['id']){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }

        $controladorUsuario=new ControladorUsuario($_SESSION['permisos'],'eliminauser.html',
        $_SESSION['usuario']);

        $controladorUsuario->eliminaUsuario($_GET['id'], isset($_POST['confirmado']));

    break;

    case 'comentar': //Log

        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],'comentario.html',
        $_SESSION['usuario']);

        if(isset($_POST['comentar'])){ 
            $comentario=$_POST['comentario'];
        }
        elseif(isset($_POST['confirmar'])){
            $comentario=$_SESSION['comentario'];
        }

        $_SESSION['comentario']=$controladorReceta->enviarComentario($comentario, $_GET['id'],
        $_SESSION['usuario']['id'], isset($_POST['confirmar']), isset($_POST['comentar']));  

        $controladorReceta->verReceta($_GET['id'], $_SESSION['usuario']);
    break;

    case 'valoracion': //Log
        if($_SESSION['permisos']==0){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayStatic();

            break; 
        }

        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],'valoracion.html',
        $_SESSION['usuario']);
        
        if(isset($_POST['valorar'])){ 
            $valoracion=$_POST['valoracion'];
        }
        elseif(isset($_POST['confirmar'])){
            $valoracion=$_SESSION['valoracion'];
        }

        $_SESSION['valoracion']=$controladorReceta->enviarValoracion($_GET['id'],
        $_SESSION['usuario']['id'], $valoracion, isset($_POST['confirmar']), 
        isset($_POST['valorar']));
        
        $controladorReceta->verReceta($_GET['id'], $_SESSION['usuario']);
    break;

    case 'anadircategoria':
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"anadircategoria.html",
        $_SESSION['usuario']);

        if(isset($_POST['confirmar'])){
            $datos=$_SESSION['datos']; 
        }
        else{
            $datos=[];
            if(isset($_POST['nombreCategoria'])){
                $datos+=['nombreCategoria'=>$_POST['nombreCategoria']];
            }
        }
        
        $_SESSION['datos']=$controladorReceta->anadirNuevaCategoria($datos, isset($_POST['enviar']),
        isset($_POST['confirmar']));
    break;

    case 'eliminacomentario':
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"eliminacomentario.html",
        $_SESSION['usuario']);

        $controladorReceta->eliminaComentario($_GET['id'], $_SESSION['usuario'], 
        isset($_POST['eliminar']));
    break;
    
    default: 
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"visualizareceta.html",
        $_SESSION['usuario']);

        if(isset($_COOKIE["ultimaPagina"])){
            $idRecetaInicio=$_COOKIE["ultimaPagina"];
        }

        $controladorReceta->verReceta($idRecetaInicio, $_SESSION['usuario']);
    break;
}

$view->render([]);

?>